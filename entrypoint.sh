#!/bin/sh

# docker/docker#7086
trap "exit" 2 3 9 15

spiped -k /spiped/key -F $@
