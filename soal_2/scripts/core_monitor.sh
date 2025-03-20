#!/bin/bash

LOG_DIR="./log"
LOG_FILE="$LOG_DIR/core.log"

mkdir -p "$LOG_DIR"

monitor_cpu_usage() {
  CPU_MODEL=$(sysctl -n machdep.cpu.brand_string)
  TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

  CPU_USAGE=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | tr -d '%')

  echo "[$TIMESTAMP] - Core Usage [$CPU_USAGE%] - Terminal Model [$CPU_MODEL]" >> "$LOG_FILE"

  clear
  printf "\e[1;36m==============================\e[0m\n"
  printf "\e[1;32m   🖥️ Arcaea Core Monitoring  \e[0m\n"
  printf "\e[1;36m==============================\e[0m\n"
  printf "\e[1;33m CPU Model: \e[0m%s \e[0m\n" "$CPU_MODEL" 
  printf "\e[1;34m CPU Usage: \e[0m %s%%\n" "$CPU_USAGE"
  printf "\e[1;36m==============================\e[0m\n"
  
  printf "\e[1;33mpress 'q' to exit: \e[0m"
}

while true; do
    monitor_cpu_usage
    sleep 2 
    read -rt 2 -n 1 key
    if [[ "$key" == "q" ]]; then
        echo -e "\nExiting Core Monitor..."
        break 
    fi

done
