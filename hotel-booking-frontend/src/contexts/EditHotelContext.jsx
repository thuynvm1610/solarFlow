// src/contexts/EditHotelContext.jsx

import { createContext, useContext, useReducer } from 'react'

// ─────────────────────────────────────────────
// Helpers
// ─────────────────────────────────────────────

// "101" → 1, "1201" → 12, "10501" → 105
function extractFloor(roomNumber) {
  return parseInt(String(roomNumber).slice(0, -2))
}

// Khởi tạo state từ data API trả về
function initStateFromHotel(hotel) {
  return {
    currentStep: 1,
    hotelId: hotel.id,

    basicInfo: {
      name:                hotel.name,
      description:         hotel.description,
      address:             hotel.address,
      city:                hotel.city,
      type:                hotel.type,
      starRating:          hotel.starRating,
      floor:               hotel.floor,
      checkInTime:         hotel.checkInTime,
      checkOutTime:        hotel.checkOutTime,
      checkInInstructions: hotel.checkInInstructions ?? '',
      policyText:          hotel.policyText ?? '',
      managerId:           hotel.manager?.id ?? null,
    },

    amenities: {
      freeAmenityIds: hotel.hotelAmenities?.map(a => a.amenityId) ?? [],
      paidAmenities:  hotel.extraServices?.map(s => ({
        amenityId: s.amenityId,
        basePrice: String(s.basePrice),
        unitId:    s.priceUnit?.id ?? null,
      })) ?? [],
    },

    selectedRoomTypes: hotel.roomTypes?.map(rt => ({
      roomTypeId:     rt.id,
      roomTypeName:   rt.name,
      existingImages: rt.images?.map(img => ({
        imageId:    img.id,
        path:       img.path,
        isPrimary:  img.isPrimary,
        isExisting: true,
      })) ?? [],
      newImages: [],
    })) ?? [],

    existingRooms: hotel.rooms?.map(r => ({
      roomId:      r.id,
      roomNumber:  r.roomNumber,
      floorNumber: extractFloor(r.roomNumber),
      roomTypeId:  r.roomType?.id ?? null,
      isBooked:    r.hasActiveBooking ?? false,
    })) ?? [],

    newRooms: [], // [{ roomNumber, floorNumber, roomTypeId }]

    existingHotelImages: hotel.images?.map(img => ({
      imageId:    img.id,
      path:       img.path,
      isPrimary:  img.isPrimary,
      isExisting: true,
    })) ?? [],
    newHotelImages: [],

    // Track xóa để gọi DELETE trên BE
    deletedImageIds: [],
    deletedRoomIds:  [],
  }
}

