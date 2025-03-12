#!/bin/bash

check_login() {
    echo "Enter your email:"
    read -r email
    echo "Enter your password:"
    read -rs password

    local found=0
    while IFS=',' read -r name email_in file_password; do
        if [[ "$email" == "$email_in" && "$password" == "$file_password" ]]; then
            found=1
            break
        fi
    done < data/player.csv

    if [[ $found -eq 1 ]]; then
        echo "Login successful!"
    else
        echo "Invalid email or password."
    fi
}

