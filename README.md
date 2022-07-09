# /Containers

Templates for containers that I run. The folders are (typically) built with podman in mind but can accomidate other services. launch.sh is to be used pretty much entirely as a first-time replacement for docker-compose or development script. Containers are intended to be used as user systemd services with the included service file. Simply copy the file over to `.config/systemd/user/`, run `systemctl --user daemon-reload` and finally run `systemctl --user enable [CONTAINER/POD]`. Persistance may require the use of `sudo loginctl enable-linger [USER]` on the desired admin account.

scan.sh is a utility to help identify podman containers running across all users. Consider it a security tool to put in the root users `.bashrc` file.