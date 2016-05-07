all: image_1.5 image_1.5-alpine

image_1.5:
	docker build -t timwolla/spiped:1.5 1.5

image_1.5-alpine:
	docker build -t timwolla/spiped:1.5-alpine 1.5/alpine

keyfile:
	dd if=/dev/urandom bs=32 count=1 of=keyfile

.PHONY: image_1.5 image_1.5-alpine
