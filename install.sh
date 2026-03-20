#!/bin/bash
# ABOUTME: Installer for Claude Code Agentic System with HPC/GPU cluster support
# ABOUTME: Supports interactive and non-interactive modes, .env-based secret management

set -euo pipefail

# Configuration
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
VERSION="5.0.0"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
BACKUP_DIR="$HOME/.claude_backup_$TIMESTAMP"

# Mode flags
INTERACTIVE=true
HPC_MODE=false
SKIP_SHELL_CONFIG=false
SKIP_MCP=false
SKIP_WORKTREE=false

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
GRAY='\033[0;37m'
NC='\033[0m'

# Installation state
EXISTING_CLAUDE_HOME=false
EXISTING_SETTINGS=false
EXISTING_HOOKS=false

# Print colored output
log_info() { echo -e "${BLUE}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }
log_success() { echo -e "${GREEN}[SUCCESS]${NC} $1"; }

# Parse CLI arguments
parse_args() {
    while [[ $# -gt 0 ]]; do
        case "$1" in
            --non-interactive)
                INTERACTIVE=false
                shift
                ;;
            --hpc)
                HPC_MODE=true
                INTERACTIVE=false
                SKIP_SHELL_CONFIG=true
                SKIP_MCP=true
                SKIP_WORKTREE=true
                shift
                ;;
            --skip-mcp)
                SKIP_MCP=true
                shift
                ;;
            --skip-shell)
                SKIP_SHELL_CONFIG=true
                shift
                ;;
            --help|-h)
                echo "Usage: ./install.sh [OPTIONS]"
                echo ""
                echo "Options:"
                echo "  --non-interactive  Skip all prompts, use defaults"
                echo "  --hpc              HPC/GPU cluster mode (non-interactive, skip GUI/MCP)"
                echo "  --skip-mcp         Skip MCP server installation"
                echo "  --skip-shell       Skip shell RC file modifications"
                echo "  -h, --help         Show this help message"
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                exit 1
                ;;
        esac
    done
}

# Detect HPC environment automatically
detect_environment() {
    # Detect SLURM
    if command -v srun &> /dev/null || command -v sbatch &> /dev/null || [[ -n "${SLURM_JOB_ID:-}" ]]; then
        log_info "SLURM environment detected"
        HPC_MODE=true
    fi

    # Detect PBS/Torque
    if command -v qsub &> /dev/null || [[ -n "${PBS_JOBID:-}" ]]; then
        log_info "PBS/Torque environment detected"
        HPC_MODE=true
    fi

    # Detect SGE
    if command -v qsub &> /dev/null && [[ -n "${SGE_ROOT:-}" ]]; then
        log_info "SGE environment detected"
        HPC_MODE=true
    fi

    if [[ "$HPC_MODE" == true ]]; then
        log_info "HPC mode enabled - skipping GUI, VS Code, and MCP setup"
        INTERACTIVE=false
        SKIP_SHELL_CONFIG=true
        SKIP_MCP=true
        SKIP_WORKTREE=true
    fi
}

# Load .env file if present
load_env_file() {
    local env_file="$REPO_DIR/.env"
    if [[ -f "$env_file" ]]; then
        log_info "Loading environment variables from .env"
        set -a
        # shellcheck source=/dev/null
        source "$env_file"
        set +a
        log_success ".env loaded"
    else
        log_warn "No .env file found - profile templates will not be populated"
        log_info "Copy .env.example to .env and fill in your API keys"
    fi
}

