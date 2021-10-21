.PHONY: docker-test docker-shards-install docker-format

docker-format:
	docker run --rm -ti -v "$(PWD):/app" -w /app crystallang/crystal:1.2.1-alpine crystal tool format src

docker-shards-install:
	docker run --rm -ti -v "$(PWD):/app" -w /app crystallang/crystal:1.2.1-alpine shards install

docker-test:
	docker run --rm -ti -v "$(PWD):/app" -w /app crystallang/crystal:1.2.1-alpine crystal spec

