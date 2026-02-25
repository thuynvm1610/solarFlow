import { useCreateHotel } from '../../../../contexts/CreateHotelContext'
import { useEditHotel } from '../../../../contexts/EditHotelContext'
import RoomTypeImageUploader from '../components/RoomTypeImageUploader'
import { uploadTempImage, validateImageFile } from '../../../../services/uploadService'

export default function Step5Images({ formOptions, isEdit }) {
  if (isEdit) return <Step5Edit />
  return <Step5Create />
}

// ── Create ───────────────────────────────────────────────────
function Step5Create() {
  const { state, dispatch } = useCreateHotel()

  const handleUpload = async (e) => {
    const files = Array.from(e.target.files || [])
    if (files.length === 0) return

    for (const file of files) {
      try {
        validateImageFile(file)
        const previewUrl = URL.createObjectURL(file)
        const res = await uploadTempImage(file)
        dispatch({
          type: 'ADD_HOTEL_IMAGE',
          payload: { tempPath: res.data.tempPath, isPrimary: false, previewUrl },
        })
      } catch (err) {
        alert(`Lỗi upload ${file.name}: ${err.message}`)
      }
    }
    
    e.target.value = ''
  }

  return (
    <div className="step-content">
      <section className="image-section">
        <h3>Ảnh khách sạn</h3>
        <div className="image-uploader">
          {state.hotelImages.map(img => (
            <ImageCard
              key={img.tempPath}
              src={img.previewUrl}
              isPrimary={img.isPrimary}
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
          ? <p className="empty-hint">Chưa có loại phòng nào được chọn.</p>
          : state.customRoomTypes.map(rt => (
            <RoomTypeImageUploader 
              key={rt.tempId} 
              roomType={rt} 
              isEdit={false} 
              dispatch={dispatch} 
            />
          ))
        }
      </section>
    </div>
  )
}

// ── Edit ─────────────────────────────────────────────────────
function Step5Edit() {
  const { state, dispatch } = useEditHotel()

  const handleUpload = async (e) => {
    const files = Array.from(e.target.files || [])
    if (files.length === 0) return

    for (const file of files) {
      try {
        validateImageFile(file)
        const previewUrl = URL.createObjectURL(file)
        const res = await uploadTempImage(file)
        dispatch({
          type: 'ADD_NEW_HOTEL_IMAGE',
          payload: { tempPath: res.data.tempPath, isPrimary: false, previewUrl },
        })
      } catch (err) {
        alert(`Lỗi upload ${file.name}: ${err.message}`)
      }
    }
    
    e.target.value = ''
  }

  return (
    <div className="step-content">
      <section className="image-section">
        <h3>Ảnh khách sạn</h3>
        <div className="image-uploader">
          {state.existingHotelImages.map(img => (
            <ImageCard
              key={img.imageId}
              src={`/uploads/${img.path}`}
              isPrimary={img.isPrimary}
              badge="Đã lưu"
              onSetPrimary={() => dispatch({ type: 'SET_HOTEL_PRIMARY', payload: { imageId: img.imageId } })}
              onDelete={() => dispatch({ type: 'DELETE_EXISTING_HOTEL_IMAGE', payload: img.imageId })}
            />
          ))}
          {state.newHotelImages.map(img => (
            <ImageCard
              key={img.tempPath}
              src={img.previewUrl}
              isPrimary={img.isPrimary}
              badge="Mới"
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
            <RoomTypeImageUploader 
              key={rt.roomTypeId} 
              roomType={rt} 
              isEdit={true} 
              dispatch={dispatch} 
            />
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
      <input 
        type="file" 
        accept="image/jpeg,image/png,image/webp" 
        multiple={multiple}
        hidden 
        onChange={onUpload} 
      />
    </label>
  )
}