show_header() {
    echo -e "${BLUE}"
    cat << 'EOF'
╔══════════════════════════════════════════════════════════════╗
║          CLAUDE CODE AGENTIC SYSTEM v5.0                    ║
║                  Safe Installation                          ║
╚══════════════════════════════════════════════════════════════╝
EOF
    echo -e "${NC}\n"
    log_info "Starting installation..."
    log_info "Repository: $REPO_DIR"
    log_info "Target: $CLAUDE_HOME"
    if [[ "$HPC_MODE" == true ]]; then
        log_info "Mode: HPC/GPU Cluster"
    elif [[ "$INTERACTIVE" == false ]]; then
        log_info "Mode: Non-interactive"
    else
        log_info "Mode: Interactive"
    fi
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
    local optional_deps=("jq" "python3" "claude" "node" "npm" "envsubst")
    local missing=()
    local missing_optional=()

    for dep in "${deps[@]}"; do
        if ! command -v "$dep" &> /dev/null; then
            missing+=("$dep")
        fi
    done

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
                "envsubst") echo "  - envsubst: Part of gettext (brew install gettext / apt-get install gettext)" ;;
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
        "$CLAUDE_HOME/agents"
        "$CLAUDE_HOME/scripts"
        "$CLAUDE_HOME/hooks/pre_tool_use"
        "$CLAUDE_HOME/hooks/post_tool_use"
        "$CLAUDE_HOME/hooks/session"
        "$CLAUDE_HOME/hooks/stop"
        "$CLAUDE_HOME/commands"
        "$CLAUDE_HOME/docs"
        "$CLAUDE_HOME/lib"
        "$CLAUDE_HOME/skills"
        "$CLAUDE_HOME/skills/learned"
        "$CLAUDE_HOME/profiles"
    )

    for dir in "${dirs[@]}"; do
        mkdir -p "$dir"
    done

    log_success "Directory structure created"
}

# Install core components
install_core_components() {
    log_info "Installing core components..."

    # Install CLAUDE.md
    if [[ -f "$REPO_DIR/CLAUDE.md" ]]; then
        cp "$REPO_DIR/CLAUDE.md" "$CLAUDE_HOME/CLAUDE.md"
        log_success "CLAUDE.md installed"
    fi

    # Install agents
    if [[ -d "$REPO_DIR/agents" ]]; then
        cp -r "$REPO_DIR/agents/"* "$CLAUDE_HOME/agents/" 2>/dev/null || true
        log_success "Agents installed"
    fi

    # Install commands
    if [[ -d "$REPO_DIR/commands" ]]; then
        cp -r "$REPO_DIR/commands/"* "$CLAUDE_HOME/commands/" 2>/dev/null || true
        log_success "Commands installed"
    fi

    # Install scripts
    if [[ -d "$REPO_DIR/scripts" ]]; then
        cp -r "$REPO_DIR/scripts/"* "$CLAUDE_HOME/scripts/" 2>/dev/null || true
        chmod +x "$CLAUDE_HOME/scripts/"*.sh 2>/dev/null || true
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

    # Install skills
    install_skills

    # Install profiles
    install_profiles

    # Install standalone files
    install_standalone_files

    # Install MCP config
    install_mcp_config
}

# Install hooks safely
install_hooks() {
    log_info "Installing hooks..."

    if [[ -d "$REPO_DIR/hooks" ]]; then
        cp -r "$REPO_DIR/hooks/"* "$CLAUDE_HOME/hooks/" 2>/dev/null || true
        find "$CLAUDE_HOME/hooks" -name "*.py" -exec chmod +x {} \; 2>/dev/null || true
        find "$CLAUDE_HOME/hooks" -name "*.sh" -exec chmod +x {} \; 2>/dev/null || true
        log_success "Hook scripts installed"
    fi
}

# Install skills directory
install_skills() {
    log_info "Installing skills..."

    if [[ -d "$REPO_DIR/skills" ]]; then
        cp -r "$REPO_DIR/skills/"* "$CLAUDE_HOME/skills/" 2>/dev/null || true
        # Ensure learned dir exists with .gitkeep
        mkdir -p "$CLAUDE_HOME/skills/learned"
        touch "$CLAUDE_HOME/skills/learned/.gitkeep"
        log_success "Skills installed"
    fi
}

# Install profiles using envsubst if available
install_profiles() {
    log_info "Installing model profiles..."

    if [[ ! -d "$REPO_DIR/profiles" ]]; then
        log_warn "No profiles directory found - skipping"
        return 0
    fi

    for example_file in "$REPO_DIR/profiles/"*.example.json; do
        [[ -f "$example_file" ]] || continue
        local basename
        basename=$(basename "$example_file" .example.json)
        local target="$CLAUDE_HOME/profiles/${basename}.json"

        # Skip if target already exists
        if [[ -f "$target" ]]; then
            log_info "Profile $basename.json already exists - skipping"
            continue
        fi

        if command -v envsubst &> /dev/null; then
            envsubst < "$example_file" > "$target"
            log_success "Profile $basename.json created (secrets substituted)"
        else
            cp "$example_file" "$target"
            log_warn "Profile $basename.json copied without secret substitution (install envsubst)"
        fi
    done

    log_success "Profiles installed"
}

