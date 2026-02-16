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
      <Sidebar isOpen={sidebarOpen} />
      <div 
        className={`flex-1 transition-all duration-300 ease-in-out max-w-full overflow-x-hidden
          ${sidebarOpen ? 'ml-64' : 'ml-20'} 
          lg:${sidebarOpen ? 'ml-64' : 'ml-20'}
          max-lg:ml-0`}
      >
        <Header toggleSidebar={toggleSidebar} />
        <div className="p-5 min-h-[calc(100vh-70px)] max-w-full overflow-x-hidden">
          <Outlet />
        </div>
      </div>
    </div>
  );
};

export default AdminLayout;