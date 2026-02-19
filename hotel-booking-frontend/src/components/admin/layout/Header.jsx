import React, { useState } from 'react';
import { FaBars, FaBell, FaUserCircle, FaSignOutAlt, FaCog, FaUser } from 'react-icons/fa';
import { useAuth } from '../../../contexts/AuthContext';
import { useNavigate } from 'react-router-dom';

const Header = ({ toggleSidebar }) => {
  const { user, logout } = useAuth();
  const [showDropdown, setShowDropdown] = useState(false);
  const navigate = useNavigate();

  const getRoleName = (role) => {
    const roles = {
      'ADMIN': 'Quản trị viên',
      'MANAGER': 'Quản lý',
      'CUSTOMER': 'Khách hàng'
    };
    return roles[role] || role;
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

  return (
    <header className="h-[70px] bg-white shadow-md flex items-center justify-between px-8 sticky top-0 z-[100]">
      {/* Left Section */}
      <div className="flex items-center">
        <button 
          onClick={toggleSidebar}
          className="bg-transparent border-none text-2xl text-gray-700 cursor-pointer p-2 rounded-md hover:bg-gray-50 transition-colors"
        >
          <FaBars />
        </button>
      </div>

      {/* Right Section */}
      <div className="flex items-center gap-5">
        {/* Notification Button */}
        <button className="relative bg-transparent border-none text-xl text-gray-500 cursor-pointer p-2 rounded-md hover:bg-gray-50 hover:text-gray-700 transition-all">
          <FaBell />
          <span className="absolute top-1 right-1 bg-red-500 text-white text-[10px] px-1.5 py-0.5 rounded-full font-semibold">
            3
          </span>
        </button>
        
        {/* User Menu */}
        <div className="relative">
          <div 
            onClick={() => setShowDropdown(!showDropdown)}
            className="flex items-center gap-3 cursor-pointer px-3 py-2 rounded-lg hover:bg-gray-50 transition-colors"
          >
            {user?.imageUrl ? (
              <img 
                src={`http://localhost:8080/uploads/avatar/${user.role.toLowerCase()}/${user.imageUrl}.jpg`}
                alt={user.fullName}
                className="w-10 h-10 rounded-full object-cover border-2 border-blue-500"
              />
            ) : (
              <FaUserCircle className="text-4xl text-blue-500" />
            )}
            <div className="flex flex-col max-md:hidden">
              <span className="font-semibold text-gray-800 text-sm">
                {user?.fullName || 'User'}
              </span>
              <span className="text-xs text-gray-500">
                {getRoleName(user?.role)}
              </span>
            </div>
          </div>

          {/* Dropdown Menu */}
          {showDropdown && (
            <>
              {/* Backdrop */}
              <div 
                className="fixed inset-0 z-10" 
                onClick={() => setShowDropdown(false)}
              />
              
              {/* Dropdown */}
              <div className="absolute right-0 mt-2 w-64 bg-white rounded-lg shadow-xl border border-gray-200 z-20 overflow-hidden">
                {/* User Info */}
                <div className="px-4 py-3 border-b border-gray-100 bg-gradient-to-r from-blue-50 to-purple-50">
                  <div className="flex items-center gap-3">
                    {user?.imageUrl ? (
                      <img 
                        src={`http://localhost:8080/uploads/avatar/${user.role.toLowerCase()}/${user.imageUrl}.jpg`}
                        alt={user.fullName}
                        className="w-12 h-12 rounded-full object-cover border-2 border-white shadow"
                      />
                    ) : (
                      <div className="w-12 h-12 bg-blue-500 rounded-full flex items-center justify-center text-white font-bold text-lg">
                        {user?.fullName?.charAt(0) || 'U'}
                      </div>
                    )}
                    <div>
                      <p className="text-sm font-semibold text-gray-800">
                        {user?.fullName || 'User'}
                      </p>
                      <p className="text-xs text-gray-500">{user?.email}</p>
                      <span className="inline-block mt-1 px-2 py-0.5 text-xs font-medium bg-blue-100 text-blue-700 rounded">
                        {getRoleName(user?.role)}
                      </span>
                    </div>
                  </div>
                </div>

                {/* Menu Items */}
                <div className="py-2">
                  <button 
                    onClick={handleProfileClick}
                    className="w-full px-4 py-2 text-left text-sm text-gray-700 hover:bg-gray-50 flex items-center gap-3 transition-colors"
                  >
                    <FaUser className="text-gray-400" />
                    Thông tin cá nhân
                  </button>
                  <button 
                    onClick={handleProfileClick}
                    className="w-full px-4 py-2 text-left text-sm text-gray-700 hover:bg-gray-50 flex items-center gap-3 transition-colors"
                  >
                    <FaCog className="text-gray-400" />
                    Cài đặt
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