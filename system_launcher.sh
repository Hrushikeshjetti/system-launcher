#!/bin/bash

# Colors for better UI
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Check for dependencies
check_dependency() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "${RED}Error: $1 is not installed.${NC}"
        echo -e "Install it using: ${YELLOW}sudo apt-get install $1${NC}"
        return 1
    fi
    return 0
}

# Check required dependencies
check_dependency "neofetch" || exit 1

# Initialize custom apps array and config file
declare -A custom_apps
CUSTOM_APPS_FILE="$HOME/.config/system_launcher/custom_apps.conf"
mkdir -p "$(dirname "$CUSTOM_APPS_FILE")"
touch "$CUSTOM_APPS_FILE"

# Load custom applications from config
load_custom_apps() {
    while IFS='=' read -r name command; do
        if [[ -n "$name" && -n "$command" ]]; then
            custom_apps["$name"]="$command"
        fi
    done < "$CUSTOM_APPS_FILE"
}

# Save custom applications to config
save_custom_apps() {
    > "$CUSTOM_APPS_FILE"
    for app_name in "${!custom_apps[@]}"; do
        echo "$app_name=${custom_apps[$app_name]}" >> "$CUSTOM_APPS_FILE"
    done
}

# Function to add custom application
add_custom_app() {
    local name="$1"
    local command="$2"
    custom_apps["$name"]="$command"
    save_custom_apps
    echo -e "${GREEN}Added custom application: $name${NC}"
}

# Function to remove custom application
remove_custom_app() {
    local name="$1"
    if [[ -n "${custom_apps[$name]}" ]]; then
        unset "custom_apps[$name]"
        save_custom_apps
        echo -e "${GREEN}Removed application: $name${NC}"
    else
        echo -e "${RED}Application not found: $name${NC}"
    fi
}

# Function to open applications
open_app() {
    if command -v "$1" &> /dev/null; then
        echo -e "${GREEN}Opening $1...${NC}"
        nohup "$1" >/dev/null 2>&1 &
    else
        echo -e "${RED}$1 is not installed.${NC}"
    fi
}

# Load saved custom apps
load_custom_apps

# Main menu loop
while true; do
    clear
    echo -e "${BLUE}=== System Information and App Launcher ===${NC}"
    echo -e "${YELLOW}Fetching system information...${NC}"
    neofetch
    
    echo -e "\n${BLUE}=== Application Menu ===${NC}"
    echo -e "${GREEN}Built-in Applications:${NC}"
    echo "1. Web Browser (firefox)"
    echo "2. Text Editor (gedit)"
    echo "3. File Manager (nautilus)"
    echo "4. Terminal (gnome-terminal)"
    
    echo -e "\n${GREEN}Custom Applications:${NC}"
    current_option=5
    for app_name in "${!custom_apps[@]}"; do
        echo "$current_option. $app_name"
        ((current_option++))
    done
    
    echo -e "\n${GREEN}Management Options:${NC}"
    echo "a. Add custom application"
    echo "r. Remove custom application"
    echo "q. Exit"
    
    read -p "$(echo -e ${YELLOW}"Enter your choice: "${NC})" choice

    case $choice in
        1) open_app firefox ;;
        2) open_app gedit ;;
        3) open_app nautilus ;;
        4) open_app gnome-terminal ;;
        [5-9])
            index=$((choice - 5))
            current=0
            for app_name in "${!custom_apps[@]}"; do
                if [ $current -eq $index ]; then
                    eval "${custom_apps[$app_name]}"
                    break
                fi
                ((current++))
            done
            ;;
        "a"|"A")
            read -p "$(echo -e ${YELLOW}"Enter application name: "${NC})" app_name
            read -p "$(echo -e ${YELLOW}"Enter application command: "${NC})" app_command
            add_custom_app "$app_name" "$app_command"
            ;;
        "r"|"R")
            if [ ${#custom_apps[@]} -eq 0 ]; then
                echo -e "${RED}No custom applications to remove${NC}"
            else
                echo -e "\n${GREEN}Available custom applications:${NC}"
                for app_name in "${!custom_apps[@]}"; do
                    echo "- $app_name"
                done
                read -p "$(echo -e ${YELLOW}"Enter application name to remove: "${NC})" app_name
                remove_custom_app "$app_name"
            fi
            ;;
        "q"|"Q")
            echo -e "${GREEN}Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid choice!${NC}"
            ;;
    esac
    
    read -p "$(echo -e ${YELLOW}"Press Enter to continue..."${NC})"
done
