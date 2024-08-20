# beeware-container

Script to build a beeware project via docker / podman.

![](./logo.png)

The makefile is configured to output flatpak and android apk for a python/toga project.

Requires:

* podman / docker
* make

Usage:

```
# Build beeware-build image, and run build for flatpak / apk:
make
```

## Licenses

I am not a lawyer, this is not legal advice

**ONLY** source code of this project is covered by the ``LICENSE`` file.

**DO NOT** distribute container images you build with this project. Do not upload them to docker.io or similar services. To understand why, [read this report by the linux foundation](https://www.linuxfoundation.org/resources/publications/docker-containers-what-are-the-open-source-licensing-considerations).

For licencing the build result (apk / flatpak) you must comply with the licenses of the technologies used (beeware, briefcase, toga, android-sdk, etc...)
