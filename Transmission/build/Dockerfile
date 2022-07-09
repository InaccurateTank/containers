FROM docker.io/alpine AS build

RUN apk add --no-cache unzip curl && \
    curl -OL https://github.com/johman10/flood-for-transmission/releases/download/latest/flood-for-transmission.zip && \
    unzip flood-for-transmission.zip

FROM docker.io/alpine

LABEL maintainer=InaccurateTank

ENV TRANSMISSION_WEB_HOME=/home/transmission/flood-for-transmission

ARG UGID=872

RUN addgroup -Sg $UGID transmission && \
    adduser -Su $UGID -G transmission transmission && \
    apk add --no-cache transmission-daemon tini && \
    mkdir -p /home/transmission/complete && \
    mkdir /home/transmission/incomplete && \
    mkdir /home/transmission/watch && \
    chown -R transmission:transmission /home/transmission

COPY --from=build --chown=transmission:transmission /flood-for-transmission /home/transmission/flood-for-transmission
COPY --chown=transmission:transmission settings.json /home/transmission/.config/transmission-daemon/

VOLUME /home/transmission/.config/transmission-daemon

EXPOSE 51413/tcp
EXPOSE 51413/udp
EXPOSE 9091/tcp

USER transmission

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["transmission-daemon", "-f"]