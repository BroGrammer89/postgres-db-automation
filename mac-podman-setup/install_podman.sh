#!/bin/bash

# Function to check if a command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Homebrew is installed
if ! command_exists brew; then
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

# Check if Podman is installed, if not, install it using Homebrew
if ! command_exists podman; then
    echo "Podman is not installed. Installing Podman using Homebrew..."
    brew install podman
    if [ $? -ne 0 ]; then
        echo "Failed to install Podman."
        exit 1
    fi
fi

# Check if pip is installed, if not, install it
if ! command_exists pip3; then
    echo "pip3 is not installed. Please install pip3 first."
    exit 1
fi

# Check if podman-compose is installed, if not, install it using pip
if ! command_exists podman-compose; then
    echo "podman-compose is not installed. Installing podman-compose using pip..."
    pip3 install podman-compose
    if [ $? -ne 0 ]; then
        echo "Failed to install podman-compose."
        exit 1
    fi
fi

# Initialize Podman machine
echo "Initializing Podman machine..."
podman machine init
if [ $? -ne 0 ]; then
    echo "Failed to initialize Podman machine."
    exit 1
fi

echo "Podman machine initialized successfully."