#!/bin/bash
# mcp/lib/mcp_utils.sh - MCP server integration utilities

source "${CLAUDE_HOME:-$HOME/.claude}/lib/utils.sh"
source "${CLAUDE_HOME:-$HOME/.claude}/lib/cache.sh"
source "${CLAUDE_HOME:-$HOME/.claude}/lib/batman.sh"

# MCP server configurations
MCP_CONFIG_DIR="${CLAUDE_HOME:-$HOME/.claude}/mcp/servers"
MCP_SERVERS=(
    "context7:documentation:9001"
    "sequential:analysis:9002"
    "magic:ui-generation:9003"
    "playwright:testing:9004"
)

# MCP server status tracking
MCP_STATUS_FILE="${CLAUDE_HOME:-$HOME/.claude}/mcp/status.json"

# Initialize MCP system
init_mcp_system() {
    ensure_directory "$MCP_CONFIG_DIR"
    
    # Create MCP status file
    cat > "$MCP_STATUS_FILE" <<EOF
{
    "initialized": "$(timestamp)",
    "servers": {},
    "active_servers": [],
    "last_health_check": ""
}
EOF
    
    # Create server configurations
    create_mcp_server_configs
    
    alfred_service "MCP System" "ready"
}

# Create individual MCP server configurations
create_mcp_server_configs() {
    
    # Context7 - Documentation and best practices
    cat > "$MCP_CONFIG_DIR/context7.json" <<EOF
{
    "name": "context7",
    "type": "documentation",
    "port": 9001,
    "capabilities": [
        "documentation_lookup",
        "best_practices",
        "code_examples",
        "api_reference"
    ],
    "config": {
        "sources": [
            "official_docs",
            "community_guides",
            "stackoverflow",
            "github_examples"
        ],
        "cache_ttl": 3600,
        "max_results": 10
    },
    "activation_triggers": [
        "documentation",
        "examples",
        "how-to",
        "reference",
        "guide"
    ]
}
EOF
    
    # Sequential - Deep analysis and reasoning
    cat > "$MCP_CONFIG_DIR/sequential.json" <<EOF
{
    "name": "sequential",
    "type": "analysis",
    "port": 9002,
    "capabilities": [
        "deep_analysis",
        "step_by_step_reasoning",
        "complex_problem_solving",
        "architecture_design",
        "debugging_analysis"
    ],
    "config": {
        "max_steps": 20,
        "reasoning_depth": "deep",
        "cache_ttl": 1800,
        "parallel_processing": false
    },
    "activation_triggers": [
        "analyze",
        "debug",
        "architect",
        "complex",
        "step-by-step",
        "reasoning"
    ]
}
EOF
    
    # Magic - UI component generation
    cat > "$MCP_CONFIG_DIR/magic.json" <<EOF
{
    "name": "magic",
    "type": "ui-generation",
    "port": 9003,
    "capabilities": [
        "component_generation",
        "ui_design",
        "responsive_layouts",
        "accessibility",
        "styling"
    ],
    "config": {
        "frameworks": ["react", "vue", "angular", "svelte"],
        "styling": ["css", "scss", "tailwind", "styled-components"],
        "accessibility": "wcag-aa",
        "responsive": true,
        "cache_ttl": 7200
    },
    "activation_triggers": [
        "component",
        "ui",
        "interface",
        "design",
        "layout",
        "responsive"
    ]
}
EOF
    
    # Playwright - E2E testing automation
    cat > "$MCP_CONFIG_DIR/playwright.json" <<EOF
{
    "name": "playwright",
    "type": "testing",
    "port": 9004,
    "capabilities": [
        "e2e_testing",
        "browser_automation",
        "test_generation",
        "screenshot_testing",
        "performance_testing"
    ],
    "config": {
        "browsers": ["chromium", "firefox", "webkit"],
        "headless": true,
        "screenshots": "on-failure",
        "videos": "retain-on-failure",
        "parallel": true,
        "cache_ttl": 600
    },
    "activation_triggers": [
        "test",
        "e2e",
        "browser",
        "automation",
        "playwright"
    ]
}
EOF
}

