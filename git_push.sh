#!/bin/bash

# Purpose:
# Quickly commit and push changes to the current git repository.
#
# Usage:
# ./git_push.sh <file_name> [commit_message] | ./git_push.sh all [commit_message]

if [ -z "$1" ]; then
    echo "Usage: ./git_push.sh <file_name> [commit_message] | ./git_push.sh all [commit_message]"
    exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: Not inside a git repository"
    exit 1
fi

REPO="$(basename "$(git rev-parse --show-toplevel)")"
FILE="$1"
MESSAGE="$2"

if [ "$FILE" = "all" ]; then
    MESSAGE="${MESSAGE:-Update all files}"

    git add .

    if git diff --cached --quiet; then
        echo "No changes to commit"
        exit 0
    fi

    git commit -m "$MESSAGE"
    git push

    echo "Pushed all changes to $REPO"
    exit 0
fi

if [ ! -f "$FILE" ]; then
    echo "Error: $FILE does not exist"
    exit 1
fi

MESSAGE="${MESSAGE:-Update $FILE}"

git add "$FILE"

if git diff --cached --quiet; then
    echo "No changes to commit in $FILE"
    exit 0
fi

git commit -m "$MESSAGE"
git push

echo "Pushed $FILE to $REPO"