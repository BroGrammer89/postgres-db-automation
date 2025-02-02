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