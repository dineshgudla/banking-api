FROM docker:cli AS docker-cli

FROM jenkins/inbound-agent:latest-jdk21

USER root

# Copy Docker CLI binary
COPY --from=docker-cli /usr/local/bin/docker /usr/local/bin/docker

# Install Maven and Git
RUN apt-get update && \
    apt-get install -y \
        maven \
        git && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

USER jenkins
