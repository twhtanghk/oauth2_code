FROM	node

ENV VERSION 0.0.6
RUN	npm install oauth2_code@${VERSION} -g
EXPOSE	1337

CMD env NODE_ENV=production oauth2_code
