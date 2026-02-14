import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import AdminLayout from './components/admin/layout/AdminLayout';
import Dashboard from './components/admin/Dashboard';
import BookingManagement from './components/admin/BookingManagement';
import RoomManagement from './components/admin/RoomManagement';
import UserManagement from './components/admin/UserManagement';
import HotelManagement from './components/admin/HotelManagement';
import ReviewManagement from './components/admin/ReviewManagement';
import Settings from './components/admin/Settings';
import './App.css';

function App() {
  return (
    <Router>
      <Routes>
        <Route path="/" element={<Navigate to="/admin/dashboard" replace />} />
        
        <Route path="/admin" element={<AdminLayout />}>
          <Route index element={<Navigate to="/admin/dashboard" replace />} />
          <Route path="dashboard" element={<Dashboard />} />
          <Route path="bookings" element={<BookingManagement />} />
          <Route path="rooms" element={<RoomManagement />} />
          <Route path="users" element={<UserManagement />} />
          <Route path="hotels" element={<HotelManagement />} />
          <Route path="reviews" element={<ReviewManagement />} />
          <Route path="settings" element={<Settings />} />
        </Route>
      </Routes>
    </Router>
  );
}

export default App;