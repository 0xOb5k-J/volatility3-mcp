# Volatility3 MCP Server Setup (Windows)

Write-Host "=== Setting up Volatility3 MCP Server (Windows) ===" -ForegroundColor Cyan
Write-Host ""

# Configuration
$PROJECT_NAME = "volatility-mcp-server"
$PROJECT_DIR = "$env:USERPROFILE\$PROJECT_NAME"
$VENV_DIR = "$PROJECT_DIR\venv"
$VOLATILITY_DIR = "$PROJECT_DIR\volatility3"

# Create project directory
Write-Host "Creating project directory at $PROJECT_DIR..."
New-Item -ItemType Directory -Force -Path $PROJECT_DIR | Out-Null
Set-Location $PROJECT_DIR

# Clone Volatility3
Write-Host "Cloning Volatility3..."
if (Test-Path $VOLATILITY_DIR) {
    Write-Host "Volatility3 directory already exists, pulling latest changes..." -ForegroundColor Yellow
    Set-Location $VOLATILITY_DIR
    git pull origin main 2>$null
    if ($LASTEXITCODE -ne 0) {
        git pull origin master 2>$null
    }
    Set-Location $PROJECT_DIR
} else {
    git clone https://github.com/volatilityfoundation/volatility3.git
}

# Create Python virtual environment
Write-Host "Creating Python virtual environment..."
python -m venv $VENV_DIR

# Activate virtual environment
$activateScript = "$VENV_DIR\Scripts\Activate.ps1"
if (Test-Path $activateScript) {
    & $activateScript
} else {
    Write-Host "Warning: Could not activate virtual environment automatically" -ForegroundColor Yellow
}

# Upgrade pip
Write-Host "Upgrading pip..."
& "$VENV_DIR\Scripts\python.exe" -m pip install --upgrade pip

# Install Volatility3 dependencies
Write-Host "Installing Volatility3 dependencies..."
if (Test-Path "$VOLATILITY_DIR\requirements.txt") {
    & "$VENV_DIR\Scripts\pip.exe" install -r "$VOLATILITY_DIR\requirements.txt"
}

# Install MCP server dependencies
Write-Host "Installing MCP server dependencies..."
& "$VENV_DIR\Scripts\pip.exe" install mcp pydantic typing-extensions asyncio

# Create project structure
Write-Host "Creating project structure..."
$directories = @("src", "config", "logs", "memory_images", "reports", "tests", "scripts")
foreach ($dir in $directories) {
    New-Item -ItemType Directory -Force -Path "$PROJECT_DIR\$dir" | Out-Null
}

Write-Host "OK - Project structure created successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Project location: $PROJECT_DIR"