# MCP server management
start_mcp_server() {
    local server_name="$1"
    local server_config="$MCP_CONFIG_DIR/${server_name}.json"
    
    if [[ ! -f "$server_config" ]]; then
        batman_error_message "file_not_found" "MCP server config: $server_name"
        return 1
    fi
    
    local port=$(json_get "$server_config" "port")
    local type=$(json_get "$server_config" "type")
    
    # Check if server is already running
    if is_mcp_server_running "$server_name"; then
        wayne_tech_status "$server_name MCP Server" "online"
        return 0
    fi
    
    alfred_service "$server_name MCP Server" "start"
    
    # Simulate server startup (in real implementation, this would start actual MCP server)
    sleep 1
    
    # Update server status
    update_mcp_server_status "$server_name" "online" "$port"
    
    wayne_tech_status "$server_name MCP Server" "online"
    return 0
}

stop_mcp_server() {
    local server_name="$1"
    
    if ! is_mcp_server_running "$server_name"; then
        wayne_tech_status "$server_name MCP Server" "offline"
        return 0
    fi
    
    alfred_service "$server_name MCP Server" "stop"
    
    # Update server status
    update_mcp_server_status "$server_name" "offline" ""
    
    wayne_tech_status "$server_name MCP Server" "offline"
    return 0
}

# Check if MCP server is running
is_mcp_server_running() {
    local server_name="$1"
    local status=$(json_get "$MCP_STATUS_FILE" "servers.$server_name.status")
    
    [[ "$status" == "online" ]]
}

# Update MCP server status
update_mcp_server_status() {
    local server_name="$1"
    local status="$2"
    local port="$3"
    
    local temp_file=$(mktemp)
    
    jq ".servers.$server_name = {\"status\": \"$status\", \"port\": \"$port\", \"last_updated\": \"$(timestamp)\"}" \
        "$MCP_STATUS_FILE" > "$temp_file" && mv "$temp_file" "$MCP_STATUS_FILE"
    
    # Update active servers list
    if [[ "$status" == "online" ]]; then
        jq ".active_servers = (.active_servers + [\"$server_name\"] | unique)" \
            "$MCP_STATUS_FILE" > "$temp_file" && mv "$temp_file" "$MCP_STATUS_FILE"
    else
        jq ".active_servers = (.active_servers - [\"$server_name\"])" \
            "$MCP_STATUS_FILE" > "$temp_file" && mv "$temp_file" "$MCP_STATUS_FILE"
    fi
}

