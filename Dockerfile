FROM node:22-slim

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    bash ca-certificates curl git openssh-client \
    build-essential \
    ripgrep jq file \
    less procps patch \
    tar gzip xz-utils unzip \
    net-tools iputils-ping dnsutils && \
    update-ca-certificates && \
    rm -rf /var/lib/apt/lists/*

RUN mkdir -p /etc/ssh \
    && ssh-keyscan -t rsa,ecdsa,ed25519 github.com >> /etc/ssh/ssh_known_hosts

ENV PATH="/node/.local/bin:$PATH"
ENV HOME="/node"
ENV SHELL="/bin/bash"
ENV PNPM_HOME="/node/.local/share/pnpm"
ENV PNPM_STORE_DIR="/node/.local/share/pnpm/store"
ENV PATH="$PNPM_HOME:$PATH"
ENV UV_INSTALL_DIR="/node/.local/bin"

RUN curl -fsSL https://get.pnpm.io/install.sh | sh -

RUN curl -LsSf https://astral.sh/uv/install.sh | sh \
    && uv python install 3.12 --default \
    && uv tool install graphifyy \
    && graphify install

RUN git config --global user.name "Pi Agent" \
    && git config --global user.email "pi-agent@globesoul.com"

# Set the working directory inside the container
WORKDIR /workspace

# Install the pi agent globally
RUN npm install -g @mariozechner/pi-coding-agent

# Set the default command to execute the agent
ENTRYPOINT ["pi"]
