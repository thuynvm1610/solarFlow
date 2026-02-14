import React, { useState, useEffect } from 'react';
import { FaSearch, FaFilter, FaEye, FaEdit, FaTrash, FaPlus } from 'react-icons/fa';
import api from '../../services/api';
import './BookingManagement.css';

const BookingManagement = () => {
  const [bookings, setBookings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [searchTerm, setSearchTerm] = useState('');
  const [statusFilter, setStatusFilter] = useState('ALL');
  const [currentPage, setCurrentPage] = useState(1);
  const [itemsPerPage] = useState(10);

  useEffect(() => {
    fetchBookings();
  }, []);

  const fetchBookings = async () => {
    try {
      setLoading(true);
      const response = await api.get('/bookings');
      setBookings(response.data);
    } catch (error) {
      console.error('Error fetching bookings:', error);
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    if (window.confirm('Are you sure you want to delete this booking?')) {
      try {
        await api.delete(`/bookings/${id}`);
        fetchBookings();
      } catch (error) {
        console.error('Error deleting booking:', error);
      }
    }
  };

  const handleStatusChange = async (id, newStatus) => {
    try {
      await api.put(`/bookings/${id}/status`, { status: newStatus });
      fetchBookings();
    } catch (error) {
      console.error('Error updating status:', error);
    }
  };

  const filteredBookings = bookings.filter(booking => {
    const matchesSearch = booking.bookingCode?.toLowerCase().includes(searchTerm.toLowerCase()) ||
                         booking.guestName?.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesStatus = statusFilter === 'ALL' || booking.status === statusFilter;
    return matchesSearch && matchesStatus;
  });

  const indexOfLastItem = currentPage * itemsPerPage;
  const indexOfFirstItem = indexOfLastItem - itemsPerPage;
  const currentItems = filteredBookings.slice(indexOfFirstItem, indexOfLastItem);
  const totalPages = Math.ceil(filteredBookings.length / itemsPerPage);

  const getStatusClass = (status) => {
    const statusMap = {
      'CONFIRMED': 'status-confirmed',
      'CHECKED_IN': 'status-checked-in',
      'CHECKED_OUT': 'status-checked-out',
      'CANCELLED': 'status-cancelled',
      'PENDING': 'status-pending',
    };
    return statusMap[status] || '';
  };

  if (loading) {
    return <div className="loading">Loading bookings...</div>;
  }

  return (
    <div className="booking-management">
      <div className="page-header">
        <h1>Booking Management</h1>
        <button className="btn btn-primary">
          <FaPlus /> New Booking
        </button>
      </div>

      <div className="filters-bar">
        <div className="search-box">
          <FaSearch />
          <input
            type="text"
            placeholder="Search by booking code or guest name..."
            value={searchTerm}
            onChange={(e) => setSearchTerm(e.target.value)}
          />
        </div>

        <div className="filter-group">
          <FaFilter />
          <select value={statusFilter} onChange={(e) => setStatusFilter(e.target.value)}>
            <option value="ALL">All Status</option>
            <option value="PENDING">Pending</option>
            <option value="CONFIRMED">Confirmed</option>
            <option value="CHECKED_IN">Checked In</option>
            <option value="CHECKED_OUT">Checked Out</option>
            <option value="CANCELLED">Cancelled</option>
          </select>
        </div>
      </div>

      <div className="stats-cards">
        <div className="stat-card">
          <h3>{bookings.filter(b => b.status === 'PENDING').length}</h3>
          <p>Pending</p>
        </div>
        <div className="stat-card">
          <h3>{bookings.filter(b => b.status === 'CONFIRMED').length}</h3>
          <p>Confirmed</p>
        </div>
        <div className="stat-card">
          <h3>{bookings.filter(b => b.status === 'CHECKED_IN').length}</h3>
          <p>Checked In</p>
        </div>
        <div className="stat-card">
          <h3>{bookings.filter(b => b.status === 'CHECKED_OUT').length}</h3>
          <p>Checked Out</p>
        </div>
      </div>

      <div className="table-container">
        <table className="data-table">
          <thead>
            <tr>
              <th>Booking Code</th>
              <th>Guest Name</th>
              <th>Hotel</th>
              <th>Check-in</th>
              <th>Check-out</th>
              <th>Total Price</th>
              <th>Status</th>
              <th>Actions</th>
            </tr>
          </thead>
          <tbody>
            {currentItems.map((booking) => (
              <tr key={booking.id}>
                <td className="booking-code">{booking.bookingCode}</td>
                <td>{booking.guestName}</td>
                <td>{booking.hotelName}</td>
                <td>{new Date(booking.checkInDate).toLocaleDateString()}</td>
                <td>{new Date(booking.checkOutDate).toLocaleDateString()}</td>
                <td className="price">${booking.totalPrice}</td>
                <td>
                  <select
                    className={`status-select ${getStatusClass(booking.status)}`}
                    value={booking.status}
                    onChange={(e) => handleStatusChange(booking.id, e.target.value)}
                  >
                    <option value="PENDING">Pending</option>
                    <option value="CONFIRMED">Confirmed</option>
                    <option value="CHECKED_IN">Checked In</option>
                    <option value="CHECKED_OUT">Checked Out</option>
                    <option value="CANCELLED">Cancelled</option>
                  </select>
                </td>
                <td>
                  <div className="action-buttons">
                    <button className="btn-icon btn-view" title="View">
                      <FaEye />
                    </button>
                    <button className="btn-icon btn-edit" title="Edit">
                      <FaEdit />
                    </button>
                    <button
                      className="btn-icon btn-delete"
                      title="Delete"
                      onClick={() => handleDelete(booking.id)}
                    >
                      <FaTrash />
                    </button>
                  </div>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>

      <div className="pagination">
        <button
          onClick={() => setCurrentPage(prev => Math.max(prev - 1, 1))}
          disabled={currentPage === 1}
        >
          Previous
        </button>
        <span>Page {currentPage} of {totalPages}</span>
        <button
          onClick={() => setCurrentPage(prev => Math.min(prev + 1, totalPages))}
          disabled={currentPage === totalPages}
        >
          Next
        </button>
      </div>
    </div>
  );
};

export default BookingManagement;