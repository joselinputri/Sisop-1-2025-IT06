email_exists() {
    local email=$1
    while IFS=',' read -r name email_in file_password; do
        if [[ "$email" == "$email_in" ]]; then
            return 0
        fi
    done < data/player.csv
    return 1
}

register_user() {
    local name=$1
    local email=$2
    local password=$3

    if email_exists "$email"; then
        echo "Email already exists. Please try logging in instead."
    else
        echo "$name,$email,$password" >> data/player.csv
        echo "Registration successful!"
    fi
}

echo "Enter your name"
read name
echo "Enter your email"
read email
echo "Enter your password"
read -s password 

register_user "$name" "$email" "$password" 
