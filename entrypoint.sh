#!/bin/bash
docker-machine create --driver=none --url=tcp://${DOCKER_MACHINE_URL}:${DOCKER_MACHINE_PORT} ${DOCKER_MACHINE_NAME}

eval "$(docker-machine env ${DOCKER_MACHINE_NAME} --shell ash)"

exec "$@"
