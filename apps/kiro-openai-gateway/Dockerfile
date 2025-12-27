FROM ghcr.io/astral-sh/uv:python3.11-bookworm-slim AS builder

ARG VERSION=1.0.7

ENV UV_COMPILE_BYTECODE=1
ENV UV_LINK_MODE=copy

WORKDIR /app
RUN apt-get update && apt-get install -y git && rm -rf /var/lib/apt/lists/*
RUN uv venv && \
  uv pip install "git+https://github.com/jwadow/kiro-openai-gateway.git@v${VERSION}"

FROM python:3.11-slim-bookworm

RUN groupadd -g 1001 kiro && \
  useradd -u 1001 -g kiro -s /bin/bash -m kiro

COPY --from=builder /app/.venv /app/.venv

USER kiro
WORKDIR /app

EXPOSE 8000

ENV PATH="/app/.venv/bin:$PATH"

CMD ["python", "-m", "uvicorn", "kiro_gateway:app", "--host", "0.0.0.0", "--port", "8000"]
