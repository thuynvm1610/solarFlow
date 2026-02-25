// src/utils/amenityIcons.js
// DB lưu key (ví dụ: "FaWifi"), file này map sang component react-icons

import {
  FaWifi,
  FaParking,
  FaSwimmingPool,
  FaDumbbell,
  FaSpa,
  FaUtensils,
  FaCoffee,
  FaConciergeBell,
  FaTv,
  FaSnowflake,
  FaBed,
  FaBath,
  FaShuttleVan,
  FaWheelchair,
  FaDog,
  FaSmoking,
  FaSmokingBan,
  FaLock,
  FaShieldAlt,
  FaFire,
  FaTshirt,
  FaPhone,
  FaPrint,
  FaGamepad,
  FaChild,
  FaMedkit,
  FaGlassMartini,
  FaSuitcase,
  FaKey,
  FaMapMarkerAlt,
  // Các icon bổ sung theo DB
  FaWater,        // SEA_VIEW
  FaMountain,     // MOUNTAIN_VIEW
  FaShower,       // SHOWER
  FaDesktop,      // WORK_DESK
  FaDoorClosed,   // WARDROBE (fallback nếu không có thì dùng FaDoorOpen)
  FaWind,         // HAIR_DRYER
  FaBroom,        // DAILY_HOUSEKEEPING
  FaCar,          // CAR_RENTAL
  FaBaby,         // BABY_COT
  FaGolfBall,     // GOLF_SERVICE
  FaUtensilSpoon, // PRIVATE_DINNER
  FaHeart,        // ROOM_DECORATION
} from 'react-icons/fa'

import {
  MdBalcony,
  MdKitchen,
  MdLocalLaundryService,
  MdRoomService,
  MdElevator,
  MdOutdoorGrill,
} from 'react-icons/md'

// ── Map tên DB → component ──────────────────────────────────
const ICON_MAP = {
  // Kết nối
  FaWifi,

  // Đỗ xe & Đi lại
  FaParking,
  FaShuttleVan,
  FaCar,

  // Hồ bơi & Thể thao
  FaSwimmingPool,
  FaDumbbell,

  // Spa & Thư giãn
  FaSpa,
  FaFire,

  // Ăn uống
  FaUtensils,
  FaCoffee,
  FaGlassMartini,
  FaUtensilSpoon,
  MdOutdoorGrill,

  // Dịch vụ phòng
  FaConciergeBell,
  MdRoomService,
  FaTshirt,
  FaBroom,
  MdLocalLaundryService,

  // Tiện nghi phòng
  FaTv,
  FaSnowflake,
  FaBed,
  FaBath,
  FaShower,
  MdKitchen,
  MdBalcony,
  FaDesktop,
  FaDoorClosed,
  FaWind,

  // View
  FaWater,
  FaMountain,

  // Dịch vụ khác
  FaSuitcase,
  FaKey,
  FaLock,
  FaShieldAlt,
  FaPhone,
  FaPrint,

  // Tiện ích đặc biệt
  FaWheelchair,
  FaDog,
  FaSmoking,
  FaSmokingBan,
  FaChild,
  FaBaby,
  FaGamepad,
  FaMedkit,
  FaGolfBall,
  FaHeart,
  MdElevator,
  FaMapMarkerAlt,
}

/**
 * Trả về React component icon tương ứng với key lưu trong DB.
 * Nếu không tìm thấy → trả về null.
 *
 * @param {string} iconKey  - Ví dụ: "FaWifi", "FaParking"
 * @param {string} className - Tailwind class tuỳ chỉnh
 */
export function AmenityIcon({ iconKey, className = 'w-4 h-4 text-slate-500' }) {
  const Icon = ICON_MAP[iconKey]
  if (!Icon) return null
  return <Icon className={className} />
}

/**
 * Danh sách tất cả icon có sẵn để dùng trong form chọn icon (admin).
 * Mỗi item: { key, label, component }
 */
export const AMENITY_ICON_LIST = Object.entries(ICON_MAP).map(([key, Component]) => ({
  key,
  label: key.replace(/^(Fa|Md)/, '').replace(/([A-Z])/g, ' $1').trim(),
  component: Component,
}))

export default ICON_MAP