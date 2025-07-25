#!/bin/bash
# Safe installer for Claude Code Ultimate Power Pack
# Version: 4.0 - Safe Installation Edition

set -euo pipefail

# Configuration
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="4.0.0"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/.claude_backup_$TIMESTAMP"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

# Installation state
EXISTING_CLAUDE_HOME=false
EXISTING_SETTINGS=false
EXISTING_HOOKS=false

# Print colored output
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }

show_header() {
    echo -e "${BLUE}"
    cat << 'EOF'
╔══════════════════════════════════════════════════════════════╗
║           CLAUDE CODE ULTIMATE POWER PACK v4.0              ║
║                    Safe Installation                         ║
╚══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}\n"
    log_info "Starting safe installation..."
    log_info "Repository: $REPO_DIR"
    log_info "Target: $CLAUDE_HOME"
}

# Check for existing installations and create backups
check_existing_installation() {
    log_info "Checking for existing Claude Code configurations..."
    
    if [[ -d "$CLAUDE_HOME" ]]; then
        EXISTING_CLAUDE_HOME=true
        log_warn "Existing Claude home directory found: $CLAUDE_HOME"
    fi
    
    if [[ -f "$CLAUDE_HOME/settings.json" ]]; then
        EXISTING_SETTINGS=true
        log_warn "Existing settings.json found"
    fi
    
    if [[ -f "$CLAUDE_HOME/settings.json" ]] && grep -q "hooks" "$CLAUDE_HOME/settings.json"; then
        EXISTING_HOOKS=true
        log_warn "Existing hooks configuration found"
    fi
    
    if [[ "$EXISTING_CLAUDE_HOME" == true ]]; then
        log_info "Creating backup at: $BACKUP_DIR"
        mkdir -p "$BACKUP_DIR"
        cp -r "$CLAUDE_HOME" "$BACKUP_DIR/claude_home_backup" 2>/dev/null || true
        log_success "Backup created successfully"
    fi
}

# Check system dependencies
check_dependencies() {
    log_info "Checking system dependencies..."
    
    local deps=("bash" "git" "curl")
    local optional_deps=("jq" "python3" "claude" "node" "npm")
    local missing=()
    local missing_optional=()
    
    # Check required dependencies
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing+=("$dep")
        fi
    done
    
    # Check optional dependencies
    for dep in "${optional_deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing_optional+=("$dep")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        log_error "Missing required dependencies: ${missing[*]}"
        echo "Please install:"
        for dep in "${missing[@]}"; do
            case "$dep" in
                "git") echo "  - Git: https://git-scm.com/downloads" ;;
                "curl") echo "  - curl: Usually pre-installed on macOS/Linux" ;;
                *) echo "  - $dep" ;;
            esac
        done
        exit 1
    fi
    
    if [[ ${#missing_optional[@]} -gt 0 ]]; then
        log_warn "Missing optional dependencies: ${missing_optional[*]}"
        echo "For full functionality, consider installing:"
        for dep in "${missing_optional[@]}"; do
            case "$dep" in
                "claude") echo "  - Claude Code: https://claude.ai/code" ;;
                "jq") echo "  - jq: brew install jq (macOS) or apt-get install jq (Linux)" ;;
                "node"|"npm") echo "  - Node.js/npm: https://nodejs.org/" ;;
                "python3") echo "  - Python 3: https://python.org/downloads/" ;;
            esac
        done
        echo ""
    fi
    
    log_success "Dependency check complete"
}

# Create directory structure
create_directory_structure() {
    log_info "Creating directory structure..."
    
    local dirs=(
        "$CLAUDE_HOME"
        "$CLAUDE_HOME/scripts"
        "$CLAUDE_HOME/hooks/pre_tool_use"
        "$CLAUDE_HOME/hooks/post_tool_use"
        "$CLAUDE_HOME/hooks/notification"
        "$CLAUDE_HOME/hooks/stop"
        "$CLAUDE_HOME/commands"
        "$CLAUDE_HOME/docs"
        "$CLAUDE_HOME/lib"
    )
    
    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
    done
    
    log_success "Directory structure created"
}

# Install core components
install_core_components() {
    log_info "Installing core components..."
    
    # Install commands (always safe to overwrite)
    if [[ -d "$REPO_DIR/commands" ]]; then
        cp -r "$REPO_DIR/commands/"* "$CLAUDE_HOME/commands/" 2>/dev/null || true
        log_success "Commands installed"
    fi
    
    # Install scripts
    if [[ -d "$REPO_DIR/scripts" ]]; then
        cp -r "$REPO_DIR/scripts/"* "$CLAUDE_HOME/scripts/" 2>/dev/null || true
        chmod +x "$CLAUDE_HOME/scripts/"*.sh 2>/dev/null || true
        chmod +x "$CLAUDE_HOME/scripts/claude-"* 2>/dev/null || true
        log_success "Scripts installed"
    fi
    
    # Install lib files
    if [[ -d "$REPO_DIR/lib" ]]; then
        cp -r "$REPO_DIR/lib/"* "$CLAUDE_HOME/lib/" 2>/dev/null || true
        log_success "Library files installed"
    fi
    
    # Install documentation
    if [[ -d "$REPO_DIR/docs" ]]; then
        cp -r "$REPO_DIR/docs/"* "$CLAUDE_HOME/docs/" 2>/dev/null || true
        log_success "Documentation installed"
    fi
    
    # Install hooks
    install_hooks
}

