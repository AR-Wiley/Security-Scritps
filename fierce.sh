#!/bin/bash

set -euo pipefail

IPRANGE="192.168.1.0"
MASK=24

function Get_Host {

        local ip_range=$1
        local sub_mask=$2

        host_discovery="/home/wiley/Documents/hosts"

        date=$(date +"%Y-%m-%d")

        if [[ ! -e "$host_discovery" ]]; then
                touch "$host_discovery"
        fi

        declare -a ip_address
        delcare -a host

        data=$(fierce --iprange "$ip_range/$submask")

        for i in "$data"; do

}
