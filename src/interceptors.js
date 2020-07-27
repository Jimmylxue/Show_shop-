import axios from 'axios'

export default vm => {
  axios.interceptors.request.use(config => {
    console.log(1, 'nonode')
    const token = localStorage.getItem('token')
    if (token) {
      console.log('two', 9999)
      config.headers.Authorization = 'Bearer ' + token
    }
    return config
  })

  axios.interceptors.response.use(null, err => {
    if (err.response.status === 401) {
      vm.$router.push('/login')
    }
    return Promise.reject(err)
  })
}
