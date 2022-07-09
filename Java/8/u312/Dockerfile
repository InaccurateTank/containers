FROM    docker.io/debian:bullseye-slim

LABEL   author="InaccurateTank" maintainer="InaccurateTank"

LABEL   org.opencontainers.image.source="https://github.com/InaccurateTank/containers/Java"
LABEL   org.opencontainers.image.licenses=MIT

ENV     LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

ARG     JAVA_VERSION=jdk8u312-b07
ARG     ESUM=18fd13e77621f712326bfcf79c3e3cc08c880e3e4b8f63a1e5da619f3054b063

RUN     apt-get update && \
          DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata curl ca-certificates fontconfig locales lsof openssl git tar sqlite3 libfreetype6 iproute2 libstdc++6 tini && \
          echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
          locale-gen en_US.UTF-8 && \
          apt-get clean && \
          rm -rf /var/lib/apt/lists/*

RUN     useradd -d /home/container -m container && \
          curl -LfsSo /tmp/openjdk.tar.gz https://github.com/adoptium/temurin8-binaries/releases/download/${JAVA_VERSION}/OpenJDK8U-jre_x64_linux_hotspot_$( echo ${JAVA_VERSION} | sed 's;jdk\(.*\)-\(.*\);\1\2;' ).tar.gz && \
          echo "${ESUM} /tmp/openjdk.tar.gz" | sha256sum -c && \
          mkdir -p /opt/java/openjdk && \
          tar -xzf /tmp/openjdk.tar.gz -C /opt/java/openjdk --strip=1 && \
          rm -rf /tmp/openjdk.tar.gz

ENV     JAVA_HOME=/opt/java/openjdk \
        PATH="/opt/java/openjdk/bin:$PATH"

USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ./../../entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/tini", "--"]
CMD     [ "/bin/bash", "/entrypoint.sh" ]