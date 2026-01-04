ARG VERSION

FROM ghcr.io/astral-sh/uv:python3.12-bookworm-slim AS builder

ARG VERSION
ADD https://github.com/jwadow/kiro-openai-gateway/archive/refs/tags/${VERSION}.tar.gz /tmp/src.tar.gz
RUN tar -xzf /tmp/src.tar.gz -C /tmp && mv /tmp/kiro-openai-gateway-* /app

WORKDIR /app
RUN uv pip install --no-cache --target=/deps -r requirements.txt

FROM python:3.12-slim

WORKDIR /app
COPY --from=builder /deps /deps
COPY --from=builder /app/kiro_gateway kiro_gateway
COPY --from=builder /app/main.py .

ENV PYTHONPATH=/deps
EXPOSE 8000

CMD ["python", "main.py"]
