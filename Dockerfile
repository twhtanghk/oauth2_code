FROM	node

ENV VERSION 0.0.7
RUN	npm install oauth2_code@${VERSION} -g
EXPOSE	1337

CMD oauth2_code
