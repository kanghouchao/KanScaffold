test:
	docker buildx build --target test .

build:
	docker buildx build --target build --tag kan-scaffold:0.0.1 .
