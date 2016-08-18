_ = require 'lodash'

_.defaults process.env,
  email: '.*'

module.exports =
  email: _.split process.env.email, ','
