// src/components/common/FieldError.jsx
// Hiển thị thông báo lỗi inline dưới input field

export default function FieldError({ message }) {
  if (!message) return null
  return (
    <p className="flex items-center gap-1.5 text-xs text-red-500 mt-1 animate-[fadeIn_0.15s_ease]">
      <span className="flex-shrink-0 w-3.5 h-3.5 rounded-full bg-red-100 flex items-center justify-center text-[9px] font-bold">!</span>
      {message}
    </p>
  )
}

// Banner lỗi tổng (dùng cho _global error hoặc step summary)
export function StepErrorBanner({ errors }) {
  const list = Object.values(errors)
  if (list.length === 0) return null

  return (
    <div className="flex items-start gap-3 px-4 py-3 bg-red-50 border border-red-200 rounded-xl mb-4 animate-[fadeIn_0.2s_ease]">
      <span className="flex-shrink-0 w-5 h-5 rounded-full bg-red-500 text-white flex items-center justify-center text-xs font-bold mt-0.5">!</span>
      <div>
        {list.length === 1 ? (
          <p className="text-sm text-red-700 font-medium">{list[0]}</p>
        ) : (
          <>
            <p className="text-sm text-red-700 font-semibold mb-1">Vui lòng kiểm tra lại:</p>
            <ul className="space-y-0.5">
              {list.map((msg, i) => (
                <li key={i} className="text-xs text-red-600 flex items-center gap-1.5">
                  <span className="w-1 h-1 rounded-full bg-red-400 flex-shrink-0" />
                  {msg}
                </li>
              ))}
            </ul>
          </>
        )}
      </div>
    </div>
  )
}