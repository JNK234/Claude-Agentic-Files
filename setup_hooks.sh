#!/bin/bash
# ABOUTME: Installation script for Claude Code hooks with linting and formatting capabilities
# ABOUTME: Sets up the complete hook system including dependencies and configuration

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Batman-themed messages
echo -e "${BLUE}🦇 BATCAVE INITIALIZATION SEQUENCE${NC}"
echo -e "${BLUE}=====================================${NC}"

# Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
    echo -e "${RED}❌ Claude Code not found. Please install Claude Code first.${NC}"
    echo -e "${YELLOW}Visit: https://docs.anthropic.com/en/docs/claude-code${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Claude Code detected${NC}"

# Define paths
CLAUDE_DIR="$HOME/.claude"
HOOKS_DIR="$CLAUDE_DIR/hooks"
PROJECT_DIR="$(pwd)"

# Create Claude directory structure if it doesn't exist
echo -e "${BLUE}🏗️  Setting up Batcave directory structure...${NC}"
mkdir -p "$HOOKS_DIR"/{pre_tool_use,post_tool_use,notification,stop}

# Function to copy and make executable
copy_hook() {
    local source="$1"
    local dest="$2"
    local name="$3"
    
    if [[ -f "$source" ]]; then
        cp "$source" "$dest"
        chmod +x "$dest"
        echo -e "${GREEN}✅ Installed $name${NC}"
    else
        echo -e "${YELLOW}⚠️  $name not found at $source${NC}"
    fi
}

# Install hooks
echo -e "${BLUE}🔧 Installing Batcave hook systems...${NC}"

# Pre-tool use hooks
copy_hook "$PROJECT_DIR/hooks/pre_tool_use/safety_guard.py" "$HOOKS_DIR/pre_tool_use/safety_guard.py" "Safety Guard"
copy_hook "$PROJECT_DIR/hooks/pre_tool_use/context_validator.py" "$HOOKS_DIR/pre_tool_use/context_validator.py" "Context Validator"

# Post-tool use hooks
copy_hook "$PROJECT_DIR/hooks/post_tool_use/auto_format.py" "$HOOKS_DIR/post_tool_use/auto_format.py" "Auto Formatter"
copy_hook "$PROJECT_DIR/hooks/post_tool_use/progress_tracker.py" "$HOOKS_DIR/post_tool_use/progress_tracker.py" "Progress Tracker"
copy_hook "$PROJECT_DIR/hooks/post_tool_use/linter_check.py" "$HOOKS_DIR/post_tool_use/linter_check.py" "Linter Check"

# Notification hooks
copy_hook "$PROJECT_DIR/hooks/notification/voice_notify.py" "$HOOKS_DIR/notification/voice_notify.py" "Voice Notifications"

# Stop hooks
copy_hook "$PROJECT_DIR/hooks/stop/session_logger.py" "$HOOKS_DIR/stop/session_logger.py" "Session Logger"

# Install settings.json
echo -e "${BLUE}⚙️  Configuring Batcave settings...${NC}"
if [[ -f "$CLAUDE_DIR/settings.json" ]]; then
    # Backup existing settings
    cp "$CLAUDE_DIR/settings.json" "$CLAUDE_DIR/settings.json.backup_$(date +%Y%m%d_%H%M%S)"
    echo -e "${YELLOW}📦 Backed up existing settings${NC}"
fi

if [[ -f "$PROJECT_DIR/settings.json" ]]; then
    cp "$PROJECT_DIR/settings.json" "$CLAUDE_DIR/settings.json"
    echo -e "${GREEN}✅ Installed Batcave configuration${NC}"
else
    echo -e "${YELLOW}⚠️  settings.json not found in project directory${NC}"
fi

# Check and install dependencies
echo -e "${BLUE}📦 Installing Wayne Tech dependencies...${NC}"

