
build:
	docker build --force-rm --progress=plain --target=build -t micronaut-graalvm-redisson .

build_run:
	docker build --force-rm --progress=plain --target=build -t micronaut-graalvm-redisson . && docker run --name micronaut-graalvm-redisson micronaut-graalvm-redisson

run:
	docker run -p 8080:8080 --link redis-node --name micronaut-graalvm-redisson micronaut-graalvm-redisson

exec:
	docker exec -it micronaut-graalvm-redisson bash

remove:
	docker stop micronaut-graalvm-redisson && docker rm micronaut-graalvm-redisson

stop:
	docker stop micronaut-graalvm-redisson