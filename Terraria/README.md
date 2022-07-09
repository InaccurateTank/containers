# /Containers/Terraria

Mildly janky but stable vanilla Terraria server container.

## Quick Start

* Clone Repo
* cd into Terraria folder
```bash
docker build -t terraria .

docker create \
  --name terraria \
  -di \
  -v /DATA/FOLDER/HERE:/terraria/data \
  -p 7777:7777 \
  terraria
```
*BE ADVISED:*
* The whole container runs as uid `837`. chown volume mount accordingly.
* Graceful shutdown can only be achieved via attaching container and typing `exit`

## Env Variables

The container lets you change a few common config options on creation. All of these can be changed in the server.cfg.

|Variable|Description|Default|
|--------|-----------|:-----:|
|`WORLDNAME`|Name of the world to use/be generated.|Terraria
|`WORLDSIZE`|1=Small, 2=Medium, 3=Large|2|
|`SEED`|Seed of the generated world|
|`DIFFICULTY`|0=Classic, 1=Expert, 2=Master, 3=Journey|0|
|`MAXPLAYERS`|Maximum players allowed in the server|8|
|`PASSWORD`|Password of the server|
|`LANG`|Language localization for the server to use|en-US|
