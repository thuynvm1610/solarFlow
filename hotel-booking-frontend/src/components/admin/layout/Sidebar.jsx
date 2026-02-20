import React from 'react';
import { NavLink } from 'react-router-dom';
import { useAuth } from '../../../contexts/AuthContext';
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
  FaTimes,
} from 'react-icons/fa';

const Sidebar = ({ isOpen, toggleSidebar }) => {
  const { logout, user } = useAuth();

  const menuItems = [
    { path: '/admin/dashboard', icon: <FaTachometerAlt />, label: 'Dashboard', color: 'text-blue-500' },
    { path: '/admin/bookings', icon: <FaCalendarCheck />, label: 'Đơn đặt phòng', color: 'text-green-500' },
    { path: '/admin/hotels', icon: <FaHotel />, label: 'Khách sạn', color: 'text-purple-500' },
    { path: '/admin/rooms', icon: <FaBed />, label: 'Phòng', color: 'text-orange-500' },
    { path: '/admin/users', icon: <FaUsers />, label: 'Người dùng', color: 'text-pink-500' },
    { path: '/admin/reviews', icon: <FaStar />, label: 'Đánh giá', color: 'text-yellow-500' },
    { path: '/admin/reports', icon: <FaChartBar />, label: 'Báo cáo', color: 'text-teal-500' },
    { path: '/admin/settings', icon: <FaCog />, label: 'Cài đặt', color: 'text-gray-500' },
  ];

  const handleLogout = () => {
    if (window.confirm('Bạn có chắc chắn muốn đăng xuất?')) {
      logout();
    }
  };

  return (
    <div
      className={`fixed left-0 top-0 h-screen bg-white border-r border-gray-200 transition-all duration-300 ease-in-out z-[1000] flex flex-col shadow-sm
        ${isOpen
          ? 'translate-x-0 w-64'
          : '-translate-x-full w-64 lg:translate-x-0 lg:w-20'
        }`}
    >
      {/* Header with Logo */}
      <div className={`p-5 border-b border-gray-200 flex items-center ${isOpen ? 'justify-between' : 'lg:justify-center'}`}>
        <div className="flex items-center gap-3">
          {/* Custom Logo */}
          <div className="relative">
            <div className="w-10 h-10 bg-blue-500 rounded-lg flex items-center justify-center shadow-md">
              <span className="text-white font-bold text-sm tracking-wide">SF</span>
            </div>
          </div>
          {isOpen && (
            <div>
              <h2 className="text-xl font-bold text-gray-800">SolarFlow</h2>
              <p className="text-xs text-gray-500">Hotel Management</p>
            </div>
          )}
        </div>

        {/* Close button - Mobile */}
        {isOpen && (
          <button
            onClick={toggleSidebar}
            className="lg:hidden p-2 hover:bg-gray-100 rounded-lg transition-colors"
          >
            <FaTimes className="text-gray-600" />
          </button>
        )}
      </div>

      {/* Navigation */}
      <nav className="flex-1 py-4 overflow-y-auto">
        {menuItems.map((item) => (
          <NavLink
            key={item.path}
            to={item.path}
            onClick={() => {
              if (window.innerWidth < 1024) {
                toggleSidebar();
              }
            }}
            className={({ isActive }) =>
              `flex items-center px-4 py-3 mx-2 my-1 rounded-lg text-gray-700 transition-all duration-200 hover:bg-gray-50 group
              ${isOpen ? 'gap-3' : 'lg:justify-center'}
              ${isActive ? 'bg-blue-50 text-blue-600 font-medium shadow-sm' : ''}`
            }
          >
            {({ isActive }) => (
              <>
                <span className={`text-xl flex items-center justify-center transition-colors ${isActive ? 'text-blue-600' : item.color} group-hover:scale-110`}>
                  {item.icon}
                </span>
                {isOpen && (
                  <span className="text-sm font-medium">
                    {item.label}
                  </span>
                )}
                {isActive && isOpen && (
                  <div className="ml-auto w-1.5 h-1.5 bg-blue-600 rounded-full"></div>
                )}
              </>
            )}
          </NavLink>
        ))}
      </nav>

      {/* Footer - Logout */}
      <div className="p-4 border-t border-gray-200">
        <button
          onClick={handleLogout}
          className={`w-full px-4 py-3 bg-red-50 text-red-600 rounded-lg font-medium transition-all duration-200 hover:bg-red-100 active:scale-95 flex items-center
            ${isOpen ? 'justify-center gap-2' : 'lg:justify-center'}`}
        >
          <FaSignOutAlt />
          {isOpen && <span className="text-sm">Đăng xuất</span>}
        </button>
      </div>
    </div>
  );
};

export default Sidebar;