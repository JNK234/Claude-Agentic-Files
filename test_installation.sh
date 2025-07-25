#!/bin/bash
# test_installation.sh - Test script for Claude Agnetic System installation

set -euo pipefail

# Colors
YELLOW='\033[1;33m'
GREEN='\033[0;32m'
RED='\033[0;31m'
GRAY='\033[0;37m'
NC='\033[0m'

# Test configuration
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
TOTAL_TESTS=0
PASSED_TESTS=0
FAILED_TESTS=0

# Test functions
test_file_exists() {
    local file="$1"
    local description="$2"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    if [[ -f "$file" ]]; then
        echo -e "${GREEN}✓${NC} $description"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        return 0
    else
        echo -e "${RED}✗${NC} $description"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
}

test_directory_exists() {
    local dir="$1"
    local description="$2"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    if [[ -d "$dir" ]]; then
        echo -e "${GREEN}✓${NC} $description"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        return 0
    else
        echo -e "${RED}✗${NC} $description"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
}

test_executable() {
    local file="$1"
    local description="$2"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    if [[ -f "$file" && -x "$file" ]]; then
        echo -e "${GREEN}✓${NC} $description"
        PASSED_TESTS=$((PASSED_TESTS + 1))
        return 0
    else
        echo -e "${RED}✗${NC} $description"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
}

test_mcp_servers() {
    local description="MCP server connections"
    
    TOTAL_TESTS=$((TOTAL_TESTS + 1))
    
    # Check if claude command exists
    if ! command -v claude &> /dev/null; then
        echo -e "${RED}✗${NC} $description (Claude Code not found)"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
    
    # Check MCP server status
    local mcp_output
    if mcp_output=$(claude mcp list 2>/dev/null); then
        local connected_servers
        connected_servers=$(echo "$mcp_output" | grep -c "✓ Connected" || echo "0")
        
        if [[ "$connected_servers" -gt 0 ]]; then
            echo -e "${GREEN}✓${NC} $description ($connected_servers servers connected)"
            PASSED_TESTS=$((PASSED_TESTS + 1))
            return 0
        else
            echo -e "${YELLOW}⚠${NC} $description (no servers connected - run mcp_setup.sh)"
            PASSED_TESTS=$((PASSED_TESTS + 1))
            return 0
        fi
    else
        echo -e "${RED}✗${NC} $description (MCP system not working)"
        FAILED_TESTS=$((FAILED_TESTS + 1))
        return 1
    fi
}

