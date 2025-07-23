#!/bin/bash
# install.sh - Master installer for Claude Agnetic System v3.0

set -euo pipefail

# Configuration
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="3.0.0"
BACKUP_SUFFIX=".backup-$(date +%s)"

# Colors for Batman theme
export BLACK='\033[0;30m'
export YELLOW='\033[1;33m'
export GRAY='\033[0;37m'
export DARK_GRAY='\033[1;30m'
export WHITE='\033[1;37m'
export NC='\033[0m' # No Color

# Batman ASCII art
show_batman_logo() {
    cat << 'EOF'
       _,    _   _    ,_
  .o888P     Y8o8Y     Y888o.
 d88888      88888      88888b
d888888b_  _d88888b_  _d888888b
8888888888888888888888888888888
8888888888888888888888888888888
YJGS8P"Y888P"Y888P"Y888P"Y8888P
 Y888   '8'   Y8P   '8'   888Y
  '8o          V          o8'
    `                     `
    
    CLAUDE AGNETIC SYSTEM v3.0
    The Dark Knight of Development
EOF
}

# Installation steps
main() {
    echo -e "${YELLOW}$(show_batman_logo)${NC}"
    echo -e "\n${YELLOW}🦇 Welcome to the Batcave, Master Wayne!${NC}"
    echo -e "${GRAY}Initializing Wayne Tech systems...${NC}\n"
    
    # Pre-flight checks
    check_dependencies
    
    # Create directory structure
    create_directory_structure
    
    # Install components
    install_core_system
    install_mcp_servers
    install_persona_system
    install_commands
    install_orchestrator
    install_hooks
    install_documentation
    
    # Configure environment
    configure_environment
    
    # Run tests
    run_installation_tests
    
    # Show completion
    show_completion_message
}

check_dependencies() {
    echo -e "${GRAY}[INFO]${NC} Checking dependencies..."
    
    local deps=("bash" "jq" "curl" "git" "python3" "claude" "npm")
    local missing=()
    
    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing+=("$dep")
        fi
    done
    
    if [[ ${#missing[@]} -gt 0 ]]; then
        echo -e "${YELLOW}[ERROR]${NC} Missing dependencies: ${missing[*]}"
        echo "Please install the missing dependencies:"
        for dep in "${missing[@]}"; do
            case "$dep" in
                "claude") echo "  - Install Claude Code: https://claude.ai/code" ;;
                "jq") echo "  - Install jq: brew install jq (macOS) or apt-get install jq (Linux)" ;;
                "npm") echo "  - Install Node.js/npm: https://nodejs.org/" ;;
                *) echo "  - Install $dep" ;;
            esac
        done
        exit 1
    fi
    
    echo -e "${GRAY}[INFO]${NC} All dependencies satisfied"
}

create_directory_structure() {
    echo -e "${GRAY}[INFO]${NC} Creating Batcave directory structure..."
    
    local dirs=(
        "$CLAUDE_HOME"
        "$CLAUDE_HOME/bin"
        "$CLAUDE_HOME/lib"
        "$CLAUDE_HOME/commands"
        "$CLAUDE_HOME/hooks/pre_tool_use"
        "$CLAUDE_HOME/hooks/post_tool_use"
        "$CLAUDE_HOME/hooks/notification"
        "$CLAUDE_HOME/hooks/stop"
        "$CLAUDE_HOME/mcp/servers"
        "$CLAUDE_HOME/mcp/lib"
        "$CLAUDE_HOME/mcp/logs"
        "$CLAUDE_HOME/personas/profiles"
        "$CLAUDE_HOME/personas/lib"
        "$CLAUDE_HOME/orchestrator/state"
        "$CLAUDE_HOME/orchestrator/logs"
        "$CLAUDE_HOME/tasks"
        "$CLAUDE_HOME/scratchpads"
        "$CLAUDE_HOME/logs"
        "$CLAUDE_HOME/cache"
        "$CLAUDE_HOME/docs/getting-started"
        "$CLAUDE_HOME/docs/use-cases"
        "$CLAUDE_HOME/docs/reference"
        "$CLAUDE_HOME/docs/advanced"
        "$CLAUDE_HOME/state"
        "$CLAUDE_HOME/scripts"
    )
    
    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
    done
    
    echo -e "${GRAY}[INFO]${NC} Directory structure created"
}

