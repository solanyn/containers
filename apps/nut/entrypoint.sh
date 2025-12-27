#!/bin/bash
set -e

# Generate nut.conf from environment variables
mkdir -p conf
cat > conf/nut.conf << EOF
{
  "paths": {
    "titleBase": "${OUTPUT_PATH}/base/{name} [{id}][v{version}].nsp",
    "nszTitleBase": "${OUTPUT_PATH}/base/{name} [{id}][v{version}].nsz",
    "xciTitleBase": "${OUTPUT_PATH}/base/{name} [{id}][v{version}].xci",
    "xczTitleBase": "${OUTPUT_PATH}/base/{name} [{id}][v{version}].xcz",
    "titleDLC": "${OUTPUT_PATH}/dlc/{baseName} [{name}] [{id}][v{version}].nsp",
    "nszTitleDLC": "${OUTPUT_PATH}/dlc/{baseName} [{name}] [{id}][v{version}].nsz",
    "titleUpdate": "${OUTPUT_PATH}/updates/{name} [{id}][v{version}].nsp",
    "nszTitleUpdate": "${OUTPUT_PATH}/updates/{name} [{id}][v{version}].nsz",
    "titleDemo": "${OUTPUT_PATH}/demo/{name} [{id}][v{version}].nsp",
    "nszTitleDemo": "${OUTPUT_PATH}/demo/{name} [{id}][v{version}].nsz",
    "titleDemoUpdate": "${OUTPUT_PATH}/demo_updates/{name} [{id}][v{version}].nsp",
    "nszTitleDemoUpdate": "${OUTPUT_PATH}/demo_updates/{name} [{id}][v{version}].nsz",
    "titleDatabase": "/app/titledb",
    "titleImages": "${OUTPUT_PATH}/images/",
    "nspOut": "${OUTPUT_PATH}/_NSPOUT",
    "duplicates": "${OUTPUT_PATH}/duplicates/",
    "scan": ["${ROMS_PATH}"]
  },
  "autoUpdateTitleDb": ${AUTO_UPDATE_TITLEDB},
  "allowNoMetadata": ${ALLOW_NO_METADATA},
  "region": "${REGION}",
  "language": "${LANGUAGE}"
}
EOF

# Create output directory
mkdir -p "${OUTPUT_PATH}"

# Add dry run flag if enabled
ARGS=""
if [ "${DRY_RUN}" = "true" ]; then
    ARGS="--dry-run"
fi

# Run NUT organize command
exec python3 nut.py --organize $ARGS "$@"
