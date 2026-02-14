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
import { Line, Doughnut } from 'react-chartjs-2';
import {
  FaHotel,
  FaUsers,
  FaDollarSign,
  FaCalendarCheck,
  FaStar,
  FaChartLine,
} from 'react-icons/fa';
import './Dashboard.css';
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
  const [monthlyRevenue, setMonthlyRevenue] = useState([]);
  const [recentBookings, setRecentBookings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);

  useEffect(() => {
    fetchDashboardData();
  }, []);

  const fetchDashboardData = async () => {
    try {
      setLoading(true);
      const [statsRes, revenueRes, bookingsRes] = await Promise.all([
        api.get('/dashboard/stats'),
        api.get('/dashboard/revenue/monthly?year=' + new Date().getFullYear()),
        api.get('/dashboard/bookings/recent?limit=10'),
      ]);

      setStats(statsRes.data);
      setMonthlyRevenue(revenueRes.data);
      setRecentBookings(bookingsRes.data);
      setError(null);
    } catch (error) {
      console.error('Error fetching dashboard data:', error);
      setError('Failed to load dashboard data. Please try again later.');
    } finally {
      setLoading(false);
    }
  };

  // Revenue Chart Data
  const revenueChartData = {
    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
    datasets: [
      {
        label: 'Revenue ($)',
        data: monthlyRevenue.length > 0
          ? Array.from({ length: 12 }, (_, i) => {
              const found = monthlyRevenue.find(item => item.month === i + 1);
              return found ? found.revenue : 0;
            })
          : Array(12).fill(0),
        borderColor: 'rgb(75, 192, 192)',
        backgroundColor: 'rgba(75, 192, 192, 0.2)',
        tension: 0.4,
        fill: true,
      },
    ],
  };

  const revenueChartOptions = {
    responsive: true,
    maintainAspectRatio: true,
    plugins: {
      legend: {
        display: true,
        position: 'top',
      },
      title: {
        display: false,
      },
    },
    scales: {
      y: {
        beginAtZero: true,
        ticks: {
          callback: function(value) {
            return '$' + value.toLocaleString();
          }
        }
      }
    }
  };

  // Room Status Chart Data
  const roomStatusData = {
    labels: ['Available', 'Occupied', 'Maintenance'],
    datasets: [
      {
        data: [
          stats?.availableRooms || 0,
          (stats?.totalRooms - stats?.availableRooms) || 0,
          0, // Maintenance - you can add this field if needed
        ],
        backgroundColor: [
          'rgba(75, 192, 192, 0.8)',
          'rgba(255, 99, 132, 0.8)',
          'rgba(255, 206, 86, 0.8)',
        ],
        borderColor: [
          'rgba(75, 192, 192, 1)',
          'rgba(255, 99, 132, 1)',
          'rgba(255, 206, 86, 1)',
        ],
        borderWidth: 1,
      },
    ],
  };

  const roomStatusOptions = {
    responsive: true,
    maintainAspectRatio: true,
    plugins: {
      legend: {
        display: true,
        position: 'bottom',
      },
    },
  };

  const formatCurrency = (amount) => {
    return new Intl.NumberFormat('en-US', {
      style: 'currency',
      currency: 'USD',
    }).format(amount || 0);
  };

  const formatDate = (dateString) => {
    return new Date(dateString).toLocaleDateString('en-US', {
      year: 'numeric',
      month: 'short',
      day: 'numeric',
    });
  };

  const getStatusBadgeClass = (status) => {
    const statusLower = status?.toLowerCase();
    switch (statusLower) {
      case 'confirmed':
        return 'status-badge confirmed';
      case 'checked_in':
        return 'status-badge checked-in';
      case 'checked_out':
        return 'status-badge checked-out';
      case 'cancelled':
        return 'status-badge cancelled';
      case 'pending':
        return 'status-badge pending';
      default:
        return 'status-badge';
    }
  };

  if (loading) {
    return (
      <div className="dashboard-loading">
        <div className="spinner"></div>
        <p>Loading dashboard...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="dashboard-error">
        <p>{error}</p>
        <button onClick={fetchDashboardData} className="retry-button">
          Retry
        </button>
      </div>
    );
  }

  return (
    <div className="dashboard">
      <div className="dashboard-header">
        <h1>Dashboard</h1>
        <p>Welcome back! Here's what's happening with your hotel today.</p>
      </div>

      {/* Stats Cards */}
      <div className="stats-grid">
        <div className="stat-card">
          <div className="stat-icon blue">
            <FaCalendarCheck />
          </div>
          <div className="stat-details">
            <h3>{stats?.totalBookings || 0}</h3>
            <p>Total Bookings</p>
            <span className="stat-badge active">{stats?.activeBookings || 0} Active</span>
          </div>
        </div>

        <div className="stat-card">
          <div className="stat-icon green">
            <FaDollarSign />
          </div>
          <div className="stat-details">
            <h3>{formatCurrency(stats?.monthlyRevenue)}</h3>
            <p>Monthly Revenue</p>
            <span className="stat-badge positive">This Month</span>
          </div>
        </div>

        <div className="stat-card">
          <div className="stat-icon orange">
            <FaHotel />
          </div>
          <div className="stat-details">
            <h3>{stats?.totalRooms || 0}</h3>
            <p>Total Rooms</p>
            <span className="stat-badge">{stats?.availableRooms || 0} Available</span>
          </div>
        </div>

        <div className="stat-card">
          <div className="stat-icon pink">
            <FaUsers />
          </div>
          <div className="stat-details">
            <h3>{stats?.totalUsers || 0}</h3>
            <p>Total Users</p>
            <span className="stat-badge">Registered</span>
          </div>
        </div>

        <div className="stat-card">
          <div className="stat-icon purple">
            <FaStar />
          </div>
          <div className="stat-details">
            <h3>{stats?.averageRating?.toFixed(1) || '0.0'}</h3>
            <p>Average Rating</p>
            <span className="stat-badge">⭐ Rating</span>
          </div>
        </div>

        <div className="stat-card">
          <div className="stat-icon teal">
            <FaChartLine />
          </div>
          <div className="stat-details">
            <h3>{stats?.occupancyRate?.toFixed(1) || '0.0'}%</h3>
            <p>Occupancy Rate</p>
            <span className="stat-badge positive">
              {stats?.occupancyRate > 70 ? 'High' : stats?.occupancyRate > 40 ? 'Medium' : 'Low'}
            </span>
          </div>
        </div>
      </div>

      {/* Charts Section */}
      <div className="charts-grid">
        <div className="chart-card">
          <div className="chart-header">
            <h2>Revenue Overview</h2>
            <span className="chart-subtitle">{new Date().getFullYear()}</span>
          </div>
          <div className="chart-container">
            <Line data={revenueChartData} options={revenueChartOptions} />
          </div>
        </div>

        <div className="chart-card">
          <div className="chart-header">
            <h2>Room Status</h2>
            <span className="chart-subtitle">Current Status</span>
          </div>
          <div className="chart-container doughnut">
            <Doughnut data={roomStatusData} options={roomStatusOptions} />
          </div>
        </div>
      </div>

      {/* Recent Bookings */}
      <div className="recent-bookings">
        <div className="section-header">
          <h2>Recent Bookings</h2>
          <button className="view-all-btn">View All</button>
        </div>
        <div className="table-container">
          {recentBookings.length > 0 ? (
            <table>
              <thead>
                <tr>
                  <th>Booking Code</th>
                  <th>Guest Name</th>
                  <th>Room</th>
                  <th>Check-in</th>
                  <th>Check-out</th>
                  <th>Total Price</th>
                  <th>Status</th>
                </tr>
              </thead>
              <tbody>
                {recentBookings.map((booking) => (
                  <tr key={booking.id}>
                    <td className="booking-code">{booking.bookingCode}</td>
                    <td>{booking.guestName}</td>
                    <td>{booking.roomNumber || 'N/A'}</td>
                    <td>{formatDate(booking.checkInDate)}</td>
                    <td>{formatDate(booking.checkOutDate)}</td>
                    <td className="price">{formatCurrency(booking.totalPrice)}</td>
                    <td>
                      <span className={getStatusBadgeClass(booking.status)}>
                        {booking.status}
                      </span>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          ) : (
            <div className="no-data">
              <p>No recent bookings found</p>
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default Dashboard;