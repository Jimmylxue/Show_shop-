import axios from 'axios'

export default {
  async getMsg() {
    return await axios.get('/api/admin/data/all')
  },
}
