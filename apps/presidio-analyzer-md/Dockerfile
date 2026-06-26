# Slim Presidio Analyzer: bundles the medium spaCy model instead of en_core_web_lg
# to cut resident memory on memory-tight clusters. RAM is driven by which model
# LOADS, so we ship exactly one model (lg removed) per image.
ARG VERSION=2.2.362
FROM mcr.microsoft.com/presidio-analyzer:${VERSION}

# Which spaCy model to bundle. This image is the "md" flavor.
ARG SPACY_MODEL=en_core_web_md

# Need root to write into site-packages and the conf file.
USER root

RUN python -m spacy download "${SPACY_MODEL}" \
  # Drop the stock large model to save disk + RAM (try both name spellings).
  && (pip uninstall -y en_core_web_lg || true) \
  && (pip uninstall -y en-core-web-lg || true) \
  # Point the NLP engine at the bundled model, keeping the rest of the conf intact.
  && sed -i -E "s/^([[:space:]]*model_name:[[:space:]]*).*/\1${SPACY_MODEL}/" \
    /app/presidio_analyzer/conf/default.yaml

# Revert to the original non-root user.
USER 1001

EXPOSE 3000

# Entrypoint/CMD inherited from the upstream image (./entrypoint.sh, gunicorn :3000).
