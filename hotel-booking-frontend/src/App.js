import React from 'react';
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom';
import { AuthProvider } from './contexts/AuthContext';
import { ToastProvider } from './contexts/ToastContext';
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
import './styles/Toast.css';

function App() {
  return (
    <AuthProvider>
      <ToastProvider>
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
              <Route index element={<Navigate to="/admin/dashboard" replace />} />
              <Route path="dashboard" element={<Dashboard />} />
              <Route path="bookings" element={<BookingManagement />} />
              <Route path="hotels" element={<HotelManagement />} />
              <Route path="rooms" element={<RoomManagement />} />
              <Route path="users" element={<UserManagement />} />
              <Route path="reviews" element={<ReviewManagement />} />
              <Route path="settings" element={<Settings />} />
            </Route>

            {/* Default redirect */}
            <Route path="/" element={<Navigate to="/login" replace />} />
            <Route path="*" element={<Navigate to="/login" replace />} />
          </Routes>
        </Router>
      </ToastProvider>
    </AuthProvider>
  );
}

export default App;