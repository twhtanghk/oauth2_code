FROM	node

ENV VERSION master
WORKDIR	/usr/src/app
ADD	https://github.com/twhtanghk/oauth2_code/archive/${VERSION}.tar.gz /tmp
RUN	tar --strip-components=1 -xzf /tmp/${VERSION}.tar.gz && \
	rm /tmp/${VERSION}.tar.gz && \
	apt-get update && \
	apt-get install -y git && \
	apt-get clean && \
	npm install
EXPOSE	1337

CMD node app.js --prod
