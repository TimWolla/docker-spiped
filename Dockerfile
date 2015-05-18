FROM debian:jessie
MAINTAINER Tim Düsterhus

ENV SPIPED_VERSION 1.5.0
ENV SPIPED_DOWNLOAD_URL https://www.tarsnap.com/spiped/spiped-1.5.0.tgz
ENV SPIPED_DOWNLOAD_SHA256 b2f74b34fb62fd37d6e2bfc969a209c039b88847e853a49e91768dec625facd7

RUN	buildDeps='libssl-dev gcc make curl ca-certificates' \
&&	apt-get update && apt-get install -y $buildDeps --no-install-recommends \
&&	rm -rf /var/lib/apt/lists/* \
&&	curl -fsSL "$SPIPED_DOWNLOAD_URL" -o spiped.tar.gz \
&&	echo "$SPIPED_DOWNLOAD_SHA256 spiped.tar.gz" |sha256sum -c - \
&&	mkdir -p /usr/local/src/spiped \
&&	tar xvf "spiped.tar.gz" -C /usr/local/src/spiped --strip-components=1 \
&&	rm "spiped.tar.gz" \
&&	make -C /usr/local/src/spiped \
&&	make -C /usr/local/src/spiped install \
&&	rm -rf /usr/local/src/spiped \
&&	apt-get purge -y --auto-remove $buildDeps

RUN	apt-get update \
&&	apt-get install -y libssl1.0.0 --no-install-recommends \
&&	rm -rf /var/lib/apt/lists/*

VOLUME /spiped
WORKDIR /spiped

COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

