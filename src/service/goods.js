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
  async editStockCount(id, count) {
    console.log(id, count)
    return await axios.post('/api/admin/good/editCount', { id, count })
  },
  async changetag(params1, params2, params3, params4) {
    return await axios.post('/api/admin/good/changetag', {
      id: params1,
      tag: params2,
      nowPrice: params3,
      price: params4,
    })
  },
}
