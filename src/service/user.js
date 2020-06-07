import axios from 'axios'

export default {
  async getUser() {
    return await axios.get('/api/admin/user/getAll')
  },
  async update(usermsg) {
    return await axios.post('/api/admin/user/update', usermsg)
  },
  async deleteUser(msg) {
    return await axios.get(`/api/admin/user/deleteUser?id=${msg}`)
  },
  async addUser(usermsg) {
    return await axios.post('/api/admin/user/addUser', usermsg)
  },
}
