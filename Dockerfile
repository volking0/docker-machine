FROM docker:dind

RUN apk update && \
    apk add --no-cache bash docker curl openssh-client \
    py3-pip docker-cli python3 py-pip python3-dev libffi-dev \
    openssl-dev gcc libc-dev rust cargo make && \
    pip3 install docker-compose awscli && aws --version

RUN DOWNLOAD_URL=$(curl -s https://api.github.com/repos/docker/machine/releases | grep browser_download_url | cut -d '"' -f 4 | grep -m 1 docker-machine-`uname -s`-`uname -m`) \
    && curl -L $DOWNLOAD_URL > /usr/bin/docker-machine \
    && chmod +x /usr/bin/docker-machine \
    && docker-machine --version

COPY entrypoint.sh /
RUN ["chmod", "+x", "/entrypoint.sh"]
ENV DOCKER_MACHINE_NAME=default
ENV DOCKER_MACHINE_PORT=2376
ENTRYPOINT ["/entrypoint.sh"]
