import React from 'react';
import { FaBars, FaBell, FaUserCircle } from 'react-icons/fa';

const Header = ({ toggleSidebar }) => {
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
        <div className="flex items-center gap-3 cursor-pointer px-3 py-2 rounded-lg hover:bg-gray-50 transition-colors">
          <FaUserCircle className="text-4xl text-blue-500" />
          <div className="flex flex-col max-md:hidden">
            <span className="font-semibold text-gray-800 text-sm">Admin User</span>
            <span className="text-xs text-gray-500">Quản trị viên</span>
          </div>
        </div>
      </div>
    </header>
  );
};

export default Header;