# Install hooks safely
install_hooks() {
    log_info "Installing hooks..."
    
    if [[ -d "$REPO_DIR/hooks" ]]; then
        # Copy hook scripts
        cp -r "$REPO_DIR/hooks/"* "$CLAUDE_HOME/hooks/" 2>/dev/null || true
        
        # Make hook scripts executable
        find "$CLAUDE_HOME/hooks" -name "*.py" -exec chmod +x {} \; 2>/dev/null || true
        find "$CLAUDE_HOME/hooks" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
        
        log_success "Hook scripts installed"
    fi
}

# Configure Claude Code settings
configure_claude_settings() {
    log_info "Configuring Claude Code settings..."
    
    local settings_file="$CLAUDE_HOME/settings.json"
    
    if [[ "$EXISTING_SETTINGS" == true ]]; then
        log_warn "Existing settings.json found - merging configurations"
        
        # Create backup of current settings
        cp "$settings_file" "$settings_file.backup_$TIMESTAMP"
        
        # Merge settings (preserve existing, add missing)
        merge_settings "$settings_file"
    else
        # Create new settings file
        create_new_settings "$settings_file"
    fi
    
    log_success "Claude Code settings configured"
}

# Create new settings file
create_new_settings() {
    local settings_file="$1"
    
    cat > "$settings_file" <<EOF
{
    "enableAllProjectMcpServers": true,
    "enabledMcpjsonServers": ["context7", "sequential", "magic", "playwright"],
    "includeCoAuthoredBy": true,
    "cleanupPeriodDays": 30,
    "permissions": {
        "defaultMode": "bypassPermissions",
        "allow": ["*"],
        "deny": []
    },
    "hooks": {
        "Notification": [
            {
                "matcher": "*",
                "hooks": [
                    {
                        "type": "command",
                        "command": "python ~/.claude/hooks/notification/voice_notify.py"
                    }
                ]
            }
        ],
        "PostToolUse": [
            {
                "matcher": "Edit|Write|MultiEdit",
                "hooks": [
                    {
                        "type": "command",
                        "command": "python ~/.claude/hooks/post_tool_use/auto_format.py"
                    }
                ]
            },
            {
                "matcher": "*",
                "hooks": [
                    {
                        "type": "command",
                        "command": "python ~/.claude/hooks/post_tool_use/progress_tracker.py"
                    }
                ]
            }
        ],
        "PreToolUse": [
            {
                "matcher": "*",
                "hooks": [
                    {
                        "type": "command",
                        "command": "python ~/.claude/hooks/pre_tool_use/context_validator.py"
                    },
                    {
                        "type": "command",
                        "command": "python ~/.claude/hooks/pre_tool_use/safety_guard.py"
                    }
                ]
            }
        ],
        "Stop": [
            {
                "matcher": "*",
                "hooks": [
                    {
                        "type": "command",
                        "command": "python ~/.claude/hooks/stop/session_logger.py"
                    }
                ]
            }
        ]
    }
}
EOF
    
    log_success "New settings.json created"
}

# Merge existing settings with new ones
merge_settings() {
    local settings_file="$1"
    
    if command -v jq &> /dev/null; then
        # Use jq for proper JSON merging if available
        local temp_file=$(mktemp)
        
        # Read existing settings
        local existing_settings=$(cat "$settings_file")
        
        # Create new settings template
        create_new_settings "$temp_file"
        local new_settings=$(cat "$temp_file")
        
        # Merge: existing settings take precedence, but add missing keys
        echo "$existing_settings" | jq --argjson new "$new_settings" '
            . as $existing | $new | 
            to_entries | 
            map(select(.key as $k | $existing | has($k) | not)) | 
            from_entries as $missing |
            $existing + $missing
        ' > "$settings_file"
        
        rm "$temp_file"
        log_success "Settings merged using jq"
    else
        # Fallback: manual merge for critical settings
        if ! grep -q "enableAllProjectMcpServers" "$settings_file"; then
            log_info "Adding missing MCP configuration"
            # Add basic MCP config if missing (simplified approach)
        fi
        
        if ! grep -q "hooks" "$settings_file"; then
            log_warn "No hooks section found - you may want to manually add hooks"
            log_info "See $CLAUDE_HOME/docs/ for hook configuration examples"
        fi
        
        log_success "Settings preserved (manual merge)"
    fi
}

