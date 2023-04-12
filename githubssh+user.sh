# #!/bin/bash

# # Read GitHub username and PAT from user input
# read -p "Enter your GitHub username: " username
# read -sp "Enter your Personal Access Token: " pat

# # Generate SSH key
# ssh-keygen -t ed25519 -C "${username}" -f "${HOME}/.ssh/github_${username}"

# # Get the contents of the public key
# pubkey="$(cat ${HOME}/.ssh/github_${username}.pub)"

# # Create the SSH key in GitHub using the GitHub API
# curl -u "${username}:${pat}" --data "{\"title\":\"GitHub SSH Key\",\"key\":\"${pubkey}\"}" https://api.github.com/user/keys

# echo "SSH key created successfully!"

#=====================================================================================================================================
# changes made
#=====================================================================================================================================

# This script allows a user to generate an SSH key pair and add the public key to their GitHub account using the GitHub API. 
# It prompts the user to enter their GitHub username and Personal Access Token (PAT), then generates an SSH key pair using the 
# ed25519 algorithm with the entered username as the comment. It then gets the contents of the public key and creates a new SSH 
# key in the user's GitHub account using the GitHub API, using the entered GitHub username and PAT to authenticate the request. 
# Finally, it prints a success message to the console.

# Here is a modified version of the script with some improvements:


#!/bin/bash

# Prompt user for GitHub username and PAT
read -p "Enter your GitHub username: " username
read -sp "Enter your Personal Access Token: " pat

# Generate SSH key
ssh-keygen -t ed25519 -C "${username}" -f "${HOME}/.ssh/github_${username}"

# Read contents of public key into variable
pubkey="$(< "${HOME}/.ssh/github_${username}.pub")"

# Add SSH key to GitHub account using API
response=$(curl -s -u "${username}:${pat}" -d "{\"title\":\"GitHub SSH Key\",\"key\":\"${pubkey}\"}" https://api.github.com/user/keys)

# Check if API request was successful
if [[ "$response" == *"id"* ]]; then
  echo "SSH key added to GitHub account successfully!"
else
  echo "Error adding SSH key to GitHub account. Response: ${response}"
fi


# Improvements made:

#     Added a more informative success/error message after adding the SSH key to the GitHub account.
#     Used the $() syntax to read the contents of the public key into a variable, rather than using cat.
#     Added the -s flag to curl to suppress the progress meter and only show the response from the API.
#     Added a check to see if the API request was successful, by checking if the response contains the id field that GitHub returns when an SSH key is added successfully. If the response does not contain id, it is assumed that the API request failed.

# Note that this script assumes that the user has already set up a PAT with sufficient permissions to add SSH keys to their GitHub account.