// ─────────────────────────────────────────────
// Reducer
// ─────────────────────────────────────────────
function reducer(state, action) {
  switch (action.type) {

    case 'SET_STEP':
      return { ...state, currentStep: action.payload }

    // ── Step 1 ──────────────────────────────────────────────
    // Edit KHÔNG reset rooms khi đổi floor (khác Create)
    case 'UPDATE_BASIC_INFO':
      return { ...state, basicInfo: { ...state.basicInfo, ...action.payload } }

    // ── Step 2 ──────────────────────────────────────────────
    case 'TOGGLE_FREE_AMENITY': {
      const id = action.payload
      if (state.amenities.paidAmenities.some(p => p.amenityId === id)) return state
      const freeIds = state.amenities.freeAmenityIds.includes(id)
        ? state.amenities.freeAmenityIds.filter(x => x !== id)
        : [...state.amenities.freeAmenityIds, id]
      return { ...state, amenities: { ...state.amenities, freeAmenityIds: freeIds } }
    }

    case 'TOGGLE_PAID_AMENITY': {
      const id = action.payload
      if (state.amenities.freeAmenityIds.includes(id)) return state
      const exists = state.amenities.paidAmenities.some(p => p.amenityId === id)
      const paidAmenities = exists
        ? state.amenities.paidAmenities.filter(p => p.amenityId !== id)
        : [...state.amenities.paidAmenities, { amenityId: id, basePrice: '', unitId: null }]
      return { ...state, amenities: { ...state.amenities, paidAmenities } }
    }

    case 'UPDATE_PAID_AMENITY': {
      const { amenityId, field, value } = action.payload
      const paidAmenities = state.amenities.paidAmenities.map(p =>
        p.amenityId === amenityId ? { ...p, [field]: value } : p
      )
      return { ...state, amenities: { ...state.amenities, paidAmenities } }
    }

    // ── Step 3 — Rooms ───────────────────────────────────────
    case 'ASSIGN_ROOM_TYPE': {
      const { roomNumber, roomTypeId } = action.payload
      // Không cho sửa phòng đang booked
      const target = state.existingRooms.find(r => r.roomNumber === roomNumber)
      if (target?.isBooked) return state
      const existingRooms = state.existingRooms.map(r =>
        r.roomNumber === roomNumber ? { ...r, roomTypeId } : r
      )
      return { ...state, existingRooms }
    }

    case 'ASSIGN_NEW_ROOM_TYPE': {
      const { roomNumber, roomTypeId } = action.payload
      const newRooms = state.newRooms.map(r =>
        r.roomNumber === roomNumber ? { ...r, roomTypeId } : r
      )
      return { ...state, newRooms }
    }

    case 'ASSIGN_ALL_FLOOR': {
      const { floorNumber, roomTypeId } = action.payload
      const existingRooms = state.existingRooms.map(r =>
        r.floorNumber === floorNumber && !r.isBooked ? { ...r, roomTypeId } : r
      )
      const newRooms = state.newRooms.map(r =>
        r.floorNumber === floorNumber ? { ...r, roomTypeId } : r
      )
      return { ...state, existingRooms, newRooms }
    }

    case 'DELETE_ROOM': {
      const roomId = action.payload
      const room = state.existingRooms.find(r => r.roomId === roomId)
      if (!room || room.isBooked) return state
      return {
        ...state,
        existingRooms:  state.existingRooms.filter(r => r.roomId !== roomId),
        deletedRoomIds: [...state.deletedRoomIds, roomId],
      }
    }

    case 'ADD_NEW_ROOM': {
      return { ...state, newRooms: [...state.newRooms, action.payload] }
    }

    case 'DELETE_NEW_ROOM': {
      const roomNumber = action.payload
      return { ...state, newRooms: state.newRooms.filter(r => r.roomNumber !== roomNumber) }
    }

    // ── Step 4 — Hotel images ────────────────────────────────
    case 'ADD_NEW_HOTEL_IMAGE': {
      const image = action.payload
      const allCount = state.existingHotelImages.length + state.newHotelImages.length
      const newImage = allCount === 0 ? { ...image, isPrimary: true } : image
      return { ...state, newHotelImages: [...state.newHotelImages, newImage] }
    }

    case 'DELETE_EXISTING_HOTEL_IMAGE': {
      const imageId = action.payload
      const wasPrimary = state.existingHotelImages.find(i => i.imageId === imageId)?.isPrimary
      let existingHotelImages = state.existingHotelImages.filter(i => i.imageId !== imageId)
      let newHotelImages = state.newHotelImages

      if (wasPrimary) {
        if (existingHotelImages.length > 0)
          existingHotelImages = existingHotelImages.map((img, idx) =>
            ({ ...img, isPrimary: idx === 0 })
          )
        else if (newHotelImages.length > 0)
          newHotelImages = newHotelImages.map((img, idx) =>
            ({ ...img, isPrimary: idx === 0 })
          )
      }

      return {
        ...state,
        existingHotelImages,
        newHotelImages,
        deletedImageIds: [...state.deletedImageIds, imageId],
      }
    }

    case 'DELETE_NEW_HOTEL_IMAGE': {
      const tempPath = action.payload
      const wasPrimary = state.newHotelImages.find(i => i.tempPath === tempPath)?.isPrimary
      let newHotelImages = state.newHotelImages.filter(i => i.tempPath !== tempPath)
      let existingHotelImages = state.existingHotelImages

      if (wasPrimary) {
        if (newHotelImages.length > 0)
          newHotelImages = newHotelImages.map((img, idx) => ({ ...img, isPrimary: idx === 0 }))
        else if (existingHotelImages.length > 0)
          existingHotelImages = existingHotelImages.map((img, idx) =>
            ({ ...img, isPrimary: idx === 0 })
          )
      }

      return { ...state, newHotelImages, existingHotelImages }
    }

    case 'SET_HOTEL_PRIMARY': {
      // payload: { imageId? } cho ảnh cũ, { tempPath? } cho ảnh mới
      const { imageId, tempPath } = action.payload
      return {
        ...state,
        existingHotelImages: state.existingHotelImages.map(i =>
          ({ ...i, isPrimary: imageId ? i.imageId === imageId : false })
        ),
        newHotelImages: state.newHotelImages.map(i =>
          ({ ...i, isPrimary: tempPath ? i.tempPath === tempPath : false })
        ),
      }
    }

    // ── Step 4 — Room type images ────────────────────────────
    case 'ADD_NEW_ROOM_TYPE_IMAGE': {
      const { roomTypeId, image } = action.payload
      const selectedRoomTypes = state.selectedRoomTypes.map(rt => {
        if (rt.roomTypeId !== roomTypeId) return rt
        const allCount = rt.existingImages.length + rt.newImages.length
        const newImage = allCount === 0 ? { ...image, isPrimary: true } : image
        return { ...rt, newImages: [...rt.newImages, newImage] }
      })
      return { ...state, selectedRoomTypes }
    }

    case 'DELETE_EXISTING_ROOM_TYPE_IMAGE': {
      const { roomTypeId, imageId } = action.payload
      const selectedRoomTypes = state.selectedRoomTypes.map(rt => {
        if (rt.roomTypeId !== roomTypeId) return rt
        const wasPrimary = rt.existingImages.find(i => i.imageId === imageId)?.isPrimary
        let existingImages = rt.existingImages.filter(i => i.imageId !== imageId)
        let newImages = rt.newImages
        if (wasPrimary) {
          if (existingImages.length > 0)
            existingImages = existingImages.map((img, idx) => ({ ...img, isPrimary: idx === 0 }))
          else if (newImages.length > 0)
            newImages = newImages.map((img, idx) => ({ ...img, isPrimary: idx === 0 }))
        }
        return { ...rt, existingImages, newImages }
      })
      return {
        ...state,
        selectedRoomTypes,
        deletedImageIds: [...state.deletedImageIds, imageId],
      }
    }

    case 'DELETE_NEW_ROOM_TYPE_IMAGE': {
      const { roomTypeId, tempPath } = action.payload
      const selectedRoomTypes = state.selectedRoomTypes.map(rt => {
        if (rt.roomTypeId !== roomTypeId) return rt
        const wasPrimary = rt.newImages.find(i => i.tempPath === tempPath)?.isPrimary
        let newImages = rt.newImages.filter(i => i.tempPath !== tempPath)
        let existingImages = rt.existingImages
        if (wasPrimary) {
          if (newImages.length > 0)
            newImages = newImages.map((img, idx) => ({ ...img, isPrimary: idx === 0 }))
          else if (existingImages.length > 0)
            existingImages = existingImages.map((img, idx) => ({ ...img, isPrimary: idx === 0 }))
        }
        return { ...rt, newImages, existingImages }
      })
      return { ...state, selectedRoomTypes }
    }

    case 'SET_ROOM_TYPE_PRIMARY': {
      const { roomTypeId, imageId, tempPath } = action.payload
      const selectedRoomTypes = state.selectedRoomTypes.map(rt => {
        if (rt.roomTypeId !== roomTypeId) return rt
        return {
          ...rt,
          existingImages: rt.existingImages.map(i =>
            ({ ...i, isPrimary: imageId ? i.imageId === imageId : false })
          ),
          newImages: rt.newImages.map(i =>
            ({ ...i, isPrimary: tempPath ? i.tempPath === tempPath : false })
          ),
        }
      })
      return { ...state, selectedRoomTypes }
    }

    default:
      return state
  }
}

