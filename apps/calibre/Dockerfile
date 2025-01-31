FROM docker.io/library/python:3.13-alpine

ARG TARGETPLATFORM
ARG TARGETARCH
ARG TARGETOS
ARG VERSION

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_ROOT_USER_ACTION=ignore \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_BREAK_SYSTEM_PACKAGES=1

ENV \
    CALIBRE_DBPATH=/config \
    UMASK="0002"

USER root

# hadolint ignore=DL3008,DL3015,SC2086
RUN \
    apk add --no-cache \
        bash \
        ca-certificates \
        ghostscript \
        libc6-compat \
        libldap \
        libmagic \
        libsasl \
        libxi \
        libxml2 \
        libxslt \
    && \
    apk add --no-cache --virtual=.build-deps \
        build-base \
        curl \
        libffi-dev \
        libxml2-dev \
        libxslt-dev \
        linux-headers \
        openldap-dev \
    && \
    # Download calibre release
    mkdir -p /app \
    && curl -fsSL "https://download.calibre-ebook.com/${VERSION}/calibre-${VERSION}-${ARCH}.txz" \
        | tar Jxvf - -C /app \
    && /app/calibre_postinstall \
    # Cleanup
    && apk del --purge .build-deps \
    && rm -rf \
        /root/.cache \
        /root/.cargo \
        /tmp/* \
    # Set permissions
    && chmod -R 755 /app

COPY ./apps/calibre/entrypoint.sh /entrypoint.sh

USER nobody:nogroup
WORKDIR /config
VOLUME [ "/config" ]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]

LABEL org.opencontainers.image.source="https://github.com/kovidgoyal/calibre"
