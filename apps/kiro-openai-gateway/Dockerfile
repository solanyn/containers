FROM ghcr.io/astral-sh/uv:python3.11-bookworm-slim AS builder

ARG VERSION=1.0.7

ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

WORKDIR /app
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
RUN git clone --depth 1 --branch v${VERSION} https://github.com/jwadow/kiro-openai-gateway.git .
RUN uv venv && uv pip install -r requirements.txt

FROM python:3.11-slim-bookworm

RUN groupadd -g 1001 kiro && \
  useradd -u 1001 -g kiro -s /bin/bash -m kiro

COPY --from=builder /app /app

USER kiro
WORKDIR /app

EXPOSE 8000

ENV PATH="/app/.venv/bin:$PATH"

CMD ["python", "main.py"]
