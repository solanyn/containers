FROM python:3.12-slim-bookworm

ARG VERSION=main

RUN groupadd -g 1001 booktree && \
  useradd -u 1001 -g booktree -s /bin/bash -m booktree

RUN apt-get update && apt-get install -y \
  ffmpeg \
  git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

RUN git clone https://github.com/myxdvz/booktree.git . && \
  if [ "${VERSION}" != "main" ]; then git checkout "${VERSION}"; fi

RUN pip install --no-cache-dir -r requirements.txt

RUN mkdir -p /config /source /media && \
  chown -R booktree:booktree /config /source /media

USER booktree

WORKDIR /config

ENTRYPOINT ["/app/booktree.py"]
