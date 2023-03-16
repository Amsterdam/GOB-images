#!/usr/bin/env bash

export DOCKER_BUILDKIT=1
export DOCKER_HUB_USER=datapunt

gob_build () {
  DOCKER_NAME=$1
  DOCKER_PATH=$2
  # Docker tags (and file).
  if [ -z "${3}" ]; then
    # Current default.
    DOCKER_TAGS="3.9-bullseye"
    DOCKER_ARGS="--tag amsterdam/${DOCKER_NAME}:3.9-bullseye"
  else
    DOCKER_TAGS=""
    for tag in ${@: 2-$#}
    do
      # First tag determines Dockerfile.
      if [ -z "${DOCKER_TAGS}" ]; then
        DOCKER_TAGS="${tag}"
        DOCKER_ARGS="--file Dockerfile.${tag} --tag amsterdam/${DOCKER_NAME}:${tag}"
      else
        DOCKER_TAGS="${DOCKER_TAGS} ${tag}"
        DOCKER_ARGS="${DOCKER_ARGS} --tag amsterdam/${DOCKER_NAME}:${tag}"
      fi
    done
  fi
  docker build --build-arg BUILDKIT_INLINE_CACHE=1 --pull ${DOCKER_ARGS} ${DOCKER_PATH}
  #
  # Push Docker image for each tags.
  for tag in ${DOCKER_TAGS}
  do
    docker push amsterdam/${DOCKER_NAME}:${tag}
  done
  echo
}

# Login to Docker Hub.
docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASSWORD}

# GOB Base.
gob_build gob_baseimage base

# GOB wheelhouse.
gob_build gob_wheelhouse wheelhouse
