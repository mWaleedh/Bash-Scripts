#!/bin/bash

# Purpose:
# Quickly commit and push a single file to the current git repository.
#
# Usage:
# ./git_push_file.sh <file_name> [commit_message]
# ./git_push_file.sh all [commit_message]

if [ -z "$1" ]; then
	echo "Usage: ./git_push.sh <file_name> [commit_message] or ./git_push.sh all [commit_message]"
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
	echo "Error: Not inside a git repository"
	exit 1
fi

REPO="$(basename "$(git rev-parse --show-toplevel)")"
FILE=$1
MESSAGE=$2
SUCCESS="Pushed $FILE to $REPO"

if [ $1 = "all" ]; then
	SUCCESS="Pushed changes to $REPO"

	if [ -z "$2" ]; then
		MESSAGE="Update files"
	fi

	if git diff --quiet; then
    		echo "No changes to commit"
    		exit 0
	fi

	git add .
else
	if [ -z "$2" ]; then
		MESSAGE="Update $FILE"
	fi

	if git diff --quiet -- "$FILE"; then
    		echo "No changes to commit in $FILE"
    		exit 0
	fi

	if [ -f "$FILE" ]; then
		git add "$FILE"
	else
		echo "$FILE does not exist"
		exit 1
	fi
fi

git commit -m "$MESSAGE" >/dev/null 2>&1

git push >/dev/null 2>&1

echo "Pushed changes to $REPO"
