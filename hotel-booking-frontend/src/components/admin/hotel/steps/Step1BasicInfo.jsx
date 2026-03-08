// src/components/admin/hotel/steps/Step1BasicInfo.jsx

import { useCreateHotel } from '../../../../contexts/CreateHotelContext'
import { useEditHotel } from '../../../../contexts/EditHotelContext'
import CustomSelect from '../../../common/CustomSelect'
import FieldError from '../../../common/FieldError'
import {
  FaHotel, FaStar, FaUserTie, FaToggleOn,
  FaMapMarkerAlt, FaBuilding, FaClock, FaFileAlt, FaLock,
} from 'react-icons/fa'

export default function Step1BasicInfo({ formOptions, isEdit, errors = {} }) {
  if (isEdit) return <Step1Form formOptions={formOptions} useCtx={useEditHotel} isEdit errors={errors} />
  return <Step1Form formOptions={formOptions} useCtx={useCreateHotel} isEdit={false} errors={errors} />
}

function SectionTitle({ icon: Icon, title, color = 'blue' }) {
  const colors = {
    blue:   'bg-blue-50 text-blue-700 border-blue-200',
    indigo: 'bg-indigo-50 text-indigo-700 border-indigo-200',
    amber:  'bg-amber-50 text-amber-700 border-amber-200',
    green:  'bg-green-50 text-green-700 border-green-200',
  }
  return (
    <div className={`flex items-center gap-2 px-3 py-1.5 rounded-lg border text-xs font-bold uppercase tracking-wider mb-4 w-fit ${colors[color]}`}>
      <Icon className="w-3.5 h-3.5" />
      {title}
    </div>
  )
}

function Label({ children, required }) {
  return (
    <label className="flex items-center gap-0.5 text-sm font-semibold text-slate-700 mb-1.5">
      {children}
      {required && <span className="text-red-500 font-bold text-base leading-none ml-0.5">*</span>}
    </label>
  )
}

function ReadOnlyField({ value, note }) {
  return (
    <div className="flex items-center gap-2 px-3.5 py-2.5 rounded-xl border border-slate-200 bg-slate-50 text-sm">
      <FaLock className="w-3 h-3 text-slate-300 flex-shrink-0" />
      <span className="font-medium text-slate-600">{value}</span>
      {note && <span className="text-xs text-slate-400 ml-auto">({note})</span>}
    </div>
  )
}

