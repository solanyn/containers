# syntax=docker/dockerfile:1

# Thin Matrix E2EE gateway for Hermes Agent. Matrix traffic is handled here and
# plaintext is forwarded to the main Hermes API in proxy mode.
FROM docker.io/library/python:3.12-slim

ARG VERSION

ENV \
    PIP_BREAK_SYSTEM_PACKAGES=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_ROOT_USER_ACTION=ignore \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    HERMES_HOME=/data

USER root
WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends ca-certificates catatonit tzdata build-essential libolm-dev \
    && pip install "hermes-agent[matrix]==${VERSION}" \
    && python -c "import olm, mautrix" \
    && mkdir -p /data \
    && chown -R nobody:nogroup /data /app \
    && apt-get purge -y --auto-remove build-essential libolm-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /root/.cache

COPY --chmod=755 entrypoint.sh /entrypoint.sh

USER nobody:nogroup
WORKDIR /data
VOLUME ["/data"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
