ARG VERSION

FROM ghcr.io/astral-sh/uv:python3.12-alpine AS builder

ARG VERSION
ARG TARGETARCH
ADD https://github.com/jwadow/kiro-openai-gateway/archive/refs/tags/${VERSION}.tar.gz /tmp/src.tar.gz
RUN tar -xzf /tmp/src.tar.gz -C /tmp && mv /tmp/kiro-openai-gateway-* /app

WORKDIR /app
COPY patches/ /tmp/patches/
RUN apk add --no-cache patch && \
  for p in /tmp/patches/*.patch; do patch -p1 < "$p"; done

RUN uv pip install --no-cache --target=/deps -r requirements.txt

FROM python:3.12-alpine

WORKDIR /app
COPY --from=builder /deps /deps
COPY --from=builder /app/kiro_gateway kiro_gateway
COPY --from=builder /app/main.py .
COPY --chmod=755 entrypoint.sh /entrypoint.sh

ENV PYTHONPATH=/deps
EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
