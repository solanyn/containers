FROM ghcr.io/ferretdb/postgres-documentdb:17-0.103.0-ferretdb-2.2.0

ARG VERSION

USER root
ADD https://github.com/tensorchord/VectorChord/releases/download/$VERSION/postgresql-17-vchord_$VERSION-1_amd64.deb /tmp/vchord.deb
RUN apt-get install -y /tmp/vchord.deb && rm -f /tmp/vchord.deb

USER postgres
