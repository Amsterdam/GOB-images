#!/usr/bin/env bash

export DOCKER_BUILDKIT=1
export DOCKER_HUB_USER=datapunt

gob_build () {
  DOCKER_NAME=$1
  DOCKER_PATH=$2
  DOCKER_TAG="${3:-3.9-buster}"
  docker build --build-arg BUILDKIT_INLINE_CACHE=1 --pull --tag amsterdam/${DOCKER_NAME}:${DOCKER_TAG} ${DOCKER_PATH}
  docker push amsterdam/${DOCKER_NAME}:${DOCKER_TAG}
}

docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASSWORD}

# GOB Base.
gob_build gob_baseimage base

# GOB wheelhouse.
gob_build gob_wheelhouse wheelhouse
