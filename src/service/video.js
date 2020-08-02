import axios from 'axios'

export default {
  async getVideoLsit() {
    return await axios.post('/api/video/list')
  },
  async uploadVideo(params) {
    return await axios.post('/api/video/add', params)
  },
  async delVideo(params) {
    return await axios.post('/api/video/del', params)
  },
}
