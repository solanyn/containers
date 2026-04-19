FROM debian:bookworm-slim

ARG UV_VERSION=0.10.9
ARG NODE_VERSION=22.15.0
ARG OP_VERSION=2.30.3
ARG GH_VERSION=2.65.0
ARG GO_VERSION=1.25.2
ARG HELM_VERSION=3.18.2
ARG TALOSCTL_VERSION=1.12.6

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

# node
RUN curl -fsSL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz | \
      tar xz -C /usr/local --strip-components=1

# kubectl
RUN KUBECTL_VERSION=$(curl -sL https://dl.k8s.io/release/stable.txt) && \
    curl -sL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" \
      -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl

# flux
RUN curl -sL https://fluxcd.io/install.sh | FLUX_VERSION=2.5.1 bash

# gh (GitHub CLI)
RUN curl -sL "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz" | \
      tar xz --strip-components=1 -C /usr/local

# 1password-cli
RUN curl -sS "https://cache.agilebits.com/dist/1P/op2/pkg/v${OP_VERSION}/op_linux_amd64_v${OP_VERSION}.zip" \
      -o /tmp/op.zip && \
    unzip -o /tmp/op.zip -d /usr/local/bin op && \
    chmod +x /usr/local/bin/op && \
    rm /tmp/op.zip

# go
RUN curl -fsSL "https://go.dev/dl/go${GO_VERSION}.linux-amd64.tar.gz" | \
      tar xz -C /usr/local && \
    ln -sf /usr/local/go/bin/go /usr/local/bin/go && \
    ln -sf /usr/local/go/bin/gofmt /usr/local/bin/gofmt

# helm
RUN curl -fsSL "https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz" | \
      tar xz --strip-components=1 -C /usr/local/bin linux-amd64/helm

# talosctl
RUN curl -fsSL "https://github.com/siderolabs/talos/releases/download/v${TALOSCTL_VERSION}/talosctl-linux-amd64" \
      -o /usr/local/bin/talosctl && \
    chmod +x /usr/local/bin/talosctl

# Install python3 via uv (install to world-readable path for non-root runtime)
ENV UV_PYTHON_INSTALL_DIR=/opt/uv/python
RUN uv python install 3.13 && \
    ln -sf $(uv python find 3.13) /usr/local/bin/python3

# Add node user for uid 1000 compatibility
RUN echo "node:x:1000:1000::/home/node/.openclaw/workspace:/bin/sh" >> /etc/passwd && \
    echo "node:*:20549:0:99999:7:::" >> /etc/shadow && \
    echo "node:x:1000:" >> /etc/group
