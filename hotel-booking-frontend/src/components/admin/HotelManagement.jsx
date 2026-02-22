import React, { useState, useEffect } from 'react';
import {
  FaSearch,
  FaFilter,
  FaStar,
  FaMapMarkerAlt,
  FaPhone,
  FaEnvelope,
  FaBuilding,
  FaBed,
  FaCalendarCheck,
  FaClock,
  FaTimes,
  FaSortAmountUp,
  FaSortAmountDown,
  FaImage,
  FaPlus
} from 'react-icons/fa';
import api from '../../services/api';
import Pagination from '../common/Pagination';

const HotelManagement = () => {
  // State for hotels data
  const [hotels, setHotels] = useState([]);
  const [loading, setLoading] = useState(false);
  const [totalHotelsInDB, setTotalHotelsInDB] = useState(0);
  const [pagination, setPagination] = useState({
    page: 0,
    size: 3,
    totalPages: 0,
    totalElements: 0
  });

  // State for filter options from DB
  const [filterOptions, setFilterOptions] = useState({
    cities: [],
    hotelTypes: [],
    statuses: [],
    roomTypeNames: [],
    minStarRating: 1,
    maxStarRating: 5,
    minFloors: 1,
    maxFloors: 50
  });

  // State for current filters
  const [filters, setFilters] = useState({
    name: '',
    type: '',
    city: '',
    status: '',
    starRatingRange: [1, 5],
    reviewRatingRange: [0, 10],
    minFloors: '',
    maxFloors: '',
    minTotalRooms: '',
    maxTotalRooms: '',
    minTotalBookings: '',
    maxTotalBookings: '',
    roomTypeNames: [],
    sortBy: 'name',
    sortDirection: 'ASC'
  });

  // State for UI
  const [showFilterPanel, setShowFilterPanel] = useState(false);
  const [activeFiltersCount, setActiveFiltersCount] = useState(0);

  useEffect(() => {
    fetchTotalCount();
    fetchFilterOptions();
    fetchHotels();
  }, []);

  useEffect(() => {
    countActiveFilters();
  }, [filters]);

  const fetchTotalCount = async () => {
    try {
      const response = await api.get('/hotels/count');
      setTotalHotelsInDB(response.data);
    } catch (error) {
      console.error('Error fetching total count:', error);
    }
  };

  const fetchFilterOptions = async () => {
    try {
      const response = await api.get('/hotels/filter-options');
      setFilterOptions(response.data);
    } catch (error) {
      console.error('Error fetching filter options:', error);
    }
  };

  const fetchHotels = async (page = 0) => {
    try {
      setLoading(true);

      const cleanFilters = {};

      if (filters.name && filters.name.trim()) cleanFilters.name = filters.name.trim();
      if (filters.type) cleanFilters.type = filters.type;
      if (filters.city) cleanFilters.city = filters.city;
      if (filters.status) cleanFilters.status = filters.status;

      // ✅ THAY ĐỔI: Gửi range cho star rating
      if (filters.starRatingRange[0] > 1 || filters.starRatingRange[1] < 5) {
        cleanFilters.minStarRating = filters.starRatingRange[0];
        cleanFilters.maxStarRating = filters.starRatingRange[1];
      }

      // ✅ THAY ĐỔI: Gửi range cho review rating
      if (filters.reviewRatingRange[0] > 0 || filters.reviewRatingRange[1] < 10) {
        cleanFilters.minReviewRating = filters.reviewRatingRange[0];
        cleanFilters.maxReviewRating = filters.reviewRatingRange[1];
      }

      if (filters.minFloors) cleanFilters.minFloors = parseInt(filters.minFloors);
      if (filters.maxFloors) cleanFilters.maxFloors = parseInt(filters.maxFloors);
      if (filters.minTotalRooms) cleanFilters.minTotalRooms = parseInt(filters.minTotalRooms);
      if (filters.maxTotalRooms) cleanFilters.maxTotalRooms = parseInt(filters.maxTotalRooms);
      if (filters.minTotalBookings) cleanFilters.minTotalBookings = parseInt(filters.minTotalBookings);
      if (filters.maxTotalBookings) cleanFilters.maxTotalBookings = parseInt(filters.maxTotalBookings);

      if (filters.roomTypeNames && filters.roomTypeNames.length > 0) {
        cleanFilters.roomTypeNames = filters.roomTypeNames;
      }

      const requestBody = {
        ...cleanFilters,
        page: page,
        size: pagination.size,
        sortBy: filters.sortBy,
        sortDirection: filters.sortDirection
      };

      console.log('Filter request:', requestBody);

      const response = await api.post('/hotels/filter', requestBody);

      setHotels(response.data.content);
      setPagination({
        page: response.data.number,
        size: response.data.size,
        totalPages: response.data.totalPages,
        totalElements: response.data.totalElements
      });
    } catch (error) {
      console.error('Error fetching hotels:', error);
      alert('Có lỗi khi tải danh sách khách sạn');
    } finally {
      setLoading(false);
    }
  };

  const handleFilterChange = (name, value) => {
    setFilters(prev => ({
      ...prev,
      [name]: value
    }));
  };

  const handleRoomTypeToggle = (roomTypeName) => {
    setFilters(prev => {
      const currentRoomTypes = prev.roomTypeNames || [];
      const newRoomTypes = currentRoomTypes.includes(roomTypeName)
        ? currentRoomTypes.filter(name => name !== roomTypeName)
        : [...currentRoomTypes, roomTypeName];

      return {
        ...prev,
        roomTypeNames: newRoomTypes
      };
    });
  };

  const handleApplyFilters = () => {
    fetchHotels(0);
    setShowFilterPanel(false);
  };

  const handleResetFilters = () => {
    setFilters({
      name: '',
      type: '',
      city: '',
      status: '',
      starRatingRange: [1, 5],
      reviewRatingRange: [0, 10],
      minFloors: '',
      maxFloors: '',
      minTotalRooms: '',
      maxTotalRooms: '',
      minTotalBookings: '',
      maxTotalBookings: '',
      roomTypeNames: [],
      sortBy: 'name',
      sortDirection: 'ASC'
    });
    setTimeout(() => {
      fetchHotels(0);
      setShowFilterPanel(false);
    }, 100);
  };

  const countActiveFilters = () => {
    let count = 0;
    if (filters.name) count++;
    if (filters.type) count++;
    if (filters.city) count++;
    if (filters.status) count++;
    if (filters.starRatingRange[0] > 1 || filters.starRatingRange[1] < 5) count++;     // ✅
    if (filters.reviewRatingRange[0] > 0 || filters.reviewRatingRange[1] < 10) count++; // ✅
    if (filters.minFloors) count++;
    if (filters.maxFloors) count++;
    if (filters.minTotalRooms) count++;
    if (filters.maxTotalRooms) count++;
    if (filters.minTotalBookings) count++;
    if (filters.maxTotalBookings) count++;
    if (filters.roomTypeNames && filters.roomTypeNames.length > 0) count++;
    setActiveFiltersCount(count);
  };

  const handleStarRangeChange = (e, index) => {
    const newRange = [...filters.starRatingRange];
    newRange[index] = parseInt(e.target.value);

    // Ensure min <= max
    if (index === 0 && newRange[0] > newRange[1]) {
      newRange[1] = newRange[0];
    }
    if (index === 1 && newRange[1] < newRange[0]) {
      newRange[0] = newRange[1];
    }

    setFilters(prev => ({
      ...prev,
      starRatingRange: newRange
    }));
  };

  const handleReviewRangeChange = (e, index) => {
    const newRange = [...filters.reviewRatingRange];
    newRange[index] = parseFloat(e.target.value);

    // Ensure min <= max
    if (index === 0 && newRange[0] > newRange[1]) {
      newRange[1] = newRange[0];
    }
    if (index === 1 && newRange[1] < newRange[0]) {
      newRange[0] = newRange[1];
    }

    setFilters(prev => ({
      ...prev,
      reviewRatingRange: newRange
    }));
  };

  const handlePageChange = (newPage) => {
    fetchHotels(newPage);
    window.scrollTo({ top: 0, behavior: 'smooth' });
  };

  const handleAddHotel = () => {
    alert('Chức năng thêm khách sạn đang được phát triển');
  };

  const getStatusBadge = (status) => {
    const statusConfig = {
      ACTIVE: { bg: 'bg-green-100', text: 'text-green-700', label: 'Hoạt động' },
      INACTIVE: { bg: 'bg-gray-100', text: 'text-gray-700', label: 'Tạm ngừng' },
      MAINTENANCE: { bg: 'bg-yellow-100', text: 'text-yellow-700', label: 'Bảo trì' }
    };

    const config = statusConfig[status] || statusConfig.ACTIVE;

    return (
      <span className={`px-2.5 py-1 rounded-full text-xs font-medium ${config.bg} ${config.text}`}>
        {config.label}
      </span>
    );
  };

  const getHotelTypeBadge = (type) => {
    const typeConfig = {
      HOTEL: { bg: 'bg-blue-100', text: 'text-blue-700', label: 'Khách sạn' },
      RESORT: { bg: 'bg-purple-100', text: 'text-purple-700', label: 'Khu nghỉ dưỡng' },
      HOME_STAY: { bg: 'bg-orange-100', text: 'text-orange-700', label: 'Nhà nghỉ' }
    };

    const config = typeConfig[type] || typeConfig.HOTEL;

    return (
      <span className={`px-2.5 py-1 rounded-full text-xs font-medium ${config.bg} ${config.text}`}>
        {config.label}
      </span>
    );
  };

  const getHotelImageUrl = (hotel) => {
    if (hotel.primaryImageUrl) {
      return `http://localhost:8080/uploads/hotel/hotel${hotel.id}/${hotel.primaryImageUrl}`;
    }
    return null;
  };

  return (
    <div className="max-w-[1600px] mx-auto">
      {/* Header */}
      <div className="mb-6">
        <h1 className="text-2xl font-bold text-gray-800 mb-2">Quản Lý Khách Sạn</h1>
        <p className="text-gray-600">Quản lý và tìm kiếm khách sạn trong hệ thống</p>
      </div>

      {/* Stats Cards - CHỈ CÒN 2 CARD */}
      <div className="grid grid-cols-1 md:grid-cols-2 gap-4 mb-6">
        <div className="bg-white rounded-xl p-5 border border-gray-200">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500 mb-1">Tổng Số Khách Sạn</p>
              <p className="text-2xl font-bold text-gray-800">{totalHotelsInDB}</p>
            </div>
            <div className="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
              <FaBuilding className="text-blue-500 text-xl" />
            </div>
          </div>
        </div>

        <div className="bg-white rounded-xl p-5 border border-gray-200">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500 mb-1">Kết Quả Hiển Thị</p>
              <p className="text-2xl font-bold text-green-600">{pagination.totalElements}</p>
            </div>
            <div className="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
              <FaSearch className="text-green-500 text-xl" />
            </div>
          </div>
        </div>
      </div>

      {/* Search & Filter Bar */}
      <div className="bg-white rounded-xl p-5 mb-6 border border-gray-200">
        <div className="flex flex-col lg:flex-row gap-4">
          {/* Search by Name */}
          <div className="flex-1">
            <div className="relative">
              <FaSearch className="absolute left-3 top-1/2 -translate-y-1/2 text-gray-400" />
              <input
                type="text"
                placeholder="Tìm kiếm theo tên khách sạn..."
                value={filters.name}
                onChange={(e) => handleFilterChange('name', e.target.value)}
                onKeyPress={(e) => e.key === 'Enter' && handleApplyFilters()}
                className="w-full pl-10 pr-4 py-2.5 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
              />
            </div>
          </div>

          {/* Quick Filters */}
          <div className="flex gap-3">
            {/* Filter Button */}
            <button
              onClick={() => setShowFilterPanel(!showFilterPanel)}
              className={`flex items-center gap-2 px-4 py-2.5 rounded-lg font-medium transition-colors ${showFilterPanel || activeFiltersCount > 0
                ? 'bg-blue-500 text-white'
                : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                }`}
            >
              <FaFilter />
              Bộ Lọc
              {activeFiltersCount > 0 && (
                <span className="bg-white text-blue-500 px-2 py-0.5 rounded-full text-xs font-bold">
                  {activeFiltersCount}
                </span>
              )}
            </button>

            {/* Apply Button */}
            <button
              onClick={handleApplyFilters}
              className="px-6 py-2.5 bg-green-500 text-white rounded-lg hover:bg-green-600 transition-colors font-medium"
            >
              Áp dụng
            </button>

            {/* Add Hotel Button */}
            <button
              onClick={handleAddHotel}
              className="flex items-center gap-2 px-6 py-2.5 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors font-medium"
            >
              <FaPlus />
              Thêm Khách Sạn
            </button>
          </div>
        </div>
      </div>

      {/* Advanced Filter Panel */}
      {showFilterPanel && (
        <div className="bg-white rounded-xl p-6 mb-6 border border-gray-200">
          <div className="flex items-center justify-between mb-4">
            <h3 className="text-lg font-semibold text-gray-800">Bộ Lọc Nâng Cao</h3>
            <button
              onClick={() => setShowFilterPanel(false)}
              className="p-2 hover:bg-gray-100 rounded-lg transition-colors"
            >
              <FaTimes className="text-gray-600" />
            </button>
          </div>

          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
            {/* Hotel Type */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Loại Hình Khách Sạn
              </label>
              <select
                value={filters.type}
                onChange={(e) => handleFilterChange('type', e.target.value)}
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
              >
                <option value="">Tất cả</option>
                {filterOptions.hotelTypes.map(type => (
                  <option key={type} value={type}>
                    {type === 'HOTEL' ? 'Khách sạn' : type === 'RESORT' ? 'Khu nghỉ dưỡng' : 'Homestay'}
                  </option>
                ))}
              </select>
            </div>

            {/* City */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Thành Phố
              </label>
              <select
                value={filters.city}
                onChange={(e) => handleFilterChange('city', e.target.value)}
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
              >
                <option value="">Tất cả</option>
                {filterOptions.cities.map(city => (
                  <option key={city} value={city}>{city}</option>
                ))}
              </select>
            </div>

            {/* Status */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Trạng Thái
              </label>
              <select
                value={filters.status}
                onChange={(e) => handleFilterChange('status', e.target.value)}
                className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
              >
                <option value="">Tất cả</option>
                {filterOptions.statuses.map(status => (
                  <option key={status} value={status}>
                    {status === 'ACTIVE' ? 'Hoạt động' : status === 'INACTIVE' ? 'Tạm ngừng' : 'Bảo trì'}
                  </option>
                ))}
              </select>
            </div>

            {/* Star Rating Range - Compact */}
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-2 flex items-center gap-1.5">
                <FaStar className="text-yellow-400 text-xs" />
                Số Sao
                <span className="ml-auto font-semibold text-gray-800">
                  {filters.starRatingRange[0]}–{filters.starRatingRange[1]}★
                </span>
              </label>
              {/* Star toggle buttons */}
              <div className="flex gap-1 mb-2">
                {[1, 2, 3, 4, 5].map(star => {
                  const inRange = star >= filters.starRatingRange[0] && star <= filters.starRatingRange[1];
                  return (
                    <button
                      key={star}
                      type="button"
                      onClick={() => {
                        const [min, max] = filters.starRatingRange;
                        let newMin = min, newMax = max;
                        if (star < min) newMin = star;
                        else if (star > max) newMax = star;
                        else if (star === min && star === max) { newMin = 1; newMax = 5; }
                        else if (star === min) newMin = star + 1;
                        else newMax = star - 1;
                        setFilters(prev => ({ ...prev, starRatingRange: [newMin, newMax] }));
                      }}
                      className={`flex-1 py-1.5 rounded text-xs font-bold transition-all duration-150 active:scale-95
                        ${inRange
                          ? 'bg-yellow-400 text-white shadow-sm shadow-yellow-200'
                          : 'bg-gray-100 text-gray-400 hover:bg-yellow-50 hover:text-yellow-400'}`}
                    >
                      {star}★
                    </button>
                  );
                })}
              </div>
              <div className="flex gap-1.5">
                <div className="flex-1">
                  <input
                    type="range" min="1" max="5" step="1"
                    value={filters.starRatingRange[0]}
                    onChange={(e) => handleStarRangeChange(e, 0)}
                    className="w-full h-1.5 rounded appearance-none cursor-pointer accent-yellow-400"
                  />
                </div>
                <div className="flex-1">
                  <input
                    type="range" min="1" max="5" step="1"
                    value={filters.starRatingRange[1]}
                    onChange={(e) => handleStarRangeChange(e, 1)}
                    className="w-full h-1.5 rounded appearance-none cursor-pointer accent-yellow-400"
                  />
                </div>
              </div>
            </div>

            {/* Review Rating Range - Compact */}
            <div>
              <label className="block text-xs font-medium text-gray-600 mb-2 flex items-center gap-1.5">
                <span className="text-green-500 font-bold text-xs">★</span>
                Điểm Đánh Giá
                <span className="ml-auto font-semibold text-gray-800">
                  {filters.reviewRatingRange[0].toFixed(1)}–{filters.reviewRatingRange[1].toFixed(1)}
                </span>
              </label>
              {/* Continuous track with filled range */}
              <div className="relative h-4 flex items-center mb-1.5">
                <div className="absolute w-full h-1.5 bg-gray-200 rounded-full" />
                <div
                  className="absolute h-1.5 bg-green-400 rounded-full transition-all"
                  style={{
                    left: `${(filters.reviewRatingRange[0] / 10) * 100}%`,
                    width: `${((filters.reviewRatingRange[1] - filters.reviewRatingRange[0]) / 10) * 100}%`
                  }}
                />
              </div>
              <div className="flex gap-1.5">
                <div className="flex-1">
                  <div className="flex justify-between text-[10px] text-gray-400 mb-0.5"><span>0</span><span>Min</span></div>
                  <input
                    type="range" min="0" max="10" step="0.5"
                    value={filters.reviewRatingRange[0]}
                    onChange={(e) => handleReviewRangeChange(e, 0)}
                    className="w-full h-1.5 rounded appearance-none cursor-pointer accent-green-500"
                  />
                </div>
                <div className="flex-1">
                  <div className="flex justify-between text-[10px] text-gray-400 mb-0.5"><span>Max</span><span>10</span></div>
                  <input
                    type="range" min="0" max="10" step="0.5"
                    value={filters.reviewRatingRange[1]}
                    onChange={(e) => handleReviewRangeChange(e, 1)}
                    className="w-full h-1.5 rounded appearance-none cursor-pointer accent-green-500"
                  />
                </div>
              </div>
            </div>

            {/* Floor Number Range */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Số Tầng (Min - Max)
              </label>
              <div className="flex gap-2">
                <input
                  type="number"
                  placeholder="Min"
                  value={filters.minFloors}
                  onChange={(e) => handleFilterChange('minFloors', e.target.value)}
                  className="w-1/2 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                />
                <input
                  type="number"
                  placeholder="Max"
                  value={filters.maxFloors}
                  onChange={(e) => handleFilterChange('maxFloors', e.target.value)}
                  className="w-1/2 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                />
              </div>
            </div>

            {/* Total Rooms Range */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Tổng Số Phòng (Min - Max)
              </label>
              <div className="flex gap-2">
                <input
                  type="number"
                  placeholder="Min"
                  value={filters.minTotalRooms}
                  onChange={(e) => handleFilterChange('minTotalRooms', e.target.value)}
                  className="w-1/2 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                />
                <input
                  type="number"
                  placeholder="Max"
                  value={filters.maxTotalRooms}
                  onChange={(e) => handleFilterChange('maxTotalRooms', e.target.value)}
                  className="w-1/2 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                />
              </div>
            </div>

            {/* Total Bookings Range */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Tổng Booking (Min - Max)
              </label>
              <div className="flex gap-2">
                <input
                  type="number"
                  placeholder="Min"
                  value={filters.minTotalBookings}
                  onChange={(e) => handleFilterChange('minTotalBookings', e.target.value)}
                  className="w-1/2 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                />
                <input
                  type="number"
                  placeholder="Max"
                  value={filters.maxTotalBookings}
                  onChange={(e) => handleFilterChange('maxTotalBookings', e.target.value)}
                  className="w-1/2 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                />
              </div>
            </div>

            {/* Sort By */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Sắp Xếp Theo
              </label>
              <div className="flex gap-2">
                <select
                  value={filters.sortBy}
                  onChange={(e) => handleFilterChange('sortBy', e.target.value)}
                  className="flex-1 px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none"
                >
                  <option value="name">Tên</option>
                  <option value="starRating">Số sao</option>
                  <option value="reviewRating">Đánh giá</option>
                </select>
                <button
                  onClick={() => handleFilterChange('sortDirection', filters.sortDirection === 'ASC' ? 'DESC' : 'ASC')}
                  className="px-3 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
                  title={filters.sortDirection === 'ASC' ? 'Tăng dần' : 'Giảm dần'}
                >
                  {filters.sortDirection === 'ASC' ? (
                    <FaSortAmountUp className="text-gray-600" />
                  ) : (
                    <FaSortAmountDown className="text-gray-600" />
                  )}
                </button>
              </div>
            </div>
          </div>

          {/* Room Types Filter */}
          {filterOptions.roomTypeNames && filterOptions.roomTypeNames.length > 0 && (
            <div className="mt-6">
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Loại Phòng Có Sẵn
              </label>
              <div className="flex flex-wrap gap-2">
                {filterOptions.roomTypeNames.map(roomTypeName => (
                  <button
                    key={roomTypeName}
                    onClick={() => handleRoomTypeToggle(roomTypeName)}
                    className={`px-4 py-2 rounded-lg text-sm font-medium transition-colors ${filters.roomTypeNames?.includes(roomTypeName)
                      ? 'bg-blue-500 text-white'
                      : 'bg-gray-100 text-gray-700 hover:bg-gray-200'
                      }`}
                  >
                    {roomTypeName}
                  </button>
                ))}
              </div>
            </div>
          )}

          {/* Filter Actions */}
          <div className="flex gap-3 mt-6 pt-6 border-t border-gray-200">
            <button
              onClick={handleResetFilters}
              className="flex-1 px-6 py-2.5 border border-gray-300 text-gray-700 rounded-lg hover:bg-gray-50 transition-colors font-medium"
            >
              Đặt Lại
            </button>
            <button
              onClick={handleApplyFilters}
              className="flex-1 px-6 py-2.5 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors font-medium"
            >
              Áp Dụng Bộ Lọc
            </button>
          </div>
        </div>
      )}

      {/* Loading State */}
      {loading && (
        <div className="flex items-center justify-center py-12">
          <div className="text-center">
            <div className="w-16 h-16 border-4 border-gray-200 border-t-blue-500 rounded-full animate-spin mx-auto mb-4"></div>
            <p className="text-gray-600">Đang tải dữ liệu...</p>
          </div>
        </div>
      )}

      {/* Hotels Grid */}
      {!loading && hotels.length > 0 && (
        <>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6 mb-6">
            {hotels.map((hotel) => (
              <div
                key={hotel.id}
                className="bg-white rounded-xl overflow-hidden border border-gray-200 hover:shadow-lg transition-all duration-300 hover:-translate-y-1"
              >
                {/* Hotel Image */}
                <div className="h-48 relative overflow-hidden">
                  {getHotelImageUrl(hotel) ? (
                    <img
                      src={getHotelImageUrl(hotel)}
                      alt={hotel.name}
                      className="w-full h-full object-cover"
                      onError={(e) => {
                        e.target.style.display = 'none';
                        e.target.nextElementSibling.style.display = 'flex';
                      }}
                    />
                  ) : null}
                  <div className="w-full h-full bg-gradient-to-br from-blue-400 to-blue-600 flex items-center justify-center" style={{ display: getHotelImageUrl(hotel) ? 'none' : 'flex' }}>
                    <div className="text-center text-white">
                      <FaImage className="text-5xl mb-2 mx-auto opacity-70" />
                      <p className="text-sm font-medium">{hotel.city}</p>
                    </div>
                  </div>
                  <div className="absolute top-3 left-3 flex gap-2">
                    {getHotelTypeBadge(hotel.type)}
                  </div>
                  <div className="absolute top-3 right-3">
                    {getStatusBadge(hotel.status)}
                  </div>
                </div>

                {/* Hotel Info */}
                <div className="p-5">
                  {/* Name & Rating */}
                  <div className="mb-3">
                    <h3 className="text-lg font-bold text-gray-800 mb-2 line-clamp-1">
                      {hotel.name}
                    </h3>
                    <div className="flex items-center justify-between">
                      <div className="flex items-center gap-1">
                        {[...Array(5)].map((_, i) => (
                          <FaStar
                            key={i}
                            className={`text-sm ${i < hotel.starRating ? 'text-yellow-400' : 'text-gray-300'
                              }`}
                          />
                        ))}
                      </div>
                      {hotel.reviewRating && (
                        <div className="flex items-center gap-1">
                          <FaStar className="text-yellow-400 text-sm" />
                          <span className="text-sm font-semibold text-gray-800">
                            {hotel.reviewRating}
                          </span>
                          <span className="text-xs text-gray-500">
                            ({hotel.reviewCount})
                          </span>
                        </div>
                      )}
                    </div>
                  </div>

                  {/* Location */}
                  <div className="flex items-start gap-2 mb-3 pb-3 border-b border-gray-100">
                    <FaMapMarkerAlt className="text-gray-400 mt-1 flex-shrink-0" />
                    <div className="flex-1 min-w-0">
                      <p className="text-sm text-gray-600 line-clamp-2">{hotel.address}</p>
                    </div>
                  </div>

                  {/* Stats */}
                  <div className="grid grid-cols-3 gap-3 mb-3">
                    <div className="text-center p-2 bg-gray-50 rounded-lg">
                      <FaBuilding className="text-gray-400 mx-auto mb-1" />
                      <p className="text-xs text-gray-500">Tầng</p>
                      <p className="text-sm font-semibold text-gray-800">{hotel.floorNumber || '-'}</p>
                    </div>
                    <div className="text-center p-2 bg-gray-50 rounded-lg">
                      <FaBed className="text-gray-400 mx-auto mb-1" />
                      <p className="text-xs text-gray-500">Phòng</p>
                      <p className="text-sm font-semibold text-gray-800">{hotel.totalRooms || 0}</p>
                    </div>
                    <div className="text-center p-2 bg-gray-50 rounded-lg">
                      <FaCalendarCheck className="text-gray-400 mx-auto mb-1" />
                      <p className="text-xs text-gray-500">Booking</p>
                      <p className="text-sm font-semibold text-gray-800">{hotel.totalBookings || 0}</p>
                    </div>
                  </div>

                  {/* Check-in/out Times */}
                  {(hotel.checkInTime || hotel.checkOutTime) && (
                    <div className="flex items-center gap-2 text-xs text-gray-600 mb-3">
                      <FaClock className="text-gray-400" />
                      <span>
                        Check-in: {hotel.checkInTime || '-'} | Check-out: {hotel.checkOutTime || '-'}
                      </span>
                    </div>
                  )}

                  {/* Contact */}
                  <div className="space-y-1 mb-3">
                    {hotel.phone && (
                      <div className="flex items-center gap-2 text-xs text-gray-600">
                        <FaPhone className="text-gray-400" />
                        <span>{hotel.phone}</span>
                      </div>
                    )}
                    {hotel.email && (
                      <div className="flex items-center gap-2 text-xs text-gray-600">
                        <FaEnvelope className="text-gray-400" />
                        <span className="truncate">{hotel.email}</span>
                      </div>
                    )}
                  </div>

                  {/* Room Types */}
                  {hotel.availableRoomTypes && hotel.availableRoomTypes.length > 0 && (
                    <div className="pt-3 border-t border-gray-100">
                      <p className="text-xs text-gray-500 mb-2">Loại phòng có sẵn:</p>
                      <div className="flex flex-wrap gap-1">
                        {hotel.availableRoomTypes.map(rt => (
                          <span
                            key={rt.id}
                            className="px-2 py-1 bg-blue-50 text-blue-700 rounded text-xs font-medium"
                          >
                            {rt.name} ({rt.count})
                          </span>
                        ))}
                      </div>
                    </div>
                  )}
                </div>
              </div>
            ))}
          </div>

          {/* Pagination */}
          <Pagination
            currentPage={pagination.page}
            totalPages={pagination.totalPages}
            totalElements={pagination.totalElements}
            pageSize={pagination.size}
            onPageChange={handlePageChange}
          />
        </>
      )}

      {/* Empty State */}
      {!loading && hotels.length === 0 && (
        <div className="text-center py-12">
          <div className="w-24 h-24 bg-gray-100 rounded-full flex items-center justify-center mx-auto mb-4">
            <FaBuilding className="text-gray-400 text-4xl" />
          </div>
          <h3 className="text-xl font-semibold text-gray-800 mb-2">Không tìm thấy khách sạn</h3>
          <p className="text-gray-600 mb-4">
            Thử thay đổi bộ lọc hoặc từ khóa tìm kiếm
          </p>
          <button
            onClick={handleResetFilters}
            className="px-6 py-2.5 bg-blue-500 text-white rounded-lg hover:bg-blue-600 transition-colors font-medium"
          >
            Đặt Lại Bộ Lọc
          </button>
        </div>
      )}
    </div>
  );
};

export default HotelManagement;