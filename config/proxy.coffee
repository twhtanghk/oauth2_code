if not ('target' of process.env)
  throw new Error "process.env.target not yet defined"

module.exports =
  proxy:
    target: '.*'
    xfwd: process.env.xfwd == 'true'
    prependPath: process.env.prependPath == 'true'
    ignorePath: process.env.ignorePath == 'true'
    router: 
      '/': process.env.target
