#!/usr/bin/env bash

set -e

workdir=$(pwd)

download_detail() {
  version=${1:?}
  os=${2:?}
  arch=${3:?}
  target_folder="${workdir}/library/docker-compose/${version}"
  if [ ! -f "${target_folder}/docker-compose-${os}-${arch}" ]; then
    tmp_dir="$(mktemp -d)"
    # e.g. https://github.com/docker/compose/releases/download/v2.19.0/docker-compose-darwin-aarch64
    curl --retry 3 \
      -L "https://github.com/docker/compose/releases/download/${version}/docker-compose-${os}-${arch}" \
      -o "${tmp_dir}/docker-compose-${os}-${arch}"
    mkdir -p "${target_folder}"
    cp -v "${tmp_dir}/docker-compose-${os}-${arch}" "${target_folder}/docker-compose-${os}-${arch}"
    rm -rfv "${tmp_dir}"
  fi
  echo "==> library/docker-compose/${version}/docker-compose-${os}-${arch}    OK"
}

download() {
  version=${1:?}
  download_detail "${version}" linux  x86_64
  download_detail "${version}" linux  aarch64
  download_detail "${version}" linux  ppc64le
  download_detail "${version}" linux  riscv64
  download_detail "${version}" linux  s390x
  download_detail "${version}" darwin x86_64
  download_detail "${version}" darwin aarch64
}

versions=(\
v2.15.0 v2.15.1 \
v2.16.0 \
v2.17.0 v2.17.1 v2.17.2 v2.17.3 \
v2.18.0 v2.18.1 \
v2.19.0)
for version in "${versions[@]}"; do
  download "${version}"
done