install_core_system() {
    echo -e "${GRAY}[INFO]${NC} Installing core system..."
    
    # Copy core libraries
    cp -r "$REPO_DIR/lib/"* "$CLAUDE_HOME/lib/"
    
    # Copy scripts
    if [[ -d "$REPO_DIR/scripts" ]]; then
        cp -r "$REPO_DIR/scripts/"* "$CLAUDE_HOME/scripts/"
        chmod +x "$CLAUDE_HOME/scripts/"*.sh
    fi
    
    # Create default settings for Claude Code
    cat > "$CLAUDE_HOME/settings.json" <<EOF
{
    "enableAllProjectMcpServers": true,
    "enabledMcpjsonServers": ["context7", "sequential", "magic", "playwright"],
    "includeCoAuthoredBy": true,
    "cleanupPeriodDays": 30,
    "permissions": {
        "defaultMode": "bypassPermissions",
        "allow": ["*"],
        "deny": []
    }
}
EOF
    
    echo -e "${GRAY}[INFO]${NC} Core system installed"
}

install_mcp_servers() {
    echo -e "${GRAY}[INFO]${NC} Installing MCP servers..."
    
    # Copy MCP system files if they exist
    if [[ -d "$REPO_DIR/mcp" ]]; then
        cp -r "$REPO_DIR/mcp/"* "$CLAUDE_HOME/mcp/"
    fi
    
    # Copy MCP configuration file
    if [[ -f "$REPO_DIR/mcp-servers-config.json" ]]; then
        cp "$REPO_DIR/mcp-servers-config.json" "$CLAUDE_HOME/mcp/"
        echo -e "${GRAY}[INFO]${NC} MCP configuration copied"
    fi
    
    # Setup MCP servers using the new configuration system
    setup_mcp_servers_from_config
    
    echo -e "${GRAY}[INFO]${NC} MCP servers configured"
}

# New function to setup MCP servers from configuration
setup_mcp_servers_from_config() {
    local config_file="$REPO_DIR/mcp-servers-config.json"
    
    if [[ ! -f "$config_file" ]]; then
        echo -e "${YELLOW}[WARN]${NC} MCP configuration file not found: $config_file"
        return 0
    fi
    
    echo -e "${GRAY}[INFO]${NC} Setting up MCP servers from configuration..."
    
    # Remove existing servers first
    echo -e "${GRAY}[INFO]${NC} Removing existing MCP servers..."
    local servers
    if servers=$(claude mcp list --json 2>/dev/null); then
        local server_names
        server_names=$(echo "$servers" | jq -r '.[].name' 2>/dev/null || echo "")
        
        if [[ -n "$server_names" ]]; then
            while IFS= read -r server_name; do
                if [[ -n "$server_name" ]]; then
                    claude mcp remove "$server_name" 2>/dev/null || true
                fi
            done <<< "$server_names"
        fi
    fi
    
    # Install servers from the 'full' preset
    local preset_servers
    preset_servers=$(jq -r '.presets.full[]?' "$config_file" 2>/dev/null)
    
    local success_count=0
    local fail_count=0
    
    while IFS= read -r server_name; do
        if [[ -n "$server_name" ]]; then
            local server_config
            server_config=$(jq -r --arg name "$server_name" '.servers[] | select(.name == $name)' "$config_file")
            
            if [[ -n "$server_config" && "$server_config" != "null" ]]; then
                local command args transport description
                command=$(echo "$server_config" | jq -r '.command')
                args=$(echo "$server_config" | jq -r '.args[]' | tr '\n' ' ')
                transport=$(echo "$server_config" | jq -r '.transport // "stdio"')
                description=$(echo "$server_config" | jq -r '.description // "No description"')
                
                echo -e "${GRAY}[INFO]${NC} Adding $server_name: $description"
                
                local full_command="$command $args"
                
                if claude mcp add "$server_name" "$full_command" 2>/dev/null; then
                    echo -e "${GRAY}[INFO]${NC}   ✓ Added: $server_name"
                    ((success_count++))
                else
                    echo -e "${YELLOW}[WARN]${NC}   ✗ Failed to add: $server_name"
                    ((fail_count++))
                fi
            fi
        fi
    done <<< "$preset_servers"
    
    echo -e "${GRAY}[INFO]${NC} MCP Server Installation Summary:"
    echo -e "${GRAY}[INFO]${NC}   ✓ Successfully installed: $success_count servers"
    if [[ $fail_count -gt 0 ]]; then
        echo -e "${YELLOW}[WARN]${NC}   ✗ Failed to install: $fail_count servers"
    fi
}

