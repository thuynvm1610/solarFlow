// src/components/admin/hotel/EditHotelModal.jsx

import { useState, useEffect }         from 'react'
import { EditHotelProvider, useEditHotel } from '../../../contexts/EditHotelContext'
import { getHotelDetail, updateHotel, getFormOptions } from '../../../services/hotelService'
import { ModalShell, StepIndicator }   from './CreateHotelModal'
import Step1BasicInfo       from './steps/Step1BasicInfo'
import Step2Amenities       from './steps/Step2Amenities'
import Step3EditRoomTypes   from './steps/Step3EditRoomTypes'
import Step4Rooms           from './steps/Step4Rooms'
import Step5Images          from './steps/Step5Images'
import {
  validateStep1, validateStep2, validateStep3Edit,
  validateStep4Edit, validateStep5Edit, hasErrors,
} from '../../../hooks/useStepValidation'

const STEPS = ['Thông tin cơ bản', 'Tiện ích & Dịch vụ', 'Loại phòng', 'Phòng', 'Hình ảnh']

// ── Wrapper ───────────────────────────────────────────────────
export default function EditHotelModal({ hotelId, onClose, onSuccess }) {
  const [hotel,       setHotel]       = useState(null)
  const [formOptions, setFormOptions] = useState(null)
  const [loading,     setLoading]     = useState(true)

  useEffect(() => {
    Promise.all([getHotelDetail(hotelId), getFormOptions(hotelId)])
      .then(([hotelRes, optionsRes]) => {
        setHotel(hotelRes.data)
        setFormOptions(optionsRes.data)
      })
      .catch(() => alert('Không thể tải dữ liệu khách sạn'))
      .finally(() => setLoading(false))
  }, [hotelId])

  if (loading) {
    return (
      <ModalShell onClose={onClose}>
        <div className="flex items-center justify-center py-20 text-slate-500">
          Đang tải dữ liệu...
        </div>
      </ModalShell>
    )
  }
  if (!hotel) return null

  return (
    <EditHotelProvider hotel={hotel}>
      <EditHotelForm formOptions={formOptions} onClose={onClose} onSuccess={onSuccess} />
    </EditHotelProvider>
  )
}

// ── Form ──────────────────────────────────────────────────────
function EditHotelForm({ formOptions, onClose, onSuccess }) {
  const { state, dispatch, buildUpdatePayload } = useEditHotel()
  const [submitting, setSubmitting] = useState(false)
  const [stepErrors, setStepErrors] = useState({})

  const currentStep = state.currentStep
  const isLastStep  = currentStep === STEPS.length

  const validateCurrentStep = () => {
    const { basicInfo, amenities, selectedRoomTypes, existingRooms, newRooms,
            existingHotelImages, newHotelImages } = state
    switch (currentStep) {
      case 1: return validateStep1(basicInfo, true)
      case 2: return validateStep2(amenities)
      case 3: return validateStep3Edit(selectedRoomTypes)
      case 4: return validateStep4Edit(existingRooms, newRooms)
      case 5: return validateStep5Edit(existingHotelImages, newHotelImages)
      default: return {}
    }
  }

  const handleNext = () => {
    const errors = validateCurrentStep()
    if (hasErrors(errors)) { setStepErrors(errors); return }
    setStepErrors({})
    dispatch({ type: 'SET_STEP', payload: currentStep + 1 })
  }

  const handleBack = () => {
    setStepErrors({})
    dispatch({ type: 'SET_STEP', payload: currentStep - 1 })
  }

  const handleSubmit = async () => {
    const errors = validateCurrentStep()
    if (hasErrors(errors)) { setStepErrors(errors); return }

    setSubmitting(true)
    try {
      await updateHotel(state.hotelId, buildUpdatePayload())
      onSuccess?.()
      onClose()
    } catch (err) {
      alert(err.response?.data?.message ?? 'Có lỗi xảy ra khi cập nhật khách sạn')
    } finally {
      setSubmitting(false)
    }
  }

  return (
    <ModalShell onClose={onClose} title="Chỉnh sửa khách sạn">
      <StepIndicator steps={STEPS} currentStep={currentStep} />

      <div className="flex-1 overflow-y-auto px-6 py-5">
        {currentStep === 1 && (
          <Step1BasicInfo formOptions={formOptions} isEdit errors={stepErrors} />
        )}
        {currentStep === 2 && (
          <Step2Amenities formOptions={formOptions} isEdit errors={stepErrors} />
        )}
        {currentStep === 3 && (
          <Step3EditRoomTypes formOptions={formOptions} errors={stepErrors} />
        )}
        {currentStep === 4 && (
          <Step4Rooms formOptions={formOptions} isEdit errors={stepErrors} />
        )}
        {currentStep === 5 && (
          <Step5Images isEdit errors={stepErrors} />
        )}
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
            className="px-5 py-2 rounded-lg bg-indigo-600 hover:bg-indigo-700 text-white font-semibold text-sm transition-colors disabled:opacity-50">
            {submitting ? 'Đang lưu...' : 'Cập nhật'}
          </button>
        ) : (
          <button onClick={handleNext}
            className="px-5 py-2 rounded-lg bg-indigo-600 hover:bg-indigo-700 text-white font-semibold text-sm transition-colors">
            Tiếp theo
          </button>
        )}
      </div>
    </ModalShell>
  )
}