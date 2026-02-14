import React, { useState, useEffect } from 'react';
import { FaSearch, FaFilter, FaEye, FaEdit, FaTrash, FaPlus } from 'react-icons/fa';
import api from '../../services/api';
import './RoomManagement.css';

const RoomManagement = () => {
  const [rooms, setRooms] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [statusFilter, setStatusFilter] = useState('ALL');

  useEffect(() => {
    fetchRooms();
  }, []);

  const fetchRooms = async () => {
    try {
      setLoading(true);
      const response = await api.get('/rooms');
      setRooms(response.data);
    } catch (error) {
      console.error('Error fetching rooms:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    if (window.confirm('Are you sure you want to delete this room?')) {
      try {
        await api.delete(`/rooms/${id}`);
        fetchRooms();
      } catch (error) {
        console.error('Error deleting room:', error);
      }
    }
  };

  const handleStatusToggle = async (id, currentStatus) => {
    const newStatus = currentStatus === 'AVAILABLE' ? 'OCCUPIED' : 'AVAILABLE';
    try {
      await api.put(`/rooms/${id}/status`, { status: newStatus });
      fetchRooms();
    } catch (error) {
      console.error('Error updating status:', error);
    }
  };

  const filteredRooms = rooms.filter(room => {
    const matchesSearch = room.roomNumber?.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         room.hotelName?.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === 'ALL' || room.status === statusFilter;
    return matchesSearch && matchesStatus;
  });

  if (loading) {
    return <div className="loading">Loading rooms...</div>;
  }

  return (
    <div className="room-management">
      <div className="page-header">
        <h1>Room Management</h1>
        <button className="btn btn-primary">
          <FaPlus /> Add Room
        </button>
      </div>

      <div className="filters-bar">
        <div className="search-box">
          <FaSearch />
          <input
            type="text"
            placeholder="Search by room number or hotel..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        </div>

        <div className="filter-group">
          <FaFilter />
          <select value={statusFilter} onChange={(e) => setStatusFilter(e.target.value)}>
            <option value="ALL">All Status</option>
            <option value="AVAILABLE">Available</option>
            <option value="OCCUPIED">Occupied</option>
            <option value="MAINTENANCE">Maintenance</option>
          </select>
        </div>
      </div>

      <div className="room-grid">
        {filteredRooms.map((room) => (
          <div key={room.id} className="room-card">
            <div className={`room-status-badge ${room.status?.toLowerCase()}`}>
              {room.status}
            </div>
            <div className="room-image">
              <img src={room.imageUrl || '/placeholder-room.jpg'} alt={room.roomNumber} />
            </div>
            <div className="room-details">
              <h3>Room {room.roomNumber}</h3>
              <p className="room-type">{room.roomTypeName}</p>
              <p className="room-hotel">{room.hotelName}</p>
              <div className="room-info">
                <span>Floor: {room.floor}</span>
                <span className="room-price">${room.basePrice}/night</span>
              </div>
            </div>
            <div className="room-actions">
              <button className="btn-icon btn-view" title="View">
                <FaEye />
              </button>
              <button className="btn-icon btn-edit" title="Edit">
                <FaEdit />
              </button>
              <button
                className="btn-icon btn-delete"
                title="Delete"
                onClick={() => handleDelete(room.id)}
              >
                <FaTrash />
              </button>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default RoomManagement;