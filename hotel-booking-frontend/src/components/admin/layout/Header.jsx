import React from 'react';
import { FaBars, FaBell, FaUserCircle } from 'react-icons/fa';
import './Header.css';

const Header = ({ toggleSidebar }) => {
  return (
    <header className="admin-header">
      <div className="header-left">
        <button className="menu-toggle" onClick={toggleSidebar}>
          <FaBars />
        </button>
      </div>

      <div className="header-right">
        <button className="header-icon-btn">
          <FaBell />
          <span className="notification-badge">3</span>
        </button>
        
        <div className="user-menu">
          <FaUserCircle className="user-avatar" />
          <div className="user-info">
            <span className="user-name">Admin User</span>
            <span className="user-role">Administrator</span>
          </div>
        </div>
      </div>
    </header>
  );
};

export default Header;