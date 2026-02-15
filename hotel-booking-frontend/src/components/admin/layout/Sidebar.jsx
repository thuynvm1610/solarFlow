import React from 'react';
import { NavLink } from 'react-router-dom';
import {
  FaTachometerAlt,
  FaCalendarCheck,
  FaHotel,
  FaBed,
  FaUsers,
  FaStar,
  FaCog,
  FaChartBar,
  FaSignOutAlt,
} from 'react-icons/fa';
import './Sidebar.css';

const Sidebar = ({ isOpen }) => {
  const menuItems = [
    { path: '/admin/dashboard', icon: <FaTachometerAlt />, label: 'Dashboard' },
    { path: '/admin/bookings', icon: <FaCalendarCheck />, label: 'Đơn đặt phòng' },
    { path: '/admin/hotels', icon: <FaHotel />, label: 'Khách sạn' },
    { path: '/admin/rooms', icon: <FaBed />, label: 'Phòng' },
    { path: '/admin/users', icon: <FaUsers />, label: 'Người dùng' },
    { path: '/admin/reviews', icon: <FaStar />, label: 'Đánh giá' },
    { path: '/admin/reports', icon: <FaChartBar />, label: 'Báo cáo' },
    { path: '/admin/settings', icon: <FaCog />, label: 'Cài đặt' },
  ];

  return (
    <div className={`sidebar ${isOpen ? 'open' : 'closed'}`}>
      <div className="sidebar-header">
        <h2>{isOpen ? 'SolarFlow' : 'SF'}</h2>
      </div>
      
      <nav className="sidebar-nav">
        {menuItems.map((item) => (
          <NavLink
            key={item.path}
            to={item.path}
            className={({ isActive }) => `sidebar-item ${isActive ? 'active' : ''}`}
          >
            <span className="sidebar-icon">{item.icon}</span>
            {isOpen && <span className="sidebar-label">{item.label}</span>}
          </NavLink>
        ))}
      </nav>

      <div className="sidebar-footer">
        <button className="logout-btn">
          <FaSignOutAlt />
          {isOpen && <span>Logout</span>}
        </button>
      </div>
    </div>
  );
};

export default Sidebar;