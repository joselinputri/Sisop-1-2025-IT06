#!/bin/bash

LOG_DIR="./log"
LOG_FILE="$LOG_DIR/fragment_monitor.log"

monitor_usage() {
    clear
    TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

    RAM_TOTAL=$(sysctl -n hw.memsize)
    RAM_TOTAL_MB=$((RAM_TOTAL / 1024 / 1024))
    RAM_FREE=$(vm_stat | awk '/Pages free/ {print $3}' | sed 's/\.//')
    RAM_FREE_MB=$((RAM_FREE * 4096 / 1024 / 1024))
    RAM_USED_MB=$((RAM_TOTAL_MB - RAM_FREE_MB))
    RAM_USAGE_PERCENT=$(( RAM_USED_MB * 100 / RAM_TOTAL_MB ))

    echo "$TIMESTAMP | Total: ${RAM_TOTAL_MB}MB | Used: ${RAM_USED_MB}MB (${RAM_USAGE_PERCENT}%) | Free: ${RAM_FREE_MB}MB" >> "$LOG_FILE"

    bar_length=30
    filled_length=$(( RAM_USAGE_PERCENT * bar_length / 100 ))
    unfilled_length=$(( bar_length - filled_length ))

    printf "\e[1;36m╭────────────────────────────────╮\e[0m\n"
    printf "\e[1;32m│   🔹 Arcaea Fragment Monitoring   │\e[0m\n"
    printf "\e[1;36m├────────────────────────────────┤\e[0m\n"

    printf "\e[1;36m│\e[0m  📦  Total     \e[1;34m%5d MB \e[0m\n" "$RAM_TOTAL_MB"
    printf "\e[1;32m│  🟩 Used:  \e[1;37m%5d MB \e[1;32m(%2d%%)  \e[0m\n" "$RAM_USED_MB" "$RAM_USAGE_PERCENT"
    printf "\e[1;34m│  🟦 Free:  \e[1;37m%5d MB \e[1;34m       \e[0m\n" "$RAM_FREE_MB"
    printf "\e[1;36m├────────────────────────────────╯\e[0m\n"

    printf "  ["
    printf "\e[1;32m"
    for ((i = 0; i < filled_length; i++)); do printf "█"; done
    printf "\e[1;30m"
    for ((i = 0; i < unfilled_length; i++)); do printf "─"; done
    printf "\e[0m] \e[1;37m %2d%%\e[0m\n" "$RAM_USAGE_PERCENT"

    printf "\e[1;36m╰────────────────────────────────╯\e[0m\n"

    printf "\e[1;33mpress 'q' to exit: \e[0m"
}

while true; do
    monitor_usage
    sleep 2
    read -rt 2 -n 1 key
    if [[ "$key" == "q" ]]; then
        echo -e "\nExiting..."
        break
    fi
done
