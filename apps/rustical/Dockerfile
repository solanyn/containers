ARG VERSION

FROM rust:1.94-alpine AS builder

ARG VERSION

RUN apk add --no-cache musl-dev pkgconf make git perl

WORKDIR /rustical
RUN git clone --depth 1 --branch "${VERSION}" https://github.com/lennart-k/rustical.git .
RUN cargo build --release --locked
RUN cp target/release/rustical /usr/local/bin/rustical

FROM alpine:3.21
RUN apk add --no-cache ca-certificates
COPY --from=builder /usr/local/bin/rustical /usr/local/bin/rustical
CMD ["/usr/local/bin/rustical"]
ENV RUSTICAL_DATA_STORE__SQLITE__DB_URL=/var/lib/rustical/db.sqlite3
EXPOSE 4000
HEALTHCHECK --interval=30s --timeout=30s --start-period=3s --retries=3 CMD ["/usr/local/bin/rustical", "health"]
