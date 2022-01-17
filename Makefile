.PHONY: build
build: build-native-platform

.PHONY: build-native-platform
build-native-platform:
	docker build \
	--tag localhost/apache-centos-8:latest .

.PHONY: build-all-platforms
build-all-platforms:
	docker buildx build --progress plain \
	--tag localhost/apache-centos-8:latest \
	--platform linux/amd64,linux/arm64 .
	# TODO: make linux/arm/v7 architecture available when possible
	# --platform linux/amd64,linux/arm/v7,linux/arm64 .

.PHONY: test
test:
	bash ./tests/run-tests.sh
