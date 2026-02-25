// src/contexts/CreateHotelContext.jsx

import { createContext, useContext, useReducer } from 'react'

const defaultState = {
  currentStep: 1,
  basicInfo: {
    name: '',
    description: '',
    address: '',
    city: '',
    type: '',
    starRating: 1,
    floor: 0,
    checkInTime: '',
    checkOutTime: '',
    checkInInstructions: '',
    policyText: '',
    managerId: null,
  },
  amenities: {
    freeAmenityIds: [],
    paidAmenities: [],
  },
  // ✅ THÊM: Custom room types
  customRoomTypes: [],  // [{ tempId, name, description, maxAdults, maxChildren, basePrice, areaM2, featureIds: [], images: [] }]

  floorConfigs: [],
  generatedRooms: [],    // Thêm field roomTypeTempId thay vì roomTypeId
  hotelImages: [],
}

function reducer(state, action) {
  switch (action.type) {

    case 'SET_STEP':
      return { ...state, currentStep: action.payload }

    // ── Step 1 ──────────────────────────────────────────────
    case 'UPDATE_BASIC_INFO': {
      const newBasicInfo = { ...state.basicInfo, ...action.payload }
      if ('floor' in action.payload) {
        const floor = Number(action.payload.floor) || 0
        return {
          ...state,
          basicInfo: newBasicInfo,
          floorConfigs: Array.from({ length: floor }, (_, i) => ({
            floorNumber: i + 1,
            roomCount: 0,
          })),
          generatedRooms: [],
        }
      }
      return { ...state, basicInfo: newBasicInfo }
    }

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

    // ── Step 3 - NEW: Custom Room Types ─────────────────────
    case 'ADD_CUSTOM_ROOM_TYPE': {
      const newRoomType = {
        tempId: `rt_${Date.now()}`,
        name: '',
        description: '',
        maxAdults: 2,
        maxChildren: 0,
        basePrice: '',
        areaM2: 20,
        featureIds: [],
        images: [],
      }
      return { ...state, customRoomTypes: [...state.customRoomTypes, newRoomType] }
    }

    case 'UPDATE_CUSTOM_ROOM_TYPE': {
      const { tempId, field, value } = action.payload
      const customRoomTypes = state.customRoomTypes.map(rt =>
        rt.tempId === tempId ? { ...rt, [field]: value } : rt
      )
      return { ...state, customRoomTypes }
    }

    case 'REMOVE_CUSTOM_ROOM_TYPE': {
      const tempId = action.payload
      return {
        ...state,
        customRoomTypes: state.customRoomTypes.filter(rt => rt.tempId !== tempId)
      }
    }

    case 'TOGGLE_ROOM_FEATURE': {
      const { tempId, featureId } = action.payload
      const customRoomTypes = state.customRoomTypes.map(rt => {
        if (rt.tempId !== tempId) return rt
        const featureIds = rt.featureIds.includes(featureId)
          ? rt.featureIds.filter(id => id !== featureId)
          : [...rt.featureIds, featureId]
        return { ...rt, featureIds }
      })
      return { ...state, customRoomTypes }
    }

    // ── Step 4 ──────────────────────────────────────────────
    case 'UPDATE_FLOOR_CONFIG': {
      const { floorNumber, roomCount } = action.payload
      const floorConfigs = state.floorConfigs.map(f =>
        f.floorNumber === floorNumber
          ? { ...f, roomCount: Math.min(99, Math.max(0, roomCount)) }
          : f
      )
      return { ...state, floorConfigs }
    }

    case 'GENERATE_ROOMS': {
      const rooms = []
      state.floorConfigs.forEach(({ floorNumber, roomCount }) => {
        for (let i = 1; i <= roomCount; i++) {
          rooms.push({
            roomNumber: `${floorNumber}${String(i).padStart(2, '0')}`,
            floorNumber,
            roomTypeTempId: null,  // ✅ Đổi từ roomTypeId
          })
        }
      })
      return { ...state, generatedRooms: rooms }
    }

    case 'ASSIGN_ROOM_TYPE': {
      const { roomNumber, roomTypeTempId } = action.payload
      const generatedRooms = state.generatedRooms.map(r =>
        r.roomNumber === roomNumber ? { ...r, roomTypeTempId } : r
      )
      return { ...state, generatedRooms }
    }

    case 'ASSIGN_ALL_FLOOR': {
      const { floorNumber, roomTypeTempId } = action.payload
      const generatedRooms = state.generatedRooms.map(r =>
        r.floorNumber === floorNumber ? { ...r, roomTypeTempId } : r
      )
      return { ...state, generatedRooms }
    }

    // ── Step 5 — Hotel images ────────────────────────────────
    case 'ADD_HOTEL_IMAGE': {
      const image = action.payload
      const images = state.hotelImages.length === 0
        ? [{ ...image, isPrimary: true }]
        : [...state.hotelImages, image]
      return { ...state, hotelImages: images }
    }

    case 'REMOVE_HOTEL_IMAGE': {
      const tempPath = action.payload
      let images = state.hotelImages.filter(i => i.tempPath !== tempPath)
      const wasPrimary = state.hotelImages.find(i => i.tempPath === tempPath)?.isPrimary
      if (wasPrimary && images.length > 0)
        images = images.map((img, idx) => ({ ...img, isPrimary: idx === 0 }))
      return { ...state, hotelImages: images }
    }

    case 'SET_HOTEL_PRIMARY': {
      const images = state.hotelImages.map(i =>
        ({ ...i, isPrimary: i.tempPath === action.payload })
      )
      return { ...state, hotelImages: images }
    }

    // ── Step 5 — Room type images (for custom room types) ───
    case 'ADD_ROOM_TYPE_IMAGE': {
      const { tempId, image } = action.payload
      const customRoomTypes = state.customRoomTypes.map(rt => {
        if (rt.tempId !== tempId) return rt
        const newImage = rt.images.length === 0 ? { ...image, isPrimary: true } : image
        return { ...rt, images: [...rt.images, newImage] }
      })
      return { ...state, customRoomTypes }
    }

    case 'REMOVE_ROOM_TYPE_IMAGE': {
      const { tempId, tempPath } = action.payload
      const customRoomTypes = state.customRoomTypes.map(rt => {
        if (rt.tempId !== tempId) return rt
        let images = rt.images.filter(i => i.tempPath !== tempPath)
        const wasPrimary = rt.images.find(i => i.tempPath === tempPath)?.isPrimary
        if (wasPrimary && images.length > 0)
          images = images.map((img, idx) => ({ ...img, isPrimary: idx === 0 }))
        return { ...rt, images }
      })
      return { ...state, customRoomTypes }
    }

    case 'SET_ROOM_TYPE_PRIMARY': {
      const { tempId, tempPath } = action.payload
      const customRoomTypes = state.customRoomTypes.map(rt => {
        if (rt.tempId !== tempId) return rt
        return {
          ...rt,
          images: rt.images.map(i => ({ ...i, isPrimary: i.tempPath === tempPath })),
        }
      })
      return { ...state, customRoomTypes }
    }

    case 'RESET':
      return defaultState

    default:
      return state
  }
}

