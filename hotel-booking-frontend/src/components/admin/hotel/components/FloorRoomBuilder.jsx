// src/components/admin/hotel/components/FloorRoomBuilder.jsx
// Dùng cho Create Hotel — generate rooms từ floor configs

import { useState, useMemo } from 'react'
import { useCreateHotel } from '../../../../contexts/CreateHotelContext'
import CustomSelect from '../../../common/CustomSelect'
import { FaBed } from 'react-icons/fa'

export default function FloorRoomBuilder({ allRoomTypes }) {
  const { state, dispatch } = useCreateHotel()
  const { floorConfigs, generatedRooms, basicInfo } = state
  const [generated, setGenerated] = useState(false)

  const roomsByFloor = useMemo(() =>
    generatedRooms.reduce((acc, room) => {
      acc[room.floorNumber] ??= []
      acc[room.floorNumber].push(room)
      return acc
    }, {}),
    [generatedRooms])

  // ✅ ĐỔI: Format options từ customRoomTypes (có tempId)
  const roomTypeOptions = allRoomTypes.map(rt => ({
    value: rt.tempId,  // ✅ Dùng tempId thay vì id
    label: rt.name,
  }))

  if (basicInfo.floor === 0 || floorConfigs.length === 0) {
    return (
      <div className="empty-hint">
        Vui lòng nhập số tầng ở bước 1 trước.
      </div>
    )
  }

  const handleGenerate = () => {
    const hasEmpty = floorConfigs.some(f => !f.roomCount || f.roomCount <= 0)
    if (hasEmpty) {
      alert('Vui lòng nhập số phòng cho tất cả các tầng')
      return
    }
    dispatch({ type: 'GENERATE_ROOMS' })
    setGenerated(true)
  }

  // ✅ ĐỔI: Đếm rooms có roomTypeTempId
  const assignedCount = generatedRooms.filter(r => r.roomTypeTempId).length

  return (
    <div className="floor-builder">

      {/* Bước 1: Nhập số phòng mỗi tầng */}
      <div className="floor-config-section">
        <h4>Số phòng mỗi tầng</h4>
        <div className="floor-config-grid">
          {floorConfigs.map(config => (
            <div key={config.floorNumber} className="floor-config-item">
              <label>Tầng {config.floorNumber}</label>
              <input
                type="number"
                min={0}
                max={99}
                value={config.roomCount || ''}
                placeholder="0"
                onChange={e => dispatch({
                  type: 'UPDATE_FLOOR_CONFIG',
                  payload: { floorNumber: config.floorNumber, roomCount: Number(e.target.value) },
                })}
              />
              <span>phòng</span>
            </div>
          ))}
        </div>

        <button className="btn-generate" onClick={handleGenerate}>
          {generated ? '↺ Tạo lại' : '→ Tạo danh sách phòng'}
        </button>

        {generated && (
          <small className="form-hint text-warning">
            ⚠ Tạo lại sẽ reset toàn bộ phân công loại phòng
          </small>
        )}
      </div>

      {/* Bước 2: Assign room type */}
      {generated && generatedRooms.length > 0 && (
        <div className="room-assign-section">
          <h4>Gán loại phòng</h4>

          {allRoomTypes.length === 0 ? (
            <div className="empty-hint">
              Chưa có loại phòng nào. Vui lòng tạo loại phòng ở bước trước.
            </div>
          ) : (
            <>
              {Object.entries(roomsByFloor).map(([floor, rooms]) => (
                <div key={floor} className="floor-section">
                  <div className="floor-header">
                    <strong>Tầng {floor}</strong>

                    {/* Gán nhanh toàn tầng */}
                    <div className="assign-all">
                      <span>Gán tất cả:</span>
                      <div className="w-44">
                        <CustomSelect
                          value=""
                          onChange={val => val && dispatch({
                            type: 'ASSIGN_ALL_FLOOR',
                            payload: { floorNumber: Number(floor), roomTypeTempId: val },  // ✅ tempId
                          })}
                          options={roomTypeOptions}
                          placeholder="-- Chọn --"
                          icon={FaBed}
                        />
                      </div>
                    </div>
                  </div>

                  <div className="room-grid">
                    {rooms.map(room => (
                      <div
                        key={room.roomNumber}
                        className={`room-card ${room.roomTypeTempId ? 'assigned' : 'unassigned'}`}  // ✅
                      >
                        <span className="room-number">Phòng {room.roomNumber}</span>
                        <CustomSelect
                          value={room.roomTypeTempId || ''}  // ✅
                          onChange={val => dispatch({
                            type: 'ASSIGN_ROOM_TYPE',
                            payload: { roomNumber: room.roomNumber, roomTypeTempId: val },  // ✅
                          })}
                          options={roomTypeOptions}
                          placeholder="-- Loại phòng --"
                        />
                      </div>
                    ))}
                  </div>
                </div>
              ))}

              <div className="assign-progress">
                Đã gán: <strong>{assignedCount}</strong> / {generatedRooms.length} phòng
              </div>
            </>
          )}
        </div>
      )}
    </div>
  )
}