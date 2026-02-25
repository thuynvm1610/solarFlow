// src/components/admin/hotel/components/FloorRoomEditor.jsx
// Dùng cho Edit Hotel — hiển thị rooms đang có, cho sửa room type
// Phòng có booking: disabled, không cho xóa

import { useMemo, useState } from 'react'
import { useEditHotel } from '../../../../contexts/EditHotelContext'

export default function FloorRoomEditor({ allRoomTypes }) {
  const { state, dispatch } = useEditHotel()
  const { existingRooms, newRooms } = state

  // Gộp existing + new để render theo tầng
  const allRooms = useMemo(() => [
    ...existingRooms.map(r => ({ ...r, isNew: false })),
    ...newRooms.map(r => ({ ...r, isNew: true })),
  ], [existingRooms, newRooms])

  const roomsByFloor = useMemo(() =>
    allRooms.reduce((acc, room) => {
      acc[room.floorNumber] ??= []
      acc[room.floorNumber].push(room)
      return acc
    }, {}),
  [allRooms])

  return (
    <div className="floor-editor">
      <div className="editor-legend">
        <span className="legend-item booked">🔒 Có booking — không thể xóa, không thể đổi loại phòng</span>
        <span className="legend-item new">🆕 Phòng mới thêm</span>
      </div>

      {Object.entries(roomsByFloor)
        .sort(([a], [b]) => Number(a) - Number(b))
        .map(([floor, rooms]) => (
          <FloorSection
            key={floor}
            floor={Number(floor)}
            rooms={rooms}
            allRoomTypes={allRoomTypes}
            dispatch={dispatch}
          />
        ))
      }

      {/* Thêm phòng mới */}
      <AddRoomPanel allRoomTypes={allRoomTypes} dispatch={dispatch} existingRooms={allRooms} />
    </div>
  )
}

// ─────────────────────────────────────────────
function FloorSection({ floor, rooms, allRoomTypes, dispatch }) {
  return (
    <div className="floor-section">
      <div className="floor-header">
        <strong>Tầng {floor}</strong>
        {/* Gán nhanh — bỏ qua phòng booked */}
        <div className="assign-all">
          <span>Gán tất cả (trừ booked):</span>
          <select
            defaultValue=""
            onChange={e => e.target.value && dispatch({
              type: 'ASSIGN_ALL_FLOOR',
              payload: { floorNumber: floor, roomTypeId: Number(e.target.value) },
            })}
          >
            <option value="">-- Chọn --</option>
            {allRoomTypes.map(rt => (
              <option key={rt.id} value={rt.id}>{rt.name}</option>
            ))}
          </select>
        </div>
      </div>

      <div className="room-grid">
        {rooms.map(room => (
          <RoomCard
            key={room.roomNumber}
            room={room}
            allRoomTypes={allRoomTypes}
            dispatch={dispatch}
          />
        ))}
      </div>
    </div>
  )
}

// ─────────────────────────────────────────────
function RoomCard({ room, allRoomTypes, dispatch }) {
  return (
    <div className={`room-card
      ${room.isBooked ? 'booked' : ''}
      ${room.isNew    ? 'new'    : ''}
      ${room.roomTypeId ? 'assigned' : 'unassigned'}
    `}>
      <div className="room-card-header">
        <span className="room-number">Phòng {room.roomNumber}</span>
        <div className="room-badges">
          {room.isBooked && <span className="badge badge-booked">Có booking</span>}
          {room.isNew    && <span className="badge badge-new">Mới</span>}
        </div>
      </div>

      <select
        value={room.roomTypeId ?? ''}
        disabled={room.isBooked}
        onChange={e => dispatch({
          type: room.isNew ? 'ASSIGN_NEW_ROOM_TYPE' : 'ASSIGN_ROOM_TYPE',
          payload: { roomNumber: room.roomNumber, roomTypeId: Number(e.target.value) },
        })}
      >
        <option value="">-- Loại phòng --</option>
        {allRoomTypes.map(rt => (
          <option key={rt.id} value={rt.id}>{rt.name}</option>
        ))}
      </select>

      {/* Xóa — chỉ cho phòng existing không booked */}
      {!room.isBooked && !room.isNew && (
        <button
          className="btn-delete-room"
          title="Xóa phòng"
          onClick={() => {
            if (window.confirm(`Xóa phòng ${room.roomNumber}?`))
              dispatch({ type: 'DELETE_ROOM', payload: room.roomId })
          }}
        >
          Xóa
        </button>
      )}

      {/* Xóa phòng mới */}
      {room.isNew && (
        <button
          className="btn-delete-room"
          title="Bỏ phòng mới này"
          onClick={() => dispatch({ type: 'DELETE_NEW_ROOM', payload: room.roomNumber })}
        >
          Bỏ
        </button>
      )}
    </div>
  )
}

// ─────────────────────────────────────────────
// Panel thêm phòng mới vào tầng đang có
// ─────────────────────────────────────────────
function AddRoomPanel({ allRoomTypes, dispatch, existingRooms }) {
  const [floorNumber, setFloorNumber] = useState('')
  const [roomTypeId,  setRoomTypeId]  = useState('')
  const [error, setError] = useState('')

  const handleAdd = () => {
    setError('')
    const floor = Number(floorNumber)
    if (!floor || floor < 1) { setError('Nhập số tầng hợp lệ'); return }
    if (!roomTypeId)          { setError('Chọn loại phòng');     return }

    // Tìm số phòng tiếp theo trong tầng này
    const roomsOnFloor = existingRooms.filter(r => r.floorNumber === floor)
    const maxIndex = roomsOnFloor.reduce((max, r) => {
      const idx = parseInt(r.roomNumber.slice(-2))
      return idx > max ? idx : max
    }, 0)

    const nextIndex = maxIndex + 1
    if (nextIndex > 99) { setError('Tầng này đã đủ 99 phòng'); return }

    const roomNumber = `${floor}${String(nextIndex).padStart(2, '0')}`

    // Kiểm tra trùng
    if (existingRooms.some(r => r.roomNumber === roomNumber)) {
      setError(`Phòng ${roomNumber} đã tồn tại`)
      return
    }

    dispatch({
      type: 'ADD_NEW_ROOM',
      payload: { roomNumber, floorNumber: floor, roomTypeId: Number(roomTypeId), isNew: true },
    })

    setFloorNumber('')
    setRoomTypeId('')
  }

  return (
    <div className="add-room-panel">
      <h4>Thêm phòng mới</h4>
      <div className="add-room-form">
        <input
          type="number"
          min={1}
          value={floorNumber}
          onChange={e => setFloorNumber(e.target.value)}
          placeholder="Tầng"
        />
        <select value={roomTypeId} onChange={e => setRoomTypeId(e.target.value)}>
          <option value="">-- Loại phòng --</option>
          {allRoomTypes.map(rt => (
            <option key={rt.id} value={rt.id}>{rt.name}</option>
          ))}
        </select>
        <button className="btn-primary" onClick={handleAdd}>Thêm phòng</button>
      </div>
      {error && <p className="error-text">{error}</p>}
      <small className="form-hint">
        Số phòng sẽ được tự động sinh tiếp theo trong tầng.
      </small>
    </div>
  )
}