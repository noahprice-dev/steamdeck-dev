#!/bin/bash

# Start up services for steamdeck dev
set -e # exit on error


# Full path to sys binaries thru Nix
TAILSCALE_BIN="/home/deck/.nix-profile/bin/tailscale"

# Check if user is running as root or with sudo
# We need sudo to use systemctl gracefully
if [[$EUID -ne 0]]; then
    echo "This script requires root priveleges. Please run with sudo:"
    echo "sudo $0"
    exit 1
fi

echo "Stopping Tailscale..."

sudo "$TAILSCALE_BIN" down
systemctl stop tailscaled

if ! systemctl is-active --quiet tailscaled; then
    echo "Tailscale is now stopped.."
else
    echo "Failed to stop tailscale."
    exit 1
fi

echo "Tailscale stopped successfully."




