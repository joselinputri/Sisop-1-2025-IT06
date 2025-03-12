check_login() {
    local email=$1
    local password=$2
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

echo "Enter your email:"
read email
echo "Enter your password:"
read -s password

check_login "$email" "$password"
