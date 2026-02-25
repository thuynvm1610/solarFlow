import { useCreateHotel } from '../../../../contexts/CreateHotelContext'
import { useEditHotel } from '../../../../contexts/EditHotelContext'
import FloorRoomBuilder from '../components/FloorRoomBuilder'
import FloorRoomEditor from '../components/FloorRoomEditor'

export default function Step4Rooms({ formOptions, isEdit }) {
  if (isEdit) return <Step4Edit formOptions={formOptions} />
  return <Step4Create formOptions={formOptions} />
}

function Step4Create() {
  const { state } = useCreateHotel()
  
  const allRoomTypes = state.customRoomTypes || []

  console.log('Custom Room Types in Step 4:', allRoomTypes)

  return (
    <div className="step-content">
      <FloorRoomBuilder allRoomTypes={allRoomTypes} />
      {state.generatedRooms.length > 0 && (
        <RoomSummary rooms={state.generatedRooms} showBooked={false} />
      )}
    </div>
  )
}

function Step4Edit({ formOptions }) {
  const { state } = useEditHotel()
  const { roomTypes: allRoomTypes = [] } = formOptions ?? {}
  const allRooms = [...state.existingRooms, ...state.newRooms]

  return (
    <div className="step-content">
      <FloorRoomEditor allRoomTypes={allRoomTypes} />
      <RoomSummary rooms={allRooms} showBooked={true} />
    </div>
  )
}

function RoomSummary({ rooms, showBooked }) {
  const assigned = rooms.filter(r => r.roomTypeTempId).length
  const booked = showBooked ? rooms.filter(r => r.isBooked).length : 0
  return (
    <div className="room-summary">
      <span>Tổng phòng: <strong>{rooms.length}</strong></span>
      <span>Đã gán loại: <strong>{assigned}</strong></span>
      {showBooked && <span>Đang có booking: <strong>{booked}</strong></span>}
      {assigned < rooms.length && (
        <span className="warning">⚠ Còn {rooms.length - assigned} phòng chưa gán loại</span>
      )}
    </div>
  )
}