// src/contexts/EditHotelContext.jsx
import { createContext, useContext, useReducer } from 'react'

// ─────────────────────────────────────────────────────────────────
// Initial state factory — built from hotel detail API response
// ─────────────────────────────────────────────────────────────────
function buildInitialState(hotel) {
  return {
    hotelId: hotel.id,
    currentStep: 1,

    // ── Step 1: Basic Info ──────────────────────────────────────
    basicInfo: {
      name:                hotel.name                ?? '',
      description:         hotel.description         ?? '',
      address:             hotel.address             ?? '',
      city:                hotel.city                ?? '',
      type:                hotel.type                ?? '',
      starRating:          hotel.starRating          ?? 3,
      floor:               hotel.floorNumber         ?? 1,
      checkInTime:         hotel.checkInTime         ? hotel.checkInTime.substring(0,5) : '14:00',
      checkOutTime:        hotel.checkOutTime        ? hotel.checkOutTime.substring(0,5) : '12:00',
      checkInInstructions: hotel.checkInInstructions ?? '',
      policyText:          hotel.policyText          ?? '',
      status:              hotel.status              ?? 'ACTIVE',
      managerId:           hotel.managerId           ?? null,
    },

    // ── Step 2: Amenities ───────────────────────────────────────
    amenities: {
      freeAmenityIds: hotel.freeAmenityIds ?? [],
      paidAmenities:  (hotel.extraServices ?? []).map(es => ({
        amenityId: es.amenityId,
        name:      es.amenityName,
        basePrice: es.basePrice?.toString() ?? '',
        unitId:    es.unitId ?? null,
      })),
    },

    // ── Step 3: Room Types (edit safe fields) ───────────────────
    // selectedRoomTypes = room types belonging to this hotel
    selectedRoomTypes: (hotel.roomTypes ?? []).map(rt => ({
      roomTypeId:   rt.roomTypeId,
      name:         rt.name,
      description:  rt.description   ?? '',
      maxAdults:    rt.maxAdults      ?? 2,
      maxChildren:  rt.maxChildren    ?? 0,
      areaM2:       rt.areaM2         ?? 25,
      basePrice:    rt.basePrice,               // read-only display only
      featureIds:   rt.featureIds     ?? [],
      existingImages: [],   // populated from hotel.roomTypeImages
      newImages:    [],
    })),

    // ── Step 4: Rooms ────────────────────────────────────────────
    existingRooms: (hotel.rooms ?? []).map(r => ({
      roomId:      r.roomId,
      roomNumber:  r.roomNumber,
      floorNumber: r.floorNumber,
      roomTypeId:  r.roomTypeId,
      status:      r.status,
      isBooked:    r.isBooked,
      _dirty:      false,   // track if changed
    })),
    newRooms:      [],
    deletedRoomIds:[],

    // ── Step 5: Images ────────────────────────────────────────────
    existingHotelImages: (hotel.hotelImages ?? []).map(img => ({
      imageId:   img.imageId,
      path:      img.fullUrl ?? img.imageUrl,
      isPrimary: img.isPrimary,
    })),
    newHotelImages:   [],
    deletedImageIds:  [],
  }
}

// Merge room type images into selectedRoomTypes
function mergeRoomTypeImages(selectedRoomTypes, roomTypeImages = []) {
  return selectedRoomTypes.map(rt => {
    const match = roomTypeImages.find(rti => rti.roomTypeId === rt.roomTypeId)
    return {
      ...rt,
      existingImages: (match?.images ?? []).map(img => ({
        imageId:   img.imageId,
        path:      img.fullUrl ?? img.imageUrl,
        isPrimary: img.isPrimary,
      })),
    }
  })
}

