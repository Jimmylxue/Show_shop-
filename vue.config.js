const path = require('path')
function resolve(dir) {
  return path.join(__dirname, dir)
}

module.exports = {
  lintOnSave: true,
  chainWebpack: config => {
    config.resolve.alias.set('@$', resolve('src'))
  },
  publicPath: '/',
  devServer: {
    port: 7070,
    host: '127.0.0.1',
    proxy: {
      '/api': {
        target: 'http://127.0.0.1:666',
        changeOrigin: true,
        // ws: true,
        secure: true,
        pathRewrite: {
          '^/api': '/',
        },
      },
    },
  },
}
