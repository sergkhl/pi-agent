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

ENV PATH="/root/.local/bin:$PATH"
ENV SHELL="/bin/bash"
ENV PNPM_HOME="/root/.local/share/pnpm"
ENV PATH="$PNPM_HOME:$PATH"

RUN curl -fsSL https://get.pnpm.io/install.sh | sh -

RUN curl -LsSf https://astral.sh/uv/install.sh | sh \
    && /root/.local/bin/uv python install 3.12 --default \
    && /root/.local/bin/uv tool install graphifyy \
    && /root/.local/bin/graphify install

# Set the working directory inside the container
WORKDIR /workspace

# Install the pi agent globally
RUN npm install -g @mariozechner/pi-coding-agent

# Set the default command to execute the agent
ENTRYPOINT ["pi"]