// ─────────────────────────────────────────────────────────────────
// Reducer
// ─────────────────────────────────────────────────────────────────
function reducer(state, action) {
  switch (action.type) {

    case 'SET_STEP':
      return { ...state, currentStep: action.payload }

    // ── Basic Info ────────────────────────────────────────────────
    case 'UPDATE_BASIC_INFO':
      return { ...state, basicInfo: { ...state.basicInfo, ...action.payload } }

    // ── Amenities ─────────────────────────────────────────────────
    case 'TOGGLE_FREE_AMENITY': {
      const id = action.payload
      const ids = state.amenities.freeAmenityIds
      const next = ids.includes(id) ? ids.filter(x => x !== id) : [...ids, id]
      return { ...state, amenities: { ...state.amenities, freeAmenityIds: next } }
    }

    case 'TOGGLE_PAID_AMENITY': {
      const { id, name } = action.payload
      const paid = state.amenities.paidAmenities
      if (paid.some(p => p.amenityId === id)) {
        return { ...state, amenities: { ...state.amenities, paidAmenities: paid.filter(p => p.amenityId !== id) } }
      }
      return {
        ...state,
        amenities: {
          ...state.amenities,
          paidAmenities: [...paid, { amenityId: id, name, basePrice: '', unitId: null }],
        },
      }
    }

    case 'UPDATE_PAID_AMENITY': {
      const { amenityId, field, value } = action.payload
      return {
        ...state,
        amenities: {
          ...state.amenities,
          paidAmenities: state.amenities.paidAmenities.map(p =>
            p.amenityId === amenityId ? { ...p, [field]: value } : p
          ),
        },
      }
    }

    // ── Room Types ────────────────────────────────────────────────
    case 'UPDATE_ROOM_TYPE': {
      const { roomTypeId, field, value } = action.payload
      return {
        ...state,
        selectedRoomTypes: state.selectedRoomTypes.map(rt =>
          rt.roomTypeId === roomTypeId ? { ...rt, [field]: value } : rt
        ),
      }
    }

    case 'TOGGLE_ROOM_TYPE_FEATURE': {
      const { roomTypeId, featureId } = action.payload
      return {
        ...state,
        selectedRoomTypes: state.selectedRoomTypes.map(rt => {
          if (rt.roomTypeId !== roomTypeId) return rt
          const fids = rt.featureIds.includes(featureId)
            ? rt.featureIds.filter(f => f !== featureId)
            : [...rt.featureIds, featureId]
          return { ...rt, featureIds: fids }
        }),
      }
    }

    // ── Rooms ─────────────────────────────────────────────────────
    case 'ASSIGN_ROOM_TYPE': {
      const { roomNumber, roomTypeId } = action.payload
      return {
        ...state,
        existingRooms: state.existingRooms.map(r =>
          r.roomNumber === roomNumber ? { ...r, roomTypeId, _dirty: true } : r
        ),
      }
    }

    case 'ASSIGN_ALL_FLOOR': {
      const { floorNumber, roomTypeId } = action.payload
      return {
        ...state,
        existingRooms: state.existingRooms.map(r =>
          r.floorNumber === floorNumber && !r.isBooked
            ? { ...r, roomTypeId, _dirty: true }
            : r
        ),
      }
    }

    case 'UPDATE_ROOM': {
      const { roomId, field, value } = action.payload
      return {
        ...state,
        existingRooms: state.existingRooms.map(r =>
          r.roomId === roomId ? { ...r, [field]: value, _dirty: true } : r
        ),
      }
    }

    case 'DELETE_ROOM': {
      const roomId = action.payload
      return {
        ...state,
        existingRooms: state.existingRooms.filter(r => r.roomId !== roomId),
        deletedRoomIds: [...state.deletedRoomIds, roomId],
      }
    }

    case 'ADD_NEW_ROOM':
      return { ...state, newRooms: [...state.newRooms, action.payload] }

    case 'ASSIGN_NEW_ROOM_TYPE': {
      const { roomNumber, roomTypeId } = action.payload
      return {
        ...state,
        newRooms: state.newRooms.map(r =>
          r.roomNumber === roomNumber ? { ...r, roomTypeId } : r
        ),
      }
    }

    case 'DELETE_NEW_ROOM':
      return { ...state, newRooms: state.newRooms.filter(r => r.roomNumber !== action.payload) }

    // ── Hotel Images ──────────────────────────────────────────────
    case 'ADD_NEW_HOTEL_IMAGE':
      return { ...state, newHotelImages: [...state.newHotelImages, action.payload] }

    case 'DELETE_NEW_HOTEL_IMAGE':
      return { ...state, newHotelImages: state.newHotelImages.filter(i => i.tempPath !== action.payload) }

    case 'DELETE_EXISTING_HOTEL_IMAGE':
      return {
        ...state,
        existingHotelImages: state.existingHotelImages.filter(i => i.imageId !== action.payload),
        deletedImageIds: [...state.deletedImageIds, action.payload],
      }

    case 'SET_HOTEL_PRIMARY': {
      const { imageId, tempPath } = action.payload
      return {
        ...state,
        existingHotelImages: state.existingHotelImages.map(i => ({
          ...i,
          isPrimary: imageId ? i.imageId === imageId : false,
        })),
        newHotelImages: state.newHotelImages.map(i => ({
          ...i,
          isPrimary: tempPath ? i.tempPath === tempPath : false,
        })),
      }
    }

    // ── Room Type Images ──────────────────────────────────────────
    case 'ADD_NEW_ROOM_TYPE_IMAGE': {
      const { roomTypeId, image } = action.payload
      return {
        ...state,
        selectedRoomTypes: state.selectedRoomTypes.map(rt =>
          rt.roomTypeId === roomTypeId
            ? { ...rt, newImages: [...rt.newImages, image] }
            : rt
        ),
      }
    }

    case 'DELETE_EXISTING_ROOM_TYPE_IMAGE': {
      const { roomTypeId, imageId } = action.payload
      return {
        ...state,
        deletedImageIds: [...state.deletedImageIds, imageId],
        selectedRoomTypes: state.selectedRoomTypes.map(rt =>
          rt.roomTypeId === roomTypeId
            ? { ...rt, existingImages: rt.existingImages.filter(i => i.imageId !== imageId) }
            : rt
        ),
      }
    }

    case 'DELETE_NEW_ROOM_TYPE_IMAGE': {
      const { roomTypeId, tempPath } = action.payload
      return {
        ...state,
        selectedRoomTypes: state.selectedRoomTypes.map(rt =>
          rt.roomTypeId === roomTypeId
            ? { ...rt, newImages: rt.newImages.filter(i => i.tempPath !== tempPath) }
            : rt
        ),
      }
    }

    case 'SET_ROOM_TYPE_PRIMARY': {
      const { roomTypeId, imageId, tempPath } = action.payload
      return {
        ...state,
        selectedRoomTypes: state.selectedRoomTypes.map(rt => {
          if (rt.roomTypeId !== roomTypeId) return rt
          return {
            ...rt,
            existingImages: rt.existingImages.map(i => ({ ...i, isPrimary: imageId ? i.imageId === imageId : false })),
            newImages:      rt.newImages.map(i =>      ({ ...i, isPrimary: tempPath ? i.tempPath === tempPath : false })),
          }
        }),
      }
    }

    default:
      return state
  }
}

