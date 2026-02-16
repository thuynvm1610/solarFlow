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
import { Line, Bar, Doughnut, Pie } from 'react-chartjs-2';
import {
  FaHotel,
  FaUsers,
  FaCalendarCheck,
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

  // Biểu đồ 1: Doanh thu 12 tháng (năm hiện tại vs năm trước)
  const monthlyComparisonData = {
    labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6', 
             'Tháng 7', 'Tháng 8', 'Tháng 9', 'Tháng 10', 'Tháng 11', 'Tháng 12'],
    datasets: [
      {
        label: `Năm ${currentYear}`,
        data: Array.from({ length: 12 }, (_, i) => {
          const found = currentYearRevenue.find(item => item.month === i + 1);
          return found ? found.revenue : 0;
        }),
        borderColor: 'rgb(75, 192, 192)',
        backgroundColor: 'rgba(75, 192, 192, 0.2)',
        tension: 0.4,
      },
      {
        label: `Năm ${currentYear - 1}`,
        data: Array.from({ length: 12 }, (_, i) => {
          const found = lastYearRevenue.find(item => item.month === i + 1);
          return found ? found.revenue : 0;
        }),
        borderColor: 'rgb(255, 99, 132)',
        backgroundColor: 'rgba(255, 99, 132, 0.2)',
        tension: 0.4,
      },
    ],
  };

  // Biểu đồ 2: Tổng doanh thu 3 năm gần nhất
  const yearlyRevenueData = {
    labels: yearlyRevenue.map(item => `Năm ${item.year}`),
    datasets: [
      {
        label: 'Tổng Doanh Thu',
        data: yearlyRevenue.map(item => item.totalRevenue),
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
        borderWidth: 1,
      },
    ],
  };

  // Biểu đồ 3: Số lượng khách sạn theo thành phố
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
          'rgba(201, 203, 207, 0.8)',
          'rgba(255, 99, 71, 0.8)',
        ],
        borderWidth: 1,
      },
    ],
  };

  // Biểu đồ 4: Top 3 khách sạn có lượng đặt phòng nhiều nhất
  const topBookingsData = {
    labels: topHotelsByBookings.map(item => item.hotelName),
    datasets: [
      {
        label: 'Số Lượng Đặt Phòng',
        data: topHotelsByBookings.map(item => item.bookingCount),
        backgroundColor: 'rgba(75, 192, 192, 0.8)',
        borderColor: 'rgba(75, 192, 192, 1)',
        borderWidth: 1,
      },
    ],
  };

  // Biểu đồ 5: Top 3 khách sạn có đánh giá cao nhất
  const topRatingsData = {
    labels: topHotelsByRating.map(item => item.hotelName),
    datasets: [
      {
        label: 'Điểm Đánh Giá Trung Bình',
        data: topHotelsByRating.map(item => item.averageRating),
        backgroundColor: 'rgba(255, 206, 86, 0.8)',
        borderColor: 'rgba(255, 206, 86, 1)',
        borderWidth: 1,
      },
    ],
  };

  // Biểu đồ 6: Số khách sạn theo số sao
  const hotelsByStarData = {
    labels: hotelsByStar.map(item => `${item.starRating} Sao`),
    datasets: [
      {
        label: 'Số Lượng Khách Sạn',
        data: hotelsByStar.map(item => item.hotelCount),
        backgroundColor: [
          'rgba(255, 99, 132, 0.8)',
          'rgba(54, 162, 235, 0.8)',
          'rgba(255, 206, 86, 0.8)',
          'rgba(75, 192, 192, 0.8)',
          'rgba(153, 102, 255, 0.8)',
        ],
        borderWidth: 1,
      },
    ],
  };

  const chartOptions = {
    responsive: true,
    maintainAspectRatio: true,
    plugins: {
      legend: {
        display: true,
        position: 'top',
      },
    },
  };

  const barChartOptions = {
    ...chartOptions,
    scales: {
      y: {
        beginAtZero: true,
      },
    },
  };

  const formatCurrency = (amount) => {
    return new Intl.NumberFormat('vi-VN', {
      style: 'currency',
      currency: 'VND',
    }).format(amount || 0);
  };

  if (loading) {
    return (
      <div className="dashboard-loading">
        <div className="spinner"></div>
        <p>Đang tải dữ liệu dashboard...</p>
      </div>
    );
  }

  if (error) {
    return (
      <div className="dashboard-error">
        <p>{error}</p>
        <button onClick={fetchDashboardData} className="retry-button">
          Thử Lại
        </button>
      </div>
    );
  }

  return (
    <div className="dashboard">
      <div className="dashboard-header">
        <h1>Trang Tổng Quan</h1>
        <p>Chào mừng trở lại! Đây là những gì đang diễn ra trong hệ thống khách sạn của bạn hôm nay.</p>
      </div>

      {/* Thẻ Thống Kê */}
      <div className="stats-grid">
        <div className="stat-card">
          <div className="stat-icon blue">
            <FaHotel />
          </div>
          <div className="stat-details">
            <h3>{stats?.totalHotels || 0}</h3>
            <p>Tổng Số Khách Sạn</p>
          </div>
        </div>

        <div className="stat-card">
          <div className="stat-icon green">
            <FaCalendarCheck />
          </div>
          <div className="stat-details">
            <h3>{stats?.totalBookings || 0}</h3>
            <p>Tổng Số Đặt Phòng</p>
            <span className="stat-badge active">{stats?.activeBookings || 0} Đang Hoạt Động</span>
          </div>
        </div>

        <div className="stat-card">
          <div className="stat-icon orange">
            <FaUsers />
          </div>
          <div className="stat-details">
            <h3>{stats?.totalUsers || 0}</h3>
            <p>Tổng Số Người Dùng</p>
          </div>
        </div>
      </div>

      {/* Dòng 1: So sánh doanh thu 2 năm (Thu nhỏ) + Biểu đồ khác */}
      <div className="chart-row">
        <div className="chart-card small">
          <div className="chart-header">
            <h2>So Sánh Doanh Thu Theo Tháng</h2>
            <span className="chart-subtitle">{currentYear} vs {currentYear - 1}</span>
          </div>
          <div className="chart-container small">
            <Line data={monthlyComparisonData} options={chartOptions} />
          </div>
        </div>

        <div className="chart-card small">
          <div className="chart-header">
            <h2>Tổng Doanh Thu Theo Năm</h2>
            <span className="chart-subtitle">3 Năm Gần Nhất</span>
          </div>
          <div className="chart-container small">
            <Bar data={yearlyRevenueData} options={barChartOptions} />
          </div>
        </div>
      </div>

      {/* Dòng 2: Khách sạn theo thành phố */}
      <div className="chart-row">
        <div className="chart-card medium">
          <div className="chart-header">
            <h2>Phân Bố Khách Sạn Theo Thành Phố</h2>
            <span className="chart-subtitle">Biểu Đồ Quạt</span>
          </div>
          <div className="chart-container medium">
            <Pie data={hotelsByCityData} options={chartOptions} />
          </div>
        </div>

        <div className="chart-card medium">
          <div className="chart-header">
            <h2>Phân Bố Theo Số Sao</h2>
            <span className="chart-subtitle">Chất Lượng Khách Sạn</span>
          </div>
          <div className="chart-container medium">
            <Bar data={hotelsByStarData} options={barChartOptions} />
          </div>
        </div>
      </div>

      {/* Dòng 3: Top Hotels */}
      <div className="chart-row">
        <div className="chart-card medium">
          <div className="chart-header">
            <h2>Top 3 Khách Sạn Được Đặt Nhiều Nhất</h2>
            <span className="chart-subtitle">Phổ Biến Nhất</span>
          </div>
          <div className="chart-container medium">
            <Bar data={topBookingsData} options={barChartOptions} />
          </div>
        </div>

        <div className="chart-card medium">
          <div className="chart-header">
            <h2>Top 3 Khách Sạn Đánh Giá Cao Nhất</h2>
            <span className="chart-subtitle">Chất Lượng Tốt Nhất</span>
          </div>
          <div className="chart-container medium">
            <Bar data={topRatingsData} options={{
              ...barChartOptions,
              scales: {
                y: {
                  beginAtZero: true,
                  max: 5,
                },
              },
            }} />
          </div>
        </div>
      </div>

      {/* Thống Kê Nhanh */}
      <div className="summary-stats-card">
        <h2>Thống Kê Nhanh</h2>
        <div className="summary-grid">
          <div className="summary-item">
            <span className="summary-label">Tổng Số Khách Sạn</span>
            <span className="summary-value">{stats?.totalHotels || 0}</span>
          </div>
          <div className="summary-item">
            <span className="summary-label">Tổng Số Đặt Phòng</span>
            <span className="summary-value">{stats?.totalBookings || 0}</span>
          </div>
          <div className="summary-item">
            <span className="summary-label">Tổng Số Người Dùng</span>
            <span className="summary-value">{stats?.totalUsers || 0}</span>
          </div>
          <div className="summary-item">
            <span className="summary-label">Tổng Số Phòng</span>
            <span className="summary-value">{stats?.totalRooms || 0}</span>
          </div>
          <div className="summary-item">
            <span className="summary-label">Phòng Còn Trống</span>
            <span className="summary-value">{stats?.availableRooms || 0}</span>
          </div>
          <div className="summary-item">
            <span className="summary-label">Tỷ Lệ Lấp Đầy</span>
            <span className="summary-value">{stats?.occupancyRate?.toFixed(1) || '0.0'}%</span>
          </div>
          <div className="summary-item">
            <span className="summary-label">Điểm Đánh Giá TB</span>
            <span className="summary-value">{stats?.averageRating?.toFixed(1) || '0.0'} ⭐</span>
          </div>
          <div className="summary-item">
            <span className="summary-label">Doanh Thu Tháng Này</span>
            <span className="summary-value highlight">{formatCurrency(stats?.monthlyRevenue)}</span>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;