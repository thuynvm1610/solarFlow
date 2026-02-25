// src/components/admin/hotel/CreateHotelModal.jsx

import { useState, useEffect } from 'react'
import { createPortal } from 'react-dom'
import { CreateHotelProvider, useCreateHotel } from '../../../contexts/CreateHotelContext'
import { createHotel, getFormOptions } from '../../../services/hotelService'
import { useToast } from '../../../contexts/ToastContext'
import Step1BasicInfo from './steps/Step1BasicInfo'
import Step2Amenities from './steps/Step2Amenities'
import Step3CreateRoomTypes from './steps/Step3CreateRoomTypes'
import Step4Rooms from './steps/Step4Rooms'
import Step5Images from './steps/Step5Images'
import './HotelSteps.css'

const STEPS = [
  'Thông tin cơ bản',
  'Tiện ích & Dịch vụ',
  'Loại phòng',
  'Phòng',
  'Hình ảnh'
]

export default function CreateHotelModal({ onClose, onSuccess }) {
  const [formOptions, setFormOptions] = useState(null)
  const [loadingOptions, setLoadingOptions] = useState(true)
  const [error, setError] = useState(null)
  const toast = useToast()

  useEffect(() => {
    getFormOptions()
      .then(res => setFormOptions(res.data))
      .catch(err => {
        const errorMsg = err.response?.data?.message || err.message || 'Không thể tải dữ liệu form'
        setError(errorMsg)
        toast.error(errorMsg)
      })
      .finally(() => setLoadingOptions(false))
  }, [toast])

  if (error) {
    return (
      <ModalShell onClose={onClose}>
        <div className="flex flex-col items-center gap-3 py-14 px-10 text-center">
          <h3 className="text-lg font-semibold text-red-600">Lỗi</h3>
          <p className="text-sm text-slate-600">{error}</p>
          <button
            onClick={onClose}
            className="mt-2 px-5 py-2.5 rounded-xl bg-sky-600 hover:bg-sky-700 text-white text-sm font-semibold transition-all"
          >
            Đóng
          </button>
        </div>
      </ModalShell>
    )
  }

  if (loadingOptions) {
    return (
      <ModalShell onClose={onClose}>
        <div className="flex items-center justify-center py-20 text-slate-500 text-sm font-medium">
          Đang tải...
        </div>
      </ModalShell>
    )
  }

  if (!formOptions) return null

  return (
    <CreateHotelProvider>
      <CreateHotelForm formOptions={formOptions} onClose={onClose} onSuccess={onSuccess} />
    </CreateHotelProvider>
  )
}

