import React, { useState } from 'react';
import { FaBars, FaBell, FaUserCircle, FaSignOutAlt, FaCog, FaSun, FaMoon } from 'react-icons/fa';
import { useAuth } from '../../../contexts/AuthContext';
import { useNavigate } from 'react-router-dom';

const Header = ({ toggleSidebar }) => {
  const { user, logout } = useAuth();
  const [showDropdown, setShowDropdown] = useState(false);
  const [showNotifications, setShowNotifications] = useState(false);
  const navigate = useNavigate();

  const getRoleName = (role) => {
    const roles = {
      'ADMIN': 'Quản trị viên',
      'MANAGER': 'Quản lý',
      'CUSTOMER': 'Khách hàng'
    };
    return roles[role] || role;
  };

  const getRoleColor = (role) => {
    const colors = {
      'ADMIN': 'bg-red-100 text-red-700 border-red-200',
      'MANAGER': 'bg-blue-100 text-blue-700 border-blue-200',
      'CUSTOMER': 'bg-green-100 text-green-700 border-green-200'
    };
    return colors[role] || 'bg-gray-100 text-gray-700 border-gray-200';
  };

  const handleLogout = () => {
    if (window.confirm('Bạn có chắc chắn muốn đăng xuất?')) {
      logout();
    }
  };

  const handleProfileClick = () => {
    setShowDropdown(false);
    navigate('/admin/settings');
  };

  // Mock notifications
  const notifications = [
    { id: 1, title: 'Đơn đặt phòng mới', message: 'Khách hàng đã đặt phòng #2024', time: '2 phút trước', unread: true },
    { id: 2, title: 'Đánh giá mới', message: 'Khách sạn Marina Bay nhận 5 sao', time: '1 giờ trước', unread: true },
    { id: 3, title: 'Thanh toán thành công', message: 'Đơn #2023 đã được thanh toán', time: '3 giờ trước', unread: false },
  ];

  return (
    <header className="h-[70px] bg-white border-b border-gray-200 flex items-center justify-between px-6 sticky top-0 z-[100]">
      {/* Left Section */}
      <div className="flex items-center gap-4">
        <button
          onClick={toggleSidebar}
          className="p-2.5 rounded-lg hover:bg-gray-100 transition-all duration-200 active:scale-95"
        >
          <FaBars className="text-xl text-gray-700" />
        </button>

        {/* Search Bar - Optional */}
        <div className="hidden md:flex items-center bg-gray-50 rounded-lg px-4 py-2 w-80 border border-gray-200 focus-within:border-blue-400 focus-within:bg-white transition-all">
          <svg className="w-4 h-4 text-gray-400" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M21 21l-6-6m2-5a7 7 0 11-14 0 7 7 0 0114 0z" />
          </svg>
          <input
            type="text"
            placeholder="Tìm kiếm..."
            className="ml-3 bg-transparent outline-none text-sm w-full text-gray-700 placeholder-gray-400"
          />
        </div>
      </div>

      {/* Right Section */}
      <div className="flex items-center gap-3">
        {/* Notification Button */}
        <div className="relative">
          <button 
            onClick={() => setShowNotifications(!showNotifications)}
            className="relative p-2.5 rounded-lg hover:bg-gray-100 transition-all duration-200 active:scale-95"
          >
            <FaBell className="text-xl text-gray-700" />
            <span className="absolute top-1.5 right-1.5 w-2 h-2 bg-red-500 rounded-full animate-pulse"></span>
          </button>

          {/* Notification Dropdown */}
          {showNotifications && (
            <>
              <div 
                className="fixed inset-0 z-10" 
                onClick={() => setShowNotifications(false)}
              />
              <div className="absolute right-0 mt-2 w-80 bg-white rounded-xl shadow-xl border border-gray-200 z-20 overflow-hidden">
                <div className="px-4 py-3 border-b border-gray-100 flex items-center justify-between">
                  <h3 className="font-semibold text-gray-800">Thông báo</h3>
                  <span className="text-xs text-blue-600 font-medium cursor-pointer hover:text-blue-700">
                    Đánh dấu đã đọc
                  </span>
                </div>
                <div className="max-h-96 overflow-y-auto">
                  {notifications.map((notif) => (
                    <div 
                      key={notif.id} 
                      className={`px-4 py-3 border-b border-gray-50 hover:bg-gray-50 cursor-pointer transition-colors ${notif.unread ? 'bg-blue-50' : ''}`}
                    >
                      <div className="flex items-start gap-3">
                        {notif.unread && <div className="w-2 h-2 bg-blue-500 rounded-full mt-2"></div>}
                        <div className="flex-1">
                          <p className="text-sm font-medium text-gray-800">{notif.title}</p>
                          <p className="text-xs text-gray-600 mt-0.5">{notif.message}</p>
                          <p className="text-xs text-gray-400 mt-1">{notif.time}</p>
                        </div>
                      </div>
                    </div>
                  ))}
                </div>
                <div className="px-4 py-3 bg-gray-50 text-center">
                  <button className="text-sm text-blue-600 font-medium hover:text-blue-700">
                    Xem tất cả
                  </button>
                </div>
              </div>
            </>
          )}
        </div>

        {/* Divider */}
        <div className="w-px h-8 bg-gray-200"></div>

        {/* User Menu */}
        <div className="relative">
          <button
            onClick={() => setShowDropdown(!showDropdown)}
            className="flex items-center gap-3 px-3 py-2 rounded-lg hover:bg-gray-100 transition-all duration-200"
          >
            {user?.imageUrl ? (
              <img
                src={`http://localhost:8080/uploads/avatar/${user.role.toLowerCase()}/${user.imageUrl}.jpg`}
                alt={user.fullName}
                className="w-9 h-9 rounded-full object-cover ring-2 ring-blue-500 ring-offset-2"
              />
            ) : (
              <div className="w-9 h-9 rounded-full bg-blue-500 flex items-center justify-center text-white font-semibold text-sm ring-2 ring-blue-500 ring-offset-2">
                {user?.fullName?.charAt(0) || 'U'}
              </div>
            )}
            <div className="hidden lg:block text-left">
              <p className="text-sm font-semibold text-gray-800 leading-tight">
                {user?.fullName || 'User'}
              </p>
              <p className="text-xs text-gray-500">
                {getRoleName(user?.role)}
              </p>
            </div>
            <svg className="w-4 h-4 text-gray-400 hidden lg:block" fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M19 9l-7 7-7-7" />
            </svg>
          </button>

          {/* User Dropdown */}
          {showDropdown && (
            <>
              <div 
                className="fixed inset-0 z-10" 
                onClick={() => setShowDropdown(false)}
              />
              <div className="absolute right-0 mt-2 w-72 bg-white rounded-xl shadow-xl border border-gray-200 z-20 overflow-hidden">
                {/* User Info Card */}
                <div className="px-4 py-4 border-b border-gray-100">
                  <div className="flex items-center gap-3">
                    {user?.imageUrl ? (
                      <img
                        src={`http://localhost:8080/uploads/avatar/${user.role.toLowerCase()}/${user.imageUrl}.jpg`}
                        alt={user.fullName}
                        className="w-12 h-12 rounded-full object-cover ring-2 ring-gray-200"
                      />
                    ) : (
                      <div className="w-12 h-12 rounded-full bg-blue-500 flex items-center justify-center text-white font-bold text-lg ring-2 ring-gray-200">
                        {user?.fullName?.charAt(0) || 'U'}
                      </div>
                    )}
                    <div className="flex-1 min-w-0">
                      <p className="text-sm font-semibold text-gray-800 truncate">
                        {user?.fullName || 'User'}
                      </p>
                      <p className="text-xs text-gray-500 truncate">{user?.email}</p>
                      <span className={`inline-block mt-1.5 px-2 py-0.5 text-xs font-medium rounded border ${getRoleColor(user?.role)}`}>
                        {getRoleName(user?.role)}
                      </span>
                    </div>
                  </div>
                </div>

                {/* Menu Items */}
                <div className="py-2">
                  <button
                    onClick={handleProfileClick}
                    className="w-full px-4 py-2.5 text-left text-sm text-gray-700 hover:bg-gray-50 flex items-center gap-3 transition-colors"
                  >
                    <FaCog className="text-gray-400" />
                    Cài đặt tài khoản
                  </button>
                </div>

                {/* Logout */}
                <div className="border-t border-gray-100">
                  <button
                    onClick={handleLogout}
                    className="w-full px-4 py-3 text-left text-sm text-red-600 hover:bg-red-50 flex items-center gap-3 transition-colors font-medium"
                  >
                    <FaSignOutAlt />
                    Đăng xuất
                  </button>
                </div>
              </div>
            </>
          )}
        </div>
      </div>
    </header>
  );
};

export default Header;