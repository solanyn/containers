ARG PYTHON_VERSION=3.9
ARG DEBIAN_VERSION=bookworm-slim

FROM python:${PYTHON_VERSION}-${DEBIAN_VERSION}

RUN apt-get update && apt-get install -y \
    git \
    libusb-1.0-0-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ARG NUT_VERSION=master
RUN git clone --depth 1 --branch ${NUT_VERSION} https://github.com/blawar/nut.git .

RUN pip install --no-cache-dir -r requirements.txt

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENV ROMS_PATH="/roms" \
    OUTPUT_PATH="/organized" \
    REGION="US" \
    LANGUAGE="en" \
    AUTO_UPDATE_TITLEDB="true" \
    ALLOW_NO_METADATA="true" \
    DRY_RUN="false"

ENTRYPOINT ["/entrypoint.sh"]
