username ?= mrbarker
imagename ?= exercism-rust
tag ?= 0.1.2

.PHONY: clean login run
all: build

build: Dockerfile
	docker build -t $(username)/$(imagename):$(tag) -t $(username)/$(imagename) .
	touch $@

push: build
	docker push $(username)/$(imagename):$(tag)
	touch $@

login:
	DOCKER_ID_USER="$(username)" docker login

run: build
	docker run --rm -it $(username)/$(imagename):$(tag)

clean:
	rm -f build push
