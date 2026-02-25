import React, { useState, useEffect, useRef, useCallback } from 'react';
import { createPortal } from 'react-dom';
import { FaTimes, FaChevronDown, FaCheck } from 'react-icons/fa';

const CustomSelect = ({ value, onChange, options, placeholder = 'Tất cả', icon: Icon }) => {
  const [open, setOpen] = useState(false);
  const [dropdownStyle, setDropdownStyle] = useState({});
  const triggerRef = useRef(null);
  const dropdownRef = useRef(null);

  // Tính toán vị trí dropdown dựa trên trigger button
  const calcPosition = useCallback(() => {
    if (!triggerRef.current) return;
    const rect = triggerRef.current.getBoundingClientRect();
    const spaceBelow = window.innerHeight - rect.bottom;
    const spaceAbove = rect.top;
    const dropHeight = 280; // max height ước tính

    const openUpward = spaceBelow < dropHeight && spaceAbove > spaceBelow;

    setDropdownStyle({
      position: 'fixed',
      left: rect.left,
      width: rect.width,
      zIndex: 9999,
      ...(openUpward
        ? { bottom: window.innerHeight - rect.top + 4 }
        : { top: rect.bottom + 4 }
      ),
    });
  }, []);

  const handleOpen = () => {
    calcPosition();
    setOpen(o => !o);
  };

  // Đóng khi click ngoài
  useEffect(() => {
    if (!open) return;
    const handler = (e) => {
      if (
        triggerRef.current && !triggerRef.current.contains(e.target) &&
        dropdownRef.current && !dropdownRef.current.contains(e.target)
      ) {
        setOpen(false);
      }
    };
    document.addEventListener('mousedown', handler);
    return () => document.removeEventListener('mousedown', handler);
  }, [open]);

  // Recalc khi scroll hoặc resize
  useEffect(() => {
    if (!open) return;
    const update = () => calcPosition();
    window.addEventListener('scroll', update, true);
    window.addEventListener('resize', update);
    return () => {
      window.removeEventListener('scroll', update, true);
      window.removeEventListener('resize', update);
    };
  }, [open, calcPosition]);

  const selected = options.find(o => o.value === value);

  const dropdown = open && (
    <div
      ref={dropdownRef}
      style={dropdownStyle}
      className="bg-white border border-gray-100 rounded-xl shadow-xl overflow-hidden animate-in"
    >
      <style>{`
        @keyframes dropIn {
          from { opacity: 0; transform: translateY(-6px) scale(0.98); }
          to   { opacity: 1; transform: translateY(0) scale(1); }
        }
        .animate-in { animation: dropIn 0.15s ease-out forwards; }
      `}</style>

      {/* All / placeholder option */}
      <button
        type="button"
        onClick={() => { onChange(''); setOpen(false); }}
        className={`
          w-full flex items-center gap-3 px-4 py-2.5 text-sm transition-colors text-left
          ${!value ? 'bg-blue-50 text-blue-600 font-medium' : 'text-gray-500 hover:bg-gray-50'}
        `}
      >
        <span className={`w-4 h-4 rounded-full border-2 flex items-center justify-center flex-shrink-0
          ${!value ? 'border-blue-500 bg-blue-500' : 'border-gray-300'}`}>
          {!value && <span className="w-1.5 h-1.5 rounded-full bg-white" />}
        </span>
        {placeholder}
      </button>

      <div className="w-full h-px bg-gray-100" />

      {/* Options */}
      <div className="max-h-52 overflow-y-auto">
        {options.map((opt) => {
          const isSelected = value === opt.value;
          return (
            <button
              key={opt.value}
              type="button"
              onClick={() => { onChange(opt.value); setOpen(false); }}
              className={`
                w-full flex items-center gap-3 px-4 py-2.5 text-sm transition-all text-left
                ${isSelected
                  ? 'bg-blue-50 text-blue-700 font-semibold'
                  : 'text-gray-700 hover:bg-gray-50 hover:pl-5'
                }
              `}
            >
              <span className={`w-4 h-4 rounded-full border-2 flex items-center justify-center flex-shrink-0 transition-colors
                ${isSelected ? 'border-blue-500 bg-blue-500' : 'border-gray-300'}`}>
                {isSelected && <span className="w-1.5 h-1.5 rounded-full bg-white" />}
              </span>
              {opt.icon && <span className="flex-shrink-0">{opt.icon}</span>}
              <span className="flex-1 truncate">{opt.label}</span>
              {isSelected && <FaCheck className="text-blue-500 text-xs flex-shrink-0" />}
            </button>
          );
        })}
      </div>
    </div>
  );

  return (
    <div className="relative w-full">
      {/* Trigger */}
      <button
        ref={triggerRef}
        type="button"
        onClick={handleOpen}
        className={`
          w-full flex items-center gap-2 px-4 py-2.5 rounded-xl border text-sm font-medium
          transition-all duration-200 text-left
          ${open
            ? 'border-blue-500 ring-2 ring-blue-100 bg-white shadow-md'
            : 'border-gray-200 bg-gray-50 hover:bg-white hover:border-blue-300 hover:shadow-sm'
          }
        `}
      >
        {Icon && <Icon className={`flex-shrink-0 text-xs ${value ? 'text-blue-500' : 'text-gray-400'}`} />}
        <span className={`flex-1 truncate ${value ? 'text-gray-800' : 'text-gray-400'}`}>
          {selected ? selected.label : placeholder}
        </span>
        {value && (
          <button
            type="button"
            onClick={(e) => { e.stopPropagation(); onChange(''); }}
            className="flex-shrink-0 w-4 h-4 rounded-full bg-gray-200 hover:bg-red-100 flex items-center justify-center transition-colors"
          >
            <FaTimes className="text-[8px] text-gray-500 hover:text-red-500" />
          </button>
        )}
        <FaChevronDown className={`flex-shrink-0 text-xs text-gray-400 transition-transform duration-200 ${open ? 'rotate-180' : ''}`} />
      </button>

      {/* Dropdown render ra document.body để thoát khỏi overflow:hidden */}
      {createPortal(dropdown, document.body)}
    </div>
  );
};

export default CustomSelect;