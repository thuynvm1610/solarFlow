import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { FaEnvelope, FaLock, FaEye, FaEyeSlash, FaHotel } from 'react-icons/fa';

const Login = () => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);
  
  const { login } = useAuth();
  const navigate = useNavigate();

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setLoading(true);

    const result = await login(email, password);
    
    if (result.success) {
      // Redirect based on role
      if (result.user.role === 'ADMIN' || result.user.role === 'MANAGER') {
        navigate('/admin/dashboard');
      } else {
        navigate('/'); // Customer dashboard or home page
      }
    } else {
      setError(result.error);
    }
    
    setLoading(false);
  };

  const fillDemoAccount = (role) => {
    switch(role) {
      case 'admin':
        setEmail('admin@hotel.com');
        setPassword('admin123');
        break;
      case 'manager':
        setEmail('manager@hotel.com');
        setPassword('manager123');
        break;
      case 'customer':
        setEmail('customer1@hotel.com');
        setPassword('customer123');
        break;
      default:
        break;
    }
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-blue-500 via-blue-600 to-purple-600 flex items-center justify-center p-4">
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-md overflow-hidden">
        {/* Header */}
        <div className="bg-gradient-to-r from-blue-500 to-purple-600 p-8 text-center">
          <div className="inline-flex items-center justify-center w-20 h-20 bg-white rounded-full mb-4">
            <FaHotel className="text-4xl text-blue-500" />
          </div>
          <h1 className="text-3xl font-bold text-white mb-2">SolarFlow Hotel</h1>
          <p className="text-blue-100">Hệ thống quản lý khách sạn</p>
        </div>

        {/* Form */}
        <div className="p-8">
          <h2 className="text-2xl font-bold text-gray-800 mb-6 text-center">Đăng nhập</h2>

          {/* Error Message */}
          {error && (
            <div className="mb-6 p-4 bg-red-50 border-l-4 border-red-500 rounded">
              <div className="flex items-start">
                <div className="flex-shrink-0">
                  <svg className="w-5 h-5 text-red-500" fill="currentColor" viewBox="0 0 20 20">
                    <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clipRule="evenodd" />
                  </svg>
                </div>
                <p className="ml-3 text-sm text-red-700">{error}</p>
              </div>
            </div>
          )}

          {/* Login Form */}
          <form onSubmit={handleSubmit} className="space-y-6">
            {/* Email Input */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Email
              </label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <FaEnvelope className="text-gray-400" />
                </div>
                <input
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="block w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition"
                  placeholder="your.email@example.com"
                  required
                />
              </div>
            </div>

            {/* Password Input */}
            <div>
              <label className="block text-sm font-medium text-gray-700 mb-2">
                Mật khẩu
              </label>
              <div className="relative">
                <div className="absolute inset-y-0 left-0 pl-3 flex items-center pointer-events-none">
                  <FaLock className="text-gray-400" />
                </div>
                <input
                  type={showPassword ? 'text' : 'password'}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="block w-full pl-10 pr-12 py-3 border border-gray-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none transition"
                  placeholder="••••••••"
                  required
                />
                <button
                  type="button"
                  onClick={() => setShowPassword(!showPassword)}
                  className="absolute inset-y-0 right-0 pr-3 flex items-center text-gray-400 hover:text-gray-600"
                >
                  {showPassword ? <FaEyeSlash /> : <FaEye />}
                </button>
              </div>
            </div>

            {/* Remember Me & Forgot Password */}
            <div className="flex items-center justify-between">
              <label className="flex items-center">
                <input
                  type="checkbox"
                  className="w-4 h-4 text-blue-500 border-gray-300 rounded focus:ring-2 focus:ring-blue-500"
                />
                <span className="ml-2 text-sm text-gray-600">Ghi nhớ đăng nhập</span>
              </label>
              <a href="#" className="text-sm text-blue-500 hover:text-blue-600 font-medium">
                Quên mật khẩu?
              </a>
            </div>

            {/* Submit Button */}
            <button
              type="submit"
              disabled={loading}
              className="w-full bg-gradient-to-r from-blue-500 to-purple-600 text-white py-3 rounded-lg font-semibold hover:from-blue-600 hover:to-purple-700 transition-all disabled:opacity-50 disabled:cursor-not-allowed shadow-lg hover:shadow-xl"
            >
              {loading ? (
                <div className="flex items-center justify-center">
                  <div className="w-5 h-5 border-2 border-white border-t-transparent rounded-full animate-spin mr-2"></div>
                  Đang đăng nhập...
                </div>
              ) : (
                'Đăng nhập'
              )}
            </button>
          </form>

          {/* Demo Accounts */}
          <div className="mt-8 p-4 bg-gradient-to-r from-gray-50 to-gray-100 rounded-lg border border-gray-200">
            <p className="text-xs font-semibold text-gray-700 mb-3 text-center">
              🔑 Tài khoản demo - Click để tự động điền
            </p>
            <div className="grid grid-cols-3 gap-2">
              <button
                type="button"
                onClick={() => fillDemoAccount('admin')}
                className="px-3 py-2 bg-white text-xs font-medium text-gray-700 rounded-md hover:bg-blue-50 hover:text-blue-600 border border-gray-300 transition-colors"
              >
                👑 Admin
              </button>
              <button
                type="button"
                onClick={() => fillDemoAccount('manager')}
                className="px-3 py-2 bg-white text-xs font-medium text-gray-700 rounded-md hover:bg-green-50 hover:text-green-600 border border-gray-300 transition-colors"
              >
                👔 Manager
              </button>
              <button
                type="button"
                onClick={() => fillDemoAccount('customer')}
                className="px-3 py-2 bg-white text-xs font-medium text-gray-700 rounded-md hover:bg-purple-50 hover:text-purple-600 border border-gray-300 transition-colors"
              >
                👤 Customer
              </button>
            </div>
            <div className="mt-3 space-y-1 text-xs text-gray-600">
              <p>• Admin: admin@hotel.com / admin123</p>
              <p>• Manager: manager@hotel.com / manager123</p>
              <p>• Customer: customer1@hotel.com / customer123</p>
            </div>
          </div>

          {/* Register Link */}
          <p className="mt-6 text-center text-sm text-gray-600">
            Chưa có tài khoản?{' '}
            <a href="#" className="text-blue-500 hover:text-blue-600 font-medium">
              Đăng ký ngay
            </a>
          </p>
        </div>
      </div>
    </div>
  );
};

export default Login;