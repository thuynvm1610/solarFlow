// src/components/admin/hotel/steps/Step4Rooms.jsx

import { useMemo, useState } from 'react'
import { useCreateHotel }   from '../../../../contexts/CreateHotelContext'
import { useEditHotel }     from '../../../../contexts/EditHotelContext'
import CustomSelect         from '../../../common/CustomSelect'
import { StepErrorBanner } from '../../../common/FieldError'
import { FaBed, FaLayerGroup, FaCheckCircle, FaExclamationTriangle } from 'react-icons/fa'

export default function Step4Rooms({ formOptions, isEdit, errors = {} }) {
  if (isEdit) return <Step4Edit formOptions={formOptions} errors={errors} />
  return <Step4Create errors={errors} />
}

// ─────────────────────────────────────────────
// CREATE
// ─────────────────────────────────────────────
function Step4Create({ errors }) {
  const { state, dispatch } = useCreateHotel()
  const { floorConfigs, generatedRooms, basicInfo, customRoomTypes } = state
  const [generated, setGenerated] = useState(generatedRooms.length > 0)

  const roomTypeOptions = customRoomTypes.map(rt => ({ value: rt.tempId, label: rt.name }))

  const roomsByFloor = useMemo(() =>
    generatedRooms.reduce((acc, room) => {
      acc[room.floorNumber] ??= []
      acc[room.floorNumber].push(room)
      return acc
    }, {}), [generatedRooms])

  const assignedCount = generatedRooms.filter(r => r.roomTypeTempId).length

  if (!basicInfo.floor || floorConfigs.length === 0) {
    return (
      <div className="flex flex-col items-center justify-center py-16 text-slate-400">
        <FaLayerGroup className="w-12 h-12 mb-3 opacity-40" />
        <p className="text-sm">Vui lòng nhập số tầng ở Bước 1 trước.</p>
      </div>
    )
  }

  const handleGenerate = () => {
    const hasEmpty = floorConfigs.some(f => !f.roomCount || f.roomCount <= 0)
    if (hasEmpty) { alert('Vui lòng nhập số phòng cho tất cả các tầng'); return }
    dispatch({ type: 'GENERATE_ROOMS' })
    setGenerated(true)
  }

  return (
    <div className="space-y-5 pb-2">
      <StepErrorBanner errors={errors} />

      {/* Config số phòng mỗi tầng */}
      <div className="bg-white rounded-2xl border border-slate-200 p-5 shadow-sm">
        <div className="flex items-center gap-2 px-3 py-1.5 rounded-lg border bg-blue-50 text-blue-700 border-blue-200 text-xs font-bold uppercase tracking-wider mb-4 w-fit">
          <FaLayerGroup className="w-3.5 h-3.5" /> Cấu hình phòng theo tầng
        </div>

        <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-3 mb-4">
          {floorConfigs.map(config => (
            <div key={config.floorNumber}
              className="flex items-center gap-2 px-3 py-2.5 rounded-xl border border-slate-200 bg-slate-50">
              <span className="text-xs font-semibold text-slate-600 whitespace-nowrap">
                Tầng {config.floorNumber}
              </span>
              <input
                type="number" min={0} max={99}
                value={config.roomCount || ''}
                placeholder="0"
                onChange={e => dispatch({
                  type: 'UPDATE_FLOOR_CONFIG',
                  payload: { floorNumber: config.floorNumber, roomCount: Number(e.target.value) },
                })}
                className="w-14 text-center px-2 py-1 rounded-lg border border-slate-200 bg-white
                           text-sm outline-none focus:border-blue-400 focus:ring-2 focus:ring-blue-100 transition-all"
              />
              <span className="text-xs text-slate-400">phòng</span>
            </div>
          ))}
        </div>

        <button onClick={handleGenerate}
          className="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-blue-600 hover:bg-blue-700
                     text-white text-sm font-semibold shadow-sm transition-all active:scale-95">
          {generated ? '↺ Tạo lại' : '→ Tạo danh sách phòng'}
        </button>

        {generated && (
          <p className="flex items-center gap-1.5 text-xs text-amber-600 mt-2">
            <FaExclamationTriangle className="w-3 h-3" />
            Tạo lại sẽ reset toàn bộ phân công loại phòng
          </p>
        )}
      </div>

      {/* Gán loại phòng */}
      {generated && generatedRooms.length > 0 && (
        <div className="bg-white rounded-2xl border border-slate-200 p-5 shadow-sm">
          <div className="flex items-center justify-between mb-4">
            <div className="flex items-center gap-2 px-3 py-1.5 rounded-lg border bg-indigo-50 text-indigo-700 border-indigo-200 text-xs font-bold uppercase tracking-wider w-fit">
              <FaBed className="w-3.5 h-3.5" /> Gán loại phòng
            </div>
            <ProgressBadge assigned={assignedCount} total={generatedRooms.length} />
          </div>

          {customRoomTypes.length === 0 ? (
            <div className="text-center py-8 text-slate-400 text-sm">
              Chưa có loại phòng nào. Vui lòng tạo loại phòng ở bước trước.
            </div>
          ) : (
            <div className="space-y-4">
              {Object.entries(roomsByFloor).map(([floor, rooms]) => (
                <FloorBlock key={floor} floor={floor} rooms={rooms}
                  roomTypeOptions={roomTypeOptions} dispatch={dispatch}
                  assignKey="roomTypeTempId"
                  assignAction="ASSIGN_ROOM_TYPE"
                  assignAllAction="ASSIGN_ALL_FLOOR"
                  assignAllPayloadKey="roomTypeTempId"
                  floorPayloadKey="floorNumber"
                />
              ))}
            </div>
          )}
        </div>
      )}
    </div>
  )
}

