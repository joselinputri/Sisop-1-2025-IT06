#!/bin/bash

CSV_FILE="data/player.csv"

if [ ! -f "$CSV_FILE" ]; then
    mkdir -p "$(dirname "$CSV_FILE")"
    echo "Name,Email,Password" > "$CSV_FILE"
fi

email_exists() {
    local email=$1
    if grep -q "^[^,]*,$email," "$CSV_FILE"; then
        return 0
    else
        return 1
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

    if [[ -z "$name" ]]; then
        echo "Error: Name cannot be empty."
        return
    fi

    if ! validate_email "$email"; then
        echo "Error: Invalid email format. Please use format: example@domain.com"
        return
    fi

    if email_exists "$email"; then
        echo "Error: Email already exists. Please try logging in instead."
        return
    fi

    if ! validate_password "$password"; then
        echo "Error: Password must be more than 8 characters."
        return
    fi

    local saved_password=$(echo -n "$password" | sha256sum | awk '{print $1}')

    echo "$name,$email,$saved_password" >> "$CSV_FILE"
    echo "Registration successful!"
}

