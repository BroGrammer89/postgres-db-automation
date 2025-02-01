# Stop the PostgreSQL container
Write-Host "Stopping PostgreSQL container..."
$containerId = podman ps --filter "name=my_postgres" --format "{{.ID}}"
if ($containerId) {
    podman stop $containerId
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to stop PostgreSQL container."
        exit 1
    }
    Write-Host "PostgreSQL container stopped."
} else {
    Write-Host "No PostgreSQL container found."
}

# Remove the PostgreSQL container
Write-Host "Removing PostgreSQL container..."
if ($containerId) {
    podman rm $containerId
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to remove PostgreSQL container."
        exit 1
    }
    Write-Host "PostgreSQL container removed."
} else {
    Write-Host "No PostgreSQL container found."
}

# Remove the PostgreSQL image
Write-Host "Removing PostgreSQL image..."
$imageId = podman images --filter "reference=docker.io/library/postgres:latest" --format "{{.ID}}"
if ($imageId) {
    podman rmi $imageId
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to remove PostgreSQL image."
        exit 1
    }
    Write-Host "PostgreSQL image removed."
} else {
    Write-Host "No PostgreSQL image found."
}

# Prune all volumes
Write-Host "Pruning all volumes..."
podman volume prune -f
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to prune volumes."
    exit 1
}
Write-Host "All volumes pruned."

Write-Host "Teardown complete."