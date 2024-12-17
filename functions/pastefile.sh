#!/bin/bash
# pastefile.sh | v. 1.0 | 12.14.24

cb() {
    if [ -z "$ID" ]; then
        local distro="termux"
    else
        local distro=$ID
    fi

    if [ "$distro" == "termux" ]; then
        # Fetch clipboard content in Termux
        local clip=$(termux-clipboard-get)
        local file=$1
        
        if [ -z "$clip" ]; then
            echo "Nothing in clipboard."
            return 1
        else
            if [ ! -z "$file" ]; then
            	if [ ! -f "$file" ]; then
					touch $file || echo "Error: Could not create file."
				fi
				echo "${clip}" >> "$file" || echo "Error: Could not paste to file. Check permissions and try again."
            else
                echo "${clip}"
            fi
        fi
    # Add additional logic for other distros if needed
    # elif [ "$distro" == "specific-distro" ]; then
    #     # Handle other Linux distributions
    else
        echo "Error: Failed to automatically detect distribution."
        return 1
    fi
}
