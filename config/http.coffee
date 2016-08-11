_ = require 'lodash'
proxy = null

module.exports =
  http:
    middleware:
      isAuth: (req, res, next) ->
        sails.config.oauth2.provider()
          .isAuth req, res
          .then (user) ->
            if user
              next()
          .catch res.serverError
      proxy: (req, res, next) ->
        # check if url matched any path defined in sails.config.proxy.router
        matched = _.some _.keys(sails.config.proxy.router), (pattern) ->
          new RegExp "^#{pattern}"
            .test req.url
        if matched
          proxy ?= require('http-proxy-middleware')(sails.config.proxy)
          proxy(req, res, next)
        else
          next()
      order: [
        'cookieParser'
        'session'
        'router'
        'isAuth'
        'proxy'
        'favicon'
        '404'
        '500'
      ]
