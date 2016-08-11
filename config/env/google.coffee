Promise = require 'bluebird'

module.exports = ->
  Provider = sails.services.provider

  class Google extends Provider
    user: (res) ->
      if res.body.error
        return Promise.reject res.body.error
      res.body

    afterAuth: (req) ->
      req.headers['X-Forwarded-User'] = req.session.user.displayName
      req.headers['X-Forwarded-Email'] = req.session.user.emails[0].value
      return req.headers['X-Forwarded-Access-Token'] = req.session.user.token

  new Google()
