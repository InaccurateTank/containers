ARG VERSION=1423

FROM docker.io/debian:stable-slim as build

ARG VERSION

WORKDIR /root

### Build Dependencies ###
RUN apt update && \
  apt install -y \
    unzip \
    wget

### Get Terraria ###
RUN wget -O terraria-server.zip https://terraria.org/api/download/pc-dedicated-server/terraria-server-${VERSION}.zip && \
  unzip terraria-server.zip && \
  chmod +x ./${VERSION}/Linux/TerrariaServer*

### Actual Container ###
FROM docker.io/debian:stable-slim

ARG VERSION
ARG CUID=837

WORKDIR /terraria

# Move Files
COPY --from=build /root/${VERSION}/Linux game/
COPY defaultserver.cfg ./
COPY entry.sh ./

# Final Touches
RUN groupadd -g $CUID terraria && \
  useradd -u $CUID -d /terraria -g terraria terraria && \
  mkdir /terraria/data && \
  chmod +x entry.sh && \
  chown -R terraria:terraria /terraria

VOLUME ["/terraria/data"]

USER terraria

EXPOSE 7777

ENTRYPOINT ["./entry.sh"]