#!/usr/bin/env python3

import json
import os
from pathlib import Path

# Determine the project directory
PROJECT_DIR = Path.home() / "volatility-mcp-server"
CONFIG_DIR = PROJECT_DIR / "config"

# Create config directory
CONFIG_DIR.mkdir(parents=True, exist_ok=True)

# Get the username
username = os.environ.get('USERNAME' if os.name == 'nt' else 'USER', 'user')

# Windows MCP configuration - using forward slashes for better compatibility
windows_mcp_config = {
    "servers": {
        "volatility3-mcp": {
            "command": "python",
            "args": [
                str(PROJECT_DIR / "launcher.py").replace('\\', '\\')
            ],
            "type": "stdio",
            "env": {
                "PYTHONPATH": str(PROJECT_DIR / "volatility3").replace('\\', '\\')
            }
        }
    },
    "inputs": []
}

# Save Windows config
windows_config_file = CONFIG_DIR / "mcp_windows.json"
with open(windows_config_file, 'w') as f:
    json.dump(windows_mcp_config, f, indent=2)
print(f"Created Windows MCP config at: {windows_config_file}")


# Print the configs for user reference
print("\n" + "="*60)
print("WINDOWS MCP CONFIG (mcp_windows.json): ")
print("="*60 + "\n")


print(json.dumps(windows_mcp_config, indent=2) + "\n")


print("="*65)
print("Copy the above JSON into your MCP configuration file of VS Code.")
print("="*65)