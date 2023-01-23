NPMRC_CONTENT=`cat .npmrc`
BUILD_ARGS = 

ifdef NPMRC_CONTENT
BUILD_ARGS := ${BUILD_ARGS} --build-arg NPMRC_CONTENT="${NPMRC_CONTENT}"
endif

SERVICE = $(shell grep SERVICE MANIFEST | cut -d '=' -f2)
VERSION = $(shell grep VERSION MANIFEST | cut -d '=' -f2)

build:
	docker build -t ${SERVICE}:${VERSION} ${BUILD_ARGS} .

run:
	docker run --rm -d ${SERVICE}:${VERSION}