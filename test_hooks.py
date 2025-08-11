#!/usr/bin/env python3
"""
ABOUTME: Test script to verify hook installation and functionality
ABOUTME: Creates sample files and tests the linting and formatting hooks
"""

import os
import tempfile
import subprocess
import json

def test_hook(hook_path, tool_data):
    """Test a hook with given tool data"""
    try:
        result = subprocess.run(
            ['python3', hook_path],
            input=json.dumps(tool_data),
            text=True,
            capture_output=True,
            timeout=10
        )
        
        if result.returncode == 0:
            try:
                response = json.loads(result.stdout)
                return True, response.get('message', 'Hook executed successfully')
            except json.JSONDecodeError:
                return True, result.stdout or 'Hook executed successfully'
        else:
            return False, result.stderr or 'Hook failed'
    except Exception as e:
        return False, str(e)

def main():
    claude_dir = os.path.expanduser("~/.claude")
    hooks_dir = os.path.join(claude_dir, "hooks")
    
    print("🦇 BATCAVE HOOK VERIFICATION")
    print("============================")
    
    # Test hooks
    hooks_to_test = [
        ("pre_tool_use/safety_guard.py", {
            "tool": "Bash",
            "input": {"command": "echo 'test'"}
        }),
        ("pre_tool_use/context_validator.py", {
            "tool_name": "Read",
            "parameters": {"file_path": "/tmp/test.txt"}
        }),
        ("post_tool_use/auto_format.py", {
            "tool": "Write",
            "input": {"file_path": "/tmp/test.py"}
        }),
        ("post_tool_use/linter_check.py", {
            "tool": "Write",
            "input": {"file_path": "/tmp/test.py"}
        }),
        ("post_tool_use/progress_tracker.py", {
            "tool_name": "Write",
            "parameters": {"file_path": "/tmp/test.py"},
            "success": True
        })
    ]
    
    for hook_path, test_data in hooks_to_test:
        full_path = os.path.join(hooks_dir, hook_path)
        hook_name = os.path.basename(hook_path)
        
        if os.path.exists(full_path):
            success, message = test_hook(full_path, test_data)
            status = "✅" if success else "❌"
            print(f"{status} {hook_name}: {message}")
        else:
            print(f"❌ {hook_name}: Not found at {full_path}")
    
    print("\n🦇 Hook verification complete!")

if __name__ == "__main__":
    main()
