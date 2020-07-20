import axios from 'axios'

export default {
  async getFunctions() {
    return await axios.get('/api/ui/function/mode')
  },
  async changeFunctionStatus(params) {
    return await axios.post('/api/ui/function/edit', params)
  },
  async addFunction(params) {
    return await axios.post('/api/ui/function/add', params)
  },
  async delFunction(params) {
    return await axios.post('/api/ui/function/del', params)
  },
}
