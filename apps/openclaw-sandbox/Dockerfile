FROM buildpack-deps:bookworm

ARG UV_VERSION=0.10.9
ARG BUN_VERSION=1.2.5
ARG OP_VERSION=2.30.3

RUN curl -fsSL https://astral.sh/uv/${UV_VERSION}/install.sh | INSTALLER_NO_MODIFY_PATH=1 UV_INSTALL_DIR=/usr/local/bin sh && \
    curl -fsSL https://bun.sh/install | BUN_INSTALL=/usr/local bash && \
    KUBECTL_VERSION=$(curl -sL https://dl.k8s.io/release/stable.txt) && \
    curl -sL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    curl -sS "https://cache.agilebits.com/dist/1P/op2/pkg/v${OP_VERSION}/op_linux_amd64_v${OP_VERSION}.zip" -o /tmp/op.zip && \
    unzip -o /tmp/op.zip -d /usr/local/bin op && \
    chmod +x /usr/local/bin/op && \
    rm /tmp/op.zip
