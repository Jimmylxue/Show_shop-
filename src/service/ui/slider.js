import axios from 'axios'

export default {
  async getSlider() {
    return await axios.get('/api/ui/slider/getSlider')
  },
  async delSlider(params) {
    return await axios.post('/api/ui/slider/delSlider', params)
  },
  async addSlider(params) {
    return await axios.post('/api/ui/slider/addSlider', params)
  },
}
