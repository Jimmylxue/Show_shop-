import axios from 'axios'

export default {
  async getGoods() {
    return await axios.get('/api/admin/good/goods')
  },
}
