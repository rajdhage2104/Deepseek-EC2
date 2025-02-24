#!/bin/bash
dnf update -y

dnf install -y amazon-linux-extras
amazon-linux-extras enable corretto17
sleep 5
dnf install -y \
    yum-utils \
    apt-transport-https \
    ca-certificates \
    curl \
    java-17-amazon-corretto \
    gcc \
    kernel-devel \
    kernel-headers

aws s3 cp --recursive s3://ec2-linux-nvidia-drivers/latest/ .
chmod +x NVIDIA-Linux-x86_64*.run
/bin/sh ./NVIDIA-Linux-x86_64*.run --tmpdir . --silent --logfile /var/log/nvidia-installer.log

echo "options nvidia NVreg_EnableGpuFirmware=0" | tee --append /etc/modprobe.d/nvidia.conf

dnf install -y docker
usermod -aG docker ec2-user
systemctl enable --now docker

dnf config-manager --add-repo https://nvidia.github.io/libnvidia-container/stable/rpm/nvidia-container-toolkit.repo
dnf install -y nvidia-container-toolkit
nvidia-ctk runtime configure --runtime=docker
systemctl restart docker

reboot
