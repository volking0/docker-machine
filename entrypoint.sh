#!/bin/bash
mkdir certs
openssl req -newkey rsa:4096 -nodes -sha256 -keyout certs/dockerrepo.key -x509 -days 365 -out certs/dockerrepo.crt -subj /CN=local-registry
docker-machine create --driver=none --url=tcp://${DOCKER_MACHINE_URL}:${DOCKER_MACHINE_PORT} ${DOCKER_MACHINE_NAME}

eval "$(docker-machine env ${DOCKER_MACHINE_NAME} --shell ash)"

exec "$@"
