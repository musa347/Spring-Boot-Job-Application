#!/bin/bash

git status

read -p "Switch to a new branch (y), 'dev' branch (d), or continue in the active branch (n)? " branch_option
if [ "$branch_option" == "y" ]; then
    read -p "Enter new branch name: " new_branch
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

git commit -m "$message"
git push -u origin $branch
