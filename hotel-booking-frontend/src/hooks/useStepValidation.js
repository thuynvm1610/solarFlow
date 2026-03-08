// src/hooks/useStepValidation.js
// Validate từng step trước khi cho chuyển trang

// ─── Step 1: Basic Info ───────────────────────────────────────
export function validateStep1(basicInfo, isEdit) {
  const errors = {}

  if (!basicInfo.name?.trim())
    errors.name = 'Tên khách sạn không được để trống'

  if (!basicInfo.description?.trim())
    errors.description = 'Mô tả không được để trống'

  if (!basicInfo.address?.trim())
    errors.address = 'Địa chỉ không được để trống'

  if (!basicInfo.city?.trim())
    errors.city = 'Thành phố không được để trống'

  if (!isEdit && !basicInfo.type)
    errors.type = 'Vui lòng chọn loại khách sạn'

  if (!basicInfo.starRating)
    errors.starRating = 'Vui lòng chọn số sao'

  if (!isEdit && (!basicInfo.floor || basicInfo.floor < 1))
    errors.floor = 'Số tầng phải từ 1 trở lên'

  if (!basicInfo.managerId)
    errors.managerId = 'Vui lòng chọn quản lý'

  if (!basicInfo.checkInTime)
    errors.checkInTime = 'Vui lòng nhập giờ check-in'

  if (!basicInfo.checkOutTime)
    errors.checkOutTime = 'Vui lòng nhập giờ check-out'

  if (isEdit && !basicInfo.status)
    errors.status = 'Vui lòng chọn trạng thái'

  return errors
}

// ─── Step 2: Amenities (không có trường bắt buộc, nhưng dịch vụ có phí phải có giá + đơn vị) ─
export function validateStep2(amenities) {
  const errors = {}

  amenities.paidAmenities?.forEach((p, idx) => {
    if (!p.basePrice || Number(p.basePrice) <= 0)
      errors[`paid_${idx}_price`] = `"${p.name}": Giá phải lớn hơn 0`
    if (!p.unitId)
      errors[`paid_${idx}_unit`] = `"${p.name}": Chưa chọn đơn vị`
  })

  return errors
}

// ─── Step 3 Create: Room Types ────────────────────────────────
export function validateStep3Create(customRoomTypes) {
  const errors = {}

  if (customRoomTypes.length === 0) {
    errors._global = 'Phải có ít nhất 1 loại phòng'
    return errors
  }

  customRoomTypes.forEach((rt, idx) => {
    if (!rt.name?.trim())
      errors[`rt_${idx}_name`] = `Loại phòng #${idx + 1}: Tên không được để trống`
    if (!rt.basePrice || Number(rt.basePrice) <= 0)
      errors[`rt_${idx}_price`] = `Loại phòng #${idx + 1}: Giá phải lớn hơn 0`
  })

  return errors
}

// ─── Step 3 Edit: Room Types (safe fields) ────────────────────
export function validateStep3Edit(selectedRoomTypes) {
  const errors = {}

  selectedRoomTypes.forEach((rt, idx) => {
    if (!rt.name?.trim())
      errors[`rt_${idx}_name`] = `Loại phòng #${idx + 1}: Tên không được để trống`
  })

  return errors
}

// ─── Step 4: Rooms ────────────────────────────────────────────
export function validateStep4Create(generatedRooms) {
  const errors = {}

  if (generatedRooms.length === 0) {
    errors._global = 'Phải tạo ít nhất 1 phòng (nhấn "Tạo danh sách phòng")'
    return errors
  }

  const unassigned = generatedRooms.filter(r => !r.roomTypeTempId).length
  if (unassigned > 0)
    errors._global = `Còn ${unassigned} phòng chưa được gán loại phòng`

  return errors
}

export function validateStep4Edit(existingRooms, newRooms) {
  const errors = {}
  const allRooms = [...existingRooms, ...newRooms]
  const unassigned = allRooms.filter(r => !r.roomTypeId).length
  if (unassigned > 0)
    errors._global = `Còn ${unassigned} phòng chưa được gán loại phòng`
  return errors
}

// ─── Step 5: Images ───────────────────────────────────────────
export function validateStep5Create(hotelImages) {
  const errors = {}

  if (hotelImages.length === 0) {
    errors._global = 'Phải có ít nhất 1 ảnh khách sạn'
    return errors
  }

  const hasPrimary = hotelImages.some(i => i.isPrimary)
  if (!hasPrimary)
    errors._global = 'Phải chọn 1 ảnh đại diện cho khách sạn (nhấn ★)'

  return errors
}

export function validateStep5Edit(existingHotelImages, newHotelImages) {
  const errors = {}
  const allImages = [...existingHotelImages, ...newHotelImages]

  if (allImages.length === 0) {
    errors._global = 'Phải có ít nhất 1 ảnh khách sạn'
    return errors
  }

  const hasPrimary = allImages.some(i => i.isPrimary)
  if (!hasPrimary)
    errors._global = 'Phải chọn 1 ảnh đại diện cho khách sạn (nhấn ★)'

  return errors
}

// ─── Helpers ──────────────────────────────────────────────────
export function hasErrors(errors) {
  return Object.keys(errors).length > 0
}

// Lấy danh sách lỗi dạng mảng để hiện toast/summary
export function getErrorList(errors) {
  return Object.values(errors)
}