provider = null
proxy = null

module.exports =
  http:
    middleware:
      isAuth: (req, res, next) ->
        provider ?= sails.config.oauth2.provider()
        provider.isAuth req, res
          .then (user) ->
            if user
              next()
          .catch res.serverError
      proxy: (req, res, next) ->
        proxy ?= require('http-proxy-middleware')(sails.config.proxy)
        proxy(req, res, next)
      order: [
        'cookieParser'
        'session'
        'router'
        'favicon'
        'isAuth'
        'proxy'
      ]
