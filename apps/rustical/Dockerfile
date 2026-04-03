ARG VERSION

FROM rust:1.94-alpine AS builder
RUN apk add --no-cache musl-dev git
ARG VERSION
WORKDIR /rustical
RUN git clone --depth 1 --branch "${VERSION}" https://github.com/lennart-k/rustical.git . \
  && cargo build --release --locked \
  && strip target/release/rustical

FROM alpine:3.21
COPY --from=builder /rustical/target/release/rustical /usr/local/bin/rustical
ENV RUSTICAL_DATA_STORE__SQLITE__DB_URL=/var/lib/rustical/db.sqlite3
EXPOSE 4000
CMD ["rustical"]
