#!/usr/bin/env bash

set -ex

################ configuration ################
server_host='127.0.0.1'
server_port='10022'
server_vm='server-1050e'
server_snapshot='9514d431-3b96-4060-b69f-ad9efea3e85e'
################ configuration ################


download() {
    app="${1:?}"
    vboxmanage controlvm "${server_vm}" poweroff || true
    vboxmanage snapshot  "${server_vm}" restore "${server_snapshot}"
    vboxmanage startvm   "${server_vm}" --type=headless
    sleep 10s

    version=$(ssh -p "${server_port}" "root@${server_host}" 'yum info '"${app}"' | grep Version | awk '"'"'{print $3}'"'"'' | head -n 1)
    ssh -p "${server_port}" "root@${server_host}" 'set -e;' \
                                                  'cd ${HOME};' \
                                                  'rm -rfv ${HOME}/tmp;' \
                                                  'mkdir ${HOME}/tmp;' \
                                                  'cd ${HOME}/tmp;' \
                                                  'yum install --downloadonly --downloaddir=$PWD -y '"${app}"''

    rm -rfv "./library/1050e/amd64/${app}/${version}"
    mkdir -p "./library/1050e/amd64/${app}"
    scp -r -P "${server_port}" "root@${server_host}:/root/tmp" "./library/1050e/amd64/${app}/${version}"

    vboxmanage controlvm "${server_vm}" poweroff || true
}


############ main ############
download docker-engine
download gcc
download vim-enhanced
