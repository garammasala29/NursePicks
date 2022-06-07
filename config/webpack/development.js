process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')

module.exports = environment.toWebpackConfig()
const config = environment.toWebpackConfig();
config.output.filename = "js/[name]-[hash].js"