# Check Node.js and npm
if command -v npm &> /dev/null; then
    echo -e "${GREEN}✅ npm detected${NC}"
    
    # Install JavaScript/TypeScript formatters and linters
    echo -e "${BLUE}   Installing JavaScript/TypeScript tools...${NC}"
    npm install -g prettier eslint typescript @typescript-eslint/parser @typescript-eslint/eslint-plugin 2>/dev/null || {
        echo -e "${YELLOW}⚠️  Could not install global npm packages. You may need to install them manually:${NC}"
        echo -e "${YELLOW}   npm install -g prettier eslint typescript @typescript-eslint/parser @typescript-eslint/eslint-plugin${NC}"
    }
else
    echo -e "${YELLOW}⚠️  npm not found. JavaScript/TypeScript linting will be limited.${NC}"
    echo -e "${YELLOW}   Install Node.js from: https://nodejs.org/${NC}"
fi

# Check Python and install Python tools
if command -v python3 &> /dev/null; then
    echo -e "${GREEN}✅ Python 3 detected${NC}"
    
    echo -e "${BLUE}   Installing Python tools...${NC}"
    # Install Python formatters and linters
    python3 -m pip install black flake8 mypy pylint 2>/dev/null || {
        echo -e "${YELLOW}⚠️  Could not install Python packages. You may need to install them manually:${NC}"
        echo -e "${YELLOW}   pip install black flake8 mypy pylint${NC}"
    }
else
    echo -e "${YELLOW}⚠️  Python 3 not found. Python linting will not work.${NC}"
    echo -e "${YELLOW}   Install Python from: https://python.org/${NC}"
fi

# Check other tools
echo -e "${BLUE}🔍 Checking additional tools...${NC}"

# Go formatter
if command -v gofmt &> /dev/null; then
    echo -e "${GREEN}✅ Go formatter available${NC}"
else
    echo -e "${YELLOW}⚠️  gofmt not found (install Go for Go file formatting)${NC}"
fi

# Rust formatter
if command -v rustfmt &> /dev/null; then
    echo -e "${GREEN}✅ Rust formatter available${NC}"
else
    echo -e "${YELLOW}⚠️  rustfmt not found (install Rust for Rust file formatting)${NC}"
fi

# Ruby formatter
if command -v rubocop &> /dev/null; then
    echo -e "${GREEN}✅ Ruby formatter available${NC}"
else
    echo -e "${YELLOW}⚠️  rubocop not found (gem install rubocop for Ruby formatting)${NC}"
fi

# Text-to-Speech check
if command -v say &> /dev/null; then
    echo -e "${GREEN}✅ macOS Text-to-Speech available${NC}"
elif command -v espeak &> /dev/null; then
    echo -e "${GREEN}✅ Linux Text-to-Speech available${NC}"
else
    echo -e "${YELLOW}⚠️  Text-to-Speech not available (voice notifications disabled)${NC}"
fi

# Create test files for verification
echo -e "${BLUE}🧪 Creating verification scripts...${NC}"

cat > "$PROJECT_DIR/test_hooks.py" << 'EOF'
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
EOF

chmod +x "$PROJECT_DIR/test_hooks.py"

# Final success message
echo -e "${GREEN}"
echo "🦇 BATCAVE INITIALIZATION COMPLETE!"
echo "=================================="
echo -e "${NC}"
echo -e "${BLUE}Next steps:${NC}"
echo -e "${YELLOW}1. Run verification: ${NC}python3 test_hooks.py"
echo -e "${YELLOW}2. Start Claude Code in any project${NC}"
echo -e "${YELLOW}3. Create/edit files to see hooks in action${NC}"
echo ""
echo -e "${BLUE}Hook Features Active:${NC}"
echo -e "${GREEN}✅ Safety Guard - Blocks dangerous commands${NC}"
echo -e "${GREEN}✅ Context Validator - Validates file operations${NC}"
echo -e "${GREEN}✅ Auto Formatter - Formats code automatically${NC}"
echo -e "${GREEN}✅ Linter Check - Validates TypeScript/Python code${NC}"
echo -e "${GREEN}✅ Progress Tracker - Batman-themed progress updates${NC}"
echo -e "${GREEN}✅ Voice Notifications - Audio feedback${NC}"
echo -e "${GREEN}✅ Session Logger - Detailed session reports${NC}"
echo ""
echo -e "${BLUE}Master Wayne, the Batcave is ready for operations! 🦇${NC}"