import axios from 'axios'

export default {
  async getSlider() {
    return await axios.get('/api/slider/getSlider')
  },
  async delSlider(params) {
    return await axios.post('/api/slider/delSlider', params)
  },
  async addSlider(params) {
    return await axios.post('/api/slider/addSlider', params)
  },
}
