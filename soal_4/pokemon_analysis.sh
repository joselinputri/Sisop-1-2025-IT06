#!/bin/bash

# Fungsi untuk menampilkan ASCII art
display_ascii_art() {
    cat << "EOF"

 ____   ___  _  _______ __  __  ___  _   _ 
|  _ \ / _ \| |/ / ____|  \/  |/ _ \| \ | |
| |_) | | | | ' /|  _| | |\/| | | | |  \| |
|  __/| |_| | . \| |___| |  | | |_| | |\  |
|_|    \___/|_|\_\_____|_|  |_|\___/|_| \_|

EOF
}

# Fungsi untuk menampilkan informasi umum file CSV
info() {
    local file="$1"
    highest_usage=$(sort -t, -k2 -n -r "$file" | head -n 1 | cut -d, -f1,2)
    highest_raw_usage=$(sort -t, -k3 -n -r "$file" | head -n 1 | cut -d, -f1,3)
    echo "Summary of pokemon_usage.csv"
    echo "Highest Adjusted Usage: $highest_usage"
    echo "Highest Raw Usage: $highest_raw_usage"
}

# Fungsi untuk mengurutkan Pokemon berdasarkan kolom tertentu
sort_data() {
    local file="$1"
    local sort_by="$2"
    case $sort_by in
        usage)
            sort_column=2
            ;;
        rawusage)
            sort_column=3
            ;;
        hp)
            sort_column=6
            ;;
        atk)
            sort_column=7
            ;;
        def)
            sort_column=8
            ;;
        spatk)
            sort_column=9
            ;;
        spdef)
            sort_column=10
            ;;
        speed)
            sort_column=11
            ;;
        *)
            echo "Error: invalid sort option"
            exit 1
            ;;
    esac
    sort -t, -k"$sort_column" -n -r "$file"
}

# Fungsi untuk mencari Pokemon berdasarkan nama
grep_pokemon() {
    local file="$1"
    local search="$2"
    grep -i "$search" "$file" | sort -t, -k2 -n -r
}

# Fungsi untuk memfilter Pokemon berdasarkan tipe
filter_by_type() {
    local file="$1"
    local type="$2"
    grep -i "$type" "$file" | sort -t, -k2 -n -r
}

# Fungsi untuk menampilkan bantuan
help_screen() {
    display_ascii_art
    echo "Usage: ./pokemon_analysis.sh <file> [options]"
    echo ""
    echo "Options:"
    echo "  --info                Show the summary of the CSV file"
    echo "  --sort <column>       Sort the data by the specified column (usage, rawusage, hp, atk, def, spatk, spdef, speed)"
    echo "  --grep <pokemon>      Search for a specific Pokemon by name"
    echo "  --filter <type>       Filter Pokemon by type"
    echo "  -h, --help            Display this help message"
    echo ""
    echo "Example usage:"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --info"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --sort usage"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --grep rotom"
    echo "  ./pokemon_analysis.sh pokemon_usage.csv --filter dark"
}

# Fungsi utama
main() {
    if [[ $# -lt 2 ]]; then
        echo "Error: no option provided"
        echo "Use -h or --help for more information"
        exit 1
    fi

    local file="$1"
    local option="$2"
    
    case $option in
        --info)
            info "$file"
            ;;
        --sort)
            if [[ -z "$3" ]]; then
                echo "Error: no sort option provided"
                exit 1
            fi
            sort_data "$file" "$3"
            ;;
        --grep)
            if [[ -z "$3" ]]; then
                echo "Error: no search term provided"
                exit 1
            fi
            grep_pokemon "$file" "$3"
            ;;
        --filter)
            if [[ -z "$3" ]]; then
                echo "Error: no filter option provided"
                exit 1
            fi
            filter_by_type "$file" "$3"
            ;;
        -h|--help)
            help_screen
            ;;
        *)
            echo "Error: no option provided"
            echo "Use -h or --help for more information"
            exit 1
            ;;
    esac
}

main "$@"
