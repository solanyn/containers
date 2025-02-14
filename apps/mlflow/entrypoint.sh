#!/usr/bin/env bash

#shellcheck disable=SC2086
exec \
    uv run \
    mlflow \
    server \
    "$@"
