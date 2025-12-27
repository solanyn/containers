# syntax=docker/dockerfile:1

ARG ALPINE_VERSION=3.22

FROM alpine:${ALPINE_VERSION} AS builder

RUN \
  apk add --no-cache \
  bash \
  ca-certificates \
  curl \
  dotnet8-sdk \
  git \
  npm \
  && \
  git clone --depth 1 --branch eros https://github.com/Whisparr/Whisparr.git /app

WORKDIR /app

RUN \
  npm ci --legacy-peer-deps && \
  npm run build && \
  dotnet publish -c Release -o /release

FROM alpine:${ALPINE_VERSION}

ENV \
  COMPlus_EnableDiagnostics=0

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

RUN \
  apk add --no-cache \
  bash \
  ca-certificates \
  catatonit \
  curl \
  icu-libs \
  jq \
  libintl \
  nano \
  sqlite-libs \
  tzdata

RUN \
  mkdir -p /app && \
  chmod -R 755 /app && \
  chown -R nobody:nogroup /app

COPY --from=builder --chown=nobody:nogroup /release /app

# Extract version from built binary (AssemblyVersion from Directory.Build.props gets expanded during build)
RUN mkdir -p /app/package_info && \
    ( /app/Whisparr --version 2>&1 || \
      strings /app/Whisparr.Core.dll | grep "^10\." | head -1 || \
      echo "eros branch" ) > /app/package_info/whisparr

USER nobody:nogroup
WORKDIR /config
VOLUME ["/config"]

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
