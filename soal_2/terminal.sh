#!/bin/bash

LOGGED_IN=1  # 1 means not logged in, 0 means logged in

while true; do
    clear
    echo "=============================="
    echo "     SISOP-IT06 TERMINAL   "
    echo "=============================="
    echo "1. Login"
    echo "2. Register"
    echo "3. Core Monitoring (CPU)"
    echo "4. Fragment Monitoring (RAM)"
    echo "5. Crontab Manager"
    echo "6. Exit"
    echo "------------------------------"
    read -rp "🔹 Choose an option: " option

    case "$option" in
        1)
            ./login.sh
            if [[ $? -eq 0 ]]; then
                LOGGED_IN=0  # Set to logged in
            fi
            ;;
        2)
            ./register.sh
            ;;
        3)
            if [[ $LOGGED_IN -eq 0 ]]; then
                ./scripts/core_monitor.sh
            else
                echo "❌ You must be logged in first!"
                read -rp "Press Enter to continue..."
            fi
            ;;
        4)
            if [[ $LOGGED_IN -eq 0 ]]; then
                ./scripts/frag_monitor.sh
            else
                echo "❌ You must be logged in first!"
                read -rp "Press Enter to continue..."
            fi
            ;;
        5)
            if [[ $LOGGED_IN -eq 0 ]]; then
                ./scripts/manager.sh
            else
                echo "❌ You must be logged in first!"
                read -rp "Press Enter to continue..."
            fi
            ;;
        6)
            echo "Exiting... Have a great day!"
            exit 0
            ;;
        *)
            echo "Invalid option! Please choose a valid number."
            sleep 1
            ;;
    esac
done
