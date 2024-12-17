#!/bin/bash

# Encrypts a single file or all files in a directory
ncrypt() {
    local target=$1
    local PASSWORD=$2

    if [[ -d "$target" ]]; then
        # Target is a directory; encrypt all files inside
        find "$target" -type f -exec bash -c 'openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -salt -in "$0" -out "$0.enc" -k "$1"' {} "$PASSWORD" \;
        echo "Directory '$target' and its contents have been encrypted."
    elif [[ -f "$target" ]]; then
        # Target is a file; encrypt it
        openssl enc -aes-256-cbc -pbkdf2 -iter 100000 -salt -in "$target" -out "$target.enc" -k "$PASSWORD"
        echo "File '$target' has been encrypted to '$target.enc'."
    else
        echo "Error: '$target' is not a valid file or directory."
        return 1
    fi
}

# Decrypts a single file or all encrypted files in a directory
dcrypt() {
    local target=$1
    local PASSWORD=$2

    if [[ -d "$target" ]]; then
        # Target is a directory; decrypt all .enc files inside
        find "$target" -type f -name "*.enc" -exec bash -c 'openssl enc -d -aes-256-cbc -pbkdf2 -iter 100000 -salt -in "$0" -out "${0%.enc}" -k "$1"' {} "$PASSWORD" \;
        echo "Directory '$target' and its contents have been decrypted."
    elif [[ -f "$target" && "$target" == *.enc ]]; then
        # Target is an encrypted file; decrypt it
        local output_file="${target%.enc}"
        openssl enc -d -aes-256-cbc -pbkdf2 -iter 100000 -salt -in "$target" -out "$output_file" -k "$PASSWORD"
        echo "File '$target' has been decrypted to '$output_file'."
    else
        echo "Error: '$target' is not a valid encrypted file or directory."
        return 1
    fi
}