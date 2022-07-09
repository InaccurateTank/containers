#!/bin/bash

GREEN='\e[32m'
YELLOW='\e[33m'
RED='\e[31m'
RESET='\e[0m'

# Kills on error or unset variable, prevents errors from being masked.
set -euo pipefail

# Logging Function
log(){
  local COLOR='\e[0m'
  local arg=''
  [ ! -z ${2:-} ] && arg=${2}
  case $arg in
    warn)  COLOR=${YELLOW} ;;
    error) COLOR=${RED} ;;
    *)     COLOR=${GREEN} ;;
  esac
  echo -e "$(date +%Y-%m-%d\ %H:%M:%S) | ${COLOR}${1}${RESET}"
}

if [[ ! -f /terraria/data/server.cfg ]]; then
  log 'Missing Config File, Creating Default File' warn
  cp /terraria/defaultserver.cfg /terraria/data/server.cfg
fi

log 'Applying Enviroment Config'
if [[ ! -z ${WORLDNAME:-} ]]; then
  sed -i "s:#\?\(world=\).*$:\1../data/Worlds/${WORLDNAME}.wld:" /terraria/data/server.cfg
  sed -i "s:#\?\(worldname=\).*$:\1${WORLDNAME}:" /terraria/data/server.cfg
fi
[ ! -z ${WORLDSIZE:-} ] && sed -i "s:#\?\(autocreate=\).*$:\1${WORLDSIZE}:" /terraria/data/server.cfg
[ ! -z ${SEED:-} ] && sed -i "s:#\?\(seed=\).*$:\1${SEED}:" /terraria/data/server.cfg
[ ! -z ${DIFFICULTY:-} ] && sed -i "s:#\?\(difficulty=\).*$:\1${DIFFICULTY}:" /terraria/data/server.cfg
[ ! -z ${MAXPLAYERS:-} ] && sed -i "s:#\?\(maxplayers=\).*$:\1${MAXPLAYERS}:" /terraria/data/server.cfg
[ ! -z ${PASSWORD:-} ] && sed -i "s:#\?\(password=\).*$:\1${PASSWORD}:" /terraria/data/server.cfg
[ ! -z ${LANG:-} ] && sed -i "s:#\?\(language=\).*$:\1${LANG}:" /terraria/data/server.cfg

if [[ ! -f '/terraria/data/banlist.txt' ]]; then
  log 'Missing Banlist, Creating' warn
  :> /terraria/data/banlist.txt
fi

if [[ ! -d '/terraria/data/Worlds' ]]; then
  log 'Missing World Folder, Creating' warn
  mkdir /terraria/data/Worlds
fi

log 'Launching Server'
/terraria/game/TerrariaServer.bin.x86_64 -port 7777 -banlist /terraria/data/banlist.txt -config /terraria/data/server.cfg