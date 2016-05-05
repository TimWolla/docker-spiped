FROM debian:jessie
MAINTAINER Tim Düsterhus

RUN	groupadd -r spiped \
&&	useradd -r -g spiped spiped

RUN	apt-get update \
&&	apt-get install -y libssl1.0.0 --no-install-recommends \
&&	rm -rf /var/lib/apt/lists/*

ENV SPIPED_VERSION 1.5.0
ENV SPIPED_DOWNLOAD_URL https://www.tarsnap.com/spiped/spiped-1.5.0.tgz
ENV SPIPED_DOWNLOAD_SHA256 b2f74b34fb62fd37d6e2bfc969a209c039b88847e853a49e91768dec625facd7

# https://github.com/Tarsnap/spiped/commit/af27ca8c91369837fa63053385e079ed945745b9
# Remove with spiped 1.6
COPY	0001-Fix-docker-stop-issue.patch /0001-Fix-docker-stop-issue.patch

RUN	buildDeps='libssl-dev gcc make curl ca-certificates patch' \
&&	apt-get update && apt-get install -y $buildDeps --no-install-recommends \
&&	rm -rf /var/lib/apt/lists/* \
&&	curl -fsSL "$SPIPED_DOWNLOAD_URL" -o spiped.tar.gz \
&&	echo "$SPIPED_DOWNLOAD_SHA256 spiped.tar.gz" |sha256sum -c - \
&&	mkdir -p /usr/local/src/spiped \
&&	tar xvf "spiped.tar.gz" -C /usr/local/src/spiped --strip-components=1 \
&&	rm "spiped.tar.gz" \
&&	patch -p1 -d /usr/local/src/spiped/ < /0001-Fix-docker-stop-issue.patch \
&&	make -C /usr/local/src/spiped \
&&	make -C /usr/local/src/spiped install \
&&	rm -rf /usr/local/src/spiped \
&&	apt-get purge -y --auto-remove $buildDeps

VOLUME /spiped
WORKDIR /spiped

COPY docker-entrypoint.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["spiped"]
