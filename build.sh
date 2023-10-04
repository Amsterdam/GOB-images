export DOCKER_BUILDKIT=1
export DOCKER_HUB_USER=datapunt

gob_build () {
  DOCKER_NAME=$1
  DOCKER_PATH=$2
  DOCKER_TAG="$3"
  EXTRA_DOCKER_TAGS="$4"
  # Docker tags (and file).
  if [ -z "${DOCKER_TAG}" ]; then
    # Current default.
    DOCKER_TAG="3.9-bullseye"
    DOCKER_ARGS="--tag amsterdam/${DOCKER_NAME}:${DOCKER_TAG}"
  else
    # First tag determines Dockerfile.
    if [ "${DOCKER_TAG}" = "latest" ]; then
      DOCKER_ARGS="--tag amsterdam/${DOCKER_NAME}:${DOCKER_TAG}"
    else
      DOCKER_ARGS="--file ${DOCKER_PATH}/Dockerfile.${DOCKER_TAG} --tag amsterdam/${DOCKER_NAME}:${DOCKER_TAG}"
    fi
  fi
  docker build --build-arg BUILDKIT_INLINE_CACHE=1 --pull ${DOCKER_ARGS} ${DOCKER_PATH}
  #
  # Tag Docker image for all extra tags.
  for tag in ${EXTRA_DOCKER_TAGS}
  do
    docker image tag amsterdam/${DOCKER_NAME}:${DOCKER_TAG} amsterdam/${DOCKER_NAME}:${tag}
  done
  docker image push --all-tags amsterdam/${DOCKER_NAME}
  echo
}

# Login to Docker Hub.
docker login -u ${DOCKER_HUB_USER} -p ${DOCKER_HUB_PASSWORD}

# GOB wheelhouse.
gob_build gob_wheelhouse wheelhouse "latest" "3.9-slim-bullseye 3.9-bullseye"
gob_build gob_wheelhouse wheelhouse "3.10-bullseye" "3.10-slim-bullseye"

# GOB Base.
gob_build gob_baseimage base
gob_build gob_baseimage base "3.9-slim-bullseye"
