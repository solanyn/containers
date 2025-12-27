#!/usr/bin/env bash

exec \
    /app/Whisparr \
        --nobrowser \
        --data=/config \
        "$@"
