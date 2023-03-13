#!/usr/bin/env bash

set -e

data_dir=$(pwd)

rclone sync --exclude=/rpm/** --exclude=/deb/** --progress --http-url https://mirrors.tuna.tsinghua.edu.cn/Adoptium  :http: "${data_dir}/library/Adoptium"
