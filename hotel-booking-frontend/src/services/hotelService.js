import api from './api';

// Dùng cho form options (load khi mở Create / Edit modal)
export const getFormOptions = () => api.get('/hotels/form-options')

// Create
export const createHotel = (payload) => api.post('/hotels', payload)

// Edit
export const getHotelDetail = (id) => api.get(`/hotels/${id}/detail`)

export const updateHotel = (id, data) => api.put(`/hotels/${id}`, data)

export const deleteHotel = (id) => api.delete(`/hotels/${id}`)

export const getTotalHotels = () => api.get('/hotels/count')

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