# Install standalone files
install_standalone_files() {
    log_info "Installing standalone files..."

    if [[ -f "$REPO_DIR/statusline-script.sh" ]]; then
        cp "$REPO_DIR/statusline-script.sh" "$CLAUDE_HOME/statusline-script.sh"
        chmod +x "$CLAUDE_HOME/statusline-script.sh"
        log_success "Statusline script installed"
    fi

    if [[ -f "$REPO_DIR/policy-limits.json" ]]; then
        cp "$REPO_DIR/policy-limits.json" "$CLAUDE_HOME/policy-limits.json"
        log_success "Policy limits installed"
    fi
}

# Install MCP desktop config using envsubst
install_mcp_config() {
    log_info "Installing MCP configuration..."

    local example_config="$REPO_DIR/claude_desktop_config.example.json"
    local target_config="$CLAUDE_HOME/claude_desktop_config.json"

    if [[ ! -f "$example_config" ]]; then
        log_warn "No claude_desktop_config.example.json found - skipping"
        return 0
    fi

    if [[ -f "$target_config" ]]; then
        log_info "claude_desktop_config.json already exists - skipping"
        return 0
    fi

    if command -v envsubst &> /dev/null; then
        envsubst < "$example_config" > "$target_config"
        log_success "MCP config created (secrets substituted)"
    else
        cp "$example_config" "$target_config"
        log_warn "MCP config copied without secret substitution (install envsubst)"
    fi
}

# Configure Claude Code settings
configure_claude_settings() {
    log_info "Configuring Claude Code settings..."

    local settings_file="$CLAUDE_HOME/settings.json"

    if [[ "$EXISTING_SETTINGS" == true ]]; then
        log_warn "Existing settings.json found - merging configurations"
        cp "$settings_file" "$settings_file.backup_$TIMESTAMP"
        merge_settings "$settings_file"
    else
        cp "$REPO_DIR/settings.json" "$settings_file"
        log_success "New settings.json installed"
    fi

    log_success "Claude Code settings configured"
}

# Merge existing settings with new ones
merge_settings() {
    local settings_file="$1"

    if command -v jq &> /dev/null; then
        local temp_file
        temp_file=$(mktemp)
        local existing_settings
        existing_settings=$(cat "$settings_file")
        local new_settings
        new_settings=$(cat "$REPO_DIR/settings.json")

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
        log_warn "jq not available - keeping existing settings"
        log_info "Review $REPO_DIR/settings.json for new configuration options"
    fi
}

# Configure shell environment
configure_shell_environment() {
    if [[ "$SKIP_SHELL_CONFIG" == true ]]; then
        log_info "Skipping shell configuration (HPC/non-interactive mode)"
        return 0
    fi

    log_info "Configuring shell environment..."

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

    if grep -q "Claude Code" "$shell_rc"; then
        log_info "Shell environment already configured"
        return 0
    fi

    cp "$shell_rc" "${shell_rc}.backup_$TIMESTAMP"

    cat >> "$shell_rc" << 'EOF'

# Claude Code Agentic System
export PATH="$HOME/.claude/scripts:$PATH"
EOF

    log_success "Shell environment configured for $shell_name"
    log_info "Run 'source $shell_rc' or restart your terminal to activate"
}

