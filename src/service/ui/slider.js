import axios from 'axios'

export default {
  async getSlider() {
    return await axios.get('/api/slider/getSlider')
  },
}
