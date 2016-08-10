# oauth2_code
Reverse proxy for oauth2 code authorization similar to bitly/oauth2_proxy

## Configuration

### OAuth2 Provider configured by environment variables defined in .env
#### google
```
```

#### github
```
```

#### mob
```
OAUTH2_PROVIDER=mob
OAUTH2_CLIENT_ID=client id
OAUTH2_CLIENT_SECRET=client secret
OAUTH2_SCOPE=https://mob.myvnc.com/org/users
OAUTH2_LOGIN_URL=https://mob.myvnc.com/org/oauth2/authorize/
OAUTH2_REDEEM_URL=https://mob.myvnc.com/org/oauth2/token/
OAUTH2_VALIDATE_URL=https://mob.myvnc.com/org/oauth2/verify/
OAUTH2_CALLBACK_URL=callback url (e.g. http://localhost:1337/oauth2/callback)
OAUTH2_PROXY_COOKIE_SECRET=keep it secret
OAUTH2_PROXY_COOKIE_EXPIRE=600000
OAUTH2_CA=/etc/ssl/certs/selfSignedCA.pem
```

### Upstream servers confgiured by config/env/upstream.coffee
```
module.exports =
  '/app1': 'http://localhost:1338'
  '/app2': 'http://localhost:1339'
```

### Upstream proxy path handling configured by config/production.coffee (optional)
Defaults to ignore prefix for single path application (e.g. /app1 defined above)
```
  proxy:
    target: '.*'
    xfwd: true
    prependPath: false
    ignorePath: true
```

### Run docker image
update environment variables defined in .env and create /path/upstream.coffee with target upstream servers
```
. .env
docker run -v /path/upstream:/usr/src/app/config/env/upstream.coffee -d twhtanghk/oauth2_code
```

or
update docker-compose.yml
```
docker-compose -f docker-compose.yml up
```