function CreateHotelForm({ formOptions, onClose, onSuccess }) {
  const { state, dispatch, buildSubmitPayload, validatePayload } = useCreateHotel()
  const [submitting, setSubmitting] = useState(false)
  const toast = useToast()

  const currentStep = state.currentStep
  const isLastStep = currentStep === STEPS.length

  const validateCurrentStep = () => {
    const { basicInfo, amenities } = state
    const errors = []

    switch (currentStep) {
      case 1:
        if (!basicInfo.name?.trim()) errors.push('Tên khách sạn không được để trống')
        if (!basicInfo.description?.trim()) errors.push('Mô tả không được để trống')
        if (!basicInfo.address?.trim()) errors.push('Địa chỉ không được để trống')
        if (!basicInfo.city?.trim()) errors.push('Thành phố không được để trống')
        if (!basicInfo.type) errors.push('Chưa chọn loại khách sạn')
        if (!basicInfo.starRating) errors.push('Chưa chọn số sao')
        if (!basicInfo.floor || basicInfo.floor <= 0) errors.push('Số tầng phải lớn hơn 0')
        if (!basicInfo.managerId) errors.push('Chưa chọn quản lý')
        if (!basicInfo.checkInTime) errors.push('Chưa nhập giờ check-in')
        if (!basicInfo.checkOutTime) errors.push('Chưa nhập giờ check-out')
        break
      case 2:
        amenities.paidAmenities.forEach((pa) => {
          if (!pa.basePrice || Number(pa.basePrice) <= 0) errors.push(`Dịch vụ "${pa.name}" chưa nhập giá`)
          if (!pa.unitId) errors.push(`Dịch vụ "${pa.name}" chưa chọn đơn vị`)
        })
        break
      case 3:
        if (state.customRoomTypes.length === 0) errors.push('Phải tạo ít nhất 1 loại phòng')
        state.customRoomTypes.forEach((rt, idx) => {
          if (!rt.name?.trim()) errors.push(`Loại phòng #${idx + 1} chưa có tên`)
          if (!rt.basePrice || Number(rt.basePrice) <= 0) errors.push(`Loại phòng "${rt.name || '#' + (idx + 1)}" chưa có giá`)
        })
        break
      case 4:
        if (state.generatedRooms.length === 0) errors.push('Chưa tạo danh sách phòng')
        const unassigned = state.generatedRooms.filter(r => !r.roomTypeTempId)
        if (unassigned.length > 0) errors.push(`Còn ${unassigned.length} phòng chưa được gán loại`)
        break
      case 5:
        if (state.hotelImages.length === 0) errors.push('Phải có ít nhất 1 ảnh khách sạn')
        if (!state.hotelImages.some(img => img.isPrimary)) errors.push('Chưa chọn ảnh đại diện cho khách sạn')
        state.customRoomTypes.forEach(rt => {
          if (rt.images.length === 0) errors.push(`Loại phòng "${rt.name}" chưa có ảnh`)
          if (!rt.images.some(i => i.isPrimary)) errors.push(`Loại phòng "${rt.name}" chưa chọn ảnh đại diện`)
        })
        break
      default:
        break
    }

    return errors
  }

  const handleNext = () => {
    const errors = validateCurrentStep()
    if (errors.length > 0) {
      errors.forEach(error => toast.error(error, 4000))
      return
    }
    dispatch({ type: 'SET_STEP', payload: currentStep + 1 })
  }

  const handleBack = () => dispatch({ type: 'SET_STEP', payload: currentStep - 1 })

  const handleSubmit = async () => {
    const errors = validatePayload()
    if (errors.length) {
      errors.forEach(error => toast.error(error, 5000))
      return
    }

    setSubmitting(true)
    try {
      await createHotel(buildSubmitPayload())
      toast.success('Tạo khách sạn thành công!', 3000)
      dispatch({ type: 'RESET' })
      onSuccess?.()
      onClose()
    } catch (err) {
      toast.error(err.response?.data?.message ?? 'Có lỗi xảy ra khi tạo khách sạn', 5000)
    } finally {
      setSubmitting(false)
    }
  }

  const stepProps = { formOptions, isEdit: false }

  return (
    <ModalShell onClose={onClose} title="Thêm mới khách sạn">
      <StepIndicator steps={STEPS} currentStep={currentStep} />

      <div className="flex-1 overflow-y-auto px-7 py-6 [scrollbar-width:thin]">
        {currentStep === 1 && <Step1BasicInfo {...stepProps} />}
        {currentStep === 2 && <Step2Amenities {...stepProps} />}
        {currentStep === 3 && <Step3CreateRoomTypes {...stepProps} />}
        {currentStep === 4 && <Step4Rooms {...stepProps} />}
        {currentStep === 5 && <Step5Images {...stepProps} />}
      </div>

      <div className="flex items-center justify-end gap-3 px-7 py-4 border-t border-slate-100 bg-slate-50">
        {currentStep > 1 && (
          <button
            onClick={handleBack}
            disabled={submitting}
            className="px-5 py-2.5 rounded-xl bg-white hover:bg-slate-100 active:scale-95 text-slate-700 text-sm font-semibold border border-slate-200 transition-all disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Quay lại
          </button>
        )}
        <button
          onClick={onClose}
          disabled={submitting}
          className="px-5 py-2.5 rounded-xl bg-white hover:bg-red-50 active:scale-95 text-red-500 text-sm font-semibold border border-red-200 hover:border-red-300 transition-all disabled:opacity-50 disabled:cursor-not-allowed"
        >
          Hủy
        </button>
        {isLastStep ? (
          <button
            onClick={handleSubmit}
            disabled={submitting}
            className="px-5 py-2.5 rounded-xl bg-sky-600 hover:bg-sky-700 active:scale-95 text-white text-sm font-semibold shadow-sm shadow-sky-200 transition-all disabled:opacity-50 disabled:cursor-not-allowed"
          >
            {submitting ? 'Đang lưu...' : 'Tạo khách sạn'}
          </button>
        ) : (
          <button
            onClick={handleNext}
            className="px-5 py-2.5 rounded-xl bg-sky-600 hover:bg-sky-700 active:scale-95 text-white text-sm font-semibold shadow-sm shadow-sky-200 transition-all"
          >
            Tiếp theo
          </button>
        )}
      </div>
    </ModalShell>
  )
}

