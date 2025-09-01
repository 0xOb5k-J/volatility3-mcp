# Volatility3 MCP Server - Create Launch Scripts (Windows)

$PROJECT_DIR = "$env:USERPROFILE\volatility-mcp-server"

Write-Host "Creating launcher scripts for Windows..." -ForegroundColor Cyan

# Create the Python launcher (cross-platform)
$launcherContent = @'
#!/usr/bin/env python3
"""
Launcher script for Volatility3 MCP Server (Windows compatible)
"""

import sys
import os
from pathlib import Path
import subprocess

# Get project directory
PROJECT_DIR = Path(__file__).parent
VENV_DIR = PROJECT_DIR / "venv"
SRC_DIR = PROJECT_DIR / "src"
VOLATILITY_DIR = PROJECT_DIR / "volatility3"

# Set environment variables
os.environ['PYTHONPATH'] = str(VOLATILITY_DIR)
os.environ['PYTHONUNBUFFERED'] = '1'

# Determine Python executable
if os.name == 'nt':  # Windows
    python_exe = VENV_DIR / "Scripts" / "python.exe"
else:  # Linux/Mac
    python_exe = VENV_DIR / "bin" / "python3"

# Check if venv exists
if not python_exe.exists():
    print(f"Error: Virtual environment not found at {VENV_DIR}")
    print("Please run the setup script first.")
    sys.exit(1)

# Run the MCP server
server_script = SRC_DIR / "mcp_server.py"
if not server_script.exists():
    print(f"Error: MCP server script not found at {server_script}")
    sys.exit(1)

# Execute the server
sys.exit(subprocess.call([str(python_exe), str(server_script)]))
'@

# Write the launcher.py file
$launcherPath = "$PROJECT_DIR\launcher.py"
$launcherContent | Out-File -FilePath $launcherPath -Encoding UTF8
Write-Host "Created launcher.py at: $launcherPath" -ForegroundColor Green

# Create a Windows batch file launcher for convenience
$batchContent = @"
@echo off
echo Starting Volatility3 MCP Server...
cd /d "$PROJECT_DIR"
python launcher.py
pause
"@

$batchPath = "$PROJECT_DIR\launch_server.bat"
$batchContent | Out-File -FilePath $batchPath -Encoding ASCII
Write-Host "Created launch_server.bat at: $batchPath" -ForegroundColor Green

Write-Host ""
Write-Host "=== Launcher Scripts Created Successfully ===" -ForegroundColor Green
Write-Host ""
Write-Host "You can now launch the server using:" -ForegroundColor Yellow
Write-Host "1. Python:      python $PROJECT_DIR\launcher.py"
Write-Host "2. Batch:       $PROJECT_DIR\launch_server.bat"