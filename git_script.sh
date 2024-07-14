#!/bin/bash

read -p "Message: " message
branch=$(git rev-parse --abbrev-ref HEAD)

git add -A
git commit -m "$message"
git push -u origin $branch
