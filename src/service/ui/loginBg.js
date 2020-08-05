import axios from 'axios'

export default {
  async getBgList(params) {
    return await axios.get('/api/ui/loginBg/loginBg', params)
  },
  async addLoginBg(params) {
    return await axios.post('/api/ui/loginBg/add', params)
  },
  async delLoginBg(params) {
    return await axios.post('/api/ui/loginBg/del', params)
  },
}
