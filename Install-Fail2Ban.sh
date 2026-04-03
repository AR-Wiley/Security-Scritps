#!/bin/bash

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root" >&2
        exit 1
fi

function System_Update {

        updates=("apt-get update"
                "apt-get upgrade -y"
                "apt-get dist-upgrade -y"
                "apt-get clean"
                "apt-get autoremove -y")

        for i in "${updates[@]}"; do
                if ! eval "$i"; then
                        echo "'$i' Failed"
                        exit 1
                else
                        echo "'$i' Success"
                fi
        done

}

function Install_Fail2Ban {

        if command -v fail2ban-client >/dev/null 2>&1; then
                echo "Fail2Ban is installed..."
                fail2ban-client -V
        else
                echo "Installing Fail2Ban..."
                if ! apt install -y fail2ban; then
                        echo "Fail2Ban Installation Failed..."
                        exit 1
                fi

                echo "Fail2Ban has been installed..."
                fail2ban-client -V
        fi
}


System_Update
Install_Fail2Ban

