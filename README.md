# oauth2_code
Reverse proxy for oauth2 code authorization similar to [bitly/oauth2_proxy](https://github.com/bitly/oauth2_proxy)

## Configuration

### OAuth2 Provider configured by environment variables in .env
#### available providers
1. [google.env](https://github.com/twhtanghk/oauth2_code/blob/master/google.env)
2. [github.env](https://github.com/twhtanghk/oauth2_code/blob/master/github.env)
3. [mob.env](https://github.com/twhtanghk/oauth2_code/blob/master/mob.env)

#### add other provider
1. extend api/services/provider class in config/env/other.coffee
2. customize the method validate, token, user, afterAuth
3. define other.env with default environment variables

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
