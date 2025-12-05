#!/usr/bin/env bash

# ----------------------------
# Ctrl+C handler
# ----------------------------
CHILD_PID=""
cleanup() {
    echo
    echo "Caught Ctrl+C — terminating dnscrypt-proxy..."
    if [[ -n "$CHILD_PID" ]]; then
        sudo kill "$CHILD_PID" 2>/dev/null
    fi

    echo "Restoring DNS..."
    echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
    exit 1
}
trap cleanup INT

# ----------------------------
# Set initial DNS
# ----------------------------
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

# ----------------------------
# Command to run
# ----------------------------
cmd='dnscrypt-proxy -config "/home/sdsaati/bin/dnscrypt.toml"'

# ----------------------------
# Start child in foreground
# ----------------------------
sudo bash -c "exec $cmd" &
CHILD_PID=$!

echo "dnscrypt-proxy started with PID $CHILD_PID"

# Give it a moment to start
sleep 1

# ----------------------------
# Set DNS to localhost
# ----------------------------
echo "nameserver 127.0.0.1" | sudo tee /etc/resolv.conf > /dev/null

# ----------------------------
# Wait for child
# ----------------------------
wait "$CHILD_PID"
STATUS=$?

# ----------------------------
# Exit handling
# ----------------------------
if [[ $STATUS -ne 0 ]]; then
    echo "dnscrypt-proxy (PID $CHILD_PID) terminated abnormally."
else
    echo "dnscrypt-proxy exited normally."
fi

# ----------------------------
# Restore DNS
# ----------------------------
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null