// ─────────────────────────────────────────────
// EDIT
// ─────────────────────────────────────────────
function Step4Edit({ formOptions, errors }) {
  const { state, dispatch } = useEditHotel()
  const { existingRooms = [], newRooms = [] } = state
  const { roomTypes: allRoomTypes = [] } = formOptions ?? {}

  const roomTypeOptions = allRoomTypes.map(rt => ({
    value: String(rt.id ?? rt.roomTypeId),
    label: rt.name,
  }))

  const allRooms = [...existingRooms, ...newRooms]
  const assignedCount = allRooms.filter(r => r.roomTypeId).length

  const roomsByFloor = useMemo(() =>
    allRooms.reduce((acc, room) => {
      const f = room.floor ?? room.floorNumber
      acc[f] ??= []
      acc[f].push(room)
      return acc
    }, {}), [existingRooms, newRooms])

  return (
    <div className="space-y-5 pb-2">
      <StepErrorBanner errors={errors} />

      <div className="bg-white rounded-2xl border border-slate-200 p-5 shadow-sm">
        <div className="flex items-center justify-between mb-4">
          <div className="flex items-center gap-2 px-3 py-1.5 rounded-lg border bg-indigo-50 text-indigo-700 border-indigo-200 text-xs font-bold uppercase tracking-wider w-fit">
            <FaBed className="w-3.5 h-3.5" /> Gán loại phòng
          </div>
          <ProgressBadge assigned={assignedCount} total={allRooms.length} />
        </div>

        <div className="space-y-4">
          {Object.entries(roomsByFloor).map(([floor, rooms]) => (
            <FloorBlockEdit key={floor} floor={floor} rooms={rooms}
              roomTypeOptions={roomTypeOptions} dispatch={dispatch} />
          ))}
        </div>
      </div>
    </div>
  )
}

// ─────────────────────────────────────────────
// Shared sub-components
// ─────────────────────────────────────────────
function ProgressBadge({ assigned, total }) {
  const allDone = assigned === total && total > 0
  return (
    <div className={`flex items-center gap-1.5 px-3 py-1.5 rounded-full text-xs font-semibold
      ${allDone ? 'bg-green-100 text-green-700' : 'bg-amber-100 text-amber-700'}`}>
      {allDone
        ? <><FaCheckCircle className="w-3 h-3" /> Đã gán đủ {total} phòng</>
        : <><FaExclamationTriangle className="w-3 h-3" /> {assigned}/{total} phòng đã gán</>}
    </div>
  )
}