# Main test function
run_tests() {
    echo -e "${YELLOW}🦇 Testing Claude Agnetic System Installation${NC}"
    echo -e "${GRAY}═══════════════════════════════════════════${NC}"
    echo
    
    # Test core directories
    echo -e "${YELLOW}Testing Core Directories:${NC}"
    test_directory_exists "$CLAUDE_HOME" "Claude home directory"
    test_directory_exists "$CLAUDE_HOME/lib" "Core libraries directory"
    test_directory_exists "$CLAUDE_HOME/commands" "Commands directory"
    test_directory_exists "$CLAUDE_HOME/personas" "Personas directory"
    test_directory_exists "$CLAUDE_HOME/mcp" "MCP directory"
    test_directory_exists "$CLAUDE_HOME/orchestrator" "Orchestrator directory"
    test_directory_exists "$CLAUDE_HOME/hooks" "Hooks directory"
    test_directory_exists "$CLAUDE_HOME/docs" "Documentation directory"
    echo
    
    # Test core files
    echo -e "${YELLOW}Testing Core Files:${NC}"
    test_file_exists "$CLAUDE_HOME/settings.json" "Settings configuration"
    test_file_exists "$CLAUDE_HOME/lib/utils.sh" "Core utilities"
    test_file_exists "$CLAUDE_HOME/lib/context.sh" "Context analysis"
    test_file_exists "$CLAUDE_HOME/lib/cache.sh" "Cache system"
    test_file_exists "$CLAUDE_HOME/lib/batman.sh" "Batman theme"
    echo
    
    # Test MCP system
    echo -e "${YELLOW}Testing MCP System:${NC}"
    test_directory_exists "$CLAUDE_HOME/mcp" "MCP directory"
    
    # Test MCP server connections
    test_mcp_servers
    echo
    
    # Test persona system
    echo -e "${YELLOW}Testing Persona System:${NC}"
    test_file_exists "$CLAUDE_HOME/personas/lib/activation.sh" "Persona activation"
    test_file_exists "$CLAUDE_HOME/personas/profiles/master_wayne.json" "Master Wayne persona"
    test_file_exists "$CLAUDE_HOME/personas/profiles/architect.json" "Architect persona"
    test_file_exists "$CLAUDE_HOME/personas/profiles/frontend.json" "Frontend persona"
    test_file_exists "$CLAUDE_HOME/personas/profiles/backend.json" "Backend persona"
    echo
    
    # Test commands
    echo -e "${YELLOW}Testing Commands:${NC}"
    test_file_exists "$CLAUDE_HOME/commands/think.md" "Enhanced think command"
    test_file_exists "$CLAUDE_HOME/commands/ship.md" "Enhanced ship command"
    test_file_exists "$CLAUDE_HOME/commands/review.md" "Enhanced review command"
    test_file_exists "$CLAUDE_HOME/commands/implement.md" "New implement command"
    test_file_exists "$CLAUDE_HOME/commands/architect.md" "New architect command"
    test_file_exists "$CLAUDE_HOME/commands/ui.md" "New UI command"
    test_file_exists "$CLAUDE_HOME/commands/debug.md" "New debug command"
    test_file_exists "$CLAUDE_HOME/commands/test-e2e.md" "New E2E test command"
    echo
    
    # Test orchestrator
    echo -e "${YELLOW}Testing Orchestrator:${NC}"
    test_file_exists "$CLAUDE_HOME/orchestrator/waves.sh" "Wave orchestration"
    test_directory_exists "$CLAUDE_HOME/orchestrator/state" "Orchestrator state"
    test_directory_exists "$CLAUDE_HOME/orchestrator/logs" "Orchestrator logs"
    echo
    
    # Test hooks
    echo -e "${YELLOW}Testing Hooks:${NC}"
    test_executable "$CLAUDE_HOME/hooks/notification/voice_notify.py" "Voice notification hook"
    test_executable "$CLAUDE_HOME/hooks/post_tool_use/progress_tracker.py" "Progress tracker hook"
    test_executable "$CLAUDE_HOME/hooks/stop/session_logger.py" "Session logger hook"
    echo
    
    # Test documentation
    echo -e "${YELLOW}Testing Documentation:${NC}"
    test_file_exists "$CLAUDE_HOME/docs/README.md" "Main documentation"
    test_file_exists "$CLAUDE_HOME/docs/USER_GUIDE.md" "User guide"
    echo
    
    # Test executables
    echo -e "${YELLOW}Testing Executables:${NC}"
    test_executable "$CLAUDE_HOME/mcp/manage.sh" "MCP management script"
    test_executable "$CLAUDE_HOME/personas/manage.sh" "Persona management script"
    test_executable "$CLAUDE_HOME/orchestrator/waves.sh" "Wave orchestration script"
    echo
    
    # Show results
    echo -e "${GRAY}═══════════════════════════════════════════${NC}"
    echo -e "${YELLOW}Test Results:${NC}"
    echo -e "Total tests: $TOTAL_TESTS"
    echo -e "Passed: ${GREEN}$PASSED_TESTS${NC}"
    echo -e "Failed: ${RED}$FAILED_TESTS${NC}"
    
    if [[ $FAILED_TESTS -eq 0 ]]; then
        echo -e "\n${GREEN}🦇 All tests passed! The Batcave is ready for action.${NC}"
        return 0
    else
        echo -e "\n${RED}🦇 Some tests failed. Please check the installation.${NC}"
        return 1
    fi
}

# Run the tests
run_tests