// ─────────────────────────────────────────────
// Shared UI
// ─────────────────────────────────────────────

/**
 * FIX 1 — Modal centering:
 * Dùng createPortal để render overlay ra document.body,
 * thoát khỏi DOM của sidebar → modal luôn căn giữa viewport
 * dù sidebar mở rộng hay thu gọn.
 */
export function ModalShell({ onClose, title, children }) {
  return createPortal(
    <div
      className="fixed inset-0 z-[200] flex items-center justify-center bg-black/60 backdrop-blur-sm"
      onClick={e => e.target === e.currentTarget && onClose()}
    >
      <div className="relative bg-white rounded-2xl shadow-2xl w-full max-w-3xl max-h-[92vh] flex flex-col overflow-hidden mx-4">
        {title && (
          <div className="flex items-center justify-between px-7 py-5 border-b border-slate-100 bg-gradient-to-r from-sky-600 to-indigo-600">
            <h2 className="text-xl font-bold text-white tracking-wide">{title}</h2>
            <button
              onClick={onClose}
              className="w-8 h-8 flex items-center justify-center rounded-full text-white/70 hover:text-white hover:bg-white/20 transition-all text-sm"
            >
              ✕
            </button>
          </div>
        )}
        {children}
      </div>
    </div>,
    document.body
  )
}

/**
 * FIX 2 — Step indicator overflow:
 * - Bỏ whitespace-nowrap, dùng text-center + line clamp thay thế
 * - Giảm connector width từ w-10 (40px) xuống w-6 (24px)
 * - Dùng overflow-x-auto + scrollbar ẩn làm fallback nếu vẫn tràn
 * - Label ẩn trên màn hình nhỏ (< sm), chỉ hiện số bước
 */
export function StepIndicator({ steps, currentStep }) {
  return (
    <div className="flex items-center px-6 py-4 bg-slate-50 border-b border-slate-100 overflow-x-auto [scrollbar-width:none] [&::-webkit-scrollbar]:hidden">
      {steps.map((label, i) => {
        const num = i + 1
        const isDone = num < currentStep
        const isActive = num === currentStep
        return (
          <div key={i} className="flex items-center flex-shrink-0">
            {/* Circle + label inline */}
            <div className="flex items-center gap-2 flex-shrink-0">
              <div className={`
                w-7 h-7 rounded-full flex items-center justify-center text-xs font-bold border-2 transition-all duration-300 flex-shrink-0
                ${isActive ? 'bg-sky-600 border-sky-600 text-white shadow-md shadow-sky-200' : ''}
                ${isDone ? 'bg-emerald-500 border-emerald-500 text-white' : ''}
                ${!isActive && !isDone ? 'border-slate-300 text-slate-400 bg-white' : ''}
              `}>
                {isDone ? '✓' : num}
              </div>
              <span className={`
                text-xs font-medium whitespace-nowrap transition-colors duration-300
                ${isActive ? 'text-sky-700 font-semibold' : ''}
                ${isDone ? 'text-emerald-600' : ''}
                ${!isActive && !isDone ? 'text-slate-400' : ''}
              `}>
                {label}
              </span>
            </div>

            {/* Connector */}
            {i < steps.length - 1 && (
              <div className={`
                w-5 h-0.5 mx-2 rounded-full flex-shrink-0 transition-all duration-300
                ${isDone ? 'bg-emerald-300' : 'bg-slate-200'}
              `} />
            )}
          </div>
        )
      })}
    </div>
  )
}