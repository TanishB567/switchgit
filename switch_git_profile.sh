#!/bin/zsh

# Script to switch Git profiles

switch_git_profile() {
    local profile=$1
    local git_email
    local git_name
    local ssh_key

    case $profile in
        "work")
            git_email="workemail@work.com"
            git_name="workUsername"
            ssh_key="$HOME/.ssh/locationOfWorkSshKey"
            ;;
        "personal")
            git_email="personalemail@email.com"
            git_name="personalUsername"
            ssh_key="$HOME/.ssh/locationOfPersonalSshKey"
            ;;
        *)
            echo "Invalid profile. Use 'work' or 'personal'."
            return 1
            ;;
    esac

    # Set Git configuration
    git config --global user.email "$git_email"
    git config --global user.name "$git_name"

    # Set SSH key (optional, depends on your setup)
    ssh-add -D  # Clear all identities first
    ssh-add "$ssh_key"

    echo "Switched to $profile profile:"
    echo "Email: $git_email"
    echo "Name: $git_name"
    echo "SSH Key: $ssh_key"
}

# Check if a profile argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 [work|personal]"
    exit 1
fi

# Call the function with the provided argument
switch_git_profile "$1"
