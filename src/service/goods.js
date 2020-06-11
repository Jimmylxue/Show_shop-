import axios from 'axios'

export default {
  async getGoods() {
    return await axios.get('/api/admin/good/goods')
  },
  async addGood(good) {
    return await axios.post('/api/admin/good/add', good)
  },
  async getCount() {
    return await axios.get('/api/admin/good/count')
  },
  async clearStock(params) {
    return await axios.post('/api/admin/good/clearCount', { id: params })
  },
}
