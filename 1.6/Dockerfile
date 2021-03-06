FROM debian:buster-slim

RUN	groupadd -r spiped \
&&	useradd -r -g spiped spiped

RUN	export DEBIAN_FRONTEND="noninteractive" \
&&	set -x \
&&	apt-get update \
&&	apt-get install -y libssl1.1 --no-install-recommends \
&&	rm -rf /var/lib/apt/lists/*

ENV SPIPED_VERSION=1.6.1 SPIPED_DOWNLOAD_SHA256=8d7089979db79a531a0ecc507b113ac6f2cf5f19305571eff1d3413e0ab33713

RUN	export DEBIAN_FRONTEND="noninteractive" \
&&	set -x \
&&	buildDeps='libssl-dev libc-dev gcc make curl ca-certificates' \
&&	apt-get update \
&&	apt-get install -y $buildDeps --no-install-recommends \
&&	rm -rf /var/lib/apt/lists/* \
&&	curl -fsSL "https://www.tarsnap.com/spiped/spiped-$SPIPED_VERSION.tgz" -o spiped.tar.gz \
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
