#!/bin/bash

config="/etc/cgproxy.conf"
source $config

# test suid bit
if [ -u "$(which cgattach)" ]; then 
    cgattach $$ $cgroup_proxy && attached=1
else
    sudo cgattach $$ $cgroup_proxy && attached=1
fi

# test attach success or not
[[ -z "$attached" ]] && echo "attach error" && exit 1

exec "$@"