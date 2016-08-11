# oauth2_code
Reverse proxy for oauth2 code authorization similar to bitly/oauth2_proxy

## Configuration

### OAuth2 Provider configured by environment variables in .env
#### google
```
```

#### github
```
```

#### mob
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

### Default upstream servers confgiured in upstream.coffee
```
module.exports =
  target: '.*'
  xfwd: (process.env.xfwd || 'true') == 'true'
  prependPath: (process.env.prependPath || 'false') == 'true'
  ignorePath: (process.env.ignorePath || 'true') == 'true'
  router:
    '/': 'http://localhost:1338'
```

### Start oauth2 proxy
#### run as node application
1. create config files '.env' and 'upstream.coffee'
2. update environment variables defined in .env
3. update proxy settings defined in upstream.coffee if required
```
npm install oauth2_code -g
set -a; . .env; set +a
env PORT=80 NODE_ENV=production oauth2_code
```

#### run docker image
update environment variables defined in .env and create /path/upstream.coffee with target upstream servers
```
docker run --env-file .env -v /path/upstream.coffee:/usr/src/app/config/env/upstream.coffee -v /etc/ssl/certs:/etc/ssl/certs -v /usr/local/share/ca-certificates:/usr/local/share/ca-certificates -d twhtanghk/oauth2_code
```

#### run by docker compose
update docker-compose.yml
```
docker-compose -f docker-compose.yml up
```
