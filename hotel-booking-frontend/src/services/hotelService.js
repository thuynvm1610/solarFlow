import api from './api';

// Dùng cho form options (load khi mở Create / Edit modal)
export const getFormOptions = () =>
  api.get('/hotels/form-options')
// Response: { managers, amenities, roomTypes, priceUnits, hotelTypes, hotelStatuses }

// Create
export const createHotel = (payload) =>
  api.post('/hotels', payload)

// Edit
// Load đầy đủ data để fill vào Edit form
export const getHotelDetail = (id) =>
  api.get(`/hotels/${id}/detail`)
// Response: hotel + rooms + images + amenities + roomTypes + extraServices

export const updateHotel = (id, payload) =>
  api.put(`/hotels/${id}`, payload)

const hotelService = {
  getAllHotels: async () => {
    const response = await api.get('/hotels');
    return response.data;
  },

  getHotelById: async (id) => {
    const response = await api.get(`/hotels/${id}`);
    return response.data;
  },

  createHotel: async (hotelData) => {
    const response = await api.post('/hotels', hotelData);
    return response.data;
  },

  updateHotel: async (id, hotelData) => {
    const response = await api.put(`/hotels/${id}`, hotelData);
    return response.data;
  },

  deleteHotel: async (id) => {
    const response = await api.delete(`/hotels/${id}`);
    return response.data;
  },

  searchHotels: async (keyword) => {
    const response = await api.get(`/hotels/search`, {
      params: { keyword }
    });
    return response.data;
  },

  getHotelsByCity: async (city) => {
    const response = await api.get(`/hotels/city/${city}`);
    return response.data;
  },
};

export default hotelService;