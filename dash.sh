#!/bin/bash

# SSH Functions
ssh_namecheap_login() { ssh -v namerabiaa; }
ssh_hostinger_architopiahub_login() { ssh -v hostinger_architopiahub; }
ssh_digitalocean_architopiahub_login() { ssh -v digitalocean_architopiahub; }
open_azurealaatest() { ssh -v AzureAlaaTest; }
open_digitalocean_odoo() { ssh -v digitaloceanOdoo; }

# Directories
dirs=(
  "mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/WAW/admin_service_backend"
  "mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/WAW/api_user_service_backend"
  "mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/WAW/business_admin_service_backend"
  "mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/WAW/checkout_service_backend"
  "mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/WAW/devops"
  "mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/WAW/location_service_backend"
  "mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/WAW/user_service_backend"

  ### Archi
  "mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/archi.local"
  "mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/archi-front-dev"
)

# SSH Functions Array and Names
ssh_functions=(
  ssh_namecheap_login
  ssh_hostinger_architopiahub_login
  ssh_digitalocean_architopiahub_login
  open_azurealaatest
  open_digitalocean_odoo
)

ssh_names=(
  "Namecheap SSH"
  "Hostinger Architopiahub SSH"
  "DigitalOcean Architopiahub SSH"
  "AzureAlaaTest SSH"
  "DigitalOcean Odoo SSH"
)

# Function to open all directories
open_all_dirs() {
  for dir in "${dirs[@]}"; do
    full_path="/$dir"
    if [[ -d "$full_path" ]]; then
      cd "$full_path"
      echo "Entered: $(basename $dir)"
      code .
      cd - > /dev/null
    else
      echo "Warning: Directory not found: $full_path"
    fi
  done
}

# Function to handle directory selection
handle_directory_selection() {
  for choice in "$@"; do # Iterate over all arguments passed
    if [[ "$choice" -ge 1 && "$choice" -le "${#dirs[@]}" ]]; then
      selected_dir="${dirs[$((choice - 1))]}"
      cd "/$selected_dir"
      echo "Entered: $(basename $selected_dir)"
      code .
      cd - > /dev/null
    else
      echo "Invalid choice: $choice"
    fi
  done
}

# Function to handle SSH selection
handle_ssh_selection() {
  if [[ "$1" -ge 1 && "$1" -le "${#ssh_functions[@]}" ]]; then
    ssh_function="${ssh_functions[$((1 - 1))]}" # corrected line
    ssh_function="${ssh_functions[$(( $1 - 1))]}"
    "$ssh_function"
  else
    echo "Invalid choice."
  fi
}

# Main Logic
if [[ "$1" == "--go" ]]; then
  shift
  if [[ $# -eq 0 ]]; then
    echo "Usage: $0 --go <number> [<number> ...] or $0 --go '*'"
    exit 1
  fi
  if [[ "$1" == "*" ]]; then
    open_all_dirs
  else
    handle_directory_selection "$@"
  fi
elif [[ "$1" == "--ss" ]]; then
  shift
  if [[ $# -eq 0 ]]; then
    echo "Usage: $0 --ss <number>"
    exit 1
  fi
  handle_ssh_selection "$1"
elif [[ -z "$1" ]]; then
  while true; do
    echo "Choose an option:"
    echo "0. Exit"
    echo "1. Open Directories"
    echo "2. SSH Connections"
    read -p "Enter your choice: " main_choice
    case "$main_choice" in
      0) echo "Exiting."; exit 0 ;;
      1)
        while true; do
          echo "Choose a directory (or multiple separated by spaces, or * for all, or 0 to return):"
          echo "0. Return to main menu"
          for i in "${!dirs[@]}"; do
            echo "$((i + 1)). $(basename ${dirs[i]})"
          done
          read -p "Enter the number(s): " choices
          if [[ "$choices" == "0" ]]; then break; fi
          if [[ "$choices" == "*" ]]; then open_all_dirs; break; fi
          read -ra choice_array <<< "$choices"
          valid_choices=true
          for choice in "${choice_array[@]}"; do
            if [[ ! "$choice" =~ ^[0-9]+$ ]] || [[ "$choice" -lt 1 || "$choice" -gt "${#dirs[@]}" ]]; then
              valid_choices=false; echo "Invalid choice: $choice"; break
            fi
          done
          if $valid_choices; then handle_directory_selection "$choices"; break; else echo "Invalid choice(s), please try again."; fi
        done
        ;;
      2)
        while true; do
          echo "Choose an SSH connection (or 0 to return):"
          echo "0. Return to main menu"
          for i in "${!ssh_names[@]}"; do
            echo "$((i + 1)). ${ssh_names[i]}"
          done
          read -p "Enter your choice: " ssh_choice
          if [[ "$ssh_choice" == "0" ]]; then break; fi
          handle_ssh_selection "$ssh_choice"
        done
        ;;
      *) echo "Invalid choice." ;;
    esac
  done
else
  echo "Usage: $0 [--go <number> [<number> ...] or --go '*']"
fi

echo "Done."