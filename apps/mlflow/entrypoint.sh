#!/usr/bin/env bash

#shellcheck disable=SC2086
exec \
    mlflow \
    server \
    "$@"
