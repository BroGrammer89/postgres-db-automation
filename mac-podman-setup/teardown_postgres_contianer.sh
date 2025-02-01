#!/bin/bash

# Stop the PostgreSQL container
echo "Stopping PostgreSQL container..."
container_id=$(podman ps --filter "name=my_postgres" --format "{{.ID}}")
if [ -n "$container_id" ]; then
    podman stop "$container_id"
    if [ $? -ne 0 ]; then
        echo "Failed to stop PostgreSQL container."
        exit 1
    fi
    echo "PostgreSQL container stopped."
else
    echo "No PostgreSQL container found."
fi

# Remove the PostgreSQL container
echo "Removing PostgreSQL container..."
if [ -n "$container_id" ]; then
    podman rm "$container_id"
    if [ $? -ne 0 ]; then
        echo "Failed to remove PostgreSQL container."
        exit 1
    fi
    echo "PostgreSQL container removed."
else
    echo "No PostgreSQL container found."
fi

# Remove the PostgreSQL image
echo "Removing PostgreSQL image..."
image_id=$(podman images --filter "reference=docker.io/library/postgres:latest" --format "{{.ID}}")
if [ -n "$image_id" ]; then
    podman rmi "$image_id"
    if [ $? -ne 0 ]; then
        echo "Failed to remove PostgreSQL image."
        exit 1
    fi
    echo "PostgreSQL image removed."
else
    echo "No PostgreSQL image found."
fi

# Prune all volumes
echo "Pruning all volumes..."
podman volume prune -f
if [ $? -ne 0 ]; then
    echo "Failed to prune volumes."
    exit 1
fi
echo "All volumes pruned."

echo "Teardown complete."