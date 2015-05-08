FROM buildpack-deps:jessie

ENV SPIPED_VERSION 1.5.0
ENV SPIPED_SHA256_SUM b2f74b34fb62fd37d6e2bfc969a209c039b88847e853a49e91768dec625facd7

RUN	curl -SLO "https://www.tarsnap.com/spiped/spiped-$SPIPED_VERSION.tgz" \
&&	echo "$SPIPED_SHA256_SUM spiped-$SPIPED_VERSION.tgz" |sha256sum -c - \
&&	mkdir /usr/local/src/spiped \
&&	tar xvf "spiped-$SPIPED_VERSION.tgz" -C /usr/local/src/spiped --strip-components=1 \
&&	rm "spiped-$SPIPED_VERSION.tgz" \
&&	cd /usr/local/src/spiped \
&&	make \
&&	make install \
&&	cd / \
&&	rm -rf /usr/local/src/spiped

ADD entrypoint.sh /entrypoint.sh

ENTRYPOINT [ "/entrypoint.sh" ]

VOLUME /spiped/
