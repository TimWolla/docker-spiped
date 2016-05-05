spiped [![Build Status](https://travis-ci.org/TimWolla/docker-spiped.svg?branch=master)](https://travis-ci.org/TimWolla/docker-spiped)
======

What is spiped?
---------------

Spiped (pronounced "ess-pipe-dee") is a utility for creating symmetrically encrypted and authenticated pipes between socket addresses, so that one may connect to one address (e.g., a UNIX socket on localhost) and transparently have a connection established to another address (e.g., a UNIX socket on a different system). This is similar to `ssh -L` functionality, but does not use SSH and requires a pre-shared symmetric key. 

> [tarsnap.com/spiped.html](https://www.tarsnap.com/spiped.html)

How to use this image
---------------------

A detailed explanation of [spiped](https://www.tarsnap.com/spiped.html) can be found on the official homepage. This image automatically takes the key from the `/spiped/key` file and runs spiped in foreground.

Running spiped to take encrypted connections on port 8025 and forward them to port 25 on localhost looks like this:

```
docker run -d -v /keyfile:/spiped/key:ro -p 8025:8025 timwolla/spiped -d -s '[0.0.0.0]:8025' -t '[127.0.0.1]:25'
```
