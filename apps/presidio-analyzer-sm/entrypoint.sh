#!/bin/sh
set -eu
: "${PORT:=3000}"
: "${THREADS:=4}"
export PORT THREADS
exec poetry run python -c "
from app import create_app
from waitress import serve
serve(
    create_app(),
    host='0.0.0.0',
    port=${PORT},
    threads=${THREADS},
    ident='presidio-analyzer-sm',
)
"
