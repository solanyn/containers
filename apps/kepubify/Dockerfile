FROM docker.io/library/alpine:3.22

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETOS

ARG VERSION

USER root
WORKDIR /app

#hadolint ignore=DL3018,DL3013
RUN \
    apk add --no-cache \
        bash \
        ca-certificates \
        curl \
    && case "${TARGETPLATFORM}" in \
        'linux/amd64') export ARCH='64bit' ;; \
        'linux/arm64') export ARCH='arm64' ;; \
    esac \
    && mkdir -p /apps \
    && curl -o \
        /app/kepubify -L \
        "https://github.com/pgaskin/kepubify/releases/download/v${VERSION}/kepubify-linux-${ARCH}" \
    && chmod -R 755 /app

ENTRYPOINT [ "/app/kepubify" ]

LABEL org.opencontainers.image.source="https://github.com/pgaskin/kepubify"
