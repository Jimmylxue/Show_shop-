import axios from 'axios'

export default {
  async login(params) {
    return await axios.post('/api/admin/log/login', params)
  },
  async register(params) {
    return await axios.post('/api/admin/log/register', params)
  },
}
