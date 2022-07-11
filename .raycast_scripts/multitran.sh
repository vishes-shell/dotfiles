#!/bin/bash

# @raycast.title Translate with Multitran
# @raycast.author Aleksey Shalynin
# @raycast.authorURL https://github.com/visheshell
# @raycast.description Search translation with multitran

# @raycast.icon images/multitran.png
# @raycast.mode silent
# @raycast.packageName Web Searches
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Search", "percentEncoded": true }

open "https://www.multitran.com/m.exe?s=${1}&l1=1&l2=2"
