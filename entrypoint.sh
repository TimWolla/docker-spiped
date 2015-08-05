#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	set -- spiped -k /spiped/key -F "$@"
fi

exec "$@"
