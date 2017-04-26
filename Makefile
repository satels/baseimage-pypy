IMAGE_NAME = jeethu/baseimage-pypy
IMAGE_VERSION = 0.9.21-5.7.1

docker:
	docker build -t $(IMAGE_NAME):$(IMAGE_VERSION) .