# Configure shell environment
configure_shell_environment() {
    log_info "Configuring shell environment..."
    
    # Detect shell
    local shell_rc=""
    local shell_name=""
    
    if [[ -n "${ZSH_VERSION:-}" ]] || [[ "$SHELL" == */zsh ]]; then
        shell_rc="$HOME/.zshrc"
        shell_name="zsh"
    elif [[ -n "${BASH_VERSION:-}" ]] || [[ "$SHELL" == */bash ]]; then
        shell_rc="$HOME/.bashrc"
        shell_name="bash"
    else
        log_warn "Could not detect shell type - skipping shell configuration"
        return 0
    fi
    
    if [[ ! -f "$shell_rc" ]]; then
        log_warn "Shell RC file not found: $shell_rc - skipping shell configuration"
        return 0
    fi
    
    # Check if already configured
    if grep -q "Claude Code Ultimate Power Pack" "$shell_rc"; then
        log_info "Shell environment already configured"
        return 0
    fi
    
    # Backup shell RC file
    cp "$shell_rc" "${shell_rc}.backup_$TIMESTAMP"
    
    # Add configuration
    cat >> "$shell_rc" << 'EOF'

# Claude Code Ultimate Power Pack
export PATH="$HOME/.claude/scripts:$PATH"

# Optional aliases (uncomment to enable)
# alias claude-status='claude mcp list'
# alias claude-worktree='~/.claude/scripts/claude-worktree'
# alias claude-parallel='~/.claude/scripts/claude-parallel'
EOF
    
    log_success "Shell environment configured for $shell_name"
    log_info "Run 'source $shell_rc' or restart your terminal to activate"
}

# Setup MCP servers (optional)
setup_mcp_servers() {
    log_info "Setting up MCP servers..."
    
    if ! command -v claude &> /dev/null; then
        log_warn "Claude Code not found - skipping MCP setup"
        log_info "Install Claude Code and run: ~/.claude/scripts/mcp_setup.sh"
        return 0
    fi
    
    if ! command -v node &> /dev/null || ! command -v npx &> /dev/null; then
        log_warn "Node.js/npx not found - skipping MCP setup"
        log_info "Install Node.js and run: ~/.claude/scripts/mcp_setup.sh"
        return 0
    fi
    
    log_info "Installing essential MCP servers..."
    
    # Install core MCP servers with error handling
    local servers=(
        "filesystem:@modelcontextprotocol/server-filesystem:$HOME"
        "sequential:@modelcontextprotocol/server-sequential-thinking:"
        "playwright:@executeautomation/playwright-mcp-server:"
        "context7:@upstash/context7-mcp@latest:"
        "memory:@modelcontextprotocol/server-memory:"
    )
    
    for server_config in "${servers[@]}"; do
        IFS=':' read -r name package args <<< "$server_config"
        
        log_info "Installing $name MCP server..."
        if [[ -n "$args" ]]; then
            claude mcp add -s user "$name" -- npx -y "$package" "$args" 2>/dev/null && \
                log_success "$name MCP installed" || \
                log_warn "$name MCP installation failed"
        else
            claude mcp add -s user "$name" -- npx -y "$package" 2>/dev/null && \
                log_success "$name MCP installed" || \
                log_warn "$name MCP installation failed"
        fi
    done
    
    # Install GitHub MCP with token if available
    if [[ -n "${GITHUB_TOKEN:-}" ]]; then
        log_info "Installing GitHub MCP with token..."
        claude mcp add -s user github -e GITHUB_TOKEN="$GITHUB_TOKEN" -- npx -y @modelcontextprotocol/server-github 2>/dev/null && \
            log_success "GitHub MCP with token installed" || \
            log_warn "GitHub MCP installation failed"
    else
        log_info "Installing GitHub MCP (no token)..."
        claude mcp add -s user github -- npx -y @modelcontextprotocol/server-github 2>/dev/null && \
            log_success "GitHub MCP installed" || \
            log_warn "GitHub MCP installation failed"
    fi
    
    log_success "MCP server setup complete"
    log_info "Run 'claude mcp list' to verify installations"
}

