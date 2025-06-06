FROM ghcr.io/solanyn/calibre:8.4.0 AS calibre
FROM ghcr.io/solanyn/kepubify:4.0.4 AS kepubify

FROM ubuntu:24.04

ENV \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PIP_BREAK_SYSTEM_PACKAGES=1 \
    PIP_ROOT_USER_ACTION=ignore \
    PIP_NO_CACHE_DIR=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1

ENV \
    CALIBRE_DBPATH=/config

ARG VERSION

SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# hadolint ignore=DL3008,DL3015,SC2086
RUN \
    apt-get update \
    && \
    apt-get install -y \
        curl \
        catatonit \
        imagemagick \
        libegl1 \
        libfontconfig1 \
        libgl1 \
        libglx-mesa0 \
        libldap2 \
        libnss3 \
        libopengl0 \
        libsasl2-2 \
        libxcomposite1 \
        libxdamage1 \
        libxi6 \
        libxkbcommon0 \
        libxrandr2 \
        libxslt1.1 \
        python3 \
        python3-pip \
        python3-pkg-resources \
    && \
    # Dev
    apt-get install -y \
        libldap2-dev \
        libsasl2-dev \
        python3-dev \
        gcc \
        g++ \
    && \
    mkdir -p /app \
    && curl -fsSL https://github.com/janeczku/calibre-web/archive/refs/tags/${VERSION}.tar.gz \
        | tar xzf - -C /app --strip-components=1 \
    && pip install --upgrade --requirement /app/requirements.txt \
    && pip install --upgrade --requirement /app/optional-requirements.txt \
    && apt-get purge -y --auto-remove libldap2-dev libsasl2-dev python3-dev gcc g++\
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

COPY --from=calibre /app /opt/calibre
COPY --from=kepubify /app/kepubify /opt/kepubify/kepubify

USER nobody:nogroup
WORKDIR /config
VOLUME ["/config"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "python3", "/app/cps.py", "-o", "/dev/stdout"]

LABEL org.opencontainers.image.source="https://github.com/janeczku/calibre-web"
