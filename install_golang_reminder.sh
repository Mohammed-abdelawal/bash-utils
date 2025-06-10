#!/bin/bash
# Install autostart entry for golang_reminder.sh

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
AUTOSTART_DIR="$HOME/.config/autostart"

mkdir -p "$AUTOSTART_DIR"

cat > "$AUTOSTART_DIR/golang_reminder.desktop" <<EOL
[Desktop Entry]
Type=Application
Exec=$SCRIPT_DIR/golang_reminder.sh
Hidden=false
NoDisplay=false
X-GNOME-Autostart-enabled=true
Name=Golang Reminder
Comment=Remember to learn Golang every day
EOL

echo "Autostart entry created at $AUTOSTART_DIR/golang_reminder.desktop"
