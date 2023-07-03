#!/usr/bin/env bash

set -e

workdir="$(pwd)"

download() {
  file_name=${1:?}
  target_folder="${workdir}/library/go/"
  if [ ! -f "${target_folder}/${file_name}" ]; then
    tmp_dir="$(mktemp -d)"
    # e.g. https://go.dev/dl/go1.20.5.linux-amd64.tar.gz
    curl --retry 3 \
      -L "https://go.dev/dl/${file_name}" \
      -o "${tmp_dir}/${file_name}"
    mkdir -p "${target_folder}"
    cp -v "${tmp_dir}/${file_name}" "${target_folder}/${file_name}"
    rm -rfv "${tmp_dir}"
  fi
  echo -e "==> library/go/${file_name}    OK"
}

python3.8 "${workdir}/py3/get-go-files.py" | while read -r file_name; do
  download "${file_name}"
done
