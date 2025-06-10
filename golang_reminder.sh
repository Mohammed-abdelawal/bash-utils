#!/bin/bash
# Display a reminder to learn Golang at login.

if command -v notify-send >/dev/null 2>&1; then
    notify-send "Reminder" "It's time to learn Golang!"
else
    echo "It's time to learn Golang!"
fi
