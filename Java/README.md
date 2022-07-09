# /Containers/Java

Pterodactyl Java docker image modified to run via an archive binary of [Eclipse Temurin](https://adoptium.net/temurin) OpenJDK on debian:bullseye-slim. The default OpenJDK containers have been depreciated, and starting in Java 11 the Temurin images contain ShenandoahGC. This is done entirely with my purposes in mind, use at your own risk.

I *think* I have the licensing done right. The entrypoint file was ripped directly from the pterodactyl repo and contains its licensing info. The dockerfiles are a spliced alamgam so I'm not sure how any of this works. I'm not a lawyer.