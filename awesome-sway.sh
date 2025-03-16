#!/usr/bin/env bash

# Start Sway Compositor (Mali) in the background with minimal configuration
# /usr/bin/sway /dev/null & disown

# Wait for a short moment to ensure compositor is ready (optional, might be needed in some cases)
sleep 1

# Start AwesomeWM
exec /usr/local/bin/awesome
