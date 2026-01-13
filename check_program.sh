#!/bin/bash

# Problem:
# Check if a program is installed and show its version if available

if [ -z "$1" ]; then
	echo "Error: Program name not provided"
	echo "Usage: $0 <program_name>"
	exit 1
fi

PROGRAM=$1

if command -v "$PROGRAM" >/dev/null 2>&1; then
	echo "Program is installed"

	if "$PROGRAM" --version >/dev/null 2>&1; then
		"$PROGRAM" --version | head -n 1
	else
		echo "Version info not available"
	fi
else
	echo "$PROGRAM not installed"
	echo "Install with: sudo apt install $PROGRAM"
fi
