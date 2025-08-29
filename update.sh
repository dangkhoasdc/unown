#!/bin/bash

# Run the 'Lazy sync' command in Neovim without opening the editor
nvim --headless -c "Lazy sync" -c "qa" 2>/dev/null

# Check if the Neovim command executed successfully
if [ $? -eq 0 ]; then

    echo "✅ Neovim 'Lazy sync' completed successfully."
else
    echo "❌ Neovim command failed. Check if 'Lazy sync' is a valid command."
    exit 1
fi

# Git operations: add all changes, commit with message, and push
git add .  # Stage all changes

if git commit -am "package updates"; then
    echo "✅ Git commit created successfully."
    # Push to the remote branch (uses the current branch's upstream)
    if git push; then
        echo "✅ Changes pushed to remote branch."
    else
        echo "❌ Git push failed."
        exit 1
    fi
else
    echo "❌ Git commit failed. No changes to commit or commit message error."
    exit 1
fi
