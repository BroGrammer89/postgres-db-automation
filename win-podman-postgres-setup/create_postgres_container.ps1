# Prompt the user for input
$POSTGRES_USER = Read-Host "Enter PostgreSQL user"
$POSTGRES_PASSWORD = Read-Host "Enter PostgreSQL password"
$POSTGRES_DB = Read-Host "Enter PostgreSQL database"

# Set environment variables for the current session
[System.Environment]::SetEnvironmentVariable("POSTGRES_USER", $POSTGRES_USER, [System.EnvironmentVariableTarget]::Process)
[System.Environment]::SetEnvironmentVariable("POSTGRES_PASSWORD", $POSTGRES_PASSWORD, [System.EnvironmentVariableTarget]::Process)
[System.Environment]::SetEnvironmentVariable("POSTGRES_DB", $POSTGRES_DB, [System.EnvironmentVariableTarget]::Process)

# Check if there is a Podman machine present
$podmanMachinePresent = podman machine ls | Select-String -Pattern "Name"

if ($podmanMachinePresent -eq $null) {
    Write-Host "No Podman machine found. Initializing Podman machine..."
    podman machine init
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to initialize Podman machine."
        exit 1
    }
}

# Check if the Podman machine is already running
$podmanMachineRunning = podman machine ls | Select-String -Pattern "Running"

if ($podmanMachineRunning -eq $null) {
    # Start the Podman machine
    Write-Host "Starting Podman machine..."
    podman machine start
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to start Podman machine."
        exit 1
    }

    # Delay for 45 seconds to allow the machine to boot up
    Write-Host "Waiting for Podman machine to boot up..."
    Start-Sleep -Seconds 15
} else {
    Write-Host "Podman machine is already running."
}

# Run PostgreSQL container with mounted init-db directory
Write-Host "Running PostgreSQL container..."
podman-compose up -d
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to run PostgreSQL container."
    exit 1
}

Write-Host "PostgreSQL container is running and exposed on port 5432."
Write-Host "You can connect to it using the following credentials:"
Write-Host "Host: localhost"
Write-Host "Port: 5432"
Write-Host "Username: $POSTGRES_USER"
Write-Host "Password: $POSTGRES_PASSWORD"