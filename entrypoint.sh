#!/bin/bash
set -e

if [ "${1:0:1}" = '-' ]; then
	spiped -k /spiped/key -F $@ &

	# docker/docker#7086
	trap "kill -TERM $!;" SIGTERM
	trap "kill -INT $!;" SIGINT

	wait $!
	exit $?
fi

exec "$@"
