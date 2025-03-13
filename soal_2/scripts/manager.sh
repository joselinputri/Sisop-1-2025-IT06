#!/bin/bash

LOG_DIR="./log"
CORE_LOG="$LOG_DIR/core.log"
FRAG_LOG="$LOG_DIR/fragment.log"

mkdir -p "$LOG_DIR"

manage_cron() {
    while true; do
        clear
        echo "=============================="
        echo "   🛠️ Arcaea Crontab Manager"
        echo "=============================="
        echo "1. Add CPU Monitoring (Core)"
        echo "2. Add RAM Monitoring (Fragment)"
        echo "3. Remove CPU Monitoring"
        echo "4. Remove RAM Monitoring"
        echo "5. View Active Jobs"
        echo "6. Exit"
        echo "------------------------------"
        read -rp "🔹 Choose an option: " choice

        case "$choice" in
            1)
                (crontab -l 2>/dev/null; echo "*/1 * * * * bash $(pwd)/scripts/core_monitor.sh >> $CORE_LOG") | crontab -
                echo "✅ CPU monitoring scheduled every 1 minute."
                sleep 1
                ;;
            2)
                (crontab -l 2>/dev/null; echo "*/1 * * * * bash $(pwd)/scripts/frag_monitor.sh >> $FRAG_LOG") | crontab -
                echo "✅ RAM monitoring scheduled every 1 minute."
                sleep 1
                ;;
            3)
                crontab -l | grep -v "core_monitor.sh" | crontab -
                echo "🗑️ Removed CPU monitoring job."
                sleep 1
                ;;
            4)
                crontab -l | grep -v "frag_monitor.sh" | crontab -
                echo "🗑️ Removed RAM monitoring job."
                sleep 1
                ;;
            5)
                echo "📜 Active Crontab Jobs:"
                crontab -l
                read -rp "Press Enter to continue..."
                ;;
            6)
                echo "Exiting Crontab Manager..."
                exit 0
                ;;
            *)
                echo "Invalid option! Please choose a valid number."
                sleep 1
                ;;
        esac
    done
}

manage_cron
