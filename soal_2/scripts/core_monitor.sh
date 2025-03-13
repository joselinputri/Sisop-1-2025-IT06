#!/bin/bash

monitor_cpu_usage() {
    CPU_MODEL=$(sysctl -n machdep.cpu.brand_string)

    while true; do
        clear
        CPU_USAGE=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | tr -d '%')

        printf "\033[1;36m==============================\033[0m\n"
        printf "\033[1;32m   🖥️ Arcaea Core Monitoring  \033[0m\n"
        printf "\033[1;36m==============================\033[0m\n"
        printf "\033[1;33m CPU Model: \033[0m%s\n" "$CPU_MODEL"
        printf "\033[1;34m CPU Usage: \033[0m%s%%\n" "$CPU_USAGE"
        printf "\033[1;36m==============================\033[0m\n"
        printf "\033[1;31m Press 'q' to exit... \033[0m\n"
        
        read -rt 2 -n 1 key
        if [[ "$key" == "q" ]]; then
            echo -e "\nExiting CPU Monitor..."
            break
        fi

        sleep 100
    done
}
