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

### Default upstream [sails_proxy](https://github.com/twhtanghk/sails_proxy)
1. target=http://sails_proxy:1337 defined in .env

### Start oauth2 proxy
#### run by docker compose (preferred way to start required services (mongo, echo, sails_proxy, oauth2_code)
1. download config files '.env' and docker-compose.yml
2. update environment variables defined in .env 
3. update docker-compose.yml if required
```
docker-compose -f docker-compose.yml up
```
