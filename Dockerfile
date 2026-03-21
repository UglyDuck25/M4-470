FROM node:latest

WORKDIR /m4

# Install dependencies
RUN apt-get update && \
    mkdir -p /usr/share/man/man1 && \
    apt-get install --yes --no-install-recommends --fix-missing \
      curl \
      wget \
      libc6-dev \
      openjdk-17-jdk-headless \
      maven \
      sqlite3 \
      make \
      git \
      cloc \
      xz-utils \
      zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Download the Infer release
RUN INFER_VERSION=v1.2.0; \
    cd /opt && \
    curl -sL \
      https://github.com/facebook/infer/releases/download/${INFER_VERSION}/infer-linux-x86_64-${INFER_VERSION}.tar.xz | \
    tar xJ && \
    rm -f /infer && \
    ln -s ${PWD}/infer-linux-x86_64-$INFER_VERSION /infer

# Install infer
ENV PATH=/infer/bin:${PATH}

WORKDIR /m4/gson

CMD ["/bin/bash"]
