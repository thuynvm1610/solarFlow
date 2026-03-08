// src/components/admin/hotel/steps/Step5Images.jsx

import { useCreateHotel } from '../../../../contexts/CreateHotelContext'
import { useEditHotel }   from '../../../../contexts/EditHotelContext'
import RoomTypeImageUploader from '../components/RoomTypeImageUploader'
import { StepErrorBanner } from '../../../common/FieldError'
import { uploadTempImage, validateImageFile } from '../../../../services/uploadService'

export default function Step5Images({ isEdit, errors = {} }) {
  if (isEdit) return <Step5Edit errors={errors} />
  return           <Step5Create errors={errors} />
}

function Step5Create({ errors }) {
  const { state, dispatch } = useCreateHotel()

  const handleUpload = async (e) => {
    const files = Array.from(e.target.files || [])
    for (const file of files) {
      try {
        validateImageFile(file)
        const previewUrl = URL.createObjectURL(file)
        const res = await uploadTempImage(file)
        dispatch({
          type: 'ADD_HOTEL_IMAGE',
          payload: { tempPath: res.data.tempPath, isPrimary: false, previewUrl },
        })
      } catch (err) { alert(`Lỗi upload ${file.name}: ${err.message}`) }
    }
    e.target.value = ''
  }

  return (
    <div className="step-content">
      <StepErrorBanner errors={errors} />

      <section className="image-section">
        <h3>Ảnh khách sạn <span className="text-red-500 normal-case text-xs font-normal">(bắt buộc, chọn 1 ảnh đại diện ★)</span></h3>
        <div className={`image-uploader p-3 rounded-xl border-2 border-dashed transition-colors
          ${errors._global ? 'border-red-300 bg-red-50' : 'border-transparent'}`}
        >
          {state.hotelImages.map(img => (
            <ImageCard key={img.tempPath} src={img.previewUrl} isPrimary={img.isPrimary}
              onSetPrimary={() => dispatch({ type: 'SET_HOTEL_PRIMARY', payload: img.tempPath })}
              onDelete={() => dispatch({ type: 'REMOVE_HOTEL_IMAGE', payload: img.tempPath })}
            />
          ))}
          <UploadButton onUpload={handleUpload} multiple />
        </div>
      </section>

      <section className="image-section">
        <h3>Ảnh theo loại phòng</h3>
        {state.customRoomTypes.length === 0
          ? <p className="empty-hint">Chưa có loại phòng nào được tạo.</p>
          : state.customRoomTypes.map(rt => (
            <RoomTypeImageUploader key={rt.tempId} roomType={rt} isEdit={false} dispatch={dispatch} />
          ))
        }
      </section>
    </div>
  )
}

function Step5Edit({ errors }) {
  const { state, dispatch } = useEditHotel()

  const handleUpload = async (e) => {
    const files = Array.from(e.target.files || [])
    for (const file of files) {
      try {
        validateImageFile(file)
        const previewUrl = URL.createObjectURL(file)
        const res = await uploadTempImage(file)
        dispatch({
          type: 'ADD_NEW_HOTEL_IMAGE',
          payload: { tempPath: res.data.tempPath, isPrimary: false, previewUrl },
        })
      } catch (err) { alert(`Lỗi upload ${file.name}: ${err.message}`) }
    }
    e.target.value = ''
  }

  return (
    <div className="step-content">
      <StepErrorBanner errors={errors} />

      <section className="image-section">
        <h3>Ảnh khách sạn <span className="text-red-500 normal-case text-xs font-normal">(bắt buộc, chọn 1 ảnh đại diện ★)</span></h3>
        <div className={`image-uploader p-3 rounded-xl border-2 border-dashed transition-colors
          ${errors._global ? 'border-red-300 bg-red-50' : 'border-transparent'}`}
        >
          {state.existingHotelImages.map(img => (
            <ImageCard key={img.imageId} src={img.path} isPrimary={img.isPrimary} badge="Đã lưu"
              onSetPrimary={() => dispatch({ type: 'SET_HOTEL_PRIMARY', payload: { imageId: img.imageId } })}
              onDelete={() => dispatch({ type: 'DELETE_EXISTING_HOTEL_IMAGE', payload: img.imageId })}
            />
          ))}
          {state.newHotelImages.map(img => (
            <ImageCard key={img.tempPath} src={img.previewUrl} isPrimary={img.isPrimary} badge="Mới"
              onSetPrimary={() => dispatch({ type: 'SET_HOTEL_PRIMARY', payload: { tempPath: img.tempPath } })}
              onDelete={() => dispatch({ type: 'DELETE_NEW_HOTEL_IMAGE', payload: img.tempPath })}
            />
          ))}
          <UploadButton onUpload={handleUpload} multiple />
        </div>
      </section>

      <section className="image-section">
        <h3>Ảnh theo loại phòng</h3>
        {state.selectedRoomTypes.length === 0
          ? <p className="empty-hint">Chưa có loại phòng nào.</p>
          : state.selectedRoomTypes.map(rt => (
            <RoomTypeImageUploader key={rt.roomTypeId} roomType={rt} isEdit dispatch={dispatch} />
          ))
        }
      </section>
    </div>
  )
}

// ── Shared UI ─────────────────────────────────────────────────
export function ImageCard({ src, isPrimary, onSetPrimary, onDelete, badge }) {
  return (
    <div className={`image-card ${isPrimary ? 'image-primary' : ''}`}>
      <img src={src} alt="preview" />
      {isPrimary && <span className="primary-badge">Ảnh đại diện</span>}
      {badge && !isPrimary && <span className="image-badge">{badge}</span>}
      <div className="image-actions">
        {!isPrimary && (
          <button className="btn-set-primary" onClick={onSetPrimary} title="Đặt làm ảnh đại diện">★</button>
        )}
        <button className="btn-delete-image" onClick={onDelete} title="Xóa">✕</button>
      </div>
    </div>
  )
}

function UploadButton({ onUpload, multiple = false }) {
  return (
    <label className="upload-btn">
      <span>+ Thêm ảnh</span>
      <input type="file" accept="image/jpeg,image/png,image/webp" multiple={multiple} hidden onChange={onUpload} />
    </label>
  )
}