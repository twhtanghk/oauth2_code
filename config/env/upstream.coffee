module.exports =
  target: '.*'
  xfwd: (process.env.xfwd || 'true') == 'true'
  prependPath: (process.env.prependPath || 'false') == 'true'
  ignorePath: (process.env.ignorePath || 'true') == 'true'
  router: 
    '/': 'http://localhost:1338'
