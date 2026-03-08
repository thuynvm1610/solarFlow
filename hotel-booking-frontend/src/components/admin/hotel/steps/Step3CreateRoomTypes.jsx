// src/components/admin/hotel/steps/Step3CreateRoomTypes.jsx

import { useCreateHotel }   from '../../../../contexts/CreateHotelContext'
import { AmenityIcon }      from '../../../../utils/amenityIcons'
import { StepErrorBanner } from '../../../common/FieldError'
import { FaPlus, FaTrash, FaBed } from 'react-icons/fa'

export default function Step3CreateRoomTypes({ formOptions, errors = {} }) {
  const { state, dispatch } = useCreateHotel()
  const { customRoomTypes } = state
  const { roomFeatures = [] } = formOptions ?? {}

  return (
    <div className="space-y-6">
      <StepErrorBanner errors={errors} />

      <div className="flex items-center justify-between">
        <div>
          <h3 className="text-lg font-bold text-slate-800">Tạo Loại Phòng Cho Khách Sạn</h3>
          <p className="text-sm text-slate-500 mt-1">Thêm các loại phòng riêng biệt cho khách sạn của bạn</p>
        </div>
        <button
          onClick={() => dispatch({ type: 'ADD_CUSTOM_ROOM_TYPE' })}
          className="flex items-center gap-2 px-4 py-2.5 bg-sky-600 hover:bg-sky-700 text-white rounded-lg font-semibold transition-all"
        >
          <FaPlus /> Thêm Loại Phòng
        </button>
      </div>

      {customRoomTypes.length === 0 ? (
        <div className={`text-center py-16 rounded-xl border-2 border-dashed transition-colors
          ${errors._global ? 'border-red-300 bg-red-50' : 'bg-slate-50 border-slate-300'}`}
        >
          <FaBed className={`w-12 h-12 mx-auto mb-3 ${errors._global ? 'text-red-300' : 'text-slate-300'}`} />
          <p className={`text-sm ${errors._global ? 'text-red-500 font-medium' : 'text-slate-500'}`}>
            {errors._global ?? 'Chưa có loại phòng nào. Nhấn "Thêm Loại Phòng" để bắt đầu.'}
          </p>
        </div>
      ) : (
        <div className="space-y-4">
          {customRoomTypes.map((roomType, index) => (
            <RoomTypeCard
              key={roomType.tempId}
              roomType={roomType}
              index={index}
              roomFeatures={roomFeatures}
              dispatch={dispatch}
              errors={errors}
            />
          ))}
        </div>
      )}
    </div>
  )
}

function RoomTypeCard({ roomType, index, roomFeatures, dispatch, errors }) {
  const update = (field, value) =>
    dispatch({ type: 'UPDATE_CUSTOM_ROOM_TYPE', payload: { tempId: roomType.tempId, field, value } })

  const nameErr  = errors[`rt_${index}_name`]
  const priceErr = errors[`rt_${index}_price`]

  const inputCls = (hasErr) =>
    `w-full px-3 py-2 border rounded-lg text-sm outline-none focus:ring-2 focus:border-transparent transition-all
     ${hasErr ? 'border-red-400 bg-red-50 focus:ring-red-100' : 'border-slate-300 focus:ring-indigo-500'}`

  return (
    <div className={`bg-white rounded-xl border-2 overflow-hidden transition-colors
      ${(nameErr || priceErr) ? 'border-red-300' : 'border-slate-200'}`}
    >
      <div className="flex items-center justify-between px-5 py-3 bg-gradient-to-r from-blue-900 to-blue-700">
        <span className="text-white font-bold">Loại Phòng #{index + 1}</span>
        <button
          onClick={() => window.confirm('Xóa loại phòng này?') &&
            dispatch({ type: 'REMOVE_CUSTOM_ROOM_TYPE', payload: roomType.tempId })}
          className="w-8 h-8 flex items-center justify-center rounded-lg bg-white/20 hover:bg-white/30 text-white transition-all"
        >
          <FaTrash className="w-3.5 h-3.5" />
        </button>
      </div>

      <div className="p-5 space-y-4">
        <div className="grid grid-cols-2 gap-4">
          {/* Tên */}
          <div>
            <label className="block text-sm font-semibold text-slate-700 mb-1.5">
              Tên loại phòng <span className="text-red-500">*</span>
            </label>
            <input type="text" value={roomType.name}
              onChange={e => update('name', e.target.value)}
              placeholder="VD: Deluxe, Suite..."
              className={inputCls(nameErr)} />
            {nameErr && <p className="text-xs text-red-500 mt-1">Tên không được để trống</p>}
          </div>
          {/* Giá */}
          <div>
            <label className="block text-sm font-semibold text-slate-700 mb-1.5">
              Giá cơ bản (VNĐ/đêm) <span className="text-red-500">*</span>
            </label>
            <input type="number" min={0} step={10000} value={roomType.basePrice}
              onChange={e => update('basePrice', e.target.value)}
              placeholder="VD: 500000"
              className={inputCls(priceErr)} />
            {priceErr && <p className="text-xs text-red-500 mt-1">Giá phải lớn hơn 0</p>}
          </div>
        </div>

        <div>
          <label className="block text-sm font-semibold text-slate-700 mb-1.5">Mô tả</label>
          <textarea rows={2} value={roomType.description}
            onChange={e => update('description', e.target.value)}
            placeholder="Mô tả ngắn gọn về loại phòng..."
            className="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent outline-none text-sm transition-all" />
        </div>

        <div className="grid grid-cols-3 gap-4">
          {[
            { label: 'Số người lớn tối đa', field: 'maxAdults', min: 1, max: 10 },
            { label: 'Số trẻ em tối đa',   field: 'maxChildren', min: 0, max: 5 },
            { label: 'Diện tích (m²)',      field: 'areaM2',     min: 10, max: 200 },
          ].map(({ label, field, min, max }) => (
            <div key={field}>
              <label className="block text-sm font-semibold text-slate-700 mb-1.5">{label}</label>
              <input type="number" min={min} max={max} value={roomType[field]}
                onChange={e => update(field, Number(e.target.value))}
                className="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent outline-none text-sm transition-all" />
            </div>
          ))}
        </div>

        {roomFeatures.length > 0 && (
          <div>
            <label className="block text-sm font-semibold text-slate-700 mb-2">Tiện ích phòng</label>
            <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-2">
              {roomFeatures.map(feature => {
                const isSelected = roomType.featureIds.includes(feature.id)
                return (
                  <button key={feature.id}
                    onClick={() => dispatch({ type: 'TOGGLE_ROOM_FEATURE', payload: { tempId: roomType.tempId, featureId: feature.id } })}
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
          </div>
        )}
      </div>
    </div>
  )
}