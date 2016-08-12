# oauth2_code
Reverse proxy for oauth2 code authorization similar to [bitly/oauth2_proxy](https://github.com/bitly/oauth2_proxy)

## Configuration

### OAuth2 Provider configured by environment variables in .env
#### environment variables
```
# mandatory environment variables
PORT: port to start oauth2_code proxy server
OAUTH2_PROVIDER: OAuth2 proivder name
OAUTH2_CLIENT_ID: OAuth2 client id
OAUTH2_CLIENT_SECRET: OAuth2 client secret
OAUTH2_SCOPE: OAuth2 scope to be authorized by end user
OAUTH2_LOGIN_URL: OAuth2 provider login url
OAUTH2_REDEEM_URL: OAuth2 provider token request url
OAUTH2_VALIDATE_URL: OAuth2 user profile url
OAUTH2_CALLBACK_URL: OAuth2 callback url
# optional environment variables
OAUTH2_PROXY_COOKIE_SECRET: user specified session secret (default: auto-generated one if not defined)
OAUTH2_PROXY_COOKIE_EXPIRE: user specified session timeout (default: 600000=10min if not defined)
OAUTH2_CA: self-signed CA
xfwd: add x-forwarded header or not (default: true if not defined)
prependPath: keep context path or not (default: true if not defined)
ignorePath: ignore context path or not (default: false if not defined)
upstream: path of customized upstream.coffee (default to start http-echo-server on PORT + 1 if no customized upstream defined)
```

#### pre-defined providers
1. [google.env](https://github.com/twhtanghk/oauth2_code/blob/master/google.env)
2. [github.env](https://github.com/twhtanghk/oauth2_code/blob/master/github.env)
3. [mob.env](https://github.com/twhtanghk/oauth2_code/blob/master/mob.env)

#### add other provider
1. extend api/services/provider class in config/env/other.coffee
2. customize the method validate, token, user, afterAuth
3. define other.env with default environment variables

### Default upstream [http-echo-server](https://github.com/watson/http-echo-server) confgiured in [upstream.coffee](https://github.com/twhtanghk/oauth2_code/blob/master/config/env/upstream.coffee)

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
