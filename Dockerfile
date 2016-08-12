FROM	node

ENV VERSION 0.0.6
RUN	npm install oauth2_code@${VERSION} -g
EXPOSE	1337

CMD env PORT=${PORT:-1337} NODE_ENV=production oauth2_code
