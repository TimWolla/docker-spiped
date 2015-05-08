spiped
======

How to use this image
---------------------

A detailed explanation of [spiped](https://www.tarsnap.com/spiped.html) can be found on the official homepage. This image automatically takes the key from the `/spiped/key` file and runs spiped in foreground.

Running spiped to take encrypted connections on port 8025 and forward them to port 25 on localhost looks like this:

```
docker run -d -v /keyfile:/spiped/key:ro -p 8025:8025 timwolla/spiped -e -s '[0.0.0.0]:8025' -t '[127.0.0.1]:25'
```
