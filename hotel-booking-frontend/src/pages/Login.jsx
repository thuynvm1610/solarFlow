import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { useAuth } from '../contexts/AuthContext';
import { FaEnvelope, FaLock, FaEye, FaEyeSlash } from 'react-icons/fa';

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
      if (result.user.role === 'ADMIN' || result.user.role === 'MANAGER') {
        navigate('/admin/dashboard');
      } else {
        navigate('/');
      }
    } else {
      setError(result.error);
    }
    setLoading(false);
  };

  return (
    <>
      <style>{`
        @import url('https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700&display=swap');

        * { box-sizing: border-box; margin: 0; padding: 0; }

        .login-root {
          min-height: 100vh;
          display: flex;
          align-items: center;
          justify-content: center;
          background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 50%, #c7d2fe 100%);
          font-family: 'Plus Jakarta Sans', sans-serif;
          padding: 24px;
        }

        .login-card {
          background: #ffffff;
          border-radius: 20px;
          box-shadow: 0 8px 48px rgba(29,78,216,0.15), 0 2px 8px rgba(29,78,216,0.08);
          width: 100%;
          max-width: 420px;
          padding: 48px 44px;
          border: 1.5px solid #93c5fd;
        }

        /* Brand */
        .brand {
          display: flex;
          align-items: center;
          gap: 12px;
          margin-bottom: 36px;
        }

        .brand-logo {
          width: 42px; height: 42px;
          background: linear-gradient(135deg, #1d4ed8, #2563eb);
          border-radius: 11px;
          display: flex; align-items: center; justify-content: center;
          font-size: 15px;
          font-weight: 700;
          color: #fff;
          flex-shrink: 0;
          box-shadow: 0 4px 14px rgba(29,78,216,0.4);
        }

        .brand-text {
          display: flex; flex-direction: column; gap: 2px;
        }

        .brand-name {
          font-size: 15px;
          font-weight: 700;
          color: #1e3a8a;
          line-height: 1;
        }

        .brand-sub {
          font-size: 11px;
          font-weight: 500;
          color: #3b82f6;
        }

        /* Heading */
        .form-heading { margin-bottom: 28px; }

        .form-title {
          font-size: 26px;
          font-weight: 700;
          color: #1e3a8a;
          margin-bottom: 5px;
        }

        .form-subtitle {
          font-size: 13px;
          font-weight: 500;
          color: #64748b;
        }

        /* Error */
        .error-box {
          background: #fff5f5;
          border: 1px solid #fca5a5;
          border-radius: 10px;
          padding: 11px 14px;
          margin-bottom: 20px;
          font-size: 13px;
          color: #dc2626;
          display: flex; align-items: center; gap: 8px;
          font-weight: 500;
        }

        .error-dot {
          width: 5px; height: 5px;
          border-radius: 50%;
          background: #dc2626;
          flex-shrink: 0;
        }

        /* Fields */
        .field-group { margin-bottom: 16px; }

        .field-label {
          display: block;
          font-size: 12px;
          font-weight: 700;
          color: #1e40af;
          margin-bottom: 7px;
          letter-spacing: 0.2px;
        }

        .field-wrapper {
          position: relative;
          display: flex; align-items: center;
        }

        .field-icon {
          position: absolute;
          left: 14px;
          color: #93c5fd;
          font-size: 13px;
          pointer-events: none;
          transition: color 0.15s;
        }

        .field-wrapper:focus-within .field-icon { color: #1d4ed8; }

        .form-input {
          width: 100%;
          padding: 12px 14px 12px 40px;
          background: #eff6ff;
          border: 1.5px solid #93c5fd;
          border-radius: 10px;
          color: #1e3a8a;
          font-family: 'Plus Jakarta Sans', sans-serif;
          font-size: 14px;
          font-weight: 500;
          outline: none;
          transition: border-color 0.15s, box-shadow 0.15s, background 0.15s;
        }

        .form-input::placeholder { color: #93c5fd; }

        .form-input:focus {
          border-color: #1d4ed8;
          background: #fff;
          box-shadow: 0 0 0 3px rgba(29,78,216,0.12);
        }

        .form-input.has-right-icon { padding-right: 44px; }

        .toggle-password {
          position: absolute;
          right: 13px;
          background: none;
          border: none;
          color: #93c5fd;
          cursor: pointer;
          font-size: 14px;
          padding: 4px;
          display: flex; align-items: center;
          transition: color 0.15s;
        }

        .toggle-password:hover { color: #1d4ed8; }

        /* Options */
        .options-row {
          display: flex;
          align-items: center;
          justify-content: space-between;
          margin: 12px 0 24px;
        }

        .remember-label {
          display: flex; align-items: center; gap: 7px;
          font-size: 12px;
          font-weight: 500;
          color: #475569;
          cursor: pointer;
          user-select: none;
        }

        .remember-check {
          width: 14px; height: 14px;
          cursor: pointer;
          accent-color: #1d4ed8;
        }

        .forgot-link {
          font-size: 12px;
          font-weight: 700;
          color: #1d4ed8;
          text-decoration: none;
          transition: color 0.15s;
        }

        .forgot-link:hover { color: #1e40af; }

        /* Button */
        .btn-submit {
          width: 100%;
          padding: 13px;
          background: linear-gradient(135deg, #1d4ed8, #2563eb);
          border: none;
          border-radius: 10px;
          font-family: 'Plus Jakarta Sans', sans-serif;
          font-size: 14px;
          font-weight: 700;
          color: #fff;
          cursor: pointer;
          transition: opacity 0.15s, box-shadow 0.15s, transform 0.1s;
          box-shadow: 0 4px 18px rgba(29,78,216,0.4);
          display: flex; align-items: center; justify-content: center; gap: 8px;
          letter-spacing: 0.2px;
        }

        .btn-submit:hover:not(:disabled) {
          opacity: 0.9;
          box-shadow: 0 6px 24px rgba(29,78,216,0.5);
        }

        .btn-submit:active:not(:disabled) { transform: scale(0.99); }
        .btn-submit:disabled { opacity: 0.55; cursor: not-allowed; }

        .spinner {
          width: 14px; height: 14px;
          border: 2px solid rgba(255,255,255,0.4);
          border-top-color: #fff;
          border-radius: 50%;
          animation: spin 0.6s linear infinite;
        }

        @keyframes spin { to { transform: rotate(360deg); } }

        /* Divider */
        .divider {
          display: flex; align-items: center; gap: 12px;
          margin: 22px 0;
        }

        .divider-line { flex: 1; height: 1px; background: #bfdbfe; }

        .divider-text {
          font-size: 11px;
          font-weight: 600;
          color: #60a5fa;
        }

        /* Register */
        .register-row {
          text-align: center;
          font-size: 13px;
          font-weight: 500;
          color: #64748b;
        }

        .register-link {
          color: #1d4ed8;
          text-decoration: none;
          font-weight: 700;
          transition: color 0.15s;
        }

        .register-link:hover { color: #1e40af; }
      `}</style>

      <div className="login-root">
        <div className="login-card">

          <div className="brand">
            <div className="brand-logo">SF</div>
            <div className="brand-text">
              <span className="brand-name">SolarFlow Hotel</span>
              <span className="brand-sub">Hệ thống quản lý khách sạn</span>
            </div>
          </div>

          <div className="form-heading">
            <h1 className="form-title">Đăng nhập</h1>
            <p className="form-subtitle">Chào mừng trở lại!</p>
          </div>

          {error && (
            <div className="error-box">
              <span className="error-dot" />
              {error}
            </div>
          )}

          <form onSubmit={handleSubmit}>
            <div className="field-group">
              <label className="field-label">Email</label>
              <div className="field-wrapper">
                <FaEnvelope className="field-icon" />
                <input
                  type="email"
                  value={email}
                  onChange={(e) => setEmail(e.target.value)}
                  className="form-input"
                  placeholder="your.email@example.com"
                  required
                />
              </div>
            </div>

            <div className="field-group">
              <label className="field-label">Mật khẩu</label>
              <div className="field-wrapper">
                <FaLock className="field-icon" />
                <input
                  type={showPassword ? 'text' : 'password'}
                  value={password}
                  onChange={(e) => setPassword(e.target.value)}
                  className="form-input has-right-icon"
                  placeholder="••••••••"
                  required
                />
                <button
                  type="button"
                  className="toggle-password"
                  onClick={() => setShowPassword(!showPassword)}
                >
                  {showPassword ? <FaEyeSlash /> : <FaEye />}
                </button>
              </div>
            </div>

            <div className="options-row">
              <label className="remember-label">
                <input type="checkbox" className="remember-check" />
                Ghi nhớ đăng nhập
              </label>
              <a href="/forgot-password" className="forgot-link">Quên mật khẩu?</a>
            </div>

            <button type="submit" className="btn-submit" disabled={loading}>
              {loading ? (
                <>
                  <span className="spinner" />
                  Đang đăng nhập...
                </>
              ) : 'Đăng nhập'}
            </button>
          </form>

          <div className="divider">
            <div className="divider-line" />
            <span className="divider-text">hoặc</span>
            <div className="divider-line" />
          </div>

          <div className="register-row">
            Chưa có tài khoản?{' '}
            <a href="/register" className="register-link">Đăng ký ngay</a>
          </div>

        </div>
      </div>
    </>
  );
};

export default Login;