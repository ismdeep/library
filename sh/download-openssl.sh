#!/usr/bin/env bash

# e.g. https://www.openssl.org/source/openssl-1.1.1t.tar.gz

set -e

workdir="$(pwd)"

download() {
  version="${1:?}"
  if [ ! -f "${workdir}/library/openssl/openssl-${version}.tar.gz" ]; then
    tmp_dir="$(mktemp -d)"
    curl -L "https://www.openssl.org/source/openssl-${version}.tar.gz" -o "${tmp_dir}/openssl-${version}.tar.gz"
    mkdir -p "${workdir}/Library/openssl/"
    cp -v "${tmp_dir}/openssl-${version}.tar.gz" "${workdir}/Library/openssl/openssl-${version}.tar.gz"
    rm -rfv "${tmp_dir}"
  fi
  echo "==> library/openssl/openssl-${version}.tar.gz    OK"
}

versions=(\
1.1.1a 1.1.1b 1.1.1c 1.1.1d 1.1.1e 1.1.1f 1.1.1g \
1.1.1h 1.1.1i 1.1.1j 1.1.1k 1.1.1l 1.1.1m 1.1.1n \
1.1.1o 1.1.1p 1.1.1q               1.1.1s 1.1.1t \
1.1.1u)
for version in "${versions[@]}"; do
  download "${version}"
done
