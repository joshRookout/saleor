PUBLISH_VERSION=$(shell echo ${NEW_VERSION} | sed 's/inner-999/1/g')

build:
	docker build --tag us.gcr.io/rookout/saleor:latest --tag us.gcr.io/rookout/saleor:${PUBLISH_VERSION} .


upload-no-latest:
	docker push us.gcr.io/rookout/saleor:${PUBLISH_VERSION}


upload: upload-no-latest
	@if [ ${CIRCLE_BRANCH} = "master" ]; then \
		docker push us.gcr.io/rookout/saleor:latest; \
	fi

build-and-upload: build upload
