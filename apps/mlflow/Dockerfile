FROM ghcr.io/astral-sh/uv:python3.13-alpine

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

ARG VERSION

ENV UMASK="0002" \
    TZ="Etc/UTC"

USER root
WORKDIR /app

#hadolint ignore=DL3018,DL3059
RUN \
    apk add --no-cache \
        bash \
        ca-certificates \
        catatonit \
        chromaprint \
        coreutils \
        curl \
        icu-libs \
        jo \
        jq \
        libintl \
        nano \
        trurl \
        tzdata \
    && \
    uv pip install --system --no-cache "mlflow[all]==${VERSION}" \
    && rm -rf /tmp/*

COPY ./apps/mlflow/entrypoint.sh /entrypoint.sh

USER nobody:nogroup
WORKDIR /config
VOLUME ["/config"]

ENV MLFLOW_HOST=0.0.0.0

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/mlflow/mlflow"
