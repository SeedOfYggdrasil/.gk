# .bashrc (termux) v. 1.0

# Functions
set_current_time() {
    echo $(date +"%H:%M:%S")
}

log() {
    if [[ "$shell_log.sh_active" == "true" ]]; then
        newlog $1
    fi
}

load_termux_env() {
    export home="/data/data/com.termux/files/home"
    alias i='pkg install -y'
    alias u='pkg update && pkg upgrade -y'
}

src_script() {
    local script=$1
    local file=$(basename "$script")
    local isActive=$(echo "${file}_active")
    if [ -f "$script" ]; then
        source $script
        if [ "$#" -eq 0 ]; then
           eval "export ${file//.sh/_}active=true"
           log "  SUCCESS: ${file}"
        else
           eval "export ${file//.sh/_}active=false"
           log "  FAIL: ${file}"
        fi
    fi
}

load_gk_shell() {
    if [ ! -d $gkf ]; then
        echo -e "Error: Directory not found."
        return 1
    else
        for file in "$gkf"/*.sh; do
	    src_script "$file" >&/dev/null
        done
    fi
}

enable_logs() {
    src_script "$gkf/shell_log.sh"
    setup_log
}

# SHELL
export now=$(set_current_time)
export NOW=$now
export user=$USER
export gk="$home/g0dking"
export gkf="$gk/functions"

alias c='clear'
alias gk='cd $gk'
alias gkf='cd $gkf'

# LOGGING
enable_logs

# ENVIRONMENT
load_termux_env
load_gk_shell
