#!/bin/bash

set -euo pipefail

if [[ $EUID -ne 0 ]]; then
        echo "You must be root to run this script..."
        exit 1
fi

DIR="/home/awiley805/Documents"

function Get_Hash {

        local path=$1

        date_today=$(date +"%Y-%m-%d")

        hash_dir="/home/awiley805/hash"

        declare -a hashes
        hashes+=("$path"/*)

        if [[ ! -d "$hash_dir" ]]; then
                mkdir "$hash_dir"
        fi

        for i in "${hashes[@]}"; do
                find "$path" -type f -exec sha256sum "$i" >> "$hash_dir/hash_$date_today"
        done
}

function Hash_Diff {

        date_today=$(date +"%Y-%m-%d")
        date_yesterday=$(date -d yesterday +"%Y-%m-%d")

        hash_dir="/home/awiley805/hash"
        hash_diff="/home/awiley805/hash/hash_diff"

        if [[ ! -e "$hash_diff" ]]; then
                touch "$hash_diff"
        fi

        if [[ -e "$hash_dir/hash_$date_yesterday" ]] ; then
                diff "$hash_dir/hash_$date_today" "$hash_dir/hash_$date_yesterday" >> "$hash_diff"
                echo "Differences have occurred... Please check hash differences log..."
        else
                echo "No differences have occurred..."
        fi
}


Get_Hash "$DIR"
Hash_Diff



