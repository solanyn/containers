FROM ubuntu:25.10

ARG UV_VERSION=0.10.9
ARG NODE_VERSION=22.15.0
ARG GH_VERSION=2.89.0
ARG GLAB_VERSION=1.92.0
ARG OP_VERSION=2.33.1

RUN apt-get update && apt-get install -y --no-install-recommends \
      git \
      curl \
      jq \
      ca-certificates \
      procps \
      unzip \
      openssh-client \
    && rm -rf /var/lib/apt/lists/*

# uv (includes python3)
RUN curl -fsSL "https://astral.sh/uv/${UV_VERSION}/install.sh" | \
      INSTALLER_NO_MODIFY_PATH=1 UV_INSTALL_DIR=/usr/local/bin sh

# node
RUN curl -fsSL https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.gz | \
      tar xz -C /usr/local --strip-components=1

# gh (GitHub CLI)
RUN curl -sL "https://github.com/cli/cli/releases/download/v${GH_VERSION}/gh_${GH_VERSION}_linux_amd64.tar.gz" | \
      tar xz --strip-components=1 -C /usr/local

# glab (GitLab CLI)
RUN curl -sL "https://gitlab.com/gitlab-org/cli/-/releases/v${GLAB_VERSION}/downloads/glab_${GLAB_VERSION}_linux_amd64.tar.gz" | \
      tar xz --strip-components=1 -C /usr/local

# 1password-cli
RUN curl -sS "https://cache.agilebits.com/dist/1P/op2/pkg/v${OP_VERSION}/op_linux_amd64_v${OP_VERSION}.zip" \
      -o /tmp/op.zip && \
    unzip -o /tmp/op.zip -d /usr/local/bin op && \
    chmod +x /usr/local/bin/op && \
    rm /tmp/op.zip

# Install python3 via uv
ENV UV_PYTHON_INSTALL_DIR=/opt/uv/python
RUN uv python install 3.13 && \
    ln -sf $(uv python find 3.13) /usr/local/bin/python3

# Add node user for uid 1000 compatibility
RUN echo "node:x:1000:1000::/workspace:/bin/sh" >> /etc/passwd && \
    echo "node:x:1000:" >> /etc/group
