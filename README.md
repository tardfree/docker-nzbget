# docker-nzbget
A basic nzbget docker container, based on the latest Alpine Linux base image.
Inspired by https://github.com/pwntr/nzbget-alpine-docker

Includes the latest testing nzbget version.

Quick start (config file is created in config volume automatically):
```shell
docker run -d -p 6789:6789 -v /path/to/config:/config -v /path/to/downloads:/downloads --name nzbget tardfree/docker-nzbget
```

To have the container start when the host boots, add docker's restart policy:
```shell
docker run -d --restart=always -p 6789:6789 -v /path/to/config:/config -v /path/to/downloads:/downloads --name nzbget tardfree/docker-nzbget
```