// ─────────────────────────────────────────────
// Context & Provider
// ─────────────────────────────────────────────
const EditHotelContext = createContext(null)

export function EditHotelProvider({ hotel, children }) {
  const [state, dispatch] = useReducer(reducer, hotel, initStateFromHotel)

  const buildUpdatePayload = () => ({
    basicInfo: state.basicInfo,
    amenities: state.amenities,
    roomTypes: state.selectedRoomTypes.map(rt => ({
      roomTypeId: rt.roomTypeId,
      existingImages: rt.existingImages.map(({ imageId, isPrimary }) => ({ imageId, isPrimary })),
      newImages:      rt.newImages.map(({ tempPath, isPrimary }) => ({ tempPath, isPrimary })),
    })),
    existingRooms: state.existingRooms.map(({ roomId, roomNumber, roomTypeId }) =>
      ({ roomId, roomNumber, roomTypeId })
    ),
    newRooms: state.newRooms.map(({ roomNumber, roomTypeId }) => ({ roomNumber, roomTypeId })),
    existingHotelImages: state.existingHotelImages.map(({ imageId, isPrimary }) =>
      ({ imageId, isPrimary })
    ),
    newHotelImages: state.newHotelImages.map(({ tempPath, isPrimary }) =>
      ({ tempPath, isPrimary })
    ),
    deletedImageIds: state.deletedImageIds,
    deletedRoomIds:  state.deletedRoomIds,
  })

  const validatePayload = () => {
    const errors = []
    if (!state.basicInfo.name?.trim())
      errors.push('Tên khách sạn không được để trống')
    if (!state.basicInfo.managerId)
      errors.push('Chưa chọn manager')

    const allHotelImages = [...state.existingHotelImages, ...state.newHotelImages]
    if (!allHotelImages.some(i => i.isPrimary))
      errors.push('Khách sạn phải có ảnh đại diện')
    if (allHotelImages.length === 0)
      errors.push('Khách sạn phải có ít nhất 1 ảnh')

    const allRooms = [...state.existingRooms, ...state.newRooms]
    if (allRooms.some(r => !r.roomTypeId))
      errors.push('Còn phòng chưa được gán loại phòng')

    state.selectedRoomTypes.forEach(rt => {
      const allImages = [...rt.existingImages, ...rt.newImages]
      if (!allImages.some(i => i.isPrimary))
        errors.push(`Room type "${rt.roomTypeName}" chưa có ảnh đại diện`)
    })

    state.amenities.paidAmenities.forEach(p => {
      if (!p.basePrice || Number(p.basePrice) <= 0)
        errors.push(`Paid amenity id=${p.amenityId} chưa nhập giá hợp lệ`)
      if (!p.unitId)
        errors.push(`Paid amenity id=${p.amenityId} chưa chọn đơn vị`)
    })

    return errors
  }

  return (
    <EditHotelContext.Provider value={{ state, dispatch, buildUpdatePayload, validatePayload }}>
      {children}
    </EditHotelContext.Provider>
  )
}

export const useEditHotel = () => useContext(EditHotelContext)