import api from './api'

const ALLOWED_TYPES = ['image/jpeg', 'image/png', 'image/webp']
const MAX_SIZE_MB = 10

export function validateImageFile(file) {
  if (!ALLOWED_TYPES.includes(file.type))
    throw new Error('Chỉ chấp nhận file jpg, png, webp')
  if (file.size > MAX_SIZE_MB * 1024 * 1024)
    throw new Error(`File không được vượt quá ${MAX_SIZE_MB}MB`)
}

// Upload 1 file lên server, trả về { tempPath }
export const uploadTempImage = (file) => {
  const form = new FormData()
  form.append('file', file)
  return api.post('/hotels/images/temp', form, {
    headers: { 'Content-Type': 'multipart/form-data' },
  })
}