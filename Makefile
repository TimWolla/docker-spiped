all: image

image:
	docker build -t timwolla/spiped .

keyfile:
	dd if=/dev/urandom bs=32 count=1 of=keyfile

.PHONY: image
