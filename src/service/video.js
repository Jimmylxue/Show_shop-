import axios from 'axios'

export default {
  async getVideoLsit() {
    return await axios.post('/api/video/list')
  },
}
