import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './contexts/AuthContext';
import ProtectedRoute from './components/ProtectedRoute';
import Login from './pages/Login';
import AdminLayout from './components/admin/layout/AdminLayout';
import Dashboard from './components/admin/Dashboard';
import BookingManagement from './components/admin/BookingManagement';
import HotelManagement from './components/admin/HotelManagement';
import RoomManagement from './components/admin/RoomManagement';
import UserManagement from './components/admin/UserManagement';
import ReviewManagement from './components/admin/ReviewManagement';
import Settings from './components/admin/Settings';

function App() {
  return (
    <AuthProvider>
      <Router>
        <Routes>
          {/* Public Routes */}
          <Route path="/login" element={<Login />} />
          
          {/* Protected Admin Routes */}
          <Route 
            path="/admin" 
            element={
              <ProtectedRoute roles={['ADMIN', 'MANAGER']}>
                <AdminLayout />
              </ProtectedRoute>
            }
          >
            <Route path="dashboard" element={<Dashboard />} />
            <Route path="bookings" element={<BookingManagement />} />
            <Route 
              path="hotels" 
              element={
                <ProtectedRoute roles={['ADMIN', 'MANAGER']}>
                  <HotelManagement />
                </ProtectedRoute>
              } 
            />
            <Route path="rooms" element={<RoomManagement />} />
            <Route 
              path="users" 
              element={
                <ProtectedRoute roles={['ADMIN']}>
                  <UserManagement />
                </ProtectedRoute>
              } 
            />
            <Route path="reviews" element={<ReviewManagement />} />
            <Route path="settings" element={<Settings />} />
          </Route>

          {/* Redirect */}
          <Route path="/" element={<Navigate to="/admin/dashboard" replace />} />
          <Route path="*" element={<Navigate to="/admin/dashboard" replace />} />
        </Routes>
      </Router>
    </AuthProvider>
  );
}

export default App;