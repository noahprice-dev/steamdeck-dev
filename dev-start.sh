#!/bin/bash

# Start up services for steamdeck dev
set -e # exit on error


# Check if user is running as root or with sudo
# We need sudo to use systemctl gracefully
if [[$EUID -ne 0]]; then
    echo "This script requires root priveleges. Please run with sudo:"
    echo "sudo $0"
    exit 1
fi

echo "Starting Tailscale..."

# ? I use TailScale for my connection to get around AP isolation. YMMV.
systemctl start tailscaled
tailscale up --ssh

if systemctl is-active --quiet tailscaled; then
    echo "Tailscale is now running."
    echo "Enabling Tailscale SSH..."
else
    echo "Failed to start tailscale."
    exit 1
fi

echo "Tailscale Status:"
tailscale status