# Setup git worktree functions
setup_git_worktree_functions() {
    if [[ "$SKIP_WORKTREE" == true ]]; then
        log_info "Skipping git worktree setup"
        return 0
    fi

    log_info "Setting up git worktree helper functions..."

    local shell_rc=""

    if [[ -n "${ZSH_VERSION:-}" ]] || [[ "$SHELL" == */zsh ]]; then
        shell_rc="$HOME/.zshrc"
    elif [[ -n "${BASH_VERSION:-}" ]] || [[ "$SHELL" == */bash ]]; then
        shell_rc="$HOME/.bashrc"
    else
        log_warn "Could not detect shell type - skipping git worktree setup"
        return 0
    fi

    if [[ ! -f "$shell_rc" ]]; then
        return 0
    fi

    if grep -q "Git worktree helper function" "$shell_rc"; then
        log_info "Git worktree functions already configured"
        return 0
    fi

    cat >> "$shell_rc" << 'WTEOF'

# Git worktree helper function
# Usage: wt <feature-name>
wt() {
    set -e
    local project_dir=$(git rev-parse --show-toplevel)
    local project_name=$(basename "$project_dir")
    local feature_name="$1"

    if [ -z "$feature_name" ]; then
        echo "Usage: wt <feature-name>"
        return 1
    fi

    local worktree_parent="$(dirname "$project_dir")/${project_name}-worktrees"
    local worktree_path="${worktree_parent}/${feature_name}"

    mkdir -p "$worktree_parent"
    git -C "$project_dir" worktree add -b "$feature_name" "$worktree_path"

    local files_to_copy=(.env .env.local .nvmrc .node-version CLAUDE.md .gitignore)
    for file in "${files_to_copy[@]}"; do
        if [ -f "$project_dir/$file" ]; then
            cp "$project_dir/$file" "$worktree_path/$file"
        fi
    done

    local hidden_dirs=(.claude .cursor .vscode)
    for dir in "${hidden_dirs[@]}"; do
        if [ -d "$project_dir/$dir" ]; then
            cp -R "$project_dir/$dir" "$worktree_path/$dir"
        fi
    done

    cd "$worktree_path"
    echo "Worktree '$feature_name' created at $worktree_path"
}

wt-list() { git worktree list; }

wt-remove() {
    local feature_name="$1"
    if [ -z "$feature_name" ]; then
        echo "Usage: wt-remove <feature-name>"
        return 1
    fi
    local project_dir=$(git rev-parse --show-toplevel)
    local project_name=$(basename "$project_dir")
    local worktree_path="$(dirname "$project_dir")/${project_name}-worktrees/${feature_name}"
    git worktree remove "$worktree_path"
    echo "Worktree '$feature_name' removed."
}
WTEOF

    log_success "Git worktree functions configured"
}