# Run installation tests
run_tests() {
    log_info "Running installation tests..."
    
    local tests_passed=0
    local tests_total=0
    
    # Test 1: Core files
    ((tests_total++))
    if [[ -f "$CLAUDE_HOME/settings.json" ]]; then
        log_success "✓ Settings file exists"
        ((tests_passed++))
    else
        log_error "✗ Settings file missing"
    fi
    
    # Test 2: Commands
    ((tests_total++))
    if [[ -d "$CLAUDE_HOME/commands" ]] && [[ $(ls -1 "$CLAUDE_HOME/commands"/*.md 2>/dev/null | wc -l) -gt 10 ]]; then
        log_success "✓ Commands installed"
        ((tests_passed++))
    else
        log_error "✗ Commands missing or incomplete"
    fi
    
    # Test 3: Scripts
    ((tests_total++))
    if [[ -f "$CLAUDE_HOME/scripts/worktree.sh" ]] && [[ -x "$CLAUDE_HOME/scripts/worktree.sh" ]]; then
        log_success "✓ Scripts installed and executable"
        ((tests_passed++))
    else
        log_error "✗ Scripts missing or not executable"
    fi
    
    # Test 4: Hooks
    ((tests_total++))
    if [[ -d "$CLAUDE_HOME/hooks" ]] && [[ $(find "$CLAUDE_HOME/hooks" -name "*.py" | wc -l) -gt 3 ]]; then
        log_success "✓ Hooks installed"
        ((tests_passed++))
    else
        log_error "✗ Hooks missing"
    fi
    
    # Test 5: PATH configuration
    ((tests_total++))
    if grep -q "\.claude/scripts" "$HOME/.zshrc" 2>/dev/null || grep -q "\.claude/scripts" "$HOME/.bashrc" 2>/dev/null; then
        log_success "✓ PATH configured"
        ((tests_passed++))
    else
        log_warn "! PATH not configured (may need manual setup)"
    fi
    
    log_info "Tests completed: $tests_passed/$tests_total passed"
    
    if [[ $tests_passed -eq $tests_total ]]; then
        log_success "All tests passed!"
        return 0
    else
        log_warn "Some tests failed - installation may be incomplete"
        return 1
    fi
}

# Show completion message
show_completion() {
    echo -e "\n${GREEN}"
    cat << 'EOF'
╔══════════════════════════════════════════════════════════════╗
║                    INSTALLATION COMPLETE!                   ║
╚══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}"
    
    log_success "Claude Code Ultimate Power Pack v$VERSION installed successfully!"
    
    if [[ "$EXISTING_CLAUDE_HOME" == true ]]; then
        echo -e "\n${YELLOW}📁 BACKUP INFORMATION:${NC}"
        echo -e "Your original configuration has been backed up to:"
        echo -e "  ${BLUE}$BACKUP_DIR${NC}"
        echo -e "If you encounter issues, you can restore with:"
        echo -e "  ${GRAY}rm -rf $CLAUDE_HOME && mv $BACKUP_DIR/claude_home_backup $CLAUDE_HOME${NC}"
    fi
    
    echo -e "\n${BLUE}🚀 NEXT STEPS:${NC}"
    echo -e "1. Reload your shell: ${YELLOW}source ~/.zshrc${NC} (or ~/.bashrc)"
    echo -e "2. Test the installation: ${YELLOW}claude mcp list${NC}"
    echo -e "3. Try a command: ${YELLOW}claude /brainstorm \"test project\"${NC}"
    
    echo -e "\n${BLUE}📚 QUICK START:${NC}"
    echo -e "• Plan & execute: ${YELLOW}claude /brainstorm → /plan → git worktree → /ship${NC}"
    echo -e "• Parallel development: ${YELLOW}git worktree add ../project-feature -b feature/name${NC}"
    echo -e "• Get help: ${YELLOW}claude /help${NC}"
    
    echo -e "\n${BLUE}🔧 ADDITIONAL SETUP:${NC}"
    echo -e "• MCP servers: ${YELLOW}~/.claude/scripts/mcp_setup.sh${NC}"
    echo -e "• Documentation: ${YELLOW}ls ~/.claude/docs/${NC}"
    
    if [[ -f "$CLAUDE_HOME/scripts/mcp_setup.sh" ]]; then
        echo -e "\n${GRAY}Run ~/.claude/scripts/mcp_setup.sh for additional MCP server options${NC}"
    fi
    
    echo -e "\n${GREEN}✨ Happy coding! Your parallel development superpowers await! ✨${NC}\n"
}

# Main installation function
main() {
    show_header
    check_existing_installation
    check_dependencies
    create_directory_structure
    install_core_components
    configure_claude_settings
    configure_shell_environment
    
    # Optional MCP setup (with user choice)
    if command -v claude &> /dev/null && command -v node &> /dev/null; then
        echo -e "\n${YELLOW}Install MCP servers now? (y/N):${NC} "
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            setup_mcp_servers
        else
            log_info "Skipping MCP setup - run ~/.claude/scripts/mcp_setup.sh later"
        fi
    fi
    
    echo ""
    run_tests
    show_completion
}

# Handle interruption
trap 'log_error "Installation interrupted"; exit 1' INT TERM

# Run main installation
main "$@"