function Step1Form({ formOptions, useCtx, isEdit, errors }) {
  const { state, dispatch } = useCtx()
  const { basicInfo } = state
  const { managers = [], hotelTypes = [], hotelStatuses = [] } = formOptions ?? {}

  const update = (field, value) =>
    dispatch({ type: 'UPDATE_BASIC_INFO', payload: { [field]: value } })

  const hotelTypeOptions = hotelTypes.map(t => ({ value: t.value, label: t.label }))
  const starOptions      = [1, 2, 3, 4, 5].map(s => ({ value: String(s), label: `${'★'.repeat(s)}  ${s} sao` }))
  const managerOptions   = managers.map(m => ({ value: String(m.id), label: m.fullName }))
  const statusOptions    = hotelStatuses.map(s => ({ value: s.value, label: s.label }))

  const inputCls = (field) =>
    `w-full px-3.5 py-2.5 rounded-xl border text-sm text-slate-800 placeholder-slate-400
     outline-none focus:ring-2 transition-all duration-150
     ${errors[field]
       ? 'border-red-400 bg-red-50 focus:border-red-400 focus:ring-red-100'
       : 'border-slate-200 bg-white focus:border-blue-400 focus:ring-blue-100'}`

  const selectWrap = (field) =>
    errors[field] ? 'ring-2 ring-red-200 rounded-xl' : ''

  return (
    <div className="space-y-5 pb-2">

      {/* ── 1. Thông tin chính ── */}
      <div className="bg-white rounded-2xl border border-slate-200 p-5 shadow-sm">
        <SectionTitle icon={FaHotel} title="Thông tin chính" color="blue" />

        <div className="space-y-4">
          <div>
            <Label required>Tên khách sạn</Label>
            <input type="text" value={basicInfo.name}
              onChange={e => update('name', e.target.value)}
              placeholder="VD: Khách sạn Solarflow Hà Nội"
              maxLength={255} className={inputCls('name')} />
            <FieldError message={errors.name} />
          </div>

          <div>
            <Label required>Mô tả</Label>
            <textarea rows={5} value={basicInfo.description}
              onChange={e => update('description', e.target.value)}
              placeholder="Mô tả chi tiết về khách sạn, điểm nổi bật, vị trí, phong cách phục vụ..."
              className={`${inputCls('description')} resize-y min-h-[110px]`} />
            <FieldError message={errors.description} />
          </div>
        </div>
      </div>

      {/* ── 2. Vị trí ── */}
      <div className="bg-white rounded-2xl border border-slate-200 p-5 shadow-sm">
        <SectionTitle icon={FaMapMarkerAlt} title="Vị trí" color="indigo" />

        <div className="space-y-4">
          <div>
            <Label required>Địa chỉ</Label>
            <input type="text" value={basicInfo.address}
              onChange={e => update('address', e.target.value)}
              placeholder="Số nhà, tên đường, phường/xã, quận/huyện..."
              className={inputCls('address')} />
            <FieldError message={errors.address} />
          </div>

          <div className="sm:w-1/2">
            <Label required>Thành phố</Label>
            <input type="text" value={basicInfo.city}
              onChange={e => update('city', e.target.value)}
              placeholder="Hà Nội, TP.HCM, Đà Nẵng..."
              className={inputCls('city')} />
            <FieldError message={errors.city} />
          </div>
        </div>
      </div>

      {/* ── 3. Phân loại & Quản lý ── */}
      <div className="bg-white rounded-2xl border border-slate-200 p-5 shadow-sm">
        <SectionTitle icon={FaBuilding} title="Phân loại & Quản lý" color="amber" />

        {/* Row 1: Loại / Số sao / Số tầng — compact */}
        <div className="grid grid-cols-3 gap-3 mb-4">
          <div>
            <Label required={!isEdit}>Loại hình</Label>
            {isEdit ? (
              <ReadOnlyField
                value={hotelTypeOptions.find(t => t.value === basicInfo.type)?.label ?? basicInfo.type}
                note="cố định" />
            ) : (
              <>
                <div className={selectWrap('type')}>
                  <CustomSelect value={basicInfo.type} onChange={v => update('type', v)}
                    options={hotelTypeOptions} placeholder="Chọn loại" icon={FaHotel} />
                </div>
                <FieldError message={errors.type} />
              </>
            )}
          </div>

          <div>
            <Label required>Số sao</Label>
            <div className={selectWrap('starRating')}>
              <CustomSelect value={String(basicInfo.starRating || '')}
                onChange={v => update('starRating', Number(v))}
                options={starOptions} placeholder="Chọn sao" icon={FaStar} />
            </div>
            <FieldError message={errors.starRating} />
          </div>

          <div>
            <Label required={!isEdit}>Số tầng</Label>
            {isEdit ? (
              <ReadOnlyField value={basicInfo.floor} note="cố định" />
            ) : (
              <>
                <input type="number" min={1} max={99} value={basicInfo.floor || ''}
                  onChange={e => update('floor', Number(e.target.value))}
                  placeholder="VD: 10" className={inputCls('floor')} />
                <FieldError message={errors.floor} />
              </>
            )}
          </div>
        </div>

        {/* Row 2: Manager + Status */}
        <div className={`grid gap-3 ${isEdit ? 'grid-cols-2' : 'grid-cols-1 sm:w-2/3'}`}>
          <div>
            <Label required>Quản lý</Label>
            <div className={selectWrap('managerId')}>
              <CustomSelect
                value={basicInfo.managerId ? String(basicInfo.managerId) : ''}
                onChange={v => update('managerId', Number(v))}
                options={managerOptions} placeholder="Chọn manager" icon={FaUserTie} />
            </div>
            <FieldError message={errors.managerId} />
          </div>

          {isEdit && (
            <div>
              <Label required>Trạng thái</Label>
              <div className={selectWrap('status')}>
                <CustomSelect value={basicInfo.status ?? ''}
                  onChange={v => update('status', v)}
                  options={statusOptions} placeholder="Chọn trạng thái" icon={FaToggleOn} />
              </div>
              <FieldError message={errors.status} />
            </div>
          )}
        </div>
      </div>

      {/* ── 4. Giờ nhận & trả phòng ── */}
      <div className="bg-white rounded-2xl border border-slate-200 p-5 shadow-sm">
        <SectionTitle icon={FaClock} title="Giờ nhận & trả phòng" color="green" />
        <div className="grid grid-cols-2 gap-4">
          <div>
            <Label required>Giờ check-in</Label>
            <input type="time" value={basicInfo.checkInTime}
              onChange={e => update('checkInTime', e.target.value)}
              className={inputCls('checkInTime')} />
            <FieldError message={errors.checkInTime} />
          </div>
          <div>
            <Label required>Giờ check-out</Label>
            <input type="time" value={basicInfo.checkOutTime}
              onChange={e => update('checkOutTime', e.target.value)}
              className={inputCls('checkOutTime')} />
            <FieldError message={errors.checkOutTime} />
          </div>
        </div>
      </div>

      {/* ── 5. Thông tin bổ sung ── */}
      <div className="bg-white rounded-2xl border border-slate-200 p-5 shadow-sm">
        <SectionTitle icon={FaFileAlt} title="Thông tin bổ sung" color="indigo" />
        <div className="space-y-4">
          <div>
            <Label>Hướng dẫn check-in</Label>
            <textarea rows={3} value={basicInfo.checkInInstructions}
              onChange={e => update('checkInInstructions', e.target.value)}
              placeholder="VD: Quầy lễ tân mở 24/7, cần xuất trình CMND/CCCD khi nhận phòng..."
              className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 bg-white text-sm
                         text-slate-800 placeholder-slate-400 outline-none focus:border-blue-400
                         focus:ring-2 focus:ring-blue-100 resize-y min-h-[80px] transition-all" />
          </div>
          <div>
            <Label>Chính sách</Label>
            <textarea rows={4} value={basicInfo.policyText}
              onChange={e => update('policyText', e.target.value)}
              placeholder="VD: Không hút thuốc trong phòng. Hủy trước 24h được hoàn 100%..."
              className="w-full px-3.5 py-2.5 rounded-xl border border-slate-200 bg-white text-sm
                         text-slate-800 placeholder-slate-400 outline-none focus:border-blue-400
                         focus:ring-2 focus:ring-blue-100 resize-y min-h-[100px] transition-all" />
          </div>
        </div>
      </div>

      <p className="text-xs text-slate-400 flex items-center gap-1">
        <span className="text-red-500 font-bold text-sm">*</span> Trường bắt buộc phải điền
      </p>

    </div>
  )
}