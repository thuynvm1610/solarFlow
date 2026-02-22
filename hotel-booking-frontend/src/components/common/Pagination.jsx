import React from 'react';
import { FaChevronLeft, FaChevronRight } from 'react-icons/fa';

/**
 * Pagination - Component phân trang tái sử dụng
 *
 * Props:
 *  - currentPage   : số trang hiện tại (0-indexed)
 *  - totalPages    : tổng số trang
 *  - totalElements : tổng số bản ghi (tuỳ chọn, để hiển thị info)
 *  - pageSize      : kích thước trang (tuỳ chọn)
 *  - onPageChange  : callback(newPage: number)
 *  - siblingCount  : số trang hiển thị mỗi bên trang hiện tại (mặc định 1)
 *  - showInfo      : hiển thị dòng thông tin "Hiển thị X - Y / Z" (mặc định true)
 */
const Pagination = ({
  currentPage = 0,
  totalPages = 0,
  totalElements,
  pageSize,
  onPageChange,
  siblingCount = 1,
  showInfo = true,
}) => {
  if (totalPages <= 1) return null;

  // ---------- helpers ----------
  const range = (start, end) => {
    const result = [];
    for (let i = start; i <= end; i++) result.push(i);
    return result;
  };

  const buildPageNumbers = () => {
    const totalPageNums = siblingCount * 2 + 5; // siblings + current + 2 ends + 2 dots

    if (totalPages <= totalPageNums) {
      return range(0, totalPages - 1);
    }

    const leftSibling  = Math.max(currentPage - siblingCount, 1);
    const rightSibling = Math.min(currentPage + siblingCount, totalPages - 2);

    const showLeftDots  = leftSibling  > 2;
    const showRightDots = rightSibling < totalPages - 3;

    if (!showLeftDots && showRightDots) {
      const leftRange = range(0, 2 + siblingCount * 2);
      return [...leftRange, 'dots-r', totalPages - 1];
    }
    if (showLeftDots && !showRightDots) {
      const rightRange = range(totalPages - 3 - siblingCount * 2, totalPages - 1);
      return [0, 'dots-l', ...rightRange];
    }
    return [0, 'dots-l', ...range(leftSibling, rightSibling), 'dots-r', totalPages - 1];
  };

  const pages = buildPageNumbers();

  // ---------- info text ----------
  const from = currentPage * (pageSize || 0) + 1;
  const to   = Math.min((currentPage + 1) * (pageSize || 0), totalElements || 0);

  // ---------- shared button base ----------
  const baseBtn = `
    inline-flex items-center justify-center min-w-[36px] h-9 px-2
    rounded-lg text-sm font-medium select-none
    transition-all duration-200 ease-in-out
    focus:outline-none focus:ring-2 focus:ring-blue-400 focus:ring-offset-1
  `;

  const arrowBtn = (disabled) => `
    ${baseBtn}
    border border-gray-200 bg-white
    ${disabled
      ? 'text-gray-300 cursor-not-allowed opacity-60'
      : 'text-gray-600 hover:bg-blue-50 hover:border-blue-300 hover:text-blue-600 active:scale-95 cursor-pointer'}
  `;

  const pageBtn = (active) => `
    ${baseBtn} cursor-pointer
    ${active
      ? 'bg-blue-600 text-white border border-blue-600 shadow-md shadow-blue-200 scale-105'
      : 'border border-gray-200 bg-white text-gray-600 hover:bg-blue-50 hover:border-blue-300 hover:text-blue-600 active:scale-95'}
  `;

  return (
    <div className="flex flex-col items-center gap-3 select-none">
      {/* Info row */}
      {showInfo && totalElements !== undefined && pageSize && (
        <p className="text-xs text-gray-400">
          Hiển thị{' '}
          <span className="font-semibold text-gray-600">{from}–{to}</span>
          {' '}trong{' '}
          <span className="font-semibold text-gray-600">{totalElements}</span>
          {' '}kết quả
        </p>
      )}

      {/* Buttons row */}
      <div className="flex items-center gap-1 flex-wrap justify-center">
        {/* First */}
        <button
          onClick={() => onPageChange(0)}
          disabled={currentPage === 0}
          className={arrowBtn(currentPage === 0)}
          title="Trang đầu"
          aria-label="Trang đầu"
        >
          <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M11 19l-7-7 7-7m8 14l-7-7 7-7" />
          </svg>
        </button>

        {/* Prev */}
        <button
          onClick={() => onPageChange(currentPage - 1)}
          disabled={currentPage === 0}
          className={arrowBtn(currentPage === 0)}
          title="Trang trước"
          aria-label="Trang trước"
        >
          <FaChevronLeft className="text-xs" />
        </button>

        {/* Page numbers */}
        {pages.map((page, idx) => {
          if (page === 'dots-l' || page === 'dots-r') {
            return (
              <span
                key={`${page}-${idx}`}
                className="inline-flex items-center justify-center min-w-[36px] h-9 text-gray-400 text-sm tracking-widest"
              >
                ···
              </span>
            );
          }
          return (
            <button
              key={page}
              onClick={() => onPageChange(page)}
              className={pageBtn(page === currentPage)}
              aria-current={page === currentPage ? 'page' : undefined}
            >
              {page + 1}
            </button>
          );
        })}

        {/* Next */}
        <button
          onClick={() => onPageChange(currentPage + 1)}
          disabled={currentPage >= totalPages - 1}
          className={arrowBtn(currentPage >= totalPages - 1)}
          title="Trang sau"
          aria-label="Trang sau"
        >
          <FaChevronRight className="text-xs" />
        </button>

        {/* Last */}
        <button
          onClick={() => onPageChange(totalPages - 1)}
          disabled={currentPage >= totalPages - 1}
          className={arrowBtn(currentPage >= totalPages - 1)}
          title="Trang cuối"
          aria-label="Trang cuối"
        >
          <svg className="w-3.5 h-3.5" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M13 5l7 7-7 7M5 5l7 7-7 7" />
          </svg>
        </button>
      </div>
    </div>
  );
};

export default Pagination;