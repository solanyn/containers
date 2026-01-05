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

RUN KIRO_ARCH=$([ "$TARGETARCH" = "arm64" ] && echo "aarch64" || echo "x86_64") && \
    wget -q "https://desktop-release.q.us-east-1.amazonaws.com/latest/kirocli-${KIRO_ARCH}-linux-musl.zip" -O /tmp/kirocli.zip && \
    unzip -q /tmp/kirocli.zip -d /tmp && \
    chmod +x /tmp/kirocli/bin/kiro-cli

FROM python:3.12-alpine

WORKDIR /app
COPY --from=builder /deps /deps
COPY --from=builder /app/kiro_gateway kiro_gateway
COPY --from=builder /app/main.py .
COPY --from=builder /tmp/kirocli/bin/kiro-cli /usr/local/bin/kiro-cli
COPY --chmod=755 entrypoint.sh /entrypoint.sh

ENV PYTHONPATH=/deps
EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
