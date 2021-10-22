.PHONY: docker-test docker-shards-install docker-format


docker-setup:
	docker build -t collectd-unixsocket.cr .

docker-format:
	docker run --rm -ti -v "$(PWD):/app" -w /app collectd-unixsocket.cr crystal tool format src

docker-shards-install:
	docker run --rm -ti -v "$(PWD):/app" -w /app collectd-unixsocket.cr shards install

docker-test:
	docker run --rm -ti -v "$(PWD):/app" -w /app collectd-unixsocket.cr crystal spec

docker-test-integration:
	docker run --rm -ti -v "$(PWD):/app" -w /app collectd-unixsocket.cr crystal spec spec_integration
