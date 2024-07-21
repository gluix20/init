#!/bin/bash

# Get the directory of the current script
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Check if the repo directory is already in PATH
if [[ ":$PATH:" != *":$REPO_DIR:"* ]]; then
    export PATH=$REPO_DIR:$PATH

    # Append to .zprofile only if it's not already present
    if ! grep -q "export PATH=$REPO_DIR:\$PATH" ~/.zprofile; then
        echo -e "\n# Setup for using gluix20/init scripts\nexport PATH=$REPO_DIR:\$PATH" >> ~/.zprofile
    fi

    # Source the profile to update the current session
    source ~/.zprofile

    echo "Setup complete. You can now use 'init.sh' from any directory."
else
    echo "The repository directory is already in PATH."
fi
