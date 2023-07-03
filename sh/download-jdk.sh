#!/usr/bin/env bash

set -e

workdir="$(pwd)"

rclone sync \
  --exclude=/rpm/** \
  --exclude=/deb/** \
  --progress \
  --http-url https://mirrors.tuna.tsinghua.edu.cn/Adoptium  \
  :http: "${workdir}/library/Adoptium"
