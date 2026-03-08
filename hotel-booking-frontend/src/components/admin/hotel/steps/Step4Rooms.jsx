// src/components/admin/hotel/steps/Step4Rooms.jsx

import { useCreateHotel } from '../../../../contexts/CreateHotelContext'
import { useEditHotel }   from '../../../../contexts/EditHotelContext'
import FloorRoomBuilder   from '../components/FloorRoomBuilder'
import FloorRoomEditor    from '../components/FloorRoomEditor'
import { StepErrorBanner } from '../../../common/FieldError'

export default function Step4Rooms({ formOptions, isEdit, errors = {} }) {
  if (isEdit) return <Step4Edit formOptions={formOptions} errors={errors} />
  return           <Step4Create errors={errors} />
}

function Step4Create({ errors }) {
  const { state } = useCreateHotel()
  const allRoomTypes = state.customRoomTypes || []

  return (
    <div className="step-content">
      <StepErrorBanner errors={errors} />
      <FloorRoomBuilder allRoomTypes={allRoomTypes} />
      {state.generatedRooms.length > 0 && (
        <RoomSummary rooms={state.generatedRooms} showBooked={false} />
      )}
    </div>
  )
}

function Step4Edit({ formOptions, errors }) {
  const { state } = useEditHotel()
  const { roomTypes: allRoomTypes = [] } = formOptions ?? {}
  const normalizedRoomTypes = allRoomTypes.map(rt => ({ ...rt, id: rt.id ?? rt.roomTypeId }))
  const allRooms = [...state.existingRooms, ...state.newRooms]

  return (
    <div className="step-content">
      <StepErrorBanner errors={errors} />
      <FloorRoomEditor allRoomTypes={normalizedRoomTypes} />
      <RoomSummary rooms={allRooms} showBooked />
    </div>
  )
}

function RoomSummary({ rooms, showBooked }) {
  const assigned = rooms.filter(r => r.roomTypeId || r.roomTypeTempId).length
  const booked   = showBooked ? rooms.filter(r => r.isBooked).length : 0
  const unassigned = rooms.length - assigned

  return (
    <div className="flex flex-wrap gap-4 px-4 py-3 bg-slate-50 rounded-lg border border-slate-200 text-sm text-slate-600 mt-4">
      <span>Tổng phòng: <strong>{rooms.length}</strong></span>
      <span>Đã gán loại: <strong>{assigned}</strong></span>
      {showBooked && <span>Đang có booking: <strong>{booked}</strong></span>}
      {unassigned > 0 && (
        <span className="text-amber-600 font-medium">⚠ Còn {unassigned} phòng chưa gán loại</span>
      )}
    </div>
  )
}