install_persona_system() {
    echo -e "${GRAY}[INFO]${NC} Installing persona system..."
    
    # Copy persona system files
    cp -r "$REPO_DIR/personas/"* "$CLAUDE_HOME/personas/"
    
    # Setup personas
    if [[ -f "$REPO_DIR/setup/personas.sh" ]]; then
        source "$REPO_DIR/setup/personas.sh"
        setup_personas "$CLAUDE_HOME"
    fi
    
    # Ensure all persona files are executable
    chmod +x "$CLAUDE_HOME/personas/"*.sh
    
    echo -e "${GRAY}[INFO]${NC} Persona system activated"
}

install_commands() {
    echo -e "${GRAY}[INFO]${NC} Installing enhanced commands..."
    
    # Copy all command files
    cp -r "$REPO_DIR/commands/"* "$CLAUDE_HOME/commands/"
    
    echo -e "${GRAY}[INFO]${NC} Commands installed"
}

install_orchestrator() {
    echo -e "${GRAY}[INFO]${NC} Installing orchestration system..."
    
    # Copy orchestrator files
    cp -r "$REPO_DIR/orchestrator/"* "$CLAUDE_HOME/orchestrator/"
    
    # Make orchestrator scripts executable
    chmod +x "$CLAUDE_HOME/orchestrator/"*.sh
    
    echo -e "${GRAY}[INFO]${NC} Orchestrator configured"
}

install_hooks() {
    echo -e "${GRAY}[INFO]${NC} Installing Batman-themed hooks..."
    
    # Copy hook files
    cp -r "$REPO_DIR/hooks/"* "$CLAUDE_HOME/hooks/"
    
    # Make hook scripts executable
    find "$CLAUDE_HOME/hooks" -name "*.py" -exec chmod +x {} \;
    find "$CLAUDE_HOME/hooks" -name "*.sh" -exec chmod +x {} \;
    
    echo -e "${GRAY}[INFO]${NC} Hooks installed"
}

install_documentation() {
    echo -e "${GRAY}[INFO]${NC} Installing documentation..."
    
    # Copy documentation
    if [[ -d "$REPO_DIR/docs" ]]; then
        cp -r "$REPO_DIR/docs/"* "$CLAUDE_HOME/docs/"
    fi
    
    echo -e "${GRAY}[INFO]${NC} Documentation installed"
}

configure_environment() {
    echo -e "${GRAY}[INFO]${NC} Configuring environment..."
    
    # Detect shell
    local shell_rc=""
    if [[ -n "${ZSH_VERSION:-}" ]]; then
        shell_rc="$HOME/.zshrc"
    elif [[ -n "${BASH_VERSION:-}" ]]; then
        shell_rc="$HOME/.bashrc"
    else
        case "$SHELL" in
            */zsh) shell_rc="$HOME/.zshrc" ;;
            */bash) shell_rc="$HOME/.bashrc" ;;
            *) echo -e "${YELLOW}[WARN]${NC} Could not detect shell type"; return 0 ;;
        esac
    fi
    
    if [[ -n "$shell_rc" ]] && [[ -f "$shell_rc" ]]; then
        # Check if already configured
        if grep -q "Claude Agnetic System" "$shell_rc"; then
            echo -e "${GRAY}[INFO]${NC} Environment already configured"
            return 0
        fi
        
        # Backup existing rc file
        cp "$shell_rc" "${shell_rc}${BACKUP_SUFFIX}"
        
        # Add Claude configuration
        cat >> "$shell_rc" << 'EOF'

# Claude Agnetic System - The Dark Knight Edition
export CLAUDE_HOME="$HOME/.claude"
export PATH="$CLAUDE_HOME/bin:$PATH"

# Source Claude utilities
if [[ -f "$CLAUDE_HOME/lib/utils.sh" ]]; then
    source "$CLAUDE_HOME/lib/utils.sh"
fi

# Enable advanced features
export CLAUDE_MCP_ENABLED=true
export CLAUDE_PERSONAS_ENABLED=true
export CLAUDE_ORCHESTRATOR_ENABLED=true
export CLAUDE_VOICE_ENABLED=true

