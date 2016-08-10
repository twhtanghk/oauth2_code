_ = require 'lodash'
uuid = require 'node-uuid'
url = require 'url'
Promise = require 'bluebird'
http = Promise.promisifyAll require 'needle'

class Provider
  constructor: (opts = sails.config.oauth2) ->
    _.extend @,
      _.pick opts, [
        'OAUTH2_CLIENT_ID'
        'OAUTH2_CLIENT_SECRET'
        'OAUTH2_SCOPE'
        'OAUTH2_LOGIN_URL'
        'OAUTH2_REDEEM_URL'
        'OAUTH2_VALIDATE_URL'
        'OAUTH2_CALLBACK_URL'
      ]

  # promise to return authenticated user or null if forwarded to oauth2 provider
  isAuth: (req, res) ->
    path = url.parse(req.url).pathname
    switch true
      when path == '/oauth2/sign_in'
        req.session.user = null
        req.session.nextUrl = '/'
        @login req, res
      when path == '/oauth2/start'
        req.session.nextUrl = req.url
        @login req, res
      when path == '/oauth2/callback'
        @redeem req, res
      else
        # forward to upstream
        req.session.nextUrl = req.url
        @login req, res
          .then (user) =>
            if user
              @afterAuth req
            user

  # promise to return current login user or null if forwarded to oauth2 provider
  login: (req, res) ->
    user = req.session.user
    if user
      return Promise.resolve user
    req.session.state = uuid()
    path = _.extend url.parse(@OAUTH2_LOGIN_URL),
      query:
        response_type: 'code'
        client_id: @OAUTH2_CLIENT_ID
        redirect_uri: @OAUTH2_CALLBACK_URL
        scope: @OAUTH2_SCOPE
        state: req.session.state
    res.redirect url.format path
    Promise.resolve()

  # promise to redirect to nextUrl when user starts authentication from if
  #  1. success in making token request
  #  2. success in verifying user
  #  3. redirect ot nextUrl
  redeem: (req, res) ->
    if req.query.state != req.session.state
      return Promise.reject 'oauth2 state mismatch'
    data =
      grant_type: 'authorization_code'
      code: req.query.code
      redirect_uri: @OAUTH2_CALLBACK_URL
      client_id: @OAUTH2_CLIENT_ID
    http
      .postAsync @OAUTH2_REDEEM_URL, data,
        username: @OAUTH2_CLIENT_ID
        password: @OAUTH2_CLIENT_SECRET
      .then @token
      .then @validate
      .then (user) ->
        req.session.user = user
        res.redirect req.session.nextUrl

  # promise to return user by verifying token via oauth2 provider
  validate: (token) =>
    http
      .getAsync @OAUTH2_VALIDATE_URL,
        headers:
          Authorization: "Bearer #{token}"
      .then @user
      .then (user) ->
        _.extend user, token: token

  # provider specific method to get token from oauth2 provider response
  token: (res) ->
    if res.body.error
      return Promise.reject res.body.error
    res.body.access_token

  # provider specific method to get user details (name, email, url) from oauth2 provider response
  user: (res) ->
    if res.body.error
      return Promise.reject res.body.error
    res.body.user

  # customized method to pass user details fter user authenticated
  afterAuth: (req) ->
    req.headers['X-Forwarded-User'] = req.session.user.username
    req.headers['X-Forwarded-Email'] = req.session.user.email
    req.headers['X-Forwarded-Access-Token'] = req.session.user.token
   
module.exports = Provider