# Select appropriate MCP servers based on context
select_mcp_servers() {
    local command="$1"
    local complexity="$2"
    local context="$3"
    local selected_servers=()
    
    # Always consider context7 for documentation needs
    if echo "$command $context" | grep -E "(implement|help|guide|example)" >/dev/null; then
        selected_servers+=("context7")
    fi
    
    # Sequential for complex analysis
    if [[ "$complexity" == "high" || "$complexity" == "very_high" ]] || \
       echo "$command $context" | grep -E "(analyze|debug|architect|complex)" >/dev/null; then
        selected_servers+=("sequential")
    fi
    
    # Magic for UI-related tasks
    if echo "$command $context" | grep -E "(ui|component|interface|design|frontend)" >/dev/null; then
        selected_servers+=("magic")
    fi
    
    # Playwright for testing
    if echo "$command $context" | grep -E "(test|e2e|browser|automation)" >/dev/null; then
        selected_servers+=("playwright")
    fi
    
    # Default to context7 and sequential for general tasks
    if [[ ${#selected_servers[@]} -eq 0 ]]; then
        selected_servers=("context7" "sequential")
    fi
    
    printf '%s\n' "${selected_servers[@]}"
}

# Activate MCP servers
activate_mcp_servers() {
    local servers=("$@")
    
    if [[ ${#servers[@]} -eq 0 ]]; then
        log_warn "No MCP servers to activate"
        return 0
    fi
    
    batcave_announce "Activating MCP servers: ${servers[*]}" "info"
    
    for server in "${servers[@]}"; do
        start_mcp_server "$server"
    done
    
    # Cache the activation
    cache_set_advanced "mcp" "active_servers" "$(join_array "," "${servers[@]}")" "$(join_array "," "${servers[@]}")" 300
}

# Deactivate MCP servers
deactivate_mcp_servers() {
    local servers=("$@")
    
    if [[ ${#servers[@]} -eq 0 ]]; then
        # Deactivate all servers
        servers=($(json_get "$MCP_STATUS_FILE" "active_servers" | jq -r '.[]'))
    fi
    
    batcave_announce "Deactivating MCP servers: ${servers[*]}" "info"
    
    for server in "${servers[@]}"; do
        stop_mcp_server "$server"
    done
}

# MCP query interface
mcp_query() {
    local server="$1"
    local query="$2"
    local options="$3"
    
    # Check cache first
    local cached_response=$(get_cached_mcp_response "$server" "$query")
    if [[ -n "$cached_response" ]]; then
        echo "$cached_response"
        return 0
    fi
    
    # Ensure server is running
    if ! is_mcp_server_running "$server"; then
        start_mcp_server "$server"
    fi
    
    alfred_service "$server MCP Query" "start"
    
    # Simulate MCP query (in real implementation, this would make actual MCP request)
    local response=""
    case "$server" in
        "context7")
            response=$(generate_context7_response "$query")
            ;;
        "sequential")
            response=$(generate_sequential_response "$query")
            ;;
        "magic")
            response=$(generate_magic_response "$query")
            ;;
        "playwright")
            response=$(generate_playwright_response "$query")
            ;;
        *)
            response="Unknown MCP server: $server"
            ;;
    esac
    
    # Cache the response
    cache_mcp_response "$server" "$query" "$response"
    
    echo "$response"
}

# Simulate MCP server responses (these would be actual MCP integrations)
generate_context7_response() {
    local query="$1"
    echo "Context7 Documentation Response for: $query"
    echo "- Official documentation links"
    echo "- Code examples"
    echo "- Best practices"
    echo "- Community resources"
}

generate_sequential_response() {
    local query="$1"
    echo "Sequential Analysis Response for: $query"
    echo "Step 1: Problem analysis"
    echo "Step 2: Solution design"
    echo "Step 3: Implementation plan"
    echo "Step 4: Validation approach"
}

generate_magic_response() {
    local query="$1"
    echo "Magic UI Generation Response for: $query"
    echo "- Component structure"
    echo "- Styling suggestions"
    echo "- Accessibility features"
    echo "- Responsive design"
}

generate_playwright_response() {
    local query="$1"
    echo "Playwright Testing Response for: $query"
    echo "- Test scenarios"
    echo "- Browser automation"
    echo "- Screenshot testing"
    echo "- Performance metrics"
}

# MCP health check
mcp_health_check() {
    local healthy_servers=()
    local unhealthy_servers=()
    
    for server_info in "${MCP_SERVERS[@]}"; do
        local server_name=$(echo "$server_info" | cut -d':' -f1)
        
        if is_mcp_server_running "$server_name"; then
            healthy_servers+=("$server_name")
        else
            unhealthy_servers+=("$server_name")
        fi
    done
    
    # Update health check timestamp
    json_set "$MCP_STATUS_FILE" "last_health_check" "$(timestamp)"
    
    # Report status
    if [[ ${#healthy_servers[@]} -gt 0 ]]; then
        batcave_announce "Healthy MCP servers: ${healthy_servers[*]}" "info"
    fi
    
    if [[ ${#unhealthy_servers[@]} -gt 0 ]]; then
        batcave_announce "Unhealthy MCP servers: ${unhealthy_servers[*]}" "warning"
    fi
}

# Get MCP system status
get_mcp_status() {
    echo -e "${YELLOW}🦇 Wayne Tech MCP System Status:${NC}"
    echo -e "${GRAY}═══════════════════════════════════════${NC}"
    
    for server_info in "${MCP_SERVERS[@]}"; do
        local server_name=$(echo "$server_info" | cut -d':' -f1)
        local server_type=$(echo "$server_info" | cut -d':' -f2)
        local server_port=$(echo "$server_info" | cut -d':' -f3)
        
        if is_mcp_server_running "$server_name"; then
            echo -e "🟢 $server_name ($server_type) - Port $server_port - ${YELLOW}ONLINE${NC}"
        else
            echo -e "🔴 $server_name ($server_type) - Port $server_port - ${GRAY}OFFLINE${NC}"
        fi
    done
    
    echo -e "${GRAY}═══════════════════════════════════════${NC}"
    
    local active_count=$(json_get "$MCP_STATUS_FILE" "active_servers" | jq '. | length')
    echo -e "Active servers: $active_count/${#MCP_SERVERS[@]}"
    
    local last_check=$(json_get "$MCP_STATUS_FILE" "last_health_check")
    if [[ -n "$last_check" ]]; then
        echo -e "Last health check: $last_check"
    fi
}

# Initialize MCP system if not already done
if [[ ! -f "$MCP_STATUS_FILE" ]]; then
    init_mcp_system
fi

# Export MCP functions
export -f init_mcp_system create_mcp_server_configs
export -f start_mcp_server stop_mcp_server is_mcp_server_running
export -f update_mcp_server_status select_mcp_servers
export -f activate_mcp_servers deactivate_mcp_servers
export -f mcp_query mcp_health_check get_mcp_status