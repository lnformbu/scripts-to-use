#!/bin/bash

# Read GitHub username and PAT from user input
read -p "Enter your GitHub username: " username
read -sp "Enter your Personal Access Token: " pat

# Generate SSH key
ssh-keygen -t ed25519 -C "${username}" -f "${HOME}/.ssh/github_${username}"

# Get the contents of the public key
pubkey="$(cat ${HOME}/.ssh/github_${username}.pub)"

# Create the SSH key in GitHub using the GitHub API
curl -u "${username}:${pat}" --data "{\"title\":\"GitHub SSH Key\",\"key\":\"${pubkey}\"}" https://api.github.com/user/keys

echo "SSH key created successfully!"
