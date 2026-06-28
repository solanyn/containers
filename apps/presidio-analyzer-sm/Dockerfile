# Slim Presidio Analyzer: bundles the small spaCy model instead of en_core_web_lg
# to cut resident memory on memory-tight clusters. RAM is driven by which model
# LOADS, so we ship exactly one model (lg removed) per image.
ARG VERSION=2.2.362
FROM mcr.microsoft.com/presidio-analyzer:${VERSION}

# Which spaCy model to bundle. This image is the "sm" flavor.
ARG SPACY_MODEL=en_core_web_sm

# Need root to write into site-packages, the conf file, and the entrypoint.
USER root

RUN python -m spacy download "${SPACY_MODEL}" \
  # Drop the stock large model to save disk + RAM (try both name spellings).
  && (pip uninstall -y en_core_web_lg || true) \
  && (pip uninstall -y en-core-web-lg || true) \
  # Point the NLP engine at the bundled model, keeping the rest of the conf intact.
  && sed -i -E "s/^([[:space:]]*model_name:[[:space:]]*).*/\1${SPACY_MODEL}/" \
    /app/presidio_analyzer/conf/default.yaml \
  # The upstream image's entrypoint is a custom "dirty" gunicorn fork
  # (DirtyPostFork / dirty_worker_init) that deadlocks during cold-start worker
  # init when the Flask app has heavy imports (AnalyzerEngineProvider.create_engine
  # loads every NLP recognizer + the spaCy model). Waitress is single-process,
  # no fork semantics, and serves the same create_app() factory in ~2s.
  && pip install --no-cache-dir 'waitress==3.0.2'

COPY entrypoint.sh /app/entrypoint.sh
RUN chmod 0755 /app/entrypoint.sh

# Revert to the original non-root user.
USER 1001

EXPOSE 3000

ENTRYPOINT ["/app/entrypoint.sh"]
