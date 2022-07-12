FROM    docker.io/debian:bullseye-slim

LABEL   author="InaccurateTank" maintainer="InaccurateTank"
LABEL   org.opencontainers.image.source="https://github.com/InaccurateTank/containers/Java"
LABEL   org.opencontainers.image.licenses=MIT

ENV     LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

ARG     JAVA_VERSION=jdk-11.0.15+10
ARG     ESUM=22831fd097dfb39e844cb34f42064ff26a0ada9cd13621d7b8bca8e9b9d3a5ee

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

RUN     echo "Confirming Java Install" && \
          java -version

USER    container
ENV     USER=container HOME=/home/container
WORKDIR /home/container

COPY    ./../entrypoint.sh /entrypoint.sh
CMD     [ "/bin/bash", "/entrypoint.sh" ]