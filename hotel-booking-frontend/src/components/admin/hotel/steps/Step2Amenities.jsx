// src/components/admin/hotel/steps/Step2Amenities.jsx

import { useCreateHotel } from '../../../../contexts/CreateHotelContext'
import { useEditHotel }   from '../../../../contexts/EditHotelContext'
import CustomSelect       from '../../../common/CustomSelect'
import { StepErrorBanner } from '../../../common/FieldError'
import { AmenityIcon }    from '../../../../utils/amenityIcons'

export default function Step2Amenities({ formOptions, isEdit, errors = {} }) {
  if (isEdit) return <Step2Form formOptions={formOptions} useCtx={useEditHotel} errors={errors} />
  return           <Step2Form formOptions={formOptions} useCtx={useCreateHotel} errors={errors} />
}

function Step2Form({ formOptions, useCtx, errors }) {
  const { state, dispatch } = useCtx()
  const { amenities } = state
  const { freeServices = [], extraServices = [], priceUnits = [] } = formOptions ?? {}

  const isFree  = (id) => amenities.freeAmenityIds.includes(id)
  const isPaid  = (id) => amenities.paidAmenities.some(p => p.amenityId === id)
  const getPaid = (id) => amenities.paidAmenities.find(p => p.amenityId === id)
  const unitOptions = priceUnits.map(u => ({ value: String(u.id), label: u.name }))

  return (
    <div className="space-y-8">
      <StepErrorBanner errors={errors} />

      {/* Free amenities */}
      <section className="bg-white rounded-xl border border-slate-200 overflow-hidden">
        <div className="bg-gradient-to-r from-emerald-500 to-teal-500 px-5 py-3">
          <h3 className="text-base font-bold text-white">Tiện Ích Khách Sạn (Miễn phí)</h3>
          <p className="text-xs text-emerald-50 mt-0.5">Chọn các tiện ích cơ bản cho khách sạn</p>
        </div>
        <div className="p-5">
          {freeServices.length === 0 ? (
            <p className="text-center text-slate-400 py-8">Không có tiện ích nào</p>
          ) : (
            <div className="grid grid-cols-2 md:grid-cols-3 lg:grid-cols-4 gap-3">
              {freeServices.map(amenity => {
                const isSelected = isFree(amenity.id)
                return (
                  <button key={amenity.id}
                    onClick={() => dispatch({ type: 'TOGGLE_FREE_AMENITY', payload: amenity.id })}
                    className={`flex items-center gap-2 px-3 py-2.5 rounded-lg border-2 transition-all
                      ${isSelected
                        ? 'border-emerald-500 bg-emerald-50 text-emerald-700'
                        : 'border-slate-200 bg-white text-slate-600 hover:border-emerald-300 hover:bg-emerald-50/50'}`}
                  >
                    <AmenityIcon iconKey={amenity.icon}
                      className={`w-4 h-4 flex-shrink-0 ${isSelected ? 'text-emerald-600' : 'text-slate-400'}`} />
                    <span className="text-xs font-medium truncate">{amenity.name}</span>
                    {isSelected && <span className="ml-auto text-emerald-600 text-sm">✓</span>}
                  </button>
                )
              })}
            </div>
          )}
          <div className="mt-4 flex items-center gap-2 text-sm">
            <span className="text-slate-500">Đã chọn:</span>
            <span className="font-bold text-emerald-600">{amenities.freeAmenityIds.length}</span>
            <span className="text-slate-400">/ {freeServices.length}</span>
          </div>
        </div>
      </section>

      {/* Paid services */}
      <section className="bg-white rounded-xl border border-slate-200 overflow-hidden">
        <div className="bg-gradient-to-r from-amber-500 to-orange-500 px-5 py-3">
          <h3 className="text-base font-bold text-white">Dịch Vụ Thêm (Có phí)</h3>
          <p className="text-xs text-amber-50 mt-0.5">Chọn và thiết lập giá cho các dịch vụ bổ sung</p>
        </div>
        <div className="p-5">
          {extraServices.length === 0 ? (
            <p className="text-center text-slate-400 py-8">Không có dịch vụ nào</p>
          ) : (
            <div className="space-y-3">
              {extraServices.map((amenity, idx) => {
                const isSelected = isPaid(amenity.id)
                const paidData   = getPaid(amenity.id)
                const priceErr   = errors[`paid_${amenities.paidAmenities.findIndex(p => p.amenityId === amenity.id)}_price`]
                const unitErr    = errors[`paid_${amenities.paidAmenities.findIndex(p => p.amenityId === amenity.id)}_unit`]

                return (
                  <div key={amenity.id}
                    className={`border-2 rounded-xl transition-all overflow-hidden
                      ${isSelected ? 'border-amber-400 bg-amber-50/50' : 'border-slate-200 bg-white'}
                      ${(priceErr || unitErr) ? 'border-red-300' : ''}`}
                  >
                    <div className="flex items-center justify-between px-4 py-3">
                      <div className="flex items-center gap-3">
                        <AmenityIcon iconKey={amenity.icon}
                          className={`w-5 h-5 flex-shrink-0 ${isSelected ? 'text-amber-600' : 'text-slate-400'}`} />
                        <span className="text-sm font-semibold text-slate-700">{amenity.name}</span>
                      </div>
                      <button
                        onClick={() => dispatch({ type: 'TOGGLE_PAID_AMENITY', payload: { id: amenity.id, name: amenity.name } })}
                        className={`px-4 py-1.5 rounded-lg text-xs font-semibold transition-all
                          ${isSelected ? 'bg-amber-500 text-white hover:bg-amber-600' : 'bg-slate-100 text-slate-600 hover:bg-slate-200'}`}
                      >
                        {isSelected ? '✓ Đã chọn' : '+ Chọn'}
                      </button>
                    </div>

                    {isSelected && paidData && (
                      <div className="px-4 pb-4 pt-2 border-t border-amber-200 bg-white">
                        <div className="grid grid-cols-2 gap-3">
                          {/* Giá */}
                          <div>
                            <label className="block text-xs font-medium text-slate-600 mb-1">
                              Giá dịch vụ <span className="text-red-500">*</span>
                            </label>
                            <input
                              type="number" min={0} step="1000"
                              value={paidData.basePrice}
                              onChange={e => dispatch({
                                type: 'UPDATE_PAID_AMENITY',
                                payload: { amenityId: amenity.id, field: 'basePrice', value: e.target.value },
                              })}
                              placeholder="Nhập giá..."
                              className={`w-full px-3 py-2 border rounded-lg text-sm focus:ring-2 focus:border-transparent outline-none transition-all
                                ${priceErr
                                  ? 'border-red-400 bg-red-50 focus:ring-red-100'
                                  : 'border-slate-300 focus:ring-amber-500'}`}
                            />
                            {priceErr && (
                              <p className="text-xs text-red-500 mt-1 flex items-center gap-1">
                                <span className="w-3 h-3 rounded-full bg-red-100 flex items-center justify-center text-[9px] font-bold flex-shrink-0">!</span>
                                Giá phải lớn hơn 0
                              </p>
                            )}
                          </div>
                          {/* Đơn vị */}
                          <div>
                            <label className="block text-xs font-medium text-slate-600 mb-1">
                              Đơn vị <span className="text-red-500">*</span>
                            </label>
                            <div className={unitErr ? 'ring-2 ring-red-200 rounded-lg' : ''}>
                              <CustomSelect
                                value={paidData.unitId ? String(paidData.unitId) : ''}
                                onChange={val => dispatch({
                                  type: 'UPDATE_PAID_AMENITY',
                                  payload: { amenityId: amenity.id, field: 'unitId', value: Number(val) },
                                })}
                                options={unitOptions}
                                placeholder="Chọn đơn vị"
                              />
                            </div>
                            {unitErr && (
                              <p className="text-xs text-red-500 mt-1 flex items-center gap-1">
                                <span className="w-3 h-3 rounded-full bg-red-100 flex items-center justify-center text-[9px] font-bold flex-shrink-0">!</span>
                                Chưa chọn đơn vị
                              </p>
                            )}
                          </div>
                        </div>
                      </div>
                    )}
                  </div>
                )
              })}
            </div>
          )}
          <div className="mt-4 flex items-center gap-2 text-sm">
            <span className="text-slate-500">Đã chọn:</span>
            <span className="font-bold text-amber-600">{amenities.paidAmenities.length}</span>
            <span className="text-slate-400">/ {extraServices.length}</span>
          </div>
        </div>
      </section>

      <div className="bg-blue-50 border border-blue-200 rounded-lg px-4 py-3 flex items-start gap-3">
        <span className="text-blue-500 text-lg flex-shrink-0">ℹ️</span>
        <p className="text-xs text-blue-700">
          Các tiện ích theo phòng (TV, điều hòa, tủ lạnh...) sẽ được chọn ở <strong>Bước 3 - Loại Phòng</strong>.
        </p>
      </div>
    </div>
  )
}