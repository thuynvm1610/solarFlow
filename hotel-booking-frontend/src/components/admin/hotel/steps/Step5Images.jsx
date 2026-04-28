// src/components/admin/hotel/steps/Step5Images.jsx

import { useCreateHotel } from '../../../../contexts/CreateHotelContext'
import { useEditHotel }   from '../../../../contexts/EditHotelContext'
import RoomTypeImageUploader from '../components/RoomTypeImageUploader'
import { StepErrorBanner } from '../../../common/FieldError'
import { uploadTempImage, validateImageFile } from '../../../../services/uploadService'
import { FaImage, FaStar, FaTimes, FaPlus, FaBed } from 'react-icons/fa'

export default function Step5Images({ isEdit, errors = {} }) {
  if (isEdit) return <Step5Edit errors={errors} />
  return <Step5Create errors={errors} />
}

// ─────────────────────────────────────────────
// CREATE
// ─────────────────────────────────────────────
function Step5Create({ errors }) {
  const { state, dispatch } = useCreateHotel()

  const handleUpload = async (e) => {
    const files = Array.from(e.target.files || [])
    for (const file of files) {
      try {
        validateImageFile(file)
        const previewUrl = URL.createObjectURL(file)
        const res = await uploadTempImage(file)
        dispatch({ type: 'ADD_HOTEL_IMAGE', payload: { tempPath: res.data.tempPath, isPrimary: false, previewUrl } })
      } catch (err) { alert(`Lỗi upload ${file.name}: ${err.message}`) }
    }
    e.target.value = ''
  }

  const hasPrimary = state.hotelImages.some(i => i.isPrimary)

  return (
    <div className="space-y-5 pb-2">
      <StepErrorBanner errors={errors} />

      {/* Hotel images */}
      <div className="bg-white rounded-2xl border border-slate-200 p-5 shadow-sm">
        <SectionTitle icon={FaImage} title="Ảnh khách sạn" required />

        {!hasPrimary && state.hotelImages.length > 0 && (
          <div className="flex items-center gap-2 px-3 py-2 bg-amber-50 border border-amber-200 rounded-lg mb-4 text-xs text-amber-700">
            <FaStar className="w-3 h-3 flex-shrink-0" />
            Nhấn <strong className="mx-0.5">★</strong> để chọn ảnh đại diện
          </div>
        )}

        <div className="flex flex-wrap gap-3">
          {state.hotelImages.map(img => (
            <ImageCard key={img.tempPath} src={img.previewUrl} isPrimary={img.isPrimary}
              onSetPrimary={() => dispatch({ type: 'SET_HOTEL_PRIMARY', payload: img.tempPath })}
              onDelete={() => dispatch({ type: 'REMOVE_HOTEL_IMAGE', payload: img.tempPath })} />
          ))}
          <UploadButton onUpload={handleUpload} multiple />
        </div>

        <p className="text-xs text-slate-400 mt-3">
          {state.hotelImages.length} ảnh • Định dạng: JPG, PNG, WEBP • Tối đa 5MB/ảnh
        </p>
      </div>

      {/* Room type images */}
      <div className="bg-white rounded-2xl border border-slate-200 p-5 shadow-sm">
        <SectionTitle icon={FaBed} title="Ảnh theo loại phòng" />

        {state.customRoomTypes.length === 0 ? (
          <div className="text-center py-8 text-slate-400 text-sm">
            Chưa có loại phòng nào được tạo.
          </div>
        ) : (
          <div className="space-y-4">
            {state.customRoomTypes.map(rt => (
              <RoomTypeImageUploader key={rt.tempId} roomType={rt} isEdit={false} dispatch={dispatch} />
            ))}
          </div>
        )}
      </div>
    </div>
  )
}

