PUBLISH_VERSION=$(shell echo ${NEW_VERSION} | sed 's/inner-999/1/g')

us.gcr.io/rookout/saleor:2.8.1-master
build:
	docker build --tag us.gcr.io/rookout/saleor:latest --tag us.gcr.io/rookout/saleor:${PUBLISH_VERSION} .


upload-no-latest:
	gcloud auth login
	gcloud docker -a
	docker push us.gcr.io/rookout/saleor:${PUBLISH_VERSION}


upload: upload-no-latest
	@if [ ${CIRCLE_BRANCH} = "master" ]; then \
		gcloud auth login; \
		gcloud docker -a; \
		docker push us.gcr.io/rookout/saleor:latest; \
	fi

build-and-upload: build upload
