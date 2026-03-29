FROM debian:bookworm-slim

ARG UV_VERSION=0.10.9
ARG BUN_VERSION=1.2.5
ARG OP_VERSION=2.30.3
ARG GH_VERSION=2.65.0

RUN apt-get update && apt-get install -y --no-install-recommends \
      git \
      curl \
      jq \
      ca-certificates \
      procps \
      unzip \
    && rm -rf /var/lib/apt/lists/*

# uv (includes python3)
RUN curl -fsSL "https://astral.sh/uv/${UV_VERSION}/install.sh" | \
      INSTALLER_NO_MODIFY_PATH=1 UV_INSTALL_DIR=/usr/local/bin sh

# bun
RUN curl -fsSL https://bun.sh/install | BUN_INSTALL=/usr/local bash

# kubectl
RUN KUBECTL_VERSION=$(curl -sL https://dl.k8s.io/release/stable.txt) && \
    curl -sL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
      -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# gh (GitHub CLI)
RUN curl -sL "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz" | \
      tar xz --strip-components=1 -C /usr/local

# 1password-cli
RUN curl -sS "https://cache.agilebits.com/dist/1P/op2/pkg/v${OP_VERSION}/op_linux_amd64_v${OP_VERSION}.zip" \
      -o /tmp/op.zip && \
    unzip -o /tmp/op.zip -d /usr/local/bin op && \
    chmod +x /usr/local/bin/op && \
    rm /tmp/op.zip

# Install python3 via uv (install to world-readable path for non-root runtime)
ENV UV_PYTHON_INSTALL_DIR=/opt/uv/python
RUN uv python install 3.13 && \
    ln -sf $(uv python find 3.13) /usr/local/bin/python3

# Add node user for uid 1000 compatibility
# When sandbox runs as --user 1000:1000, tools like op CLI
# need a passwd entry to resolve the current user
RUN echo "node:x:1000:1000::/workspace:/bin/sh" >> /etc/passwd && \
    echo "node:x:1000:" >> /etc/group
