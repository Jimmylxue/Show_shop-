const path = require('path')
function resolve(dir) {
  return path.join(__dirname, dir)
}

module.exports = {
  lintOnSave: false,
  chainWebpack: (config) => {
    config.resolve.alias.set('@$', resolve('src'))
  },
  publicPath: '/',
  devServer: {
    port: 7070,
    proxy: {
      '/api': {
        target: 'http://localhost:666',
        changeOrigin: true,
        ws: true,
        secure: true,
        pathRewrite: {
          '^/api': '/',
        },
      },
    },
  },
}
