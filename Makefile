.PHONY: default build dependencies image

default: build

build:
	CGO_ENABLED=0 go build -a --installsuffix cgo --ldflags="-s" -o whoami

dependencies:
	dep ensure -v

image:
	docker build --target single -t eugenmayer/whoami .
	docker tag eugenmayer/whoami eugenmayer/whoami:single
	docker build --target multiple -t eugenmayer/whoami:multiple .

push:
	docker push	eugenmayer/whoami