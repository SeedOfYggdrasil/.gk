#!/bin/bash
# initialize.sh | v. 1.0 | 11.24.24

# Automates the intialization of the G0DKING shell environment
# To use, source this file, then call the functions in ~/.bashrc

env_update() {
    env_dir=$HOME/g0dking

    echo -e "${yellow}Checking for updates...${nc}"
    sudo apt update >&/dev/null || error "Could not update package repository."
    echo -e "${green}SUCCESS${nc}"
    echo
    echo -e "${yellow}Upgrading packages..."
    sudo apt full-upgrade -y >&/dev/null || error "Could not upgrade packages."
    echo -e "${green}SUCCESS${nc}"
    echo

    if [ -d "$env_dir" ]; then
        cd $env_dir
        echo -e "${yellow}Syncing environment..."
        git pull >&/dev/null || error "Could not update environment configuration."
        echo -e "${green}SUCCESS${nc}"
        echo
        cd $HOME
    fi
}

init_env() {
    local env_dir=$HOME/g0dking
    local config_dir=$env_dir/files/config
    local functions_dir=$env_dir/functions
    local check_tools=$HOME/g0dking/files/config/app_index

    dirs=(
        $config_dir
        $functions_dir
    )

    for dir in "${dirs[@]}"; do
        for file in $dir/*.{sh,config}; do
            if [[ -e "$file" ]]; then
                source "$file" || error "Failed to load $file"
            fi
        done
    done
}

set_env() {
	set_colors
	set_prompt
	set_secrets
    if [ "$ID" != "termux" ]; then
	set_dns
    fi
	_nvm
	_miniconda
	ssh_github
}

initial_load_output() {
    local vars=(
        Aliases
        Shortcuts
        Network
        Themes
        Secrets
        Variables
    )

    echo -e "Applying configurations...${nc}"
    sleep 0.2

    for var in ${vars[@]}; do
        if [[ ! -z "$set_dns_complete" ]]; then
            echo -e "    ${bold_blue}${var}${nc}"
            sleep 0.3
        fi
    done
    echo -e "${green}SUCCESS${nc}"
    echo
    echo -e "Loading tools & services..."
    sleep 0.3
    if command -v nvm >&/dev/null; then
        echo -e "${bold_blue}    Node Version Manager${nc}"
        sleep 0.3
    fi
    if command -v conda >&/dev/null; then
        echo -e "${bold_blue}    Miniconda${nc}"
        sleep 0.3
    fi
    if command -v gh >&/dev/null; then
        echo -e "${bold_blue}    GitHub CLI${nc}"
        sleep 0.3
    fi
    echo -e "${green}SUCCESS${nc}"
    sleep 0.5
}

finish_init() {
    if [ $USER == "root" ]; then
        color=$red
    else
        color=$cyan
    fi

    echo
    echo -e "Logging in as: ${color}$USER${nc}"
    echo
    echo -e "Press Enter"
    read -r
    clear
}

title_env() {
    echo -e "${red}G${bold_blue}0${bold_purple}D${greenest}K${bold_yellow}I${blue}N${purplest}G${green} S${yellow}H${reddest}E${bluest}L${bold_purple}L"
    echo -e "${purple}Alex Pariah${nc}"
    echo -e "${yellow}OS: ${cyan}${ID}${nc}"
    echo
}

load_env() {
#    init_env
    set_env
}

apply() {
    [[ $- != *i* ]] && return

    osrel="/etc/os-release"
    if [ -f $osrel ]; then
        source $osrel
    else
        export ID="termux"
    fi
    export ID=$ID
    export id=$ID

    title_env
    echo -n "Check for updates? (y/N): "
    read -r choice
    choice=${choice:-n}

    case $choice in
    [yY])
        if [ $ID != "termux" ]; then
            env_update
        fi
        load_env
        initial_load_output
        ;;
    [nN]|""|*)
        load_env
        ;;
    esac
}
