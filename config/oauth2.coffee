[
  'OAUTH2_PROVIDER'
  'OAUTH2_CLIENT_ID'
  'OAUTH2_CLIENT_SECRET'
  'OAUTH2_SCOPE'
  'OAUTH2_LOGIN_URL'
  'OAUTH2_REDEEM_URL'
  'OAUTH2_VALIDATE_URL'
  'OAUTH2_CALLBACK_URL'
].map (name) ->
  if not (name of process.env)
    throw new Error "process.env.#{name} not yet defined"

module.exports =
  oauth2:
    provider: ->
      require("./env/#{process.env.OAUTH2_PROVIDER}")()
    OAUTH2_CLIENT_ID: process.env.OAUTH2_CLIENT_ID
    OAUTH2_CLIENT_SECRET: process.env.OAUTH2_CLIENT_SECRET
    OAUTH2_SCOPE: process.env.OAUTH2_SCOPE
    OAUTH2_LOGIN_URL: process.env.OAUTH2_LOGIN_URL
    OAUTH2_REDEEM_URL: process.env.OAUTH2_REDEEM_URL
    OAUTH2_VALIDATE_URL: process.env.OAUTH2_VALIDATE_URL
    OAUTH2_CALLBACK_URL: process.env.OAUTH2_CALLBACK_URL
