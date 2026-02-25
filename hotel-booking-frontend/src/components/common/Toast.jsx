import { useEffect } from 'react'
import { FaCheckCircle, FaExclamationCircle, FaInfoCircle, FaTimes } from 'react-icons/fa'

export default function Toast({ message, type = 'error', onClose, duration = 5000 }) {
  useEffect(() => {
    if (duration && duration > 0) {
      const timer = setTimeout(onClose, duration)
      return () => clearTimeout(timer)
    }
  }, [duration, onClose])

  const icons = {
    success: <FaCheckCircle className="toast-icon" />,
    error: <FaExclamationCircle className="toast-icon" />,
    warning: <FaExclamationCircle className="toast-icon" />,
    info: <FaInfoCircle className="toast-icon" />,
  }

  return (
    <div className={`toast toast-${type}`}>
      <div className="toast-content">
        {icons[type]}
        <div className="toast-message">{message}</div>
      </div>
      <button onClick={onClose} className="toast-close">
        <FaTimes />
      </button>
      <div className="toast-progress" style={{ animationDuration: `${duration}ms` }} />
    </div>
  )
}