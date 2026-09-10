#!/bin/sh
set -eu

mkdir -p "${HERMES_HOME:-/data}/platforms/matrix/store"

exec hermes gateway run "$@"
