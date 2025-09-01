# Master setup script for Windows

Write-Host "=== Complete Volatility3 MCP Server Setup (Windows) ===" -ForegroundColor Cyan
Write-Host "User: $env:USERNAME"
Write-Host "Date: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')"
Write-Host ""
Write-Host "This script will set up everything automatically."
Write-Host "Press Enter to continue or Ctrl+C to cancel..."
Read-Host

try {
    # Run all setup scripts in order
    Write-Host ""
    Write-Host "Step 1: Checking prerequisites..." -ForegroundColor Yellow
    & "$PSScriptRoot\00_check_prerequisites.ps1"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Prerequisites check failed. Please install missing components." -ForegroundColor Red
        exit 1
    }

    Write-Host ""
    Write-Host "Step 2: Setting up project structure and dependencies..." -ForegroundColor Yellow
    & "$PSScriptRoot\01_setup_volatility_mcp.ps1"

    Write-Host ""
    Write-Host "Step 3: Creating MCP server..." -ForegroundColor Yellow
    python "$PSScriptRoot\02_create_mcp_server.py"

    Write-Host ""
    Write-Host "Step 4: Creating configuration files..." -ForegroundColor Yellow
    python "$PSScriptRoot\03_create_configs.py"

    Write-Host ""
    Write-Host "Step 5: Creating test scripts..." -ForegroundColor Yellow
    python "$PSScriptRoot\04_create_test_script.py"

    Write-Host ""
    Write-Host "Step 6: Creating launch scripts..." -ForegroundColor Yellow
    & "$PSScriptRoot\05_create_launch_script.ps1"

    Write-Host ""
    Write-Host "=== Setup Complete! ===" -ForegroundColor Green
    Write-Host ""
    Write-Host "Project Directory: $env:USERPROFILE\volatility-mcp-server" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "Directory Structure:" -ForegroundColor Yellow
    Write-Host "volatility-mcp-server\"
    Write-Host "  - volatility3\          # Cloned Volatility3 repository"
    Write-Host "  - src\"
    Write-Host "      - mcp_server.py     # Main MCP server"
    Write-Host "  - config\"
    Write-Host "      - mcp_windows.json  # Windows MCP configuration"
    Write-Host "  - tests\"
    Write-Host "      - test_server.py    # Test script"
    Write-Host "  - logs\                 # Server logs"
    Write-Host "  - memory_images\        # Memory image storage"
    Write-Host "  - reports\              # Generated reports"
    Write-Host "  - venv\                 # Python virtual environment"
    Write-Host "  - launcher.py           # Python launcher"
    Write-Host "  - launch_server.bat     # Batch launcher"
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Green
    Write-Host "1. Copy the full mcp_server_adaptive.py content to src\mcp_server.py"
    Write-Host "2. Place memory images in: $env:USERPROFILE\volatility-mcp-server\memory_images\"
    Write-Host "3. Test: cd $env:USERPROFILE\volatility-mcp-server; .\venv\Scripts\python tests\test_server.py"
    Write-Host "4. Launch: python launcher.py"
    Write-Host "5. Configure your MCP client with config\mcp_windows.json"
} catch {
    Write-Host "An error occurred during setup:" -ForegroundColor Red
    Write-Host $_.Exception.Message
    exit 1
}