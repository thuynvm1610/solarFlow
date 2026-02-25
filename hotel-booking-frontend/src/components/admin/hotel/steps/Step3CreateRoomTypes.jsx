// src/components/admin/hotel/steps/Step3CreateRoomTypes.jsx

import { useCreateHotel } from '../../../../contexts/CreateHotelContext'
import { AmenityIcon } from '../../../../utils/amenityIcons'
import { FaPlus, FaTrash, FaBed } from 'react-icons/fa'

export default function Step3CreateRoomTypes({ formOptions }) {
    const { state, dispatch } = useCreateHotel()
    const { customRoomTypes } = state
    const { roomFeatures = [] } = formOptions ?? {}

    const handleAdd = () => {
        dispatch({ type: 'ADD_CUSTOM_ROOM_TYPE' })
    }

    return (
        <div className="space-y-6">
            <div className="flex items-center justify-between">
                <div>
                    <h3 className="text-lg font-bold text-slate-800">Tạo Loại Phòng Cho Khách Sạn</h3>
                    <p className="text-sm text-slate-500 mt-1">Thêm các loại phòng riêng biệt cho khách sạn của bạn</p>
                </div>
                <button
                    onClick={handleAdd}
                    className="flex items-center gap-2 px-4 py-2.5 bg-sky-600 hover:bg-sky-700 text-white rounded-lg font-semibold transition-all"
                >
                    <FaPlus /> Thêm Loại Phòng
                </button>
            </div>

            {customRoomTypes.length === 0 ? (
                <div className="text-center py-16 bg-slate-50 rounded-xl border-2 border-dashed border-slate-300">
                    <FaBed className="w-12 h-12 text-slate-300 mx-auto mb-3" />
                    <p className="text-slate-500 text-sm">Chưa có loại phòng nào. Nhấn "Thêm Loại Phòng" để bắt đầu.</p>
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
                        />
                    ))}
                </div>
            )}
        </div>
    )
}

function RoomTypeCard({ roomType, index, roomFeatures, dispatch }) {
    const update = (field, value) => {
        dispatch({
            type: 'UPDATE_CUSTOM_ROOM_TYPE',
            payload: { tempId: roomType.tempId, field, value },
        })
    }

    const remove = () => {
        if (window.confirm('Xóa loại phòng này?')) {
            dispatch({ type: 'REMOVE_CUSTOM_ROOM_TYPE', payload: roomType.tempId })
        }
    }

    const toggleFeature = (featureId) => {
        dispatch({
            type: 'TOGGLE_ROOM_FEATURE',
            payload: { tempId: roomType.tempId, featureId },
        })
    }

    return (
        <div className="bg-white rounded-xl border-2 border-slate-200 overflow-hidden">
            {/* Header */}
            <div className="flex items-center justify-between px-5 py-3 bg-gradient-to-r from-blue-900 to-blue-700">
                <span className="text-white font-bold">Loại Phòng #{index + 1}</span>
                <button
                    onClick={remove}
                    className="w-8 h-8 flex items-center justify-center rounded-lg bg-white/20 hover:bg-white/30 text-white transition-all"
                >
                    <FaTrash className="w-3.5 h-3.5" />
                </button>
            </div>

            {/* Body */}
            <div className="p-5 space-y-4">
                {/* Row 1 */}
                <div className="grid grid-cols-2 gap-4">
                    <div>
                        <label className="block text-sm font-semibold text-slate-700 mb-1.5">
                            Tên loại phòng <span className="text-red-500">*</span>
                        </label>
                        <input
                            type="text"
                            value={roomType.name}
                            onChange={(e) => update('name', e.target.value)}
                            placeholder="VD: Deluxe, Suite..."
                            className="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                        />
                    </div>

                    <div>
                        <label className="block text-sm font-semibold text-slate-700 mb-1.5">
                            Giá cơ bản (VNĐ/đêm) <span className="text-red-500">*</span>
                        </label>
                        <input
                            type="number"
                            min={0}
                            step={10000}
                            value={roomType.basePrice}
                            onChange={(e) => update('basePrice', e.target.value)}
                            placeholder="VD: 500000"
                            className="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                        />
                    </div>
                </div>

                {/* Row 2 */}
                <div>
                    <label className="block text-sm font-semibold text-slate-700 mb-1.5">
                        Mô tả
                    </label>
                    <textarea
                        rows={2}
                        value={roomType.description}
                        onChange={(e) => update('description', e.target.value)}
                        placeholder="Mô tả ngắn gọn về loại phòng..."
                        className="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                    />
                </div>

                {/* Row 3 */}
                <div className="grid grid-cols-3 gap-4">
                    <div>
                        <label className="block text-sm font-semibold text-slate-700 mb-1.5">
                            Số người lớn tối đa
                        </label>
                        <input
                            type="number"
                            min={1}
                            max={10}
                            value={roomType.maxAdults}
                            onChange={(e) => update('maxAdults', Number(e.target.value))}
                            className="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                        />
                    </div>

                    <div>
                        <label className="block text-sm font-semibold text-slate-700 mb-1.5">
                            Số trẻ em tối đa
                        </label>
                        <input
                            type="number"
                            min={0}
                            max={5}
                            value={roomType.maxChildren}
                            onChange={(e) => update('maxChildren', Number(e.target.value))}
                            className="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                        />
                    </div>

                    <div>
                        <label className="block text-sm font-semibold text-slate-700 mb-1.5">
                            Diện tích (m²)
                        </label>
                        <input
                            type="number"
                            min={10}
                            max={200}
                            value={roomType.areaM2}
                            onChange={(e) => update('areaM2', Number(e.target.value))}
                            className="w-full px-3 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                        />
                    </div>
                </div>

                {/* Row 4: Room Features */}
                {roomFeatures.length > 0 && (
                    <div>
                        <label className="block text-sm font-semibold text-slate-700 mb-2">
                            Tiện ích phòng
                        </label>
                        <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-2">
                            {roomFeatures.map(feature => {
                                const isSelected = roomType.featureIds.includes(feature.id)
                                return (
                                    <button
                                        key={feature.id}
                                        onClick={() => toggleFeature(feature.id)}
                                        className={`
                      flex items-center gap-2 px-2.5 py-2 rounded-lg border-2 transition-all text-xs font-medium
                      ${isSelected
                                                ? 'border-indigo-500 bg-indigo-50 text-indigo-700'
                                                : 'border-slate-200 bg-white text-slate-600 hover:border-indigo-300'
                                            }
                    `}
                                    >
                                        <AmenityIcon
                                            iconKey={feature.icon}
                                            className={`w-3.5 h-3.5 flex-shrink-0 ${isSelected ? 'text-indigo-600' : 'text-slate-400'}`}
                                        />
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