FROM --platform=linux/amd64 node:latest

WORKDIR /m4

# Install dependencies
RUN apt-get update && \
    mkdir -p /usr/share/man/man1 && \
    apt-get install --yes --no-install-recommends \
      curl \
      libc6-dev \
      openjdk-17-jdk-headless \
      sqlite3 \
      make \
      git \
      cloc \
      xz-utils \
      zlib1g-dev && \
    rm -rf /var/lib/apt/lists/*

# Install Maven 3.9.6
RUN curl -sL https://archive.apache.org/dist/maven/maven-3/3.9.6/binaries/apache-maven-3.9.6-bin.tar.gz | tar xz -C /opt
ENV PATH=/opt/apache-maven-3.9.6/bin:${PATH}

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

# 2. Clone Gson repository
COPY . .

# initialize submodules inside container
RUN git submodule update --init --recursive
WORKDIR /m4/gson

# 3. Record commit/tag information
RUN git rev-parse HEAD > commit_hash.txt

# 4. Record environment details
WORKDIR /m4/details

# Verify installation
RUN infer --version > /m4/details/infer_version.txt
RUN uname -a > /m4/details/os_info.txt
RUN java -version > /m4/details/java_version.txt 2>&1
RUN mvn -version > /m4/details/maven_version.txt

# 5. Count LOC
WORKDIR /m4/gson
RUN git remote get-url origin > /m4/details/repo_url.txt
RUN cloc . > /m4/details/loc.txt

# 6. Build GSON (verify build)
# RUN mvn clean verify

# 7. Run Infer analysis
# RUN infer run -- mvn clean install


# -------------------------------
# Final output summary
# -------------------------------

# RUN echo "=== Experiment 1 Complete ===" && \
#     echo "\nInfer Version:" && cat /infer_version.txt && \
#     echo "\nOS Info:" && cat os_info.txt && \
#     echo "\nJava Version:" && cat java_version.txt && \
#     echo "\nMaven Version:" && cat maven_version.txt && \
#     echo "\nRepository URL:" && cat repo_url.txt && \
#     echo "\nLOC Summary:" && cat loc.txt
CMD ["/bin/bash"]
