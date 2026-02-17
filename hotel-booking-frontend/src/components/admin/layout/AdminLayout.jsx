import React, { useState } from 'react';
import { Outlet } from 'react-router-dom';
import Sidebar from './Sidebar';
import Header from './Header';

const AdminLayout = () => {
  const [sidebarOpen, setSidebarOpen] = useState(true);

  const toggleSidebar = () => {
    setSidebarOpen(!sidebarOpen);
  };

  return (
    <div className="flex min-h-screen bg-gray-50 overflow-x-hidden">
      {/* Overlay for mobile when sidebar is open */}
      {sidebarOpen && (
        <div 
          className="fixed inset-0 bg-black bg-opacity-50 z-[999] lg:hidden"
          onClick={toggleSidebar}
        />
      )}

      <Sidebar isOpen={sidebarOpen} toggleSidebar={toggleSidebar} />
      
      <div 
        className={`flex-1 transition-all duration-300 ease-in-out w-full
          ${sidebarOpen ? 'lg:ml-64' : 'lg:ml-20'}
          ml-0`}
      >
        <Header toggleSidebar={toggleSidebar} />
        <div className="p-5 lg:p-8 min-h-[calc(100vh-70px)]">
          <Outlet />
        </div>
      </div>
    </div>
  );
};

export default AdminLayout;