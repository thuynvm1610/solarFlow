import { uploadTempImage, validateImageFile } from '../../../../services/uploadService'
import { ImageCard } from '../steps/Step5Images'

export default function RoomTypeImageUploader({ roomType, isEdit, dispatch }) {
  const {
    tempId,
    roomTypeId,
    roomTypeName,
    name,
    images = [],
    existingImages = [],
    newImages = [],
  } = roomType

  const handleUpload = async (e) => {
    const files = Array.from(e.target.files || [])
    if (files.length === 0) return

    for (const file of files) {
      try {
        validateImageFile(file)
        const previewUrl = URL.createObjectURL(file)
        const res = await uploadTempImage(file)
        const tempPath = res.data.tempPath

        if (isEdit) {
          dispatch({
            type: 'ADD_NEW_ROOM_TYPE_IMAGE',
            payload: { roomTypeId, image: { tempPath, isPrimary: false, previewUrl } },
          })
        } else {
          dispatch({
            type: 'ADD_ROOM_TYPE_IMAGE',
            payload: { tempId, image: { tempPath, isPrimary: false, previewUrl } },
          })
        }
      } catch (err) {
        alert(`Lỗi upload ${file.name}: ${err.message}`)
      }
    }

    e.target.value = ''
  }

  const displayName = isEdit ? roomTypeName : name

  return (
    <div className="room-type-uploader">
      <h4>{displayName}</h4>

      <div className="image-uploader">
        {isEdit && existingImages.map(img => (
          <ImageCard
            key={img.imageId}
            src={`/uploads/${img.path}`}
            isPrimary={img.isPrimary}
            badge="Đã lưu"
            onSetPrimary={() => dispatch({
              type: 'SET_ROOM_TYPE_PRIMARY',
              payload: { roomTypeId, imageId: img.imageId },
            })}
            onDelete={() => dispatch({
              type: 'DELETE_EXISTING_ROOM_TYPE_IMAGE',
              payload: { roomTypeId, imageId: img.imageId },
            })}
          />
        ))}

        {(isEdit ? newImages : images).map(img => (
          <ImageCard
            key={img.tempPath}
            src={img.previewUrl}
            isPrimary={img.isPrimary}
            badge={isEdit ? 'Mới' : null}
            onSetPrimary={() => dispatch({
              type: 'SET_ROOM_TYPE_PRIMARY',
              payload: isEdit
                ? { roomTypeId, tempPath: img.tempPath }
                : { tempId, tempPath: img.tempPath },
            })}
            onDelete={() => dispatch({
              type: isEdit ? 'DELETE_NEW_ROOM_TYPE_IMAGE' : 'REMOVE_ROOM_TYPE_IMAGE',
              payload: isEdit 
                ? { roomTypeId, tempPath: img.tempPath }
                : { tempId, tempPath: img.tempPath },
            })}
          />
        ))}

        <label className="upload-btn">
          <span>+ Thêm ảnh</span>
          <input 
            type="file" 
            accept="image/jpeg,image/png,image/webp" 
            multiple 
            hidden 
            onChange={handleUpload} 
          />
        </label>
      </div>

      {(() => {
        const allImages = isEdit ? [...existingImages, ...newImages] : images
        return allImages.length > 0 && !allImages.some(i => i.isPrimary) ? (
          <p className="warning-text">⚠ Chưa có ảnh đại diện</p>
        ) : null
      })()}
    </div>
  )
}