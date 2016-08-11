Promise = require 'bluebird'

module.exports = ->
  Provider = sails.services.provider

  class Github extends Provider
    token: (res) ->
      if res.body.error
        return Promise.reject res.body.error
      res.body.access_token

    user: (res) ->
      if res.body.error
        return Promise.reject res.body.error
      res.body

    afterAuth: (req) ->
      req.headers['X-Forwarded-User'] = req.session.user.name
      req.headers['X-Forwarded-Email'] = req.session.user.email;
      return req.headers['X-Forwarded-Access-Token'] = req.session.user.token;

  new Github()