const CreateHotelContext = createContext(null)

export function CreateHotelProvider({ children }) {
  const [state, dispatch] = useReducer(reducer, defaultState)

  const buildSubmitPayload = () => ({
    basicInfo: state.basicInfo,
    amenities: state.amenities,
    customRoomTypes: state.customRoomTypes.map(rt => ({
      tempId: rt.tempId,
      name: rt.name,
      description: rt.description,
      maxAdults: rt.maxAdults,
      maxChildren: rt.maxChildren,
      basePrice: rt.basePrice,
      areaM2: rt.areaM2,
      featureIds: rt.featureIds,
    })),
    rooms: state.generatedRooms.map(r => ({
      roomNumber: r.roomNumber,
      roomTypeTempId: r.roomTypeTempId,
    })),
    roomTypeImages: state.customRoomTypes.map(rt => ({
      roomTypeTempId: rt.tempId,
      images: rt.images.map(({ tempPath, isPrimary }) => ({ tempPath, isPrimary })),
    })),
    hotelImages: state.hotelImages.map(({ tempPath, isPrimary }) => ({ tempPath, isPrimary })),
  })

  const validatePayload = () => {
    const errors = []
    if (!state.basicInfo.name?.trim())
      errors.push('Tên khách sạn không được để trống')
    if (!state.basicInfo.managerId)
      errors.push('Chưa chọn manager')
    if (state.customRoomTypes.length === 0)
      errors.push('Phải tạo ít nhất 1 loại phòng')
    if (!state.hotelImages.some(i => i.isPrimary))
      errors.push('Chưa chọn ảnh đại diện cho khách sạn')
    if (state.generatedRooms.some(r => !r.roomTypeTempId))
      errors.push('Còn phòng chưa được gán loại phòng')
    state.customRoomTypes.forEach(rt => {
      if (!rt.name?.trim())
        errors.push(`Loại phòng "${rt.tempId}" chưa có tên`)
      if (!rt.basePrice || Number(rt.basePrice) <= 0)
        errors.push(`Loại phòng "${rt.name}" chưa có giá`)
      if (!rt.images.some(i => i.isPrimary))
        errors.push(`Loại phòng "${rt.name}" chưa có ảnh đại diện`)
    })
    return errors
  }

  return (
    <CreateHotelContext.Provider value={{ state, dispatch, buildSubmitPayload, validatePayload }}>
      {children}
    </CreateHotelContext.Provider>
  )
}

export const useCreateHotel = () => useContext(CreateHotelContext)