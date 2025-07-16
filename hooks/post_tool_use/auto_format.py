#!/usr/bin/env python3
"""
Auto-format code after file modifications
"""

import json
import sys
import subprocess
import os

FORMATTERS = {
    # JavaScript/TypeScript
    ('.js', '.jsx', '.ts', '.tsx'): ['prettier', '--write'],
    ('.json',): ['prettier', '--write'],
    
    # Python
    ('.py',): ['black'],
    
    # Go
    ('.go',): ['gofmt', '-w'],
    
    # Rust
    ('.rs',): ['rustfmt'],
    
    # Ruby
    ('.rb',): ['rubocop', '-a'],
    
    # CSS/SCSS
    ('.css', '.scss', '.sass'): ['prettier', '--write'],
    
    # Markdown
    ('.md',): ['prettier', '--write'],
    
    # YAML
    ('.yml', '.yaml'): ['prettier', '--write'],
}

def format_file(file_path):
    """Format a file based on its extension"""
    if not os.path.exists(file_path):
        return
    
    # Find appropriate formatter
    for extensions, formatter_cmd in FORMATTERS.items():
        if any(file_path.endswith(ext) for ext in extensions):
            try:
                # Check if formatter exists
                subprocess.run(['which', formatter_cmd[0]], 
                             check=True, capture_output=True)
                
                # Run formatter
                cmd = formatter_cmd + [file_path]
                subprocess.run(cmd, capture_output=True)
                
            except subprocess.CalledProcessError:
                # Formatter not installed, skip
                pass
            break

def main():
    """Main entry point for the hook"""
    try:
        # Read tool use from stdin
        tool_use = json.load(sys.stdin)
        
        # Check if it's a file modification tool
        if tool_use.get("tool") in ["Write", "Edit", "MultiEdit"]:
            file_path = tool_use.get("input", {}).get("file_path")
            
            if file_path:
                format_file(file_path)
        
        # Always allow (this is post-tool)
        print(json.dumps({"action": "allow"}))
        
    except Exception as e:
        # Don't block on formatting errors
        print(json.dumps({"action": "allow"}))

if __name__ == "__main__":
    main()