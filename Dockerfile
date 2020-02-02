FROM alpine:latest

LABEL description="This is a Concourse combined Docker image for pipeline operations."

ENV BOSH_VERSION=6.2.0 \
    CF_VERSION=6.49.0 \
    PACK_VERSION=0.8.1

RUN set -x && \
    apk update && \
    apk add curl jq bash findutils && \
    curl -Lo /usr/local/bin/bosh https://github.com/cloudfoundry/bosh-cli/releases/download/v${BOSH_VERSION}/bosh-cli-${BOSH_VERSION}-linux-amd64 && \
    curl -Lo /tmp/cf.tgz "https://packages.cloudfoundry.org/stable?release=linux64-binary&version=${CF_VERSION}&source=github-rel" && \
    tar xzf /tmp/cf.tgz -C /usr/local/bin cf && \
    curl -Lo /tmp/pack.tgz https://github.com/buildpacks/pack/releases/download/v${PACK_VERSION}/pack-v${PACK_VERSION}-linux.tgz && \
    tar xzf /tmp/pack.tgz -C /usr/local/bin pack && \
    chmod +x /usr/local/bin/* && \
    rm -rf /tmp/*
