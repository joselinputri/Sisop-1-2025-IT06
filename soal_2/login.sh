#!/bin/bash

CSV_FILE="data/player.csv"
if [ ! -f "$CSV_FILE" ]; then
    echo "Name,Email,Password" > "$CSV_FILE"
fi

login() {
    echo "Enter your email:"
    read -r email
    echo "Enter your password:"
    read -rs password

    local found=0
    while IFS=',' read -r name email_in file_password; do
      if [[ "$email" == "$email_in" && "$(echo -n "$password" | sha256sum | awk '{print $1}')" == "$file_password" ]]; then
            found=1
            break
        fi
    done < "$CSV_FILE"

    if [[ $found -eq 1 ]]; then
        echo "Login successful!"
    else
        echo "Invalid email or password."
    fi
}

