// src/components/admin/hotel/CreateHotelModal.jsx

import { useState, useEffect }         from 'react'
import { CreateHotelProvider, useCreateHotel } from '../../../contexts/CreateHotelContext'
import { createHotel, getFormOptions }         from '../../../services/hotelService'
import { useToast }            from '../../../contexts/ToastContext'
import Step1BasicInfo          from './steps/Step1BasicInfo'
import Step2Amenities          from './steps/Step2Amenities'
import Step3CreateRoomTypes    from './steps/Step3CreateRoomTypes'
import Step4Rooms              from './steps/Step4Rooms'
import Step5Images             from './steps/Step5Images'
import {
  validateStep1, validateStep2, validateStep3Create,
  validateStep4Create, validateStep5Create,
  hasErrors, getErrorList,
} from '../../../hooks/useStepValidation'

const STEPS = ['Thông tin cơ bản', 'Tiện ích & Dịch vụ', 'Loại phòng', 'Phòng', 'Hình ảnh']

// ── Wrapper ───────────────────────────────────────────────────
export default function CreateHotelModal({ onClose, onSuccess }) {
  const [formOptions, setFormOptions] = useState(null)
  const [loading,     setLoading]     = useState(true)
  const toast = useToast()

  useEffect(() => {
    getFormOptions()
      .then(res => setFormOptions(res.data))
      .catch(() => toast.error('Không thể tải form options'))
      .finally(() => setLoading(false))
  }, [])

  if (loading) {
    return (
      <ModalShell onClose={onClose}>
        <div className="flex items-center justify-center py-20 text-slate-500">
          Đang tải dữ liệu...
        </div>
      </ModalShell>
    )
  }

  return (
    <CreateHotelProvider>
      <CreateHotelForm formOptions={formOptions} onClose={onClose} onSuccess={onSuccess} />
    </CreateHotelProvider>
  )
}

