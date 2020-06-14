import axios from 'axios'

export default {
  async getList() {
    return await axios.get('/api/admin/order/lists')
  },
  async changeMsg(params) {
    return await axios.post('/api/admin/order/change', { params })
  },
}
