#!/bin/sh

# @raycast.schemaVersion 1
# @raycast.title Convert Clipboard to Jira Syntax
# @raycast.mode silent
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon 💻
#
# Documentation:
# @raycast.description Convert markdown in clipboard to Jira Syntax to clipboard
# @raycast.author Aleksey Shalynin
# @raycast.authorURL https://github.com/visheshell

LANG=en_US.UTF-8 pbpaste | pandoc -f markdown -t jira -s | LANG=en_US.UTF-8 pbcopy | echo "Jira Markup in your Clipboard 🪄"
