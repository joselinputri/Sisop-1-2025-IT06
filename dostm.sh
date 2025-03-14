#!/bin/bash

speak_to_me() {
    while true; do
        curl -s https://www.affirmations.dev | awk -F'"' '{print $4}'
        sleep 1
    done
}

on_the_run() {
    bar_length=200
    progress=0
    while [ $progress -le $bar_length ]; do
        clear
        echo "*** On the Run ***"
        echo -n "["
        for ((i = 0; i < progress; i++)); do echo -n "*"; done
        for ((i = progress; i < bar_length; i++)); do echo -n " "; done
        echo "] $(($progress * 100 / $bar_length))%"
        progress=$((progress + 1))
        sleep 0.2
    done
}

time_display() {
    while true; do
        clear
        echo "~~~ Time ~~~"
        date "+%Y-%m-%d %H:%M:%S"
        sleep 1
    done
}


money() {
    symbols=('$' '€' '£' '¥' '¢' 'K' 'A' 'W' 'O' 'R' 'U' '𓆩♡𓆪')
    cols=$(tput cols)
    lines=$(tput lines)

    tput civis
    clear

    while true; do
        row=$((RANDOM % lines))
        col=$((RANDOM % cols))
        symbol="${symbols[$RANDOM % ${#symbols[@]}]}"
        color=$((RANDOM % 256))
        tput cup $row $col
        echo -ne "\e[38;5;${color}m${symbol}\e[0m"

        sleep 0.05
    done
}

brain_damage() {
    while true; do
        clear
        echo -e "\e[1;35m------ Brain Damage ------\e[0m"
        echo -e "\e[1;33mWaktu:\e[0m $(date '+%H:%M:%S')"
        echo -e "\e[1;33mLoad Average:\e[0m$(uptime | awk -F'load average:' '{print $2}')"
        echo -e "\e[1;33mTasks:\e[0m $(ps -eo stat | grep -c '^R') running, $(ps -eo stat | grep -c '^S') sleeping"
        echo -e "\e[1;34m====================================\e[0m"
        echo -e "\e[1;36mPID   USER      PR  NI    VIRT   RES  %CPU %MEM  TIME+ COMMAND\e[0m"
        
        ps -eo pid,user,pri,ni,vsize,rss,pcpu,pmem,time,comm --sort=-%cpu | head -15 | while read -r pid user pri ni virt res pcpu pmem time comm; do
            printf "\e[1;37m%-6s %-8s %-3s %-3s %-8s %-6s %-4s %-4s %-8s %-s\e[0m\n" "$pid" "$user" "$pri" "$ni" "$virt" "$res" "$pcpu" "$pmem" "$time" "$comm"
        done

        sleep 2
    done
}





case "$1" in
    --play="Speak to Me") speak_to_me ;;
    --play="On the Run") on_the_run ;;
    --play="Time") time_display ;;
    --play="Money") money ;;
    --play="Brain Damage") brain_damage ;;
    *) 
echo "Usage: $0 --play=\"<Track>\""
        echo "Available Tracks: Speak to Me, On the Run, Time, Money, Brain Damage"
        exit 1
        ;;
esac
