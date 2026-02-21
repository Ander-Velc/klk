#!/bin/bash

green="\e[0;32m\033[1m"
end="\033[0m\e[0m"
red="\e[0;31m\033[1m"
blue="\e[0;34m\033[1m"
yellow="\e[0;33m\033[1m"
cyan="\e[0;36m\033[1m"

ip_input="$1"
ip_broadcast="${ip_input%.*}."

for ((i=1; i<=254; i++)); do
{
    ip="${ip_broadcast}${i}"
    ttl=$(timeout 0.9 ping -c 1 "$ip" 2>/dev/null | grep -o 'ttl=[0-9]\+' | grep -o '[0-9]\+')

    if [[ -n $ttl ]]; then
        if (( ttl <= 64 )); then
            echo -e "${green}[+]${end} $ip : ${cyan}Linux${end} ${blue}TTL:$ttl${end}"
        elif (( ttl <= 128 )); then
            echo -e "${green}[+]${end} $ip : ${yellow}Windows${end} ${blue}TTL:$ttl${end}"
        else
            echo -e "${green}[?]${end} $ip : ${red}Unknown${end} ${blue}TTL:$ttl${end}"
        fi
    fi
} &
done; wait
