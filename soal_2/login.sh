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
    echo

    local password_hash
    password_hash=$(echo -n "$password" | sha256sum | awk '{print $1}')

    while IFS=',' read -r name email_in file_password; do
        if [[ "$email" == "$email_in" && "$password_hash" == "$file_password" ]]; then
            echo "✅ Login successful!"
            return 0 
        fi
    done < <(tail -n +2 "$CSV_FILE")

    echo "❌ Invalid email or password."
    return 1
}

while true; do
    login
    if [[ $? -eq 0 ]]; then
      sleep 1  
      break
    fi
    sleep 2
done
