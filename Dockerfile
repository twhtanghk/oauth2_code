FROM	node

ENV VERSION 0.0.8
RUN	npm install oauth2_code@${VERSION} -g
EXPOSE	1337

CMD oauth2_code
