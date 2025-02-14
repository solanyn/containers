FROM ghcr.io/astral-sh/uv:python3.13-bookworm-slim

ARG VERSION

ENV UMASK="0002" \
    TZ="Etc/UTC"

USER root
WORKDIR /app

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

#hadolint ignore=DL3018,DL3059
RUN \
    apt-get -qq update \
    && \
    apt-get -qq install -y \
        catatonit \
    && \
    uv tool install --no-cache "mlflow[all]==${VERSION}" \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get clean \
    && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/ \
    && chown -R root:root /app \
    && chmod -R 755 /app \
    && printf "umask %d" "${UMASK}" >> /etc/bash.bashrc

COPY ./apps/mlflow/entrypoint.sh /entrypoint.sh

USER nobody:nogroup
WORKDIR /config
VOLUME ["/config"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/mlflow/mlflow"
