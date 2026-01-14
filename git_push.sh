#!/bin/bash
 
if [ -z "$1" ]; then
	echo "Usage: $0 <file_name> [commit_message]"
	exit 1
fi

if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
	echo "Not inside a git repo"
	exit 1
fi

if git diff --quiet; then
    echo "No changes to commit"
    exit 0
fi

REPO="$(basename '$(git rev-parse --show-toplevel)')"
FILE=$1
MESSAGE=$2

if [ -f "$FILE" ]; then
	git add "$FILE"
else
	echo "$FILE does not exist"
	exit 1
fi

if [ -z "$MESSAGE" ]; then
	MESSAGE="update $FILE"
fi

git commit -m "$MESSAGE" >/dev/null 2>&1

git push >/dev/null 2>&1

echo "Pushed $FILE to $REPO"
