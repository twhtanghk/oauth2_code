module.exports =
  target: '.*'
  xfwd: (process.env.xfwd || 'true') == 'true'
  prependPath: (process.env.prependPath || 'true') == 'true'
  ignorePath: (process.env.ignorePath || 'false') == 'true'
  router: 
    '/': "http://localhost:#{sails.config.PORT++}"
  apps: ->
    require 'http-echo-server'