// ─────────────────────────────────────────────
// EDIT
// ─────────────────────────────────────────────
function Step5Edit({ errors }) {
  const { state, dispatch } = useEditHotel()

  const handleUpload = async (e) => {
    const files = Array.from(e.target.files || [])
    for (const file of files) {
      try {
        validateImageFile(file)
        const previewUrl = URL.createObjectURL(file)
        const res = await uploadTempImage(file)
        dispatch({ type: 'ADD_NEW_HOTEL_IMAGE', payload: { tempPath: res.data.tempPath, isPrimary: false, previewUrl } })
      } catch (err) { alert(`Lỗi upload ${file.name}: ${err.message}`) }
    }
    e.target.value = ''
  }

  const allImages = [...(state.existingHotelImages ?? []), ...(state.newHotelImages ?? [])]
  const hasPrimary = allImages.some(i => i.isPrimary)

  return (
    <div className="space-y-5 pb-2">
      <StepErrorBanner errors={errors} />

      <div className="bg-white rounded-2xl border border-slate-200 p-5 shadow-sm">
        <SectionTitle icon={FaImage} title="Ảnh khách sạn" required />

        {!hasPrimary && allImages.length > 0 && (
          <div className="flex items-center gap-2 px-3 py-2 bg-amber-50 border border-amber-200 rounded-lg mb-4 text-xs text-amber-700">
            <FaStar className="w-3 h-3 flex-shrink-0" />
            Nhấn <strong className="mx-0.5">★</strong> để chọn ảnh đại diện
          </div>
        )}

        <div className="flex flex-wrap gap-3">
          {(state.existingHotelImages ?? []).map(img => (
            <ImageCard key={img.imageId} src={`/uploads/${img.path}`} isPrimary={img.isPrimary} badge="Đã lưu"
              onSetPrimary={() => dispatch({ type: 'SET_HOTEL_PRIMARY', payload: { imageId: img.imageId } })}
              onDelete={() => dispatch({ type: 'DELETE_EXISTING_HOTEL_IMAGE', payload: img.imageId })} />
          ))}
          {(state.newHotelImages ?? []).map(img => (
            <ImageCard key={img.tempPath} src={img.previewUrl} isPrimary={img.isPrimary} badge="Mới"
              onSetPrimary={() => dispatch({ type: 'SET_HOTEL_PRIMARY', payload: { tempPath: img.tempPath } })}
              onDelete={() => dispatch({ type: 'DELETE_NEW_HOTEL_IMAGE', payload: img.tempPath })} />
          ))}
          <UploadButton onUpload={handleUpload} multiple />
        </div>

        <p className="text-xs text-slate-400 mt-3">
          {allImages.length} ảnh • Định dạng: JPG, PNG, WEBP
        </p>
      </div>

      <div className="bg-white rounded-2xl border border-slate-200 p-5 shadow-sm">
        <SectionTitle icon={FaBed} title="Ảnh theo loại phòng" />

        {(state.selectedRoomTypes ?? []).length === 0 ? (
          <div className="text-center py-8 text-slate-400 text-sm">Chưa có loại phòng nào.</div>
        ) : (
          <div className="space-y-4">
            {(state.selectedRoomTypes ?? []).map(rt => (
              <RoomTypeImageUploader key={rt.roomTypeId} roomType={rt} isEdit dispatch={dispatch} />
            ))}
          </div>
        )}
      </div>
    </div>
  )
}

// ─────────────────────────────────────────────
// Shared UI components
// ─────────────────────────────────────────────
function SectionTitle({ icon: Icon, title, required }) {
  return (
    <div className="flex items-center gap-2 mb-4">
      <div className="flex items-center gap-2 px-3 py-1.5 rounded-lg border bg-indigo-50 text-indigo-700 border-indigo-200 text-xs font-bold uppercase tracking-wider">
        <Icon className="w-3.5 h-3.5" />
        {title}
      </div>
      {required && <span className="text-red-500 text-xs font-semibold">* bắt buộc</span>}
    </div>
  )
}

export function ImageCard({ src, isPrimary, onSetPrimary, onDelete, badge }) {
  return (
    <div className={`relative w-28 h-28 rounded-xl overflow-hidden border-2 transition-all group flex-shrink-0
      ${isPrimary ? 'border-blue-500 ring-2 ring-blue-200' : 'border-slate-200'}`}>

      {/* Image — object-cover để không bị méo/full size */}
      <img src={src} alt="preview" className="w-full h-full object-cover" />

      {/* Primary badge */}
      {isPrimary && (
        <div className="absolute top-1.5 left-1.5 px-1.5 py-0.5 bg-blue-500 text-white text-[10px] font-bold rounded-md">
          Đại diện
        </div>
      )}

      {/* New/Saved badge */}
      {badge && !isPrimary && (
        <div className={`absolute top-1.5 left-1.5 px-1.5 py-0.5 text-[10px] font-semibold rounded-md
          ${badge === 'Mới' ? 'bg-green-500 text-white' : 'bg-slate-500 text-white'}`}>
          {badge}
        </div>
      )}

      {/* Hover overlay with actions */}
      <div className="absolute inset-0 flex items-center justify-center gap-2
                      bg-black/0 group-hover:bg-black/40 opacity-0 group-hover:opacity-100
                      transition-all duration-200">
        {!isPrimary && (
          <button onClick={onSetPrimary}
            className="w-8 h-8 rounded-full bg-white/90 hover:bg-yellow-400 text-yellow-500
                       hover:text-white flex items-center justify-center shadow-sm transition-all"
            title="Đặt làm ảnh đại diện">
            <FaStar className="w-3.5 h-3.5" />
          </button>
        )}
        <button onClick={onDelete}
          className="w-8 h-8 rounded-full bg-white/90 hover:bg-red-500 text-red-500
                     hover:text-white flex items-center justify-center shadow-sm transition-all"
          title="Xóa">
          <FaTimes className="w-3 h-3" />
        </button>
      </div>
    </div>
  )
}

function UploadButton({ onUpload, multiple = false }) {
  return (
    <label className="w-28 h-28 rounded-xl border-2 border-dashed border-slate-300 flex flex-col
                       items-center justify-center cursor-pointer text-slate-400 flex-shrink-0
                       hover:border-blue-400 hover:text-blue-500 hover:bg-blue-50/50
                       transition-all duration-150">
      <FaPlus className="w-5 h-5 mb-1" />
      <span className="text-xs font-medium">Thêm ảnh</span>
      <input type="file" accept="image/jpeg,image/png,image/webp"
        multiple={multiple} hidden onChange={onUpload} />
    </label>
  )
}