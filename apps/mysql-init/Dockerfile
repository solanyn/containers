FROM docker.io/library/alpine:3.22

ARG TARGETPLATFORM
ARG VERSION
ARG CHANNEL

USER root
WORKDIR /app

RUN \
  apk add --no-cache \
  bash \
  ca-certificates \
  catatonit \
  mariadb-client~"${VERSION}"

COPY entrypoint.sh /entrypoint.sh

USER nobody:nogroup

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/mysql/mysql"
