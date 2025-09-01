#!/usr/bin/env python3

from pathlib import Path
import os

PROJECT_DIR = Path.home() / "volatility-mcp-server"
TESTS_DIR = PROJECT_DIR / "tests"

test_content = '''#!/usr/bin/env python3
"""
Test script for Volatility3 MCP Server
"""

import json
import asyncio
import sys
from pathlib import Path

# Add project to path
sys.path.insert(0, str(Path(__file__).parent.parent / "src"))

async def test_mcp_server():
    """Test basic MCP server functionality"""
    print("Testing Volatility3 MCP Server...")
    print("-" * 50)
    
    # Test imports
    try:
        import mcp_server
        print("OK - MCP server module imported successfully")
    except ImportError as e:
        print(f"ERROR - Failed to import MCP server: {e}")
        print("Make sure to copy the full mcp_server_adaptive.py content to src/mcp_server.py")
        return
    
    # List expected tools
    print("\\nExpected tools:")
    tools = [
        "load_memory_image",
        "get_image_info",
        "list_available_plugins",
        "build_plugin_command",
        "execute_plugin",
        "analyze_error",
        "suggest_plugins",
        "batch_execute",
        "generate_documentation"
    ]
    for tool in tools:
        print(f"  - {tool}")
    
    print("\\nTest completed!")

if __name__ == "__main__":
    asyncio.run(test_mcp_server())
'''

# Write test script
TESTS_DIR.mkdir(parents=True, exist_ok=True)
test_file = TESTS_DIR / "test_server.py"
with open(test_file, 'w') as f:
    f.write(test_content)

print(f"Created test script at: {test_file}")

# Make it executable on Linux
if os.name != 'nt':
    os.chmod(test_file, 0o755)