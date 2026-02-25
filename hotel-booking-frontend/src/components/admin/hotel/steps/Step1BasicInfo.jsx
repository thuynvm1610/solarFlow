// src/components/admin/hotel/steps/Step1BasicInfo.jsx

import { useCreateHotel } from '../../../../contexts/CreateHotelContext'
import { useEditHotel }   from '../../../../contexts/EditHotelContext'
import CustomSelect       from '../../../common/CustomSelect'
import { FaHotel, FaStar, FaUserTie } from 'react-icons/fa'

export default function Step1BasicInfo({ formOptions, isEdit }) {
  if (isEdit) return <Step1Form formOptions={formOptions} useCtx={useEditHotel} />
  return           <Step1Form formOptions={formOptions} useCtx={useCreateHotel} />
}

function Step1Form({ formOptions, useCtx }) {
  const { state, dispatch } = useCtx()
  const { basicInfo } = state
  const { managers = [], hotelTypes = [] } = formOptions ?? {}

  const update = (field, value) =>
    dispatch({ type: 'UPDATE_BASIC_INFO', payload: { [field]: value } })

  // Chuyển data sang format { value, label } cho CustomSelect
  const hotelTypeOptions = hotelTypes.map(t => ({ value: t.value, label: t.label }))

  const starOptions = [1, 2, 3, 4, 5].map(s => ({
    value: String(s),
    label: `${s} sao`,
  }))

  const managerOptions = managers.map(m => ({
    value: String(m.id),
    label: `${m.fullName}`,
    icon: <span className="text-xs text-slate-400">{m.email}</span>,
  }))

  return (
    <div className="step-content">
      <div className="form-grid">

        <div className="form-group full-width">
          <label>Tên khách sạn <span className="required">*</span></label>
          <input
            type="text"
            value={basicInfo.name}
            onChange={e => update('name', e.target.value)}
            placeholder="Nhập tên khách sạn"
            maxLength={255}
          />
        </div>

        <div className="form-group full-width">
          <label>Mô tả <span className="required">*</span></label>
          <textarea
            rows={4}
            value={basicInfo.description}
            onChange={e => update('description', e.target.value)}
            placeholder="Mô tả về khách sạn"
          />
        </div>

        <div className="form-group full-width">
          <label>Địa chỉ <span className="required">*</span></label>
          <input
            type="text"
            value={basicInfo.address}
            onChange={e => update('address', e.target.value)}
            placeholder="Số nhà, tên đường..."
          />
        </div>

        <div className="form-group">
          <label>Thành phố <span className="required">*</span></label>
          <input
            type="text"
            value={basicInfo.city}
            onChange={e => update('city', e.target.value)}
            placeholder="Hà Nội, TP.HCM..."
          />
        </div>

        <div className="form-group">
          <label>Loại <span className="required">*</span></label>
          <CustomSelect
            value={basicInfo.type}
            onChange={val => update('type', val)}
            options={hotelTypeOptions}
            placeholder="-- Chọn loại --"
            icon={FaHotel}
          />
        </div>

        <div className="form-group">
          <label>Số sao <span className="required">*</span></label>
          <CustomSelect
            value={String(basicInfo.starRating)}
            onChange={val => update('starRating', Number(val))}
            options={starOptions}
            placeholder="-- Chọn số sao --"
            icon={FaStar}
          />
        </div>

        <div className="form-group">
          <label>Số tầng <span className="required">*</span></label>
          <input
            type="number" min={1} max={99}
            value={basicInfo.floor || ''}
            onChange={e => update('floor', Number(e.target.value))}
            placeholder="1 - 99"
          />
        </div>

        <div className="form-group">
          <label>Quản lý <span className="required">*</span></label>
          <CustomSelect
            value={basicInfo.managerId ? String(basicInfo.managerId) : ''}
            onChange={val => update('managerId', Number(val))}
            options={managerOptions}
            placeholder="-- Chọn manager --"
            icon={FaUserTie}
          />
        </div>

        <div className="form-group">
          <label>Giờ check-in <span className="required">*</span></label>
          <input
            type="time"
            value={basicInfo.checkInTime}
            onChange={e => update('checkInTime', e.target.value)}
          />
        </div>

        <div className="form-group">
          <label>Giờ check-out <span className="required">*</span></label>
          <input
            type="time"
            value={basicInfo.checkOutTime}
            onChange={e => update('checkOutTime', e.target.value)}
          />
        </div>

        <div className="form-group full-width">
          <label>Hướng dẫn check-in</label>
          <textarea
            rows={3}
            value={basicInfo.checkInInstructions}
            onChange={e => update('checkInInstructions', e.target.value)}
            placeholder="Hướng dẫn cho khách khi check-in..."
          />
        </div>

        <div className="form-group full-width">
          <label>Chính sách khách sạn</label>
          <textarea
            rows={4}
            value={basicInfo.policyText}
            onChange={e => update('policyText', e.target.value)}
            placeholder="Các chính sách về hủy phòng, thú cưng, hút thuốc..."
          />
        </div>

      </div>
    </div>
  )
}