# Setup MCP servers (optional)
setup_mcp_servers() {
    if [[ "$SKIP_MCP" == true ]]; then
        log_info "Skipping MCP server setup"
        return 0
    fi

    log_info "Setting up MCP servers..."

    if ! command -v claude &> /dev/null; then
        log_warn "Claude Code not found - skipping MCP setup"
        return 0
    fi

    if ! command -v node &> /dev/null || ! command -v npx &> /dev/null; then
        log_warn "Node.js/npx not found - skipping MCP setup"
        return 0
    fi

    log_info "Installing essential MCP servers..."

    local servers=(
        "filesystem:@modelcontextprotocol/server-filesystem:$HOME"
        "sequential:@modelcontextprotocol/server-sequential-thinking:"
        "context7:@upstash/context7-mcp@latest:"
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

    if [[ -n "${GITHUB_TOKEN:-}" ]]; then
        claude mcp add -s user github -e GITHUB_TOKEN="$GITHUB_TOKEN" -- npx -y @modelcontextprotocol/server-github 2>/dev/null && \
            log_success "GitHub MCP with token installed" || \
            log_warn "GitHub MCP installation failed"
    fi

    log_success "MCP server setup complete"
}

# Run installation tests
run_tests() {
    log_info "Running installation tests..."

    local tests_passed=0
    local tests_total=0

    # Test 1: Core files
    ((tests_total++))
    if [[ -f "$CLAUDE_HOME/settings.json" ]]; then
        log_success "Settings file exists"
        ((tests_passed++))
    else
        log_error "Settings file missing"
    fi

    # Test 2: Commands
    ((tests_total++))
    if [[ -d "$CLAUDE_HOME/commands" ]] && [[ $(ls -1 "$CLAUDE_HOME/commands/"*.md 2>/dev/null | wc -l) -gt 5 ]]; then
        log_success "Commands installed"
        ((tests_passed++))
    else
        log_error "Commands missing or incomplete"
    fi

    # Test 3: Hooks
    ((tests_total++))
    if [[ -d "$CLAUDE_HOME/hooks" ]] && [[ $(find "$CLAUDE_HOME/hooks" -name "*.py" 2>/dev/null | wc -l) -gt 3 ]]; then
        log_success "Hooks installed"
        ((tests_passed++))
    else
        log_error "Hooks missing"
    fi

    # Test 4: Skills
    ((tests_total++))
    if [[ -d "$CLAUDE_HOME/skills" ]] && [[ $(ls -1d "$CLAUDE_HOME/skills/"*/ 2>/dev/null | wc -l) -gt 3 ]]; then
        log_success "Skills installed"
        ((tests_passed++))
    else
        log_warn "Skills directory sparse or missing"
    fi

    # Test 5: Profiles
    ((tests_total++))
    if [[ -d "$CLAUDE_HOME/profiles" ]]; then
        log_success "Profiles directory exists"
        ((tests_passed++))
    else
        log_error "Profiles directory missing"
    fi

    # Test 6: Agents
    ((tests_total++))
    if [[ -d "$CLAUDE_HOME/agents" ]] && [[ $(ls -1 "$CLAUDE_HOME/agents/"*.md 2>/dev/null | wc -l) -gt 1 ]]; then
        log_success "Agents installed"
        ((tests_passed++))
    else
        log_error "Agents missing"
    fi

    # Test 7: CLAUDE.md
    ((tests_total++))
    if [[ -f "$CLAUDE_HOME/CLAUDE.md" ]]; then
        log_success "CLAUDE.md installed"
        ((tests_passed++))
    else
        log_error "CLAUDE.md missing"
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

    log_success "Claude Code Agentic System v$VERSION installed successfully!"

    if [[ "$EXISTING_CLAUDE_HOME" == true ]]; then
        echo -e "\n${YELLOW}BACKUP INFORMATION:${NC}"
        echo -e "Your original configuration has been backed up to:"
        echo -e "  ${BLUE}$BACKUP_DIR${NC}"
        echo -e "Restore with:"
        echo -e "  ${GRAY}rm -rf $CLAUDE_HOME && mv $BACKUP_DIR/claude_home_backup $CLAUDE_HOME${NC}"
    fi

    if [[ "$HPC_MODE" == true ]]; then
        echo -e "\n${BLUE}HPC QUICK START:${NC}"
        echo -e "1. Verify: ${YELLOW}ls ~/.claude/settings.json${NC}"
        echo -e "2. Switch profile: ${YELLOW}cp ~/.claude/profiles/openrouter.json ~/.claude/settings.json${NC}"
        echo -e "3. Start Claude: ${YELLOW}claude${NC}"
    else
        echo -e "\n${BLUE}NEXT STEPS:${NC}"
        echo -e "1. Reload your shell: ${YELLOW}source ~/.zshrc${NC} (or ~/.bashrc)"
        echo -e "2. Test the installation: ${YELLOW}claude mcp list${NC}"
        echo -e "3. Try a command: ${YELLOW}claude /brainstorm \"test project\"${NC}"
    fi

    echo ""
}

# Main installation function
main() {
    parse_args "$@"
    detect_environment
    load_env_file
    show_header
    check_existing_installation
    check_dependencies
    create_directory_structure
    install_core_components
    configure_claude_settings
    configure_shell_environment

    if [[ "$INTERACTIVE" == true ]]; then
        echo -e "\n${YELLOW}Install git worktree helper functions? (y/N):${NC} "
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            setup_git_worktree_functions
        fi

        if command -v claude &> /dev/null && command -v node &> /dev/null; then
            echo -e "\n${YELLOW}Install MCP servers now? (y/N):${NC} "
            read -r response
            if [[ "$response" =~ ^[Yy]$ ]]; then
                setup_mcp_servers
            fi
        fi
    else
        setup_git_worktree_functions
        setup_mcp_servers
    fi

    echo ""
    run_tests
    show_completion
}

# Handle interruption
trap 'log_error "Installation interrupted"; exit 1' INT TERM

# Run main installation
main "$@"