// ─────────────────────────────────────────────────────────────────
// Context & Provider
// ─────────────────────────────────────────────────────────────────
const EditHotelContext = createContext(null)

export function EditHotelProvider({ hotel, children }) {
  const initial = (() => {
    const s = buildInitialState(hotel)
    s.selectedRoomTypes = mergeRoomTypeImages(s.selectedRoomTypes, hotel.roomTypeImages)
    return s
  })()

  const [state, dispatch] = useReducer(reducer, initial)

  // ── Build payload for PUT /hotels/{id} ────────────────────────
  const buildUpdatePayload = () => {
    const { basicInfo, amenities, existingRooms, newRooms, deletedRoomIds,
            selectedRoomTypes, existingHotelImages, newHotelImages, deletedImageIds } = state

    return {
      basicInfo: {
        name:                basicInfo.name,
        description:         basicInfo.description,
        address:             basicInfo.address,
        city:                basicInfo.city,
        starRating:          basicInfo.starRating,
        checkInTime:         basicInfo.checkInTime,
        checkOutTime:        basicInfo.checkOutTime,
        checkInInstructions: basicInfo.checkInInstructions,
        policyText:          basicInfo.policyText,
        status:              basicInfo.status,
        managerId:           basicInfo.managerId,
        // type & floor intentionally omitted
      },

      amenities: {
        freeAmenityIds: amenities.freeAmenityIds,
        paidAmenities: amenities.paidAmenities.map(p => ({
          amenityId: p.amenityId,
          basePrice: String(p.basePrice),
          unitId:    p.unitId,
        })),
      },

      // Room types — safe fields only
      roomTypes: selectedRoomTypes.map(rt => ({
        roomTypeId:  rt.roomTypeId,
        name:        rt.name,
        description: rt.description,
        areaM2:      rt.areaM2,
        maxAdults:   rt.maxAdults,
        maxChildren: rt.maxChildren,
        featureIds:  rt.featureIds,
      })),

      // Rooms
      existingRooms: existingRooms
        .filter(r => r._dirty)
        .map(r => ({
          roomId:      r.roomId,
          roomTypeId:  r.roomTypeId,
          roomNumber:  r.roomNumber,
          floor:       r.floorNumber,
          status:      r.status,
        })),
      newRooms: newRooms.map(r => ({
        roomNumber:  r.roomNumber,
        floorNumber: r.floorNumber,
        roomTypeId:  r.roomTypeId,
      })),
      deletedRoomIds,

      // Hotel images
      newHotelImages: newHotelImages.map(i => ({ tempPath: i.tempPath, isPrimary: i.isPrimary })),
      existingHotelImages: existingHotelImages.map(i => ({ imageId: i.imageId, isPrimary: i.isPrimary })),
      deletedImageIds,

      // Room type images
      roomTypeImages: selectedRoomTypes.map(rt => ({
        roomTypeId: rt.roomTypeId,
        newImages:  rt.newImages.map(i => ({ tempPath: i.tempPath, isPrimary: i.isPrimary })),
        existingImages: rt.existingImages.map(i => ({
          imageId: i.imageId, isPrimary: i.isPrimary, deleted: false,
        })),
      })),
    }
  }

  // ── Client-side validation ─────────────────────────────────────
  const validatePayload = () => {
    const errors = []
    const { basicInfo, amenities } = state

    if (!basicInfo.name?.trim())    errors.push('Tên khách sạn không được để trống')
    if (!basicInfo.address?.trim()) errors.push('Địa chỉ không được để trống')
    if (!basicInfo.city?.trim())    errors.push('Thành phố không được để trống')
    if (!basicInfo.managerId)       errors.push('Phải chọn quản lý')

    amenities.paidAmenities.forEach(p => {
      if (!p.basePrice || Number(p.basePrice) <= 0)
        errors.push(`Dịch vụ "${p.name}" phải có giá > 0`)
      if (!p.unitId)
        errors.push(`Dịch vụ "${p.name}" phải chọn đơn vị`)
    })

    return errors
  }

  return (
    <EditHotelContext.Provider value={{ state, dispatch, buildUpdatePayload, validatePayload }}>
      {children}
    </EditHotelContext.Provider>
  )
}

export function useEditHotel() {
  const ctx = useContext(EditHotelContext)
  if (!ctx) throw new Error('useEditHotel must be used within EditHotelProvider')
  return ctx
}