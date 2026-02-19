import React from 'react';
import { NavLink } from 'react-router-dom';
import { useAuth } from '../../../contexts/AuthContext';import {
  FaTachometerAlt,
  FaCalendarCheck,
  FaHotel,
  FaBed,
  FaUsers,
  FaStar,
  FaCog,
  FaChartBar,
  FaSignOutAlt,
  FaTimes,
} from 'react-icons/fa';

const Sidebar = ({ isOpen, toggleSidebar }) => {
  const { logout } = useAuth();
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
    <div
      className={`fixed left-0 top-0 h-screen bg-gradient-to-b from-[#1e3c72] to-[#2a5298] text-white transition-all duration-300 ease-in-out z-[1000] flex flex-col
        ${isOpen
          ? 'translate-x-0 w-64'
          : '-translate-x-full w-64 lg:translate-x-0 lg:w-20'
        }`}
    >
      {/* Header */}
      <div className="p-5 text-center border-b border-white border-opacity-10 flex items-center justify-between lg:justify-center">
        <h2 className={`m-0 text-2xl font-bold ${!isOpen && 'lg:text-base'}`}>
          {isOpen ? 'SolarFlow' : 'SF'}
        </h2>
        {/* Close button - Only on mobile */}
        {isOpen && (
          <button
            onClick={toggleSidebar}
            className="lg:hidden text-white text-2xl p-2 hover:bg-white/10 rounded-lg"
          >
            <FaTimes />
          </button>
        )}
      </div>

      {/* Navigation */}
      <nav className="flex-1 py-5 overflow-y-auto scrollbar-thin scrollbar-thumb-white/30 scrollbar-track-white/10">
        {menuItems.map((item) => (
          <NavLink
            key={item.path}
            to={item.path}
            onClick={() => {
              // Auto close sidebar on mobile when clicking a link
              if (window.innerWidth < 1024) {
                toggleSidebar();
              }
            }}
            className={({ isActive }) =>
              `flex items-center px-5 py-4 text-white/80 no-underline transition-all duration-300 hover:bg-white/10 hover:text-white
              ${isOpen ? 'gap-4' : 'gap-0 lg:justify-center'}
              ${isActive ? 'bg-white/15 text-white border-l-4 border-green-500' : ''}`
            }
          >
            <span className="text-xl min-w-[24px] flex items-center justify-center">
              {item.icon}
            </span>
            {isOpen && (
              <span className="whitespace-nowrap text-[15px] font-medium">
                {item.label}
              </span>
            )}
          </NavLink>
        ))}
      </nav>

      {/* Footer - Logout */}
      <div className="p-5 border-t border-white border-opacity-10">
        <button
          onClick={logout}
          className={`w-full px-3 py-3 bg-white/10 border-none text-white rounded-md cursor-pointer flex items-center transition-colors hover:bg-white/20
      ${isOpen ? 'justify-center gap-2.5' : 'justify-center lg:justify-center'}`}
        >
          <FaSignOutAlt />
          {isOpen && <span className="text-[15px]">Logout</span>}
        </button>
      </div>
    </div>
  );
};

export default Sidebar;