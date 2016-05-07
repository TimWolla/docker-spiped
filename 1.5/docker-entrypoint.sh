#!/bin/sh
set -e

if [ ! -z "$(echo x$1 |awk '/^x-/')" ]; then
	set -- spiped -k /spiped/key -F "$@"
fi

exec "$@"
