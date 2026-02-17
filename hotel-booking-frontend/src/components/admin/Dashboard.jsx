import React, { useState, useEffect } from 'react';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  Title,
  Tooltip,
  Legend,
  ArcElement,
} from 'chart.js';
import { Line, Bar, Pie } from 'react-chartjs-2';
import {
  FaHotel,
  FaUsers,
  FaCalendarCheck,
  FaBed,
  FaDollarSign,
  FaStar,
} from 'react-icons/fa';
import api from '../../services/api';

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  Title,
  Tooltip,
  Legend,
  ArcElement
);

const Dashboard = () => {
  const [stats, setStats] = useState(null);
  const [currentYearRevenue, setCurrentYearRevenue] = useState([]);
  const [lastYearRevenue, setLastYearRevenue] = useState([]);
  const [yearlyRevenue, setYearlyRevenue] = useState([]);
  const [hotelsByCity, setHotelsByCity] = useState([]);
  const [hotelsByStar, setHotelsByStar] = useState([]);
  const [topHotelsByBookings, setTopHotelsByBookings] = useState([]);
  const [topHotelsByRating, setTopHotelsByRating] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  const currentYear = new Date().getFullYear();

  useEffect(() => {
    fetchDashboardData();
  }, []);

  const fetchDashboardData = async () => {
    try {
      setLoading(true);
      
      const [
        statsRes,
        currentYearRes,
        lastYearRes,
        yearlyRes,
        cityRes,
        starRes,
        topBookingsRes,
        topRatingsRes
      ] = await Promise.all([
        api.get('/dashboard/stats'),
        api.get(`/dashboard/revenue/monthly?year=${currentYear}`),
        api.get(`/dashboard/revenue/monthly?year=${currentYear - 1}`),
        api.get('/dashboard/revenue/yearly?limit=3'),
        api.get('/dashboard/hotels/by-city'),
        api.get('/dashboard/hotels/by-star'),
        api.get('/dashboard/hotels/top-bookings?limit=3'),
        api.get('/dashboard/hotels/top-ratings?limit=3'),
      ]);

      setStats(statsRes.data);
      setCurrentYearRevenue(currentYearRes.data);
      setLastYearRevenue(lastYearRes.data);
      setYearlyRevenue(yearlyRes.data);
      setHotelsByCity(cityRes.data);
      setHotelsByStar(starRes.data);
      setTopHotelsByBookings(topBookingsRes.data);
      setTopHotelsByRating(topRatingsRes.data);
      
      setError(null);
    } catch (error) {
      console.error('Lỗi khi tải dữ liệu dashboard:', error);
      setError('Không thể tải dữ liệu dashboard. Vui lòng thử lại sau.');
    } finally {
      setLoading(false);
    }
  };

  const formatCurrency = (amount) => {
    if (!amount) return '0';
    const value = parseFloat(amount);
    if (value >= 1000000000) {
      return `${(value / 1000000000).toFixed(1)} Tỷ`;
    } else if (value >= 1000000) {
      return `${(value / 1000000).toFixed(1)} Tr`;
    } else {
      return new Intl.NumberFormat('vi-VN').format(value);
    }
  };

  // Chart Data
  const monthlyComparisonData = {
    labels: ['T1', 'T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'T8', 'T9', 'T10', 'T11', 'T12'],
    datasets: [
      {
        label: `${currentYear}`,
        data: Array.from({ length: 12 }, (_, i) => {
          const found = currentYearRevenue.find(item => item.month === i + 1);
          return found ? found.revenue : 0;
        }),
        borderColor: 'rgb(75, 192, 192)',
        backgroundColor: 'rgba(75, 192, 192, 0.1)',
        tension: 0.4,
        fill: true,
      },
      {
        label: `${currentYear - 1}`,
        data: Array.from({ length: 12 }, (_, i) => {
          const found = lastYearRevenue.find(item => item.month === i + 1);
          return found ? found.revenue : 0;
        }),
        borderColor: 'rgb(255, 99, 132)',
        backgroundColor: 'rgba(255, 99, 132, 0.1)',
        tension: 0.4,
        fill: true,
      },
    ],
  };

  const yearlyRevenueData = {
    labels: yearlyRevenue.map(item => `${item.year}`),
    datasets: [
      {
        label: 'Tổng Doanh Thu (Tỷ)',
        data: yearlyRevenue.map(item => item.totalRevenue / 1000000000),
        backgroundColor: [
          'rgba(54, 162, 235, 0.8)',
          'rgba(255, 206, 86, 0.8)',
          'rgba(75, 192, 192, 0.8)',
        ],
        borderColor: [
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(75, 192, 192, 1)',
        ],
        borderWidth: 2,
      },
    ],
  };

  const hotelsByCityData = {
    labels: hotelsByCity.map(item => item.city),
    datasets: [
      {
        data: hotelsByCity.map(item => item.hotelCount),
        backgroundColor: [
          'rgba(255, 99, 132, 0.8)',
          'rgba(54, 162, 235, 0.8)',
          'rgba(255, 206, 86, 0.8)',
          'rgba(75, 192, 192, 0.8)',
          'rgba(153, 102, 255, 0.8)',
          'rgba(255, 159, 64, 0.8)',
        ],
        borderWidth: 2,
        borderColor: '#fff',
      },
    ],
  };

  const chartOptions = {
    responsive: true,
    maintainAspectRatio: true,
    plugins: {
      legend: {
        display: true,
        position: 'bottom',
      },
    },
  };

  const barChartOptions = {
    responsive: true,
    maintainAspectRatio: true,
    plugins: {
      legend: {
        display: false,
      },
    },
    scales: {
      y: {
        beginAtZero: true,
        ticks: {
          callback: function(value) {
            return value.toFixed(1) + ' Tỷ';
          }
        }
      },
    },
  };

  if (loading) {
    return (
      <div className="flex flex-col items-center justify-center min-h-screen bg-gray-50">
        <div className="w-12 h-12 border-4 border-gray-200 border-t-blue-500 rounded-full animate-spin-slow"></div>
        <p className="mt-4 text-lg text-gray-600">Đang tải dữ liệu dashboard...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="flex flex-col items-center justify-center min-h-screen bg-gray-50 px-4">
        <p className="text-lg text-red-500 text-center mb-5">{error}</p>
        <button 
          onClick={fetchDashboardData} 
          className="px-6 py-3 bg-blue-500 text-white rounded-lg font-medium hover:bg-blue-600 transition-colors"
        >
          Thử Lại
        </button>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50 p-6 lg:p-8">
      {/* Header */}
      <div className="flex flex-col lg:flex-row justify-between items-start lg:items-center mb-6 lg:mb-8 gap-4">
      <div>
        <h1 className="text-2xl lg:text-3xl font-bold text-gray-800 mb-2">Trang Tổng Quan</h1>
        <p className="text-sm lg:text-base text-gray-600">Chào mừng trở lại! Đây là những gì đang diễn ra trong hệ thống khách sạn của bạn hôm nay.</p>
      </div>
      <div className="flex gap-3 lg:gap-5 w-full lg:w-auto">
        <div className="flex items-center gap-2 lg:gap-3 px-3 lg:px-5 py-2 lg:py-3 bg-white rounded-xl shadow-card flex-1 lg:flex-initial">
          <FaHotel className="text-xl lg:text-2xl text-blue-500" />
          <div>
            <span className="block text-lg lg:text-xl font-bold text-gray-800">{stats?.totalHotels || 0}</span>
            <span className="block text-xs text-gray-500">Khách Sạn</span>
          </div>
        </div>
        <div className="flex items-center gap-2 lg:gap-3 px-3 lg:px-5 py-2 lg:py-3 bg-white rounded-xl shadow-card flex-1 lg:flex-initial">
          <FaUsers className="text-xl lg:text-2xl text-blue-500" />
          <div>
            <span className="block text-lg lg:text-xl font-bold text-gray-800">{stats?.totalUsers || 0}</span>
            <span className="block text-xs text-gray-500">Người Dùng</span>
          </div>
        </div>
      </div>
    </div>

      {/* Main Stats Cards */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-5 mb-8">
        {/* Khách sạn hoạt động */}
        <div className="bg-[#5e72e4] text-white rounded-xl p-6 shadow-lg hover:-translate-y-1 transition-transform">
          <div className="flex items-center gap-5">
            <div className="w-15 h-15 bg-white bg-opacity-20 rounded-xl flex items-center justify-center">
              <FaHotel className="text-3xl" />
            </div>
            <div>
              <h3 className="text-3xl font-bold mb-1">{stats?.activeHotels || 0}/{stats?.totalHotels || 0}</h3>
              <p className="text-sm opacity-90">Khách Sạn Hoạt Động</p>
            </div>
          </div>
        </div>

        {/* Đơn đặt phòng */}
        <div className="bg-[#2dce89] text-white rounded-xl p-6 shadow-lg hover:-translate-y-1 transition-transform">
          <div className="flex items-center gap-5">
            <div className="w-15 h-15 bg-white bg-opacity-20 rounded-xl flex items-center justify-center">
              <FaCalendarCheck className="text-3xl" />
            </div>
            <div>
              <h3 className="text-3xl font-bold mb-1">{stats?.activeBookings || 0}/{stats?.totalBookings || 0}</h3>
              <p className="text-sm opacity-90">Đơn Đặt Phòng Hoạt Động</p>
            </div>
          </div>
        </div>

        {/* Doanh thu */}
        <div className="bg-[#825ee4] text-white rounded-xl p-6 shadow-lg hover:-translate-y-1 transition-transform">
          <div className="flex items-center gap-5">
            <div className="w-15 h-15 bg-white bg-opacity-20 rounded-xl flex items-center justify-center">
              <FaDollarSign className="text-3xl" />
            </div>
            <div>
              <h3 className="text-3xl font-bold mb-1">{formatCurrency(stats?.monthlyRevenue)}</h3>
              <p className="text-sm opacity-90">Doanh Thu Tháng {new Date().getMonth() + 1}/{currentYear}</p>
            </div>
          </div>
        </div>

        {/* Tổng số phòng */}
        <div className="bg-[#fb6340] text-white rounded-xl p-6 shadow-lg hover:-translate-y-1 transition-transform">
          <div className="flex items-center gap-5">
            <div className="w-15 h-15 bg-white bg-opacity-20 rounded-xl flex items-center justify-center">
              <FaBed className="text-3xl" />
            </div>
            <div>
              <h3 className="text-3xl font-bold mb-1">{stats?.totalRooms || 0}</h3>
              <p className="text-sm opacity-90">Tổng Số Phòng</p>
            </div>
          </div>
        </div>
      </div>
      
      <div className="grid grid-cols-1 md:grid-cols-3 gap-5 mb-8">
        {/* Phòng Đang Thuê */}
        <div className="bg-white rounded-xl p-5 shadow-card border-l-4 border-red-500 hover:shadow-card-hover transition-shadow">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500 font-medium mb-1">Phòng Đang Thuê</p>
              <h3 className="text-3xl font-bold text-gray-800">{stats?.occupiedRooms || 0}</h3>
            </div>
            <div className="w-14 h-14 bg-red-50 rounded-lg flex items-center justify-center">
              <svg className="w-7 h-7 text-red-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
              </svg>
            </div>
          </div>
          <div className="mt-3 pt-3 border-t border-gray-100">
            <div className="flex items-center text-xs text-gray-600">
              <span className="inline-block w-2 h-2 bg-red-500 rounded-full mr-2"></span>
              Không thể đặt
            </div>
          </div>
        </div>

        {/* Phòng Còn Trống */}
        <div className="bg-white rounded-xl p-5 shadow-card border-l-4 border-green-500 hover:shadow-card-hover transition-shadow">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500 font-medium mb-1">Phòng Còn Trống</p>
              <h3 className="text-3xl font-bold text-gray-800">{stats?.availableRooms || 0}</h3>
            </div>
            <div className="w-14 h-14 bg-green-50 rounded-lg flex items-center justify-center">
              <svg className="w-7 h-7 text-green-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z" />
              </svg>
            </div>
          </div>
          <div className="mt-3 pt-3 border-t border-gray-100">
            <div className="flex items-center text-xs text-gray-600">
              <span className="inline-block w-2 h-2 bg-green-500 rounded-full mr-2"></span>
              Sẵn sàng cho thuê
            </div>
          </div>
        </div>

        {/* Phòng Bảo Trì */}
        <div className="bg-white rounded-xl p-5 shadow-card border-l-4 border-yellow-500 hover:shadow-card-hover transition-shadow">
          <div className="flex items-center justify-between">
            <div>
              <p className="text-sm text-gray-500 font-medium mb-1">Phòng Bảo Trì</p>
              <h3 className="text-3xl font-bold text-gray-800">{stats?.maintenanceRooms || 0}</h3>
            </div>
            <div className="w-14 h-14 bg-yellow-50 rounded-lg flex items-center justify-center">
              <svg className="w-7 h-7 text-yellow-500" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z" />
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M15 12a3 3 0 11-6 0 3 3 0 016 0z" />
              </svg>
            </div>
          </div>
          <div className="mt-3 pt-3 border-t border-gray-100">
            <div className="flex items-center text-xs text-gray-600">
              <span className="inline-block w-2 h-2 bg-yellow-500 rounded-full mr-2"></span>
              Đang sửa chữa
            </div>
          </div>
        </div>
      </div>

      {/* Main Content Grid */}
      <div className="grid grid-cols-1 lg:grid-cols-3 gap-6">
        {/* Left Column - Charts (2/3 width) */}
        <div className="lg:col-span-2 space-y-6">
          {/* Monthly Revenue Chart */}
          <div className="bg-white rounded-xl shadow-card p-6 border border-gray-100">
            <div className="mb-5 pb-3 border-b-2 border-gray-100">
              <h2 className="text-lg font-semibold text-gray-800">Doanh Thu Theo Tháng</h2>
              <span className="text-xs text-gray-500">So sánh {currentYear} vs {currentYear - 1}</span>
            </div>
            <div className="h-96">
              <Line data={monthlyComparisonData} options={chartOptions} />
            </div>
          </div>

          {/* Yearly Revenue Chart */}
          <div className="bg-white rounded-xl shadow-card p-6 border border-gray-100">
            <div className="mb-5 pb-3 border-b-2 border-gray-100">
              <h2 className="text-lg font-semibold text-gray-800">Tổng Doanh Thu Theo Năm</h2>
              <span className="text-xs text-gray-500">3 Năm Gần Nhất (Đơn vị: Tỷ VNĐ)</span>
            </div>
            <div className="h-80">
              <Bar data={yearlyRevenueData} options={barChartOptions} />
            </div>
          </div>

          {/* Top Hotels Grid */}
          <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
            {/* Top by Bookings */}
            <div className="bg-white rounded-xl shadow-card border border-gray-100 overflow-hidden">
              <div className="flex items-center gap-2 px-5 py-4 bg-gray-50 border-b-2 border-gray-100">
                <FaCalendarCheck className="text-lg text-blue-500" />
                <h3 className="text-sm font-semibold text-gray-800">Top 3 Đặt Nhiều Nhất</h3>
              </div>
              <div className="p-4 space-y-3">
                {topHotelsByBookings.map((hotel, index) => (
                  <div key={hotel.hotelId} className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors">
                    <div className={`w-9 h-9 rounded-lg flex items-center justify-center text-white font-bold text-sm
                      ${index === 0 ? 'bg-yellow-500' : index === 1 ? 'bg-gray-400' : 'bg-orange-600'}`}>
                      {index + 1}
                    </div>
                    <div className="flex-1 min-w-0">
                      <h4 className="text-sm font-semibold text-gray-800 truncate">{hotel.hotelName}</h4>
                      <span className="text-xs text-gray-500">{hotel.bookingCount} đơn</span>
                    </div>
                  </div>
                ))}
              </div>
            </div>

            {/* Top by Rating */}
            <div className="bg-white rounded-xl shadow-card border border-gray-100 overflow-hidden">
              <div className="flex items-center gap-2 px-5 py-4 bg-gray-50 border-b-2 border-gray-100">
                <FaStar className="text-lg text-yellow-500" />
                <h3 className="text-sm font-semibold text-gray-800">Top 3 Đánh Giá Cao</h3>
              </div>
              <div className="p-4 space-y-3">
                {topHotelsByRating.map((hotel, index) => (
                  <div key={hotel.hotelId} className="flex items-center gap-3 p-3 bg-gray-50 rounded-lg hover:bg-gray-100 transition-colors">
                    <div className={`w-9 h-9 rounded-lg flex items-center justify-center text-white font-bold text-sm
                      ${index === 0 ? 'bg-yellow-500' : index === 1 ? 'bg-gray-400' : 'bg-orange-600'}`}>
                      {index + 1}
                    </div>
                    <div className="flex-1 min-w-0 pt-1">
                      <h4 className="text-sm font-semibold text-gray-800 truncate">{hotel.hotelName}</h4>
                      <div className="flex items-center gap-1.5">
                        <FaStar className="text-xs text-yellow-500" />
                        <span className="text-sm font-bold text-gray-800">{hotel.averageRating.toFixed(1)}</span>
                        <span className="text-xs text-gray-500">({hotel.reviewCount})</span>
                      </div>
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>

        {/* Right Column - Sidebar (1/3 width) */}
        <div className="space-y-6">
          {/* Star Distribution */}
          <div className="bg-white rounded-xl shadow-card border border-gray-100 overflow-hidden">
            <div className="flex items-center gap-2 px-5 py-4 bg-gray-50 border-b-2 border-gray-100">
              <FaStar className="text-lg text-yellow-500" />
              <h3 className="text-sm font-semibold text-gray-800">Phân Bố Theo Số Sao</h3>
            </div>
            <div className="p-5 space-y-4">
              {hotelsByStar.sort((a, b) => b.starRating - a.starRating).map((item) => (
                <div key={item.starRating} className="flex justify-between items-center p-4 bg-gray-50 rounded-lg border-l-4 border-yellow-500 hover:bg-gray-100 transition-colors">
                  <div>
                    <div className="flex gap-0.5 mb-1">
                      {Array.from({ length: item.starRating }).map((_, i) => (
                        <FaStar key={i} className="text-sm text-yellow-500" />
                      ))}
                    </div>
                    <span className="text-xs text-gray-500">{item.starRating} Sao</span>
                  </div>
                  <div className="text-right">
                    <span className="block text-2xl font-bold text-gray-800">{item.hotelCount}</span>
                    <span className="text-xs text-gray-500">khách sạn</span>
                  </div>
                </div>
              ))}
            </div>
          </div>

          {/* City Distribution */}
          <div className="bg-white rounded-xl shadow-card p-6 border border-gray-100">
            <div className="mb-5 pb-3 border-b-2 border-gray-100">
              <h2 className="text-lg font-semibold text-gray-800">KS Phân Bố Theo TP</h2>
            </div>
            <div className="h-72">
              <Pie data={hotelsByCityData} options={chartOptions} />
            </div>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;