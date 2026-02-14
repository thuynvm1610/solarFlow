import React, { useState, useEffect } from 'react';
import { FaSearch, FaFilter, FaEye, FaEdit, FaTrash, FaPlus, FaStar, FaMapMarkerAlt } from 'react-icons/fa';
import api from '../../services/api';
import './HotelManagement.css';

const HotelManagement = () => {
  const [hotels, setHotels] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [cityFilter, setCityFilter] = useState('ALL');

  useEffect(() => {
    fetchHotels();
  }, []);

  const fetchHotels = async () => {
    try {
      setLoading(true);
      const response = await api.get('/hotels');
      setHotels(response.data);
    } catch (error) {
      console.error('Error fetching hotels:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    if (window.confirm('Are you sure you want to delete this hotel?')) {
      try {
        await api.delete(`/hotels/${id}`);
        fetchHotels();
      } catch (error) {
        console.error('Error deleting hotel:', error);
      }
    }
  };

  const filteredHotels = hotels.filter(hotel => {
    const matchesSearch = hotel.name?.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         hotel.address?.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesCity = cityFilter === 'ALL' || hotel.city === cityFilter;
    return matchesSearch && matchesCity;
  });

  const cities = [...new Set(hotels.map(h => h.city))];

  if (loading) {
    return <div className="loading">Loading hotels...</div>;
  }

  return (
    <div className="hotel-management">
      <div className="page-header">
        <h1>Hotel Management</h1>
        <button className="btn btn-primary">
          <FaPlus /> Add Hotel
        </button>
      </div>

      <div className="filters-bar">
        <div className="search-box">
          <FaSearch />
          <input
            type="text"
            placeholder="Search hotels..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        </div>

        <div className="filter-group">
          <FaFilter />
          <select value={cityFilter} onChange={(e) => setCityFilter(e.target.value)}>
            <option value="ALL">All Cities</option>
            {cities.map(city => (
              <option key={city} value={city}>{city}</option>
            ))}
          </select>
        </div>
      </div>

      <div className="hotel-grid">
        {filteredHotels.map((hotel) => (
          <div key={hotel.id} className="hotel-card">
            <div className="hotel-image">
              <img src={hotel.imageUrl || '/placeholder-hotel.jpg'} alt={hotel.name} />
              <div className="hotel-rating">
                <FaStar /> {hotel.starRating}
              </div>
            </div>
            <div className="hotel-content">
              <h3>{hotel.name}</h3>
              <p className="hotel-type">{hotel.type}</p>
              <div className="hotel-location">
                <FaMapMarkerAlt />
                <span>{hotel.city}, {hotel.address}</span>
              </div>
              <div className="hotel-stats">
                <div className="stat-item">
                  <span className="stat-label">Rooms</span>
                  <span className="stat-value">{hotel.totalRooms || 0}</span>
                </div>
                <div className="stat-item">
                  <span className="stat-label">Floor</span>
                  <span className="stat-value">{hotel.floor}</span>
                </div>
                <div className="stat-item">
                  <span className="stat-label">Rating</span>
                  <span className="stat-value">{hotel.reviewRating || '0.0'}</span>
                </div>
              </div>
              <div className="hotel-actions">
                <button className="btn-icon btn-view" title="View">
                  <FaEye />
                </button>
                <button className="btn-icon btn-edit" title="Edit">
                  <FaEdit />
                </button>
                <button
                  className="btn-icon btn-delete"
                  title="Delete"
                  onClick={() => handleDelete(hotel.id)}
                >
                  <FaTrash />
                </button>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default HotelManagement;