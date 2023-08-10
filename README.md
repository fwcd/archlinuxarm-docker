# Arch Linux ARM Docker images

[![Build and Deploy](https://github.com/fwcd/archlinuxarm-docker/actions/workflows/build-deploy.yml/badge.svg)](https://github.com/fwcd/archlinuxarm-docker/actions/workflows/build-deploy.yml)

Unofficial, automated Docker images for Arch Linux ARM on AArch32 (ARMv7-A) and AArch64 (ARMv8-A). Built using native pacman and Docker multi-stage builds. Builds daily by GitHub Actions on publicly visible infrastructure using QEMU emulation.

## Running the images

```sh
docker run --rm -ti ghcr.io/fwcd/archlinuxarm-docker
```

## Tags

|  Tag   |   Update   |  Type   |                                 Description                                        |
|:------:|:----------:|:-------:|:-----------------------------------------------------------------------------------|
| latest | **daily**  | minimal | minimal Arch Linux ARM with pacman support                                         |

### Layer structure

The image is generated from a freshly built pacman rootfs. Pacman has configured
to delete man pages and clean the package cache after installation to keep
images small.

## Issues and improvements

If you want to contribute, get to the [issues-section of this repository](https://github.com/fwcd/archlinuxarm-docker/issues).

## Common hurdles

### Setting the timezone

Simply add the `TZ` environment-variable and define it with a valid timezone-value.

```
docker run -e TZ=Europe/Berlin ghcr.io/fwcd/archlinuxarm-docker
```

## Building it yourself

### Prerequisites

- Docker with experimental mode on (required for squash)

### Building

See the [CI workflow](.github/workflows/build-deploy.yml).

### Building from scratch

Since the image depends on itself, the question which arise is how this all
started. The initial containers have been created using the tarballs provided by
the Arch Linux ARM project. I used the following steps to bootstrap for each
architecture:

```
sudo tar xvzf ArchLinuxARM-armv7-latest.tar.gz -C tmp-arch
sudo tar cf ArchLinuxARM-armv7-latest.tar -C tmp-arch/ .
docker import ArchLinuxARM-armv7-latest.tar agners/armv7-archlinux:latest
```

## Credits

Ideas have been taken from already existing Docker files for Arch Linux.
However, this repository takes a slightly different approach to create images.

- https://github.com/agners/archlinuxarm-docker
  - The upstream project
- https://github.com/danhunsaker/archlinuxarm-docker
  - GitHub Actions fork
- https://github.com/archlinux/archlinux-docker
  - Focus on Arch Linux for x86
  - Uses docker run in priviledged mode to build images
- https://github.com/lopsided98/archlinux
  - Uses prebuilt tarballs which contain packages not required in containers
