#!/bin/bash
sudo dnf update -y

sudo dnf install -y docker
usermod -aG docker ec2-user
systemctl enable --now docker








