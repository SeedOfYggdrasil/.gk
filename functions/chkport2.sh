#!/bin/bash

chkport_err() {
    local port=$1

    if  [[ -z "$port" ]]; then
        echo -e "${red}ERROR${nc}: Must specify which port to check."
        return 1
    fi
}

chkport() {
    local port=$1
    local cmd1=$(sudo netstat -tvulnp | grep :"$port")
	local cmd2=$(sudo lsof -i :$1)
	local cmd=$($cmd1 || $cmd2)

    if ! command -v netstat &>/dev/null; then
 		sudo apt install -y net-tools >&/dev/null 
    fi

    chkport_err "$port"
    if [[ $? -ne 0 ]]; then
        return 1
    fi

    clear
    echo -e "${yellow}Checking port ${red}$port${yellow}...${nc}"
    echo

    if [[ -z "$cmd" ]]; then
        echo -e "${yellow}Port ${red}$port${yellow} is not currently in use.${nc}"
    else
        echo -e "${green}$cmd${nc}"
    fi
    echo
}
