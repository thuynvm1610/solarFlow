import api from './api';

const roomService = {
  getAllRooms: async () => {
    const response = await api.get('/rooms');
    return response.data;
  },

  getRoomById: async (id) => {
    const response = await api.get(`/rooms/${id}`);
    return response.data;
  },

  createRoom: async (roomData) => {
    const response = await api.post('/rooms', roomData);
    return response.data;
  },

  updateRoom: async (id, roomData) => {
    const response = await api.put(`/rooms/${id}`, roomData);
    return response.data;
  },

  updateRoomStatus: async (id, status) => {
    const response = await api.put(`/rooms/${id}/status`, { status });
    return response.data;
  },

  deleteRoom: async (id) => {
    const response = await api.delete(`/rooms/${id}`);
    return response.data;
  },

  getRoomsByHotel: async (hotelId) => {
    const response = await api.get(`/rooms/hotel/${hotelId}`);
    return response.data;
  },

  getAvailableRooms: async (hotelId, checkIn, checkOut) => {
    const response = await api.get(`/rooms/available`, {
      params: { hotelId, checkIn, checkOut }
    });
    return response.data;
  },
};

export default roomService;