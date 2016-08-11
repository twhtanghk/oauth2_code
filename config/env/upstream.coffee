module.exports =
  target: '.*'
  xfwd: (process.env.xfwd || 'true') == 'true'
  prependPath: (process.env.prependPath || 'true') == 'true'
  ignorePath: (process.env.ignorePath || 'false') == 'true'
  router: 
    '/': 'http://localhost:1338'
  apps: ->
    process.env.PORT = 1338
    require 'http-echo-server'
