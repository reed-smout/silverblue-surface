#!/usr/bin/env bash

# Tell this script to exit if there are any errors.
# You should have this in every custom script, to ensure that your completed
# builds actually ran successfully without any errors!
set -oue pipefail

# Your code goes here.
wget -O /etc/yum.repos.d/linux-surface.repo https://pkg.surfacelinux.com/fedora/linux-surface.repo
sed -i 's/f$releasever/f42/g' /etc/yum.repos.d/linux-surface.repo
wget https://github.com/linux-surface/linux-surface/releases/download/silverblue-20201215-1/kernel-20201215-1.x86_64.rpm -O /tmp/surface-kernel.rpm
rpm-ostree cliwrap install-to-root /
rpm-ostree override replace /tmp/surface-kernel.rpm \
        --remove kernel-core \
        --remove kernel-modules \
        --remove kernel-modules-extra \
        --remove libwacom \
        --remove libwacom-data \
        --install kernel-surface \
        --install iptsd \
        --install libwacom-surface \
        --install libwacom-surface-data
rpm-ostree install surface-secureboot
