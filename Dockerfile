FROM ghcr.io/fwcd/archlinuxarm-docker AS bootstrap

WORKDIR /archlinux

RUN mkdir -p /archlinux/rootfs

COPY pacstrap-docker /archlinux/

RUN ./pacstrap-docker /archlinux/rootfs base archlinuxarm-keyring

# Remove current pacman database, likely outdated very soon
RUN rm rootfs/var/lib/pacman/sync/*

FROM scratch
COPY --from=bootstrap /archlinux/rootfs/ /
COPY rootfs/ /

ENV LANG=en_US.UTF-8

RUN locale-gen
RUN pacman-key --init
RUN pacman-key --populate archlinuxarm

CMD ["/usr/bin/bash"]
