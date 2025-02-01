# Function to check if a command exists
function CommandExists {
    param (
        [string]$command
    )
    $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
}

# Check if winget is installed
if (-not (CommandExists "winget")) {
    Write-Host "winget is not installed. Please install winget first."
    exit 1
}

# Check if Podman is installed, if not, install it using winget
if (-not (CommandExists "podman")) {
    Write-Host "Podman is not installed. Installing Podman using winget..."
    winget install --id=RedHat.Podman -e
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to install Podman."
        exit 1
    }
    
    # Delay to ensure system recognizes Podman installation
    Write-Host "Waiting for system to recognize Podman installation..."
    Start-Sleep -Seconds 10
}

# Check if pip is installed, if not, install it
if (-not (CommandExists "pip")) {
    Write-Host "pip is not installed. Please install pip first."
    exit 1
}

# Check if podman-compose is installed, if not, install it using pip
if (-not (CommandExists "podman-compose")) {
    Write-Host "podman-compose is not installed. Installing podman-compose using pip..."
    pip install podman-compose
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Failed to install podman-compose."
        exit 1
    }
}

# Initialize Podman machine
Write-Host "Initializing Podman machine..."
podman machine init
if ($LASTEXITCODE -ne 0) {
    Write-Host "Failed to initialize Podman machine."
    exit 1
}

Write-Host "Podman machine initialized successfully."