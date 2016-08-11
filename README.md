# oauth2_code
Reverse proxy for oauth2 code authorization similar to [bitly/oauth2_proxy](https://github.com/bitly/oauth2_proxy)

## Configuration

### OAuth2 Provider configured by environment variables in .env
#### google
```
```

#### github .env
```
OAUTH2_PROVIDER=github
OAUTH2_CLIENT_ID=client_id
OAUTH2_CLIENT_SECRET=client_secret
OAUTH2_SCOPE=user:email
OAUTH2_LOGIN_URL=https://github.com/login/oauth/authorize
OAUTH2_REDEEM_URL=https://github.com/login/oauth/access_token
OAUTH2_VALIDATE_URL=https://api.github.com/user
OAUTH2_CALLBACK_URL=callback_url # (e.g. http://localhost:1337/oauth2/callback)
OAUTH2_PROXY_COOKIE_SECRET=keep_it_secret
OAUTH2_PROXY_COOKIE_EXPIRE=600000
```

#### mob .env
```
OAUTH2_PROVIDER=mob
OAUTH2_CLIENT_ID=client_id
OAUTH2_CLIENT_SECRET=client_secret
OAUTH2_SCOPE=https://mob.myvnc.com/org/users
OAUTH2_LOGIN_URL=https://mob.myvnc.com/org/oauth2/authorize/
OAUTH2_REDEEM_URL=https://mob.myvnc.com/org/oauth2/token/
OAUTH2_VALIDATE_URL=https://mob.myvnc.com/org/oauth2/verify/
OAUTH2_CALLBACK_URL=callback_url # (e.g. http://localhost:1337/oauth2/callback)
OAUTH2_PROXY_COOKIE_SECRET=keep_it_secret
OAUTH2_PROXY_COOKIE_EXPIRE=600000
#OAUTH2_CA=/etc/ssl/certs/selfSignedCA.pem # optional parameters for self-signed CA only
#upstream=/tmp/upstream.coffee # optional parameters for customized proxy settings
```

### Default upstream [http-echo-server](https://github.com/watson/http-echo-server) confgiured in upstream.coffee
```
module.exports =
  target: '.*'
  xfwd: (process.env.xfwd || 'true') == 'true'
  prependPath: (process.env.prependPath || 'true') == 'true'
  ignorePath: (process.env.ignorePath || 'false') == 'true'
  router:
    '/': 'http://localhost:1338'
  apps: ->
    process.env.PORT = 1338
    require 'http-echo-server'
```

### Start oauth2 proxy
#### run as node application
1. create config files '.env' and 'upstream.coffee' if required
2. update environment variables defined in .env
3. update proxy settings defined in upstream.coffee if required
```
npm install oauth2_code -g
set -a; . .env; set +a
env PORT=80 NODE_ENV=production oauth2_code
```

#### run docker image
1. create config files '.env' and 'upstream.coffee' if required
2. update environment variables defined in .env 
3. update proxy settings defined in upstream.coffee if required
```
docker run --name oauth2_code --env-file .env -p 1337:1337 -v /path/upstream.coffee:/usr/src/app/config/env/upstream.coffee -v /etc/ssl/certs:/etc/ssl/certs -v /usr/local/share/ca-certificates:/usr/local/share/ca-certificates -d twhtanghk/oauth2_code
```

#### run by docker compose
1. create config files '.env' and 'upstream.coffee' if required
2. update environment variables defined in .env 
3. update proxy settings defined in upstream.coffee if required
4. update docker-compose.yml if required
```
docker-compose -f docker-compose.yml up
```
