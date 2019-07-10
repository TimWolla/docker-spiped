FROM debian:buster-slim

RUN	groupadd -r spiped \
&&	useradd -r -g spiped spiped

RUN	DEBIAN_FRONTEND="noninteractive" \
&&	set -x \
&&	apt-get update \
&&	apt-get install -y libssl1.1 --no-install-recommends \
&&	rm -rf /var/lib/apt/lists/*

ENV SPIPED_VERSION 1.6.0
ENV SPIPED_DOWNLOAD_URL https://www.tarsnap.com/spiped/spiped-1.6.0.tgz
ENV SPIPED_DOWNLOAD_SHA256 e6f7f8f912172c3ad55638af8346ae7c4ecaa92aed6d3fb60f2bda4359cba1e4

RUN	DEBIAN_FRONTEND="noninteractive" \
&&	set -x \
&&	buildDeps='libssl-dev libc-dev gcc make curl ca-certificates' \
&&	apt-get update && apt-get install -y $buildDeps --no-install-recommends \
&&	rm -rf /var/lib/apt/lists/* \
&&	curl -fsSL "$SPIPED_DOWNLOAD_URL" -o spiped.tar.gz \
&&	echo "$SPIPED_DOWNLOAD_SHA256 spiped.tar.gz" |sha256sum -c - \
&&	mkdir -p /usr/local/src/spiped \
&&	tar xzf "spiped.tar.gz" -C /usr/local/src/spiped --strip-components=1 \
&&	rm "spiped.tar.gz" \
&&	make -C /usr/local/src/spiped \
&&	make -C /usr/local/src/spiped install \
&&	rm -rf /usr/local/src/spiped \
&&	apt-get purge -y --auto-remove $buildDeps

VOLUME /spiped
WORKDIR /spiped

COPY *.sh /usr/local/bin/
ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["spiped"]
