#!/bin/bash
# Claude Code Power Pack Installation Script

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}"
echo "╔═══════════════════════════════════════╗"
echo "║   Claude Code Ultimate Power Pack     ║"
echo "║        Installation Script            ║"
echo "╚═══════════════════════════════════════╝"
echo -e "${NC}"

# Check if running from the right directory
if [ ! -f "CLAUDE_POWER_PACK_PLAN.md" ]; then
    echo -e "${RED}Error: Please run this script from the claude-power-pack directory${NC}"
    exit 1
fi

# Create ~/.claude directory structure
echo -e "${YELLOW}Creating directory structure...${NC}"
mkdir -p ~/.claude/{commands,hooks/pre_tool_use,hooks/post_tool_use,hooks/notification,hooks/stop,scripts,personas}

# Copy commands
echo -e "${YELLOW}Installing commands...${NC}"
cp -r commands/* ~/.claude/commands/
echo -e "${GREEN}✅ Commands installed${NC}"

# Copy hooks
echo -e "${YELLOW}Installing hooks...${NC}"
cp -r hooks/pre_tool_use/* ~/.claude/hooks/pre_tool_use/
cp -r hooks/post_tool_use/* ~/.claude/hooks/post_tool_use/
cp -r hooks/notification/* ~/.claude/hooks/notification/
cp -r hooks/stop/* ~/.claude/hooks/stop/
echo -e "${GREEN}✅ Hooks installed${NC}"

# Make hook scripts executable
chmod +x ~/.claude/hooks/**/*.py

# Copy scripts
echo -e "${YELLOW}Installing automation scripts...${NC}"
cp -r scripts/* ~/.claude/scripts/
chmod +x ~/.claude/scripts/*.sh
echo -e "${GREEN}✅ Scripts installed${NC}"

# Copy personas
echo -e "${YELLOW}Installing personas...${NC}"
cp -r personas/* ~/.claude/personas/
echo -e "${GREEN}✅ Personas installed${NC}"

# Handle settings.json
echo -e "${YELLOW}Configuring settings...${NC}"
if [ -f ~/.claude/settings.json ]; then
    echo -e "${YELLOW}⚠️  Existing settings.json found${NC}"
    echo "Would you like to:"
    echo "1) Backup existing and install new settings"
    echo "2) Keep existing settings"
    read -p "Choice (1/2): " choice
    
    if [ "$choice" = "1" ]; then
        mv ~/.claude/settings.json ~/.claude/settings.json.backup.$(date +%Y%m%d_%H%M%S)
        cp settings.json ~/.claude/settings.json
        echo -e "${GREEN}✅ Settings installed (old settings backed up)${NC}"
    else
        echo -e "${BLUE}Keeping existing settings${NC}"
    fi
else
    cp settings.json ~/.claude/settings.json
    echo -e "${GREEN}✅ Settings installed${NC}"
fi

# Set up shell aliases (optional)
echo ""
echo -e "${YELLOW}Would you like to add helpful aliases to your shell? (y/n)${NC}"
read -p "> " add_aliases

if [ "$add_aliases" = "y" ] || [ "$add_aliases" = "Y" ]; then
    SHELL_RC=""
    
    # Detect shell
    if [ -n "$ZSH_VERSION" ]; then
        SHELL_RC="$HOME/.zshrc"
    elif [ -n "$BASH_VERSION" ]; then
        SHELL_RC="$HOME/.bashrc"
    fi
    
    if [ -n "$SHELL_RC" ]; then
        echo "" >> "$SHELL_RC"
        echo "# Claude Code Power Pack Aliases" >> "$SHELL_RC"
        echo "alias cl='claude'" >> "$SHELL_RC"
        echo "alias clt='claude /think'" >> "$SHELL_RC"
        echo "alias cls='claude /ship'" >> "$SHELL_RC"
        echo "alias clr='claude /review'" >> "$SHELL_RC"
        echo "alias clp='claude /plan'" >> "$SHELL_RC"
        echo "alias cli='claude /init'" >> "$SHELL_RC"
        echo "alias clwt='~/.claude/scripts/worktree.sh'" >> "$SHELL_RC"
        echo "alias clsquad='~/.claude/scripts/parallel.sh'" >> "$SHELL_RC"
        
        echo -e "${GREEN}✅ Aliases added to $SHELL_RC${NC}"
        echo -e "${BLUE}Run 'source $SHELL_RC' to activate them${NC}"
    fi
fi

# Check for required dependencies
echo ""
echo -e "${YELLOW}Checking dependencies...${NC}"

missing_deps=()

# Check for Claude Code
if ! command -v claude &> /dev/null; then
    missing_deps+=("claude-code")
fi

# Check for tmux (for parallel execution)
if ! command -v tmux &> /dev/null; then
    missing_deps+=("tmux")
fi

# Check for git
if ! command -v git &> /dev/null; then
    missing_deps+=("git")
fi

# Check for Python 3
if ! command -v python3 &> /dev/null; then
    missing_deps+=("python3")
fi

if [ ${#missing_deps[@]} -gt 0 ]; then
    echo -e "${RED}Missing dependencies:${NC}"
    for dep in "${missing_deps[@]}"; do
        echo "  - $dep"
    done
    echo ""
    echo "Please install missing dependencies before using all features"
else
    echo -e "${GREEN}✅ All dependencies satisfied${NC}"
fi

# Success message
echo ""
echo -e "${GREEN}╔═══════════════════════════════════════╗${NC}"
echo -e "${GREEN}║    Installation Complete! 🎉          ║${NC}"
echo -e "${GREEN}╚═══════════════════════════════════════╝${NC}"
echo ""
echo "Quick Start:"
echo "1. Navigate to any project: cd /your/project"
echo "2. Initialize: claude /init"
echo "3. Start coding: claude /ship \"implement user auth\""
echo ""
echo "For parallel development:"
echo "  ~/.claude/scripts/worktree.sh task-123"
echo "  ~/.claude/scripts/parallel.sh 5"
echo ""
echo "To set up MCP servers:"
echo "  ~/.claude/scripts/mcp_setup.sh"
echo ""
echo -e "${BLUE}Happy coding, Doctor Biz! 🚀${NC}"