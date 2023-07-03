#!/usr/bin/env bash

set -e

data_dir=$(pwd)

download_detail() {
  name=${1:?}
  version=${2:?}
  os=${3:?}
  arch=${4:?}
  target_folder="${data_dir}/library/kubernetes/${name}/${version}/${os}/${arch}"
  if [ ! -f "${target_folder}/${name}" ]; then
    tmp_dir="$(mktemp -d)"
    curl -L "https://storage.googleapis.com/kubernetes-release/release/${version}/bin/${os}/${arch}/${name}" -o "${tmp_dir}/${name}"
    mkdir -p "${target_folder}"
    cp -v "${tmp_dir}/${name}" "${target_folder}/${name}"
    rm -rfv "${tmp_dir}"
  fi
  echo -e "==> library/kubernetes/${name}/${version}/${os}/${arch}/${name}    OK"
}

download() {
  version=${1:?}
  if [ "${version}" == "latest" ]; then
    version=$(curl -L -s https://dl.k8s.io/release/stable.txt)
  fi
  download_detail "kubectl" "${version}" linux  amd64
  download_detail "kubectl" "${version}" linux  arm64
  download_detail "kubectl" "${version}" darwin amd64
  download_detail "kubectl" "${version}" darwin arm64
  download_detail "kubelet" "${version}" linux  amd64
  download_detail "kubelet" "${version}" linux  arm64
  download_detail "kubeadm" "${version}" linux  amd64
  download_detail "kubeadm" "${version}" linux  arm64
}

versions=(\
v1.22.0 v1.22.1 v1.22.2 v1.22.3 v1.22.4 v1.22.5 v1.22.6 v1.22.7 v1.22.8 v1.22.9 v1.22.10 v1.22.11 v1.22.12 v1.22.13 v1.22.14 v1.22.15 v1.22.16 v1.22.17 \
v1.23.0 v1.23.1 v1.23.2 v1.23.3 v1.23.4 v1.23.5 v1.23.6 v1.23.7 v1.23.8 v1.23.9 v1.23.10 v1.23.11 v1.23.12 v1.23.13 v1.23.14 v1.23.15 v1.23.16 v1.23.17 \
v1.24.0 v1.24.1 v1.24.2 v1.24.3 v1.24.4 v1.24.5 v1.24.6 v1.24.7 v1.24.8 v1.24.9 v1.24.10 v1.24.11 v1.24.12 v1.24.13 v1.24.14 v1.24.15 \
v1.25.0 v1.25.1 v1.25.2 v1.25.3 v1.25.4 v1.25.5 v1.25.6 v1.25.7 v1.25.8 v1.25.9 v1.25.10 v1.25.11 \
v1.26.0 v1.26.1 v1.26.2 v1.26.3 v1.26.4 v1.26.5 v1.26.6 \
v1.27.0 v1.27.1 v1.27.2 \
latest)
for version in "${versions[@]}"; do
  download "${version}"
done
