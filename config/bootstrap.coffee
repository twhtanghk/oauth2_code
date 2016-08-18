module.exports =
  bootstrap: (cb) ->
    # add self signed ca if defined
    CA = process.env.OAUTH2_CA
    if CA
      require 'ssl-root-cas'
        .inject()
        .addFile CA

    sails.log.info _.pick(sails.config, 'oauth2', 'proxy', 'email', 'session')

    cb()
