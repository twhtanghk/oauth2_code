# oauth2_code
Reverse proxy for oauth2 code authorization similar to [bitly/oauth2_proxy](https://github.com/bitly/oauth2_proxy)

## Configuration

### OAuth2 Provider 
#### configured by environment variables in .env
1. update environment variables in [.env](https://github.com/twhtanghk/oauth2_code/blob/master/mob.env)

#### pre-defined providers
1. [google.env](https://github.com/twhtanghk/oauth2_code/blob/master/google.env)
2. [github.env](https://github.com/twhtanghk/oauth2_code/blob/master/github.env)
3. [mob.env](https://github.com/twhtanghk/oauth2_code/blob/master/mob.env)

#### add other provider
1. extend api/services/provider class in config/env/other.coffee
2. customize the method validate, token, user, afterAuth
3. define other.env with default environment variables

### Default upstream [sails_proxy](https://github.com/twhtanghk/sails_proxy) confgiured in [upstream.coffee](https://github.com/twhtanghk/oauth2_code/blob/master/config/env/upstream.coffee)

### Start oauth2 proxy
#### run as node application
1. create config files '.env'
2. update environment variables defined in .env
```
npm install oauth2_code -g
set -a; . .env; set +a
env PORT=80 NODE_ENV=production oauth2_code
```

#### run docker image
1. create config files '.env' if required
2. update environment variables defined in .env 
```
docker run --name oauth2_code -e "NODE_ENV=production" --env-file .env -p 1337:1337 -v /etc/ssl/certs:/etc/ssl/certs -v /usr/local/share/ca-certificates:/usr/local/share/ca-certificates -d twhtanghk/oauth2_code
```

#### run by docker compose (preferred way to start required services (mongo, echo, sails_proxy, oauth2_code)
1. create config files '.env' if required
2. update environment variables defined in .env 
4. update docker-compose.yml if required
```
docker-compose -f docker-compose.yml up
```
