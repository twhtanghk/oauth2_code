###
see environment variables defined in .env
###
module.exports =
  oauth2:
    provider: ->
      require("./#{process.env.OAUTH2_PROVIDER}")()
    OAUTH2_CLIENT_ID: process.env.OAUTH2_CLIENT_ID
    OAUTH2_CLIENT_SECRET: process.env.OAUTH2_CLIENT_SECRET
    OAUTH2_SCOPE: process.env.OAUTH2_SCOPE
    OAUTH2_LOGIN_URL: process.env.OAUTH2_LOGIN_URL
    OAUTH2_REDEEM_URL: process.env.OAUTH2_REDEEM_URL
    OAUTH2_VALIDATE_URL: process.env.OAUTH2_VALIDATE_URL
    OAUTH2_CALLBACK_URL: process.env.OAUTH2_CALLBACK_URL
  session:
    secret: process.env.OAUTH2_PROXY_COOKIE_SECRET
    cookie:
      maxAge: parseInt process.env.OAUTH2_PROXY_COOKIE_EXPIRE || '600000', 10
      httpOnly: true
      secure: false  # assume front end (nginx) directly connected to this app
  proxy: require process.env.upstream || './upstream.coffee'
  log:
    level: 'silly'
  bootstrap: (cb) ->
    # add self signed ca if defined
    CA = process.env.OAUTH2_CA
    if CA
      require 'ssl-root-cas'
        .inject()
        .addFile CA

    # if apps defined, start upstream servers after server started
    sails.on 'lifted', ->
      if sails.config.proxy.apps
        sails.config.proxy.apps()

    cb()
