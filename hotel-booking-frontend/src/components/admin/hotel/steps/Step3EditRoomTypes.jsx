// src/components/admin/hotel/steps/Step3EditRoomTypes.jsx
// Chỉ dùng cho Edit Hotel — chỉnh sửa safe fields của loại phòng đang có
// Create Hotel dùng Step3CreateRoomTypes.jsx (file riêng)
// Safe fields: name, description, area_m2, max_adults, max_children, featureIds
// basePrice KHÔNG được phép sửa

import { useEditHotel } from '../../../../contexts/EditHotelContext'
import { AmenityIcon }  from '../../../../utils/amenityIcons'

export default function Step3EditRoomTypes({ formOptions }) {
  const { state, dispatch } = useEditHotel()
  const { selectedRoomTypes } = state
  const { roomFeatures = [] } = formOptions ?? {}

  if (selectedRoomTypes.length === 0) {
    return (
      <div className="text-center py-16 bg-slate-50 rounded-xl border-2 border-dashed border-slate-300">
        <p className="text-slate-500 text-sm">Khách sạn này chưa có loại phòng nào.</p>
      </div>
    )
  }

  return (
    <div className="space-y-5">
      <div className="flex items-start gap-3 bg-blue-50 border border-blue-200 rounded-lg px-4 py-3">
        <span className="text-blue-500 text-lg flex-shrink-0">ℹ️</span>
        <p className="text-xs text-blue-700">
          Chỉ có thể chỉnh sửa <strong>tên, mô tả, diện tích, số khách tối đa và tiện ích phòng</strong>.
          Giá cơ bản không thể thay đổi tại đây.
        </p>
      </div>

      {selectedRoomTypes.map((rt, idx) => (
        <RoomTypeEditCard
          key={rt.roomTypeId}
          roomType={rt}
          index={idx}
          roomFeatures={roomFeatures}
          dispatch={dispatch}
        />
      ))}
    </div>
  )
}

function RoomTypeEditCard({ roomType, index, roomFeatures, dispatch }) {
  const update = (field, value) =>
    dispatch({ type: 'UPDATE_ROOM_TYPE', payload: { roomTypeId: roomType.roomTypeId, field, value } })

  const toggleFeature = (featureId) =>
    dispatch({ type: 'TOGGLE_ROOM_TYPE_FEATURE', payload: { roomTypeId: roomType.roomTypeId, featureId } })

  return (
    <div className="bg-white rounded-xl border-2 border-slate-200 overflow-hidden">
      <div className="flex items-center justify-between px-5 py-3 bg-gradient-to-r from-indigo-700 to-indigo-500">
        <span className="text-white font-bold">
          Loại Phòng #{index + 1}
          <span className="ml-2 text-indigo-200 font-normal text-sm">ID: {roomType.roomTypeId}</span>
        </span>
        {roomType.basePrice != null && (
          <span className="text-indigo-100 text-sm">
            Giá: {Number(roomType.basePrice).toLocaleString('vi-VN')} VNĐ/đêm
            <span className="ml-1 text-indigo-300 text-xs">(không thể chỉnh)</span>
          </span>
        )}
      </div>

      <div className="p-5 space-y-4">
        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-semibold text-slate-700 mb-1.5">
              Tên loại phòng <span className="text-red-500">*</span>
            </label>
            <input
              type="text"
              value={roomType.name}
              onChange={e => update('name', e.target.value)}
              className="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
            />
          </div>
          <div>
            <label className="block text-sm font-semibold text-slate-700 mb-1.5">Diện tích (m²)</label>
            <input
              type="number" min={10} max={500}
              value={roomType.areaM2}
              onChange={e => update('areaM2', Number(e.target.value))}
              className="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
            />
          </div>
        </div>

        <div>
          <label className="block text-sm font-semibold text-slate-700 mb-1.5">Mô tả</label>
          <textarea
            rows={2}
            value={roomType.description}
            onChange={e => update('description', e.target.value)}
            className="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
          />
        </div>

        <div className="grid grid-cols-2 gap-4">
          <div>
            <label className="block text-sm font-semibold text-slate-700 mb-1.5">Số người lớn tối đa</label>
            <input type="number" min={1} max={10} value={roomType.maxAdults}
              onChange={e => update('maxAdults', Number(e.target.value))}
              className="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent" />
          </div>
          <div>
            <label className="block text-sm font-semibold text-slate-700 mb-1.5">Số trẻ em tối đa</label>
            <input type="number" min={0} max={5} value={roomType.maxChildren}
              onChange={e => update('maxChildren', Number(e.target.value))}
              className="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent" />
          </div>
        </div>

        {roomFeatures.length > 0 && (
          <div>
            <label className="block text-sm font-semibold text-slate-700 mb-2">Tiện ích phòng</label>
            <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-2">
              {roomFeatures.map(feature => {
                const isSelected = roomType.featureIds.includes(feature.id)
                return (
                  <button key={feature.id} onClick={() => toggleFeature(feature.id)}
                    className={`flex items-center gap-2 px-2.5 py-2 rounded-lg border-2 transition-all text-xs font-medium
                      ${isSelected ? 'border-indigo-500 bg-indigo-50 text-indigo-700' : 'border-slate-200 bg-white text-slate-600 hover:border-indigo-300'}`}
                  >
                    <AmenityIcon iconKey={feature.icon}
                      className={`w-3.5 h-3.5 flex-shrink-0 ${isSelected ? 'text-indigo-600' : 'text-slate-400'}`} />
                    <span className="truncate">{feature.name}</span>
                    {isSelected && <span className="ml-auto text-indigo-600">✓</span>}
                  </button>
                )
              })}
            </div>
            <p className="text-xs text-slate-500 mt-2">
              Đã chọn: <strong>{roomType.featureIds.length}</strong> / {roomFeatures.length}
            </p>
          </div>
        )}
      </div>
    </div>
  )
}