// src/components/admin/hotel/EditHotelModal.jsx

import { useState, useEffect } from 'react'
import { EditHotelProvider, useEditHotel } from '../../../contexts/EditHotelContext'
import { getHotelDetail, updateHotel, getFormOptions } from '../../../services/hotelService'
import { ModalShell, StepIndicator } from './CreateHotelModal'
import Step1BasicInfo from './steps/Step1BasicInfo'
import Step2Amenities from './steps/Step2Amenities'
import Step3CreateRoomTypes from './steps/Step3CreateRoomTypes'
import Step4Rooms from './steps/Step4Rooms'
import Step5Images from './steps/Step5Images'

const STEPS = ['Thông tin cơ bản', 'Tiện ích & Dịch vụ', 'Phòng', 'Hình ảnh']

// Wrapper: load hotel data + formOptions trước khi render form
export default function EditHotelModal({ hotelId, onClose, onSuccess }) {
  const [hotel, setHotel] = useState(null)
  const [formOptions, setFormOptions] = useState(null)
  const [loading, setLoading] = useState(true)

  useEffect(() => {
    Promise.all([
      getHotelDetail(hotelId),
      getFormOptions(),
    ])
      .then(([hotelRes, optionsRes]) => {
        setHotel(hotelRes.data)
        setFormOptions(optionsRes.data)
      })
      .catch(() => alert('Không thể tải dữ liệu khách sạn'))
      .finally(() => setLoading(false))
  }, [hotelId])

  if (loading) return <ModalShell onClose={onClose}><div className="modal-loading">Đang tải...</div></ModalShell>
  if (!hotel) return null

  return (
    <EditHotelProvider hotel={hotel}>
      <EditHotelForm formOptions={formOptions} onClose={onClose} onSuccess={onSuccess} />
    </EditHotelProvider>
  )
}

// Form chính — bên trong EditHotelProvider
function EditHotelForm({ formOptions, onClose, onSuccess }) {
  const { state, dispatch, buildUpdatePayload, validatePayload } = useEditHotel()
  const [submitting, setSubmitting] = useState(false)

  const currentStep = state.currentStep
  const isLastStep = currentStep === STEPS.length

  const handleNext = () => dispatch({ type: 'SET_STEP', payload: currentStep + 1 })
  const handleBack = () => dispatch({ type: 'SET_STEP', payload: currentStep - 1 })

  const handleSubmit = async () => {
    const errors = validatePayload()
    if (errors.length) {
      alert(errors[0])
      return
    }
    setSubmitting(true)
    try {
      const payload = buildUpdatePayload()
      await updateHotel(state.hotelId, payload)
      onSuccess?.()
      onClose()
    } catch (err) {
      alert(err.response?.data?.message ?? 'Có lỗi xảy ra khi cập nhật khách sạn')
    } finally {
      setSubmitting(false)
    }
  }

  const stepProps = { formOptions, isEdit: true }

  return (
    <ModalShell onClose={onClose} title={`Chỉnh sửa khách sạn`}>
      <StepIndicator steps={STEPS} currentStep={currentStep} />

      <div className="modal-body">
        {currentStep === 1 && <Step1BasicInfo {...stepProps} />}
        {currentStep === 2 && <Step2Amenities {...stepProps} />}
        {currentStep === 3 && <Step3CreateRoomTypes     {...stepProps} />}
        {currentStep === 4 && <Step4Rooms     {...stepProps} />}
        {currentStep === 5 && <Step5Images    {...stepProps} />}
      </div>

      <div className="modal-footer">
        {currentStep > 1 && (
          <button className="btn-secondary" onClick={handleBack} disabled={submitting}>
            Quay lại
          </button>
        )}
        <button className="btn-cancel" onClick={onClose} disabled={submitting}>
          Hủy
        </button>
        {isLastStep ? (
          <button className="btn-primary" onClick={handleSubmit} disabled={submitting}>
            {submitting ? 'Đang lưu...' : 'Cập nhật'}
          </button>
        ) : (
          <button className="btn-primary" onClick={handleNext}>
            Tiếp theo
          </button>
        )}
      </div>
    </ModalShell>
  )
}