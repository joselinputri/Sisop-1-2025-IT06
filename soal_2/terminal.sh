#!/bin/bash

source register.sh
source login.sh

while true; do
    clear
    echo "=============================="
    echo "     SISOP-IT06 TERMINAL   "
    echo "=============================="
    echo "1. Login"
    echo "2. Register"
    echo "3. Exit"
    echo "------------------------------"
    read -rp "🔹 Choose an option: " option

    case "$option" in
        1)
            check_login
            read -rp "Press Enter to continue..."
            ;;
        2)
            register
            read -rp "Press Enter to continue..."
            ;;
        3)
            echo "Exiting... Have a great day!"
            exit 0
            ;;
        *)
            echo "Invalid option! Please choose 1, 2, or 3."
            sleep 1
            ;;
    esac
done
