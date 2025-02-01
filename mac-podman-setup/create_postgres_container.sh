#!/bin/bash

# Prompt the user for input
read -p "Enter PostgreSQL user: " POSTGRES_USER
read -sp "Enter PostgreSQL password: " POSTGRES_PASSWORD
echo
read -p "Enter PostgreSQL database: " POSTGRES_DB

# Export environment variables for the current session
export POSTGRES_USER
export POSTGRES_PASSWORD
export POSTGRES_DB

# Check if there is a Podman machine present
podman_machine_present=$(podman machine ls | grep "Name")

if [ -z "$podman_machine_present" ]; then
    echo "No Podman machine found. Initializing Podman machine..."
    podman machine init
    if [ $? -ne 0 ]; then
        echo "Failed to initialize Podman machine."
        exit 1
    fi
fi

# Check if the Podman machine is already running
podman_machine_running=$(podman machine ls | grep "Running")

if [ -z "$podman_machine_running" ]; then
    # Start the Podman machine
    echo "Starting Podman machine..."
    podman machine start
    if [ $? -ne 0 ]; then
        echo "Failed to start Podman machine."
        exit 1
    fi

    # Delay for 15 seconds to allow the machine to boot up
    echo "Waiting for Podman machine to boot up..."
    sleep 15
else
    echo "Podman machine is already running."
fi

# Run PostgreSQL container with mounted init-db directory
echo "Running PostgreSQL container..."
podman-compose up -d
if [ $? -ne 0 ]; then
    echo "Failed to run PostgreSQL container."
    exit 1
fi

echo "PostgreSQL container is running and exposed on port 5432."
echo "You can connect to it using the following credentials:"
echo "Host: localhost"
echo "Port: 5432"
echo "Username: $POSTGRES_USER"
echo "Password: $POSTGRES_PASSWORD"