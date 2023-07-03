#!/usr/bin/env bash

set -e

workdir=$(pwd)

download_detail() {
  version=${1:?}
  ext=${2:?}
  target_folder="${workdir}/library/allure/${version}"
  if [ ! -f "${target_folder}/allure-${version}.${ext}" ]; then
    tmp_dir="$(mktemp -d)"
    # e.g. https://github.com/allure-framework/allure2/releases/download/2.18.1/allure-2.18.1.tgz
    curl --retry 3 \
      -L "https://github.com/allure-framework/allure2/releases/download/${version}/allure-${version}.${ext}" \
      -o "${tmp_dir}/allure-${version}.${ext}"
    mkdir -p "${target_folder}"
    cp -v "${tmp_dir}/allure-${version}.${ext}" "${target_folder}/allure-${version}.${ext}"
    rm -rfv "${tmp_dir}"
  fi
  echo "==> library/allure/${version}/allure-${version}.${ext}    OK"
}

download() {
  version=${1:?}
  download_detail "${version}" tgz
  download_detail "${version}" zip
}

versions=(\
2.13.7 \
2.17.0 2.17.1 2.17.2 2.17.3 \
2.18.0 2.18.1 \
2.19.0 \
2.20.0 2.20.1 \
2.22.0 2.22.1 2.22.2 2.22.3 2.22.4 \
2.23.0)
for version in "${versions[@]}"; do
  download "${version}"
done