# Batman theme
export CLAUDE_THEME="batman"
export CLAUDE_GREETING="Master Wayne"

# Aliases
alias batman='claude'
alias batcave='cd $CLAUDE_HOME'
alias alfred='claude /help'
alias wayne='claude /personas status'
EOF
        
        echo -e "${GRAY}[INFO]${NC} Shell configuration updated"
    fi
}

run_installation_tests() {
    echo -e "${GRAY}[INFO]${NC} Running installation tests..."
    
    # Test core functionality
    if [[ -f "$CLAUDE_HOME/settings.json" ]]; then
        echo -e "${GRAY}[INFO]${NC}   ✓ Core files installed"
    else
        echo -e "${YELLOW}[ERROR]${NC}   ✗ Core files missing"
        return 1
    fi
    
    # Test MCP servers
    if command -v claude &> /dev/null && claude mcp list &> /dev/null; then
        local server_count
        server_count=$(claude mcp list 2>/dev/null | grep -c "✓ Connected" 2>/dev/null || echo "0")
        if [[ $server_count -gt 0 ]]; then
            echo -e "${GRAY}[INFO]${NC}   ✓ MCP servers configured ($server_count active)"
        else
            echo -e "${YELLOW}[WARN]${NC}   ! No active MCP servers found"
        fi
    else
        echo -e "${YELLOW}[WARN]${NC}   ! Could not test MCP servers"
    fi
    
    # Test personas
    if [[ -f "$CLAUDE_HOME/personas/profiles/master_wayne.json" ]]; then
        echo -e "${GRAY}[INFO]${NC}   ✓ Master Wayne persona ready"
    else
        echo -e "${YELLOW}[ERROR]${NC}   ✗ Master Wayne persona missing"
        return 1
    fi
    
    # Test commands
    if [[ -f "$CLAUDE_HOME/commands/think.md" ]]; then
        echo -e "${GRAY}[INFO]${NC}   ✓ Commands installed"
    else
        echo -e "${YELLOW}[ERROR]${NC}   ✗ Commands missing"
        return 1
    fi
    
    echo -e "${GRAY}[INFO]${NC} All tests passed"
}

show_completion_message() {
    echo -e "\n${YELLOW}🦇 Installation Complete!${NC}"
    echo -e "${GRAY}═══════════════════════════════════════${NC}"
    echo
    echo -e "${YELLOW}The Batcave is fully operational, Master Wayne!${NC}"
    echo
    echo -e "${WHITE}Next steps:${NC}"
    echo -e "1. Reload your shell: ${YELLOW}source ~/.zshrc${NC} (or ~/.bashrc)"
    echo -e "2. Test the system: ${YELLOW}claude /sync${NC}"
    echo -e "3. Read the guide: ${YELLOW}batman /help${NC}"
    echo
    echo -e "${WHITE}Available aliases:${NC}"
    echo -e "• ${YELLOW}batman${NC} - Same as 'claude'"
    echo -e "• ${YELLOW}batcave${NC} - Navigate to Claude home"
    echo -e "• ${YELLOW}alfred${NC} - Get help"
    echo -e "• ${YELLOW}wayne${NC} - Check persona status"
    echo
    echo -e "${WHITE}Quick start commands:${NC}"
    echo -e "• ${YELLOW}claude /think 'complex problem'${NC} - Advanced reasoning"
    echo -e "• ${YELLOW}claude /implement 'feature description'${NC} - Intelligent implementation"
    echo -e "• ${YELLOW}claude /architect 'system design'${NC} - Architecture design"
    echo -e "• ${YELLOW}claude /ui 'component description'${NC} - UI component generation"
    echo -e "• ${YELLOW}claude /review security --fix${NC} - Security review with fixes"
    echo
    echo -e "${WHITE}MCP Management:${NC}"
    echo -e "• ${YELLOW}./setup-mcp.sh preset full${NC} - Install all MCP servers"
    echo -e "• ${YELLOW}./setup-mcp.sh status${NC} - Check MCP server status"
    echo -e "• ${YELLOW}claude mcp list${NC} - List active MCP servers"
    echo
    echo -e "${YELLOW}🦇 Welcome to Wayne Enterprises. Let's protect Gotham's codebase!${NC}"
    echo -e "${GRAY}═══════════════════════════════════════${NC}"
}

# Run installation
main "$@"