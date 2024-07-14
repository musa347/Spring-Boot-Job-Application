#!/bin/bash

git status

ignore_files=".idea .DS_Store  .idea/sonarlint git.sh"
read -p "Enter additional file(s) to ignore (separated by spaces, leave empty to use default): " more_ignore_files
if [ -n "$more_ignore_files" ]; then
    ignore_files="$ignore_files $more_ignore_files"
fi

read -p "Switch to a new 'feature/MIA' branch (y), 'dev' branch (d), or continue in the active branch (n)? " branch_option
if [ "$branch_option" == "y" ]; then
    read -p "Enter the 'MIA' part of the branch name: " new_branch_name
    new_branch="feature/$new_branch_name"
    git checkout -b $new_branch
elif [ "$branch_option" == "d" ]; then
    git checkout dev
elif [ "$branch_option" == "n" ]; then
    echo "Continuing in the active branch."
else
    echo "Invalid option. Exiting script."
    exit 1
fi

read -p "Add all files (y/n)? " add_all
if [ "$add_all" == "y" ]; then
    git add -A
else
    read -p "Enter file(s) to add (separated by spaces): " files
    git add $files
fi

read -p "Message: " message
branch=$(git rev-parse --abbrev-ref HEAD)

if [ -n "$ignore_files" ]; then
    git commit -m "$message" -- . ":(exclude)$ignore_files"
else
    git commit -m "$message"
fi

git push -u origin $branch
