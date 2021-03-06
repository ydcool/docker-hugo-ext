# Credit to Kubernetes (https://github.com/kubernetes ). This Dockerfile
# is essentially based on his Dockerfile at
# https://github.com/kubernetes/website/blob/master/Dockerfile.

FROM alpine:latest

LABEL maintainer="Dominic Yin <hi@ydcool.me>"

RUN apk add --no-cache \
    curl \
    git \
    openssh-client \
    rsync \
    build-base \
    libc6-compat \
    npm && \
    npm install -D autoprefixer postcss-cli

ARG HUGO_VERSION

RUN mkdir -p /usr/local/src && \
    cd /usr/local/src && \
    curl -L https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz | tar -xz && \
    mv hugo /usr/local/bin/hugo && \
    addgroup -Sg 1000 hugo && \
    adduser -Sg hugo -u 1000 -h /src hugo

WORKDIR /src

USER hugo:hugo

EXPOSE 1313
