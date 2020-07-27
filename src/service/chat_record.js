import axios from 'axios'

export default {
  async getChat(params) {
    return await axios.post('/api/chat/record', params)
  },
}