function FloorBlock({ floor, rooms, roomTypeOptions, dispatch,
  assignKey, assignAction, assignAllAction, assignAllPayloadKey, floorPayloadKey }) {
  const allAssigned = rooms.every(r => r[assignKey])

  return (
    <div className={`rounded-xl border p-4 transition-colors
      ${allAssigned ? 'border-green-200 bg-green-50/30' : 'border-slate-200 bg-slate-50/50'}`}>

      {/* Floor header */}
      <div className="flex flex-wrap items-center justify-between gap-3 mb-3">
        <div className="flex items-center gap-2">
          <span className={`w-6 h-6 rounded-lg flex items-center justify-center text-xs font-bold
            ${allAssigned ? 'bg-green-500 text-white' : 'bg-slate-300 text-slate-600'}`}>
            {floor}
          </span>
          <strong className="text-sm font-bold text-slate-700">Tầng {floor}</strong>
          <span className="text-xs text-slate-400">({rooms.length} phòng)</span>
        </div>

        {/* Gán nhanh cả tầng */}
        <div className="flex items-center gap-2">
          <span className="text-xs text-slate-500">Gán cả tầng:</span>
          <div className="w-40">
            <CustomSelect
              value=""
              onChange={val => val && dispatch({
                type: assignAllAction,
                payload: { [floorPayloadKey]: Number(floor), [assignAllPayloadKey]: val },
              })}
              options={roomTypeOptions}
              placeholder="-- Chọn --"
              icon={FaBed}
            />
          </div>
        </div>
      </div>

      {/* Room grid */}
      <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-2">
        {rooms.map(room => {
          const isAssigned = !!room[assignKey]
          return (
            <div key={room.roomNumber}
              className={`rounded-xl border-2 p-2.5 transition-all
                ${isAssigned ? 'border-green-300 bg-white' : 'border-slate-200 bg-white'}`}>
              <div className="flex items-center gap-1 mb-1.5">
                <div className={`w-2 h-2 rounded-full flex-shrink-0
                  ${isAssigned ? 'bg-green-400' : 'bg-slate-300'}`} />
                <span className="text-xs font-semibold text-slate-600">Phòng {room.roomNumber}</span>
              </div>
              <CustomSelect
                value={room[assignKey] || ''}
                onChange={val => dispatch({
                  type: assignAction,
                  payload: { roomNumber: room.roomNumber, [assignKey]: val },
                })}
                options={roomTypeOptions}
                placeholder="Loại phòng"
              />
            </div>
          )
        })}
      </div>
    </div>
  )
}

function FloorBlockEdit({ floor, rooms, roomTypeOptions, dispatch }) {
  const allAssigned = rooms.every(r => r.roomTypeId)

  return (
    <div className={`rounded-xl border p-4 transition-colors
      ${allAssigned ? 'border-green-200 bg-green-50/30' : 'border-slate-200 bg-slate-50/50'}`}>

      <div className="flex flex-wrap items-center justify-between gap-3 mb-3">
        <div className="flex items-center gap-2">
          <span className={`w-6 h-6 rounded-lg flex items-center justify-center text-xs font-bold
            ${allAssigned ? 'bg-green-500 text-white' : 'bg-slate-300 text-slate-600'}`}>
            {floor}
          </span>
          <strong className="text-sm font-bold text-slate-700">Tầng {floor}</strong>
          <span className="text-xs text-slate-400">({rooms.length} phòng)</span>
        </div>
        <div className="flex items-center gap-2">
          <span className="text-xs text-slate-500">Gán cả tầng:</span>
          <div className="w-40">
            <CustomSelect
              value=""
              onChange={val => val && dispatch({
                type: 'ASSIGN_ALL_FLOOR',
                payload: { floorNumber: Number(floor), roomTypeId: val },
              })}
              options={roomTypeOptions}
              placeholder="-- Chọn --"
              icon={FaBed}
            />
          </div>
        </div>
      </div>

      <div className="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 gap-2">
        {rooms.map(room => {
          const isAssigned = !!room.roomTypeId
          const roomNum = room.roomNumber ?? room.room_number
          return (
            <div key={roomNum}
              className={`rounded-xl border-2 p-2.5 transition-all
                ${isAssigned ? 'border-green-300 bg-white' : 'border-slate-200 bg-white'}`}>
              <div className="flex items-center gap-1 mb-1.5">
                <div className={`w-2 h-2 rounded-full flex-shrink-0 ${isAssigned ? 'bg-green-400' : 'bg-slate-300'}`} />
                <span className="text-xs font-semibold text-slate-600">Phòng {roomNum}</span>
                {room.isBooked && (
                  <span className="ml-auto text-[9px] px-1.5 py-0.5 bg-orange-100 text-orange-600 rounded font-semibold">Booked</span>
                )}
              </div>
              <CustomSelect
                value={room.roomTypeId ? String(room.roomTypeId) : ''}
                onChange={val => dispatch({
                  type: 'ASSIGN_ROOM_TYPE',
                  payload: { roomId: room.roomId, roomTypeId: Number(val) },
                })}
                options={roomTypeOptions}
                placeholder="Loại phòng"
              />
            </div>
          )
        })}
      </div>
    </div>
  )
}