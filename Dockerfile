FROM docker:cli AS docker-cli

FROM jenkins/inbound-agent:latest-jdk21

USER root

COPY --from=docker-cli /usr/local/bin/docker /usr/local/bin/docker

RUN apt-get update && \
    apt-get install -y \
        maven \
        git \
        unzip \
        curl && \
    rm -rf /var/lib/apt/lists/*

RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" \
    -o "awscliv2.zip"

RUN unzip awscliv2.zip

RUN ./aws/install

RUN rm -rf aws awscliv2.zip

RUN groupadd -g 988 dockerhost && \
    usermod -aG dockerhost jenkins

USER jenkins
