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
    { path: '/admin/bookings', icon: <FaCalendarCheck />, label: 'Bookings' },
    { path: '/admin/hotels', icon: <FaHotel />, label: 'Hotels' },
    { path: '/admin/rooms', icon: <FaBed />, label: 'Rooms' },
    { path: '/admin/users', icon: <FaUsers />, label: 'Users' },
    { path: '/admin/reviews', icon: <FaStar />, label: 'Reviews' },
    { path: '/admin/reports', icon: <FaChartBar />, label: 'Reports' },
    { path: '/admin/settings', icon: <FaCog />, label: 'Settings' },
  ];

  return (
    <div className={`sidebar ${isOpen ? 'open' : 'closed'}`}>
      <div className="sidebar-header">
        <h2>{isOpen ? 'Hotel Admin' : 'HA'}</h2>
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