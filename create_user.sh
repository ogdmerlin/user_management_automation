#!/bin/bash

LOG_FILE="/var/log/user_management.log"
PASSWORD_FILE="/var/secure/user_passwords.txt"

# Check for root privileges
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run with root privileges." >&2
  exit 1
fi

# Check if user file is provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 users.txt file is needed"
    exit 1
fi

# Create necessary folders and files
mkdir -p /var/secure
chmod 700 /var/secure

touch "$PASSWORD_FILE"
chmod 600 "$PASSWORD_FILE"

touch "$LOG_FILE"
chmod 600 "$LOG_FILE"

# Function to generate random password
generate_password() {
    openssl rand -base64 8
}

# Function to log messages
log_message() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

# Process each line in the text file
while IFS=';' read -r username groups; do
    username=$(echo "$username" | xargs) # Remove leading/trailing whitespace
    groups=$(echo "$groups" | xargs)     # Remove leading/trailing whitespace

    if id "$username" &>/dev/null; then
        log_message "User $username already exists."
        continue
    fi

    # Create user with home directory and personal group
    useradd -m -s /bin/bash "$username"
    log_message "Created user $username with personal group."

    # Add user to additional groups
    IFS=',' read -r -a group_array <<< "$groups"
    for group in "${group_array[@]}"; do
        group=$(echo "$group" | xargs) # Remove leading/trailing whitespace
        if ! getent group "$group" &>/dev/null; then
            groupadd "$group"
            log_message "Created group $group."
        fi
        usermod -aG "$group" "$username"
        log_message "Added user $username to group $group."
    done

    # Generate and store random password
    password=$(generate_password)
    echo "$username,$password" >> "$PASSWORD_FILE"
    echo "$username:$password" | chpasswd
    log_message "Set password for user $username."

done < "$1"

log_message "User creation process completed."

echo done