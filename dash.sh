#!/bin/bash

dirs=(
  business_admin_service_backend
  checkout_service_backend
  devops
  location_service_backend
  notification_service_backend
  user_service_backend
)

open_all_dirs() {
    for dir in "${dirs[@]}"; do
        full_path="/mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/WAW/$dir"
        if [[ -d "$full_path" ]]; then # Check if the directory exists
            cd "$full_path"
            echo "Entered: $dir"
            code .
            cd - > /dev/null
        else
            echo "Warning: Directory not found: $full_path"
        fi
    done
}

if [[ "$1" == "--go" ]]; then
  shift

  if [[ $# -eq 0 ]]; then
    echo "Usage: $0 --go <number> [<number> ...] or $0 --go '*'"
    exit 1
  fi

  if [[ "$1" == "*" ]]; then
    open_all_dirs
  else
    for choice in "$@"; do
      if [[ "$choice" -ge 1 && "$choice" -le "${#dirs[@]}" ]]; then
        selected_dir="${dirs[$((choice - 1))]}"
        cd "/mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/WAW/$selected_dir"
        echo "Entered: $selected_dir"
        code .
        cd - > /dev/null
      else
        echo "Invalid choice: $choice"
      fi
    done
  fi
elif [[ -z "$1" ]]; then
  while true; do
    echo "Choose a directory (or multiple separated by spaces, or * for all, or 0 to exit):"
    echo "0. Exit"
    for i in "${!dirs[@]}"; do
      echo "$((i + 1)). ${dirs[i]}"
    done

    read -p "Enter the number(s): " choices

    if [[ "$choices" == "0" ]]; then
        echo "Exiting."
        exit 0
    fi

    if [[ "$choices" == "*" ]]; then
        open_all_dirs
        break
    fi

    read -ra choice_array <<< "$choices"

    valid_choices=true
    for choice in "${choice_array[@]}"; do
        if [[ ! "$choice" =~ ^[0-9]+$ ]] || [[ "$choice" -lt 1 || "$choice" -gt "${#dirs[@]}" ]]; then
          valid_choices=false
          echo "Invalid choice: $choice"
          break
        fi
    done

    if $valid_choices; then
        for choice in "${choice_array[@]}"; do
            selected_dir="${dirs[$((choice - 1))]}"
            cd "/mnt/9719fc6b-332d-46b8-95fc-054a92a6caed/WAW/$selected_dir"
            echo "Entered: $selected_dir"
            code .
            cd - > /dev/null
        done
        break
    else
        echo "Invalid choice(s), please try again."
    fi
  done
else
  echo "Usage: $0 [--go <number> [<number> ...] or --go '*']"
fi