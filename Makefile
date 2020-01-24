ifndef PY
PY=3.7
endif

.PHONY: build
build:
	@for version in ${PY} ; do \
		echo "Building $$version" ; \
		DOCKER_BUILDKIT=1 docker build --build-arg PYTHON_VERSION=$$version . --tag smileychris/pywatchman:$$version ; \
	done