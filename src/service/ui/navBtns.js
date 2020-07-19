import axios from 'axios'

export default {
  async getBnts() {
    return await axios.get('/api/ui/navBtns/Btns')
  },
  async dekBtn(params) {
    return await axios.post('/api/ui/navBtns/del', params)
  },
  async addBtns(params) {
    return await axios.post('/api/ui/navBtns/add', params)
  },
}
