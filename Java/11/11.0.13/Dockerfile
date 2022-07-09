FROM    docker.io/debian:bullseye-slim

LABEL   author="InaccurateTank" maintainer="InaccurateTank"

LABEL   org.opencontainers.image.source="https://github.com/InaccurateTank/containers/Java"
LABEL   org.opencontainers.image.licenses=MIT

ENV     LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

ARG     JAVA_VERSION=jdk-11.0.13+8
ARG     ESUM=fb0a27e6e1f26a1ee79daa92e4cfe3ec0d676acfe114d99dd84b3414f056e8a0

RUN     apt-get update && \
          DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata curl ca-certificates fontconfig locales lsof openssl git tar sqlite3 libfreetype6 iproute2 libstdc++6 && \
          echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && \
          locale-gen en_US.UTF-8 && \
          apt-get clean && \
          rm -rf /var/lib/apt/lists/*

RUN     useradd -d /home/container -m container && \
          curl -LfsSo /tmp/openjdk.tar.gz https://github.com/adoptium/temurin11-binaries/releases/download/$( echo ${JAVA_VERSION} | sed 's;\(.*\)+\(.*\);\1\%2B\2;' )/OpenJDK11U-jre_x64_linux_hotspot_$( echo ${JAVA_VERSION} | sed 's;jdk-\(.*\)+\(.*\);\1_\2;' ).tar.gz && \
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
CMD     [ "/bin/bash", "/entrypoint.sh" ]