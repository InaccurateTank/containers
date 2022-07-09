#!/bin/bash

MAIN_DIR='/path/to/main/directory'
DL_DIR='/path/to/download/directory'

podman build -t transmission $MAIN_DIR/build/

podman run -d \
  --net slirp4netns:port_handler=slirp4netns \
  --name transmission \
  -v $MAIN_DIR/incomplete/:/home/transmission/incomplete/ \
  -v tmvol:/home/transmission/.config/transmission-daemon/ \
  -v $DL_DIR/Watch/:/home/transmission/watch/ \
  -v $DL_DIR/Complete/:/home/transmission/complete/ \
  -p 51413:51413/tcp -p 51413:51413/udp \
  -p 9091:9091/tcp \
  transmission