#!/bin/bash

CSV_FILE="data/player.csv"

if [ ! -f "$CSV_FILE" ]; then
    mkdir -p "$(dirname "$CSV_FILE")"
    echo "Name,Email,Password" > "$CSV_FILE"
fi

email_exists() {
    local email=$1
    if grep -q "^.*,$email,.*$" "$CSV_FILE"; then
        return 0  # Email exists
    else
        return 1  # Email does not exist
    fi
}

validate_email() {
    local email=$1
    if [[ "$email" =~ ^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$ ]]; then
        return 0
    else
        return 1
    fi
}

validate_password() {
    local password=$1
    if [[ ${#password} -ge 8 ]]; then
        return 0
    else
        return 1
    fi
}

register() {
    echo "Enter your name:"
    read -r name
    echo "Enter your email:"
    read -r email
    echo "Enter your password:"
    read -rs password
    echo

    if [[ -z "$name" ]]; then
        echo "❌ Please fill out your name"
        return
    fi

    if ! validate_email "$email"; then
        echo "❌ Invalid email format. Use example@domain.com"
        return 1
    fi

    if email_exists "$email"; then
        echo "❌ Email already exists. Try logging in."
        return 1
    fi

    if ! validate_password "$password"; then
        echo "❌ Password must be at least 8 characters long."
        return 1
    fi

    local saved_password
    saved_password=$(echo -n "$password" | sha256sum | awk '{print $1}')

    echo "$name,$email,$saved_password" >> "$CSV_FILE"
    echo "✅ Registration successful!"
    return 0
}
while true; do
    register
    if [[ $? -eq 0 ]]; then
      sleep 1  
      break
    fi
    sleep 2
done
