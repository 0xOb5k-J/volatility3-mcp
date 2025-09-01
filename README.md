# Volatility3 MCP Server

A Model Context Protocol (MCP) server that integrates Volatility3 memory forensics framework with LLM-based tools.

# Demo:
https://github.com/user-attachments/assets/60936f5b-9792-45e3-8d74-9379db8b97a9

# Tested On:

- Windows 11 24h2
- Python 3.12.0
- VS Code
## Features

- **Multi-OS Support**: Automatically detects and adapts to Windows, Linux, and Mac memory images
- **Intelligent Plugin Discovery**: Dynamically discovers available plugins based on loaded image
- **Error Analysis**: Automatic error analysis with solutions and alternatives
- **Batch Processing**: Execute multiple plugins in sequence
- **Documentation Generation**: Generate comprehensive analysis reports

## Available Tools

| Tool | Description |
|------|-------------|
| `load_memory_image` | Load a memory image and auto-detect OS type (Always start here) |
| `get_image_info` | Get detailed information about the loaded memory image |
| `list_available_plugins` | List all available plugins for the current OS |
| `build_plugin_command` | Build and validate Volatility3 commands |
| `execute_plugin` | Execute a Volatility3 plugin with error handling |
| `analyze_error` | Analyze errors and provide solutions |
| `suggest_plugins` | Get plugin suggestions based on analysis goal |
| `batch_execute` | Execute multiple plugins in sequence |
| `generate_documentation` | Generate comprehensive analysis documentation |

## Installation

### Windows

```powershell
git clone https://github.com/0xOb5k-J/vol3-mcp-win.git
```

```powershell
cd vol3-mcp-win
```

```powershell
Get-ChildItem -Path . -Recurse -File | Unblock-File
```

```powershell
.\setup_all.ps1
```

## Configuration

### Windows MCP Configuration

Location: `%USERPROFILE%\volatility-mcp-server\config\mcp_windows.json`

```json
{
  "servers": {
    "volatility3-mcp": {
      "command": "python",
      "args": [
        "C:\\Users\\USERNAME\\volatility-mcp-server\\launcher.py"
      ],
      "type": "stdio",
      "env": {
        "PYTHONPATH": "C:\\Users\\USERNAME\\volatility-mcp-server\\volatility3"
      }
    }
  },
  "inputs": []
}
```

## Testing

### Test the Server

**Windows:**
```powershell
cd %USERPROFILE%\volatility-mcp-server
python launcher.py
```

---
### Using with GitHub Copilot (VSCode) as MCP Client

1. Copy the config to your MCP client configuration
2. Restart VSCode
3. The Volatility3 tools will be available in GitHub Copilot

## Directory Structure

```
volatility-mcp-server/
├── volatility3/          # Volatility3 framework
├── src/
│   └── mcp_server.py     # MCP server implementation
├── config/
│   ├── mcp_linux.json    # Linux configuration
│   └── mcp_windows.json  # Windows configuration
├── tests/
│   └── test_server.py    # Test suite
├── logs/                 # Server logs
├── memory_images/        # Memory dumps location
├── reports/              # Generated reports
├── .vscode/
│   └── settings.json     # VSCode configuration
├── venv/                 # Python virtual environment
├── launch_server.sh      # Linux launcher
└── launcher.py           # Cross-platform launcher
```

---
## Troubleshooting

### Server won't start
- Check Python version: `python3 --version` (needs 3.8+)
- Verify virtual environment exists
- Check logs in `logs/mcp_server.log`

### Memory image not loading
- Place images in `memory_images/` directory or you can just directly specify the absolute path in the chat itself.
- Check file permissions
- Verify image format compatibility

### Plugin execution fails
- Use `analyze_error()` tool for automatic diagnosis
- Check `suggest_plugins()` for alternatives
- Verify OS compatibility

## License

MIT License