// ── Form ──────────────────────────────────────────────────────
function CreateHotelForm({ formOptions, onClose, onSuccess }) {
  const { state, dispatch, buildCreatePayload } = useCreateHotel()
  const toast = useToast()
  const [submitting, setSubmitting] = useState(false)

  // stepErrors chỉ dùng cho Step 1 (inline field errors)
  // Step 2-5 dùng toast
  const [step1Errors, setStep1Errors] = useState({})

  const currentStep = state.currentStep
  const isLastStep  = currentStep === STEPS.length

  const validateCurrentStep = () => {
    const { basicInfo, amenities, customRoomTypes, generatedRooms, hotelImages } = state
    switch (currentStep) {
      case 1: return validateStep1(basicInfo, false)
      case 2: return validateStep2(amenities)
      case 3: return validateStep3Create(customRoomTypes)
      case 4: return validateStep4Create(generatedRooms)
      case 5: return validateStep5Create(hotelImages)
      default: return {}
    }
  }

  const handleNext = () => {
    const errors = validateCurrentStep()
    if (!hasErrors(errors)) {
      setStep1Errors({})
      dispatch({ type: 'SET_STEP', payload: currentStep + 1 })
      return
    }

    if (currentStep === 1) {
      // Step 1: hiện inline errors dưới từng field
      setStep1Errors(errors)
      toast.error('Vui lòng điền đầy đủ các trường bắt buộc')
    } else {
      // Step 2-5: chỉ toast, không cần inline
      getErrorList(errors).forEach(msg => toast.error(msg))
    }
  }

  const handleBack = () => {
    setStep1Errors({})
    dispatch({ type: 'SET_STEP', payload: currentStep - 1 })
  }

  const handleSubmit = async () => {
    const errors = validateCurrentStep()
    if (hasErrors(errors)) {
      if (currentStep === 1) {
        setStep1Errors(errors)
        toast.error('Vui lòng điền đầy đủ các trường bắt buộc')
      } else {
        getErrorList(errors).forEach(msg => toast.error(msg))
      }
      return
    }

    setSubmitting(true)
    try {
      await createHotel(buildCreatePayload())
      toast.success('Tạo khách sạn thành công!')
      onSuccess?.()
      onClose()
    } catch (err) {
      toast.error(err.response?.data?.message ?? 'Có lỗi xảy ra khi tạo khách sạn')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <ModalShell onClose={onClose} title="Tạo khách sạn mới">
      <StepIndicator steps={STEPS} currentStep={currentStep} />

      <div className="flex-1 overflow-y-auto px-6 py-5">
        {currentStep === 1 && (
          <Step1BasicInfo formOptions={formOptions} isEdit={false} errors={step1Errors} />
        )}
        {currentStep === 2 && <Step2Amenities formOptions={formOptions} isEdit={false} />}
        {currentStep === 3 && <Step3CreateRoomTypes formOptions={formOptions} />}
        {currentStep === 4 && <Step4Rooms formOptions={formOptions} isEdit={false} />}
        {currentStep === 5 && <Step5Images isEdit={false} />}
      </div>

      <div className="flex items-center justify-end gap-3 px-6 py-4 border-t border-slate-200 flex-shrink-0">
        {currentStep > 1 && (
          <button onClick={handleBack} disabled={submitting}
            className="px-4 py-2 rounded-lg border border-slate-300 text-slate-700 hover:bg-slate-50 font-medium text-sm transition-colors">
            Quay lại
          </button>
        )}
        <button onClick={onClose} disabled={submitting}
          className="px-4 py-2 rounded-lg border border-slate-300 text-slate-700 hover:bg-slate-50 font-medium text-sm transition-colors">
          Hủy
        </button>
        {isLastStep ? (
          <button onClick={handleSubmit} disabled={submitting}
            className="px-5 py-2 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-sm transition-colors disabled:opacity-50">
            {submitting ? 'Đang tạo...' : 'Tạo khách sạn'}
          </button>
        ) : (
          <button onClick={handleNext}
            className="px-5 py-2 rounded-lg bg-blue-600 hover:bg-blue-700 text-white font-semibold text-sm transition-colors">
            Tiếp theo
          </button>
        )}
      </div>
    </ModalShell>
  )
}

// ── Shared UI ─────────────────────────────────────────────────
export function ModalShell({ onClose, title, children }) {
  return (
    <div
      className="fixed inset-0 z-[1100] flex items-center justify-center bg-black/50 backdrop-blur-sm p-4"
      onClick={e => e.target === e.currentTarget && onClose()}
    >
      <div className="bg-white rounded-2xl shadow-2xl w-full max-w-4xl max-h-[90vh] flex flex-col overflow-hidden">
        {title && (
          <div className="flex items-center justify-between px-6 py-4 border-b border-slate-200 flex-shrink-0">
            <h2 className="text-xl font-bold text-slate-800">{title}</h2>
            <button onClick={onClose}
              className="w-8 h-8 flex items-center justify-center rounded-lg hover:bg-slate-100 text-slate-500 hover:text-slate-700 transition-colors text-lg">
              ✕
            </button>
          </div>
        )}
        {children}
      </div>
    </div>
  )
}

export function StepIndicator({ steps, currentStep }) {
  return (
    <div className="flex items-center px-6 py-4 border-b border-slate-100 flex-shrink-0 overflow-x-auto">
      {steps.map((label, idx) => {
        const step   = idx + 1
        const done   = step < currentStep
        const active = step === currentStep
        return (
          <div key={step} className="flex items-center min-w-0">
            <div className="flex items-center gap-2 flex-shrink-0">
              <div className={`w-7 h-7 rounded-full flex items-center justify-center text-xs font-bold transition-colors
                ${done   ? 'bg-green-500 text-white' : ''}
                ${active ? 'bg-blue-600 text-white ring-4 ring-blue-100' : ''}
                ${!done && !active ? 'bg-slate-200 text-slate-500' : ''}
              `}>
                {done ? '✓' : step}
              </div>
              <span className={`text-xs font-medium whitespace-nowrap
                ${active ? 'text-blue-600' : done ? 'text-green-600' : 'text-slate-400'}
              `}>
                {label}
              </span>
            </div>
            {idx < steps.length - 1 && (
              <div className={`h-px w-6 mx-2 flex-shrink-0 ${done ? 'bg-green-400' : 'bg-slate-200'}`} />
            )}
          </div>
        )
      })}
    </div>
  )
}