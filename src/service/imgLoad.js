import axios from 'axios'

export default {
  async getDir() {
    return axios.get('/api/img_plugin/getDir')
  },
  async getImgs(params) {
    return axios.post('/api/img_plugin/getImgs', params)
  },
  async upLoadImgs(params) {
    return axios.post('/api/img_plugin/uploadImgs', params)
  },
  async delImg(params) {
    return axios.post('/api/img_plugin/delImg', params)
  },
}
