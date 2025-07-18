#!/bin/bash
# personas/lib/activation.sh - Persona activation and management system

source "${CLAUDE_HOME:-$HOME/.claude}/lib/utils.sh"
source "${CLAUDE_HOME:-$HOME/.claude}/lib/context.sh"
source "${CLAUDE_HOME:-$HOME/.claude}/lib/cache.sh"
source "${CLAUDE_HOME:-$HOME/.claude}/lib/batman.sh"

# Persona configuration
PERSONAS_DIR="${CLAUDE_HOME:-$HOME/.claude}/personas/profiles"
ACTIVE_PERSONAS_FILE="${CLAUDE_HOME:-$HOME/.claude}/personas/active.json"
DEFAULT_PERSONA="${DEFAULT_PERSONA:-master_wayne}"

# Available personas (bash 3.2 compatible - NO ASSOCIATIVE ARRAYS)
PERSONAS=(
    "master_wayne:The Dark Knight of Development - Batman-themed professional persona"
    "architect:System design and architecture specialist"
    "frontend:Frontend development and UI/UX expert"
    "backend:Backend systems and API development expert"
    "security:Security analysis and vulnerability assessment expert"
    "performance:Performance optimization and monitoring expert"
    "qa:Quality assurance and testing specialist"
    "devops:DevOps, CI/CD, and infrastructure expert"
    "analyzer:Code analysis and problem-solving specialist"
    "refactorer:Code refactoring and optimization expert"
    "mentor:Technical mentorship and knowledge sharing expert"
    "scribe:Documentation and technical writing expert"
)

# Initialize persona system
init_persona_system() {
    ensure_directory "$PERSONAS_DIR"
    
    # Create active personas tracking file
    cat > "$ACTIVE_PERSONAS_FILE" <<EOF
{
    "primary_persona": "$DEFAULT_PERSONA",
    "active_personas": ["$DEFAULT_PERSONA"],
    "context": "",
    "activated_at": "$(timestamp)",
    "session_id": "$(epoch_time)"
}
EOF
    
    # Create all persona profiles
    create_persona_profiles
    
    alfred_service "Persona System" "ready"
}

# Create persona profiles
create_persona_profiles() {
    # Master Wayne already exists, create others
    
    # Architect persona
    cat > "$PERSONAS_DIR/architect.json" <<EOF
{
    "name": "architect",
    "display_name": "System Architect",
    "description": "Enterprise system design and architecture specialist",
    "expertise_areas": ["system_design", "architecture_patterns", "scalability", "microservices"],
    "activation_triggers": ["architect", "design", "system", "scalability", "pattern"],
    "mcp_preferences": ["sequential", "context7"],
    "behavior": {
        "greeting": "System architecture analysis initiated.",
        "working_message": "Designing enterprise-grade architecture...",
        "approach": "systematic_design_thinking"
    }
}
EOF
    
    # Frontend persona
    cat > "$PERSONAS_DIR/frontend.json" <<EOF
{
    "name": "frontend",
    "display_name": "Frontend Expert",
    "description": "Frontend development and UI/UX specialist",
    "expertise_areas": ["react", "vue", "angular", "css", "javascript", "typescript", "responsive_design"],
    "activation_triggers": ["frontend", "ui", "component", "react", "vue", "css"],
    "mcp_preferences": ["magic", "context7"],
    "behavior": {
        "greeting": "Frontend development systems online.",
        "working_message": "Crafting user interface components...",
        "approach": "user_centric_design"
    }
}
EOF
    
    # Backend persona
    cat > "$PERSONAS_DIR/backend.json" <<EOF
{
    "name": "backend",
    "display_name": "Backend Expert",
    "description": "Backend systems and API development specialist",
    "expertise_areas": ["api_design", "databases", "microservices", "performance", "security"],
    "activation_triggers": ["backend", "api", "database", "server", "microservice"],
    "mcp_preferences": ["sequential", "context7"],
    "behavior": {
        "greeting": "Backend systems analysis initiated.",
        "working_message": "Optimizing server-side architecture...",
        "approach": "scalable_robust_design"
    }
}
EOF
    
    # Security persona
    cat > "$PERSONAS_DIR/security.json" <<EOF
{
    "name": "security",
    "display_name": "Security Expert",
    "description": "Security analysis and vulnerability assessment specialist",
    "expertise_areas": ["vulnerability_analysis", "penetration_testing", "secure_coding", "compliance"],
    "activation_triggers": ["security", "vulnerability", "auth", "encryption", "secure"],
    "mcp_preferences": ["sequential", "context7"],
    "behavior": {
        "greeting": "Security protocols activated.",
        "working_message": "Scanning for vulnerabilities and threats...",
        "approach": "threat_model_analysis"
    }
}
EOF
    
    # Performance persona
    cat > "$PERSONAS_DIR/performance.json" <<EOF
{
    "name": "performance",
    "display_name": "Performance Expert",
    "description": "Performance optimization and monitoring specialist",
    "expertise_areas": ["performance_tuning", "monitoring", "profiling", "optimization"],
    "activation_triggers": ["performance", "optimization", "speed", "latency", "monitoring"],
    "mcp_preferences": ["sequential", "context7"],
    "behavior": {
        "greeting": "Performance analysis systems online.",
        "working_message": "Optimizing system performance...",
        "approach": "data_driven_optimization"
    }
}
EOF
    
    # QA persona
    cat > "$PERSONAS_DIR/qa.json" <<EOF
{
    "name": "qa",
    "display_name": "QA Expert",
    "description": "Quality assurance and testing specialist",
    "expertise_areas": ["testing_strategies", "test_automation", "quality_metrics", "bug_analysis"],
    "activation_triggers": ["test", "testing", "qa", "quality", "bug"],
    "mcp_preferences": ["playwright", "sequential"],
    "behavior": {
        "greeting": "Quality assurance protocols activated.",
        "working_message": "Implementing comprehensive testing strategies...",
        "approach": "quality_first_methodology"
    }
}
EOF
    
    # DevOps persona
    cat > "$PERSONAS_DIR/devops.json" <<EOF
{
    "name": "devops",
    "display_name": "DevOps Expert",
    "description": "DevOps, CI/CD, and infrastructure specialist",
    "expertise_areas": ["ci_cd", "infrastructure", "containerization", "orchestration", "monitoring"],
    "activation_triggers": ["devops", "deployment", "ci", "cd", "docker", "kubernetes"],
    "mcp_preferences": ["sequential", "context7"],
    "behavior": {
        "greeting": "DevOps pipeline systems activated.",
        "working_message": "Orchestrating deployment pipeline...",
        "approach": "infrastructure_as_code"
    }
}
EOF
    
    # Analyzer persona
    cat > "$PERSONAS_DIR/analyzer.json" <<EOF
{
    "name": "analyzer",
    "display_name": "Code Analyzer",
    "description": "Code analysis and problem-solving specialist",
    "expertise_areas": ["code_analysis", "debugging", "problem_solving", "optimization"],
    "activation_triggers": ["analyze", "debug", "problem", "investigate", "troubleshoot"],
    "mcp_preferences": ["sequential", "context7"],
    "behavior": {
        "greeting": "Analysis systems online.",
        "working_message": "Performing deep code analysis...",
        "approach": "systematic_investigation"
    }
}
EOF
    
    # Refactorer persona
    cat > "$PERSONAS_DIR/refactorer.json" <<EOF
{
    "name": "refactorer",
    "display_name": "Code Refactorer",
    "description": "Code refactoring and optimization specialist",
    "expertise_areas": ["refactoring", "code_cleanup", "patterns", "maintainability"],
    "activation_triggers": ["refactor", "cleanup", "improve", "optimize", "restructure"],
    "mcp_preferences": ["sequential", "context7"],
    "behavior": {
        "greeting": "Code refactoring protocols activated.",
        "working_message": "Improving code structure and quality...",
        "approach": "incremental_improvement"
    }
}
EOF
    
    # Mentor persona
    cat > "$PERSONAS_DIR/mentor.json" <<EOF
{
    "name": "mentor",
    "display_name": "Technical Mentor",
    "description": "Technical mentorship and knowledge sharing expert",
    "expertise_areas": ["mentoring", "teaching", "knowledge_transfer", "best_practices"],
    "activation_triggers": ["mentor", "teach", "explain", "learn", "guide"],
    "mcp_preferences": ["context7", "sequential"],
    "behavior": {
        "greeting": "Technical mentorship mode activated.",
        "working_message": "Sharing knowledge and best practices...",
        "approach": "educational_guidance"
    }
}
EOF
    
    # Scribe persona
    cat > "$PERSONAS_DIR/scribe.json" <<EOF
{
    "name": "scribe",
    "display_name": "Technical Scribe",
    "description": "Documentation and technical writing expert",
    "expertise_areas": ["documentation", "technical_writing", "api_docs", "user_guides"],
    "activation_triggers": ["document", "write", "readme", "docs", "guide"],
    "mcp_preferences": ["context7", "sequential"],
    "behavior": {
        "greeting": "Documentation systems activated.",
        "working_message": "Creating comprehensive documentation...",
        "approach": "clear_comprehensive_writing"
    }
}
EOF
}

# Activate personas based on context
activate_personas() {
    local context="$1"
    local command="${2:-}"
    local requested_personas=("${@:3}")
    
    local selected_personas=()
    
    # If personas are explicitly requested, use them
    if [[ ${#requested_personas[@]} -gt 0 ]]; then
        selected_personas=("${requested_personas[@]}")
    else
        # Auto-select based on context
        selected_personas=($(auto_select_personas "$context" "$command"))
    fi
    
    # Always include Master Wayne as primary
    if ! contains "master_wayne" "${selected_personas[@]}"; then
        selected_personas=("master_wayne" "${selected_personas[@]}")
    fi
    
    # Activate the selected personas
    for persona in "${selected_personas[@]}"; do
        activate_persona "$persona" "$context"
    done
    
    # Update active personas file
    update_active_personas "${selected_personas[@]}"
    
    printf '%s\n' "${selected_personas[@]}"
}

# Auto-select personas based on context
auto_select_personas() {
    local context="$1"
    local command="$2"
    local selected=()
    
    # Analyze context for persona triggers
    local context_lower=$(to_lower "$context $command")
    
    # Parse personas from array (bash 3.2 compatible)
    for persona_entry in "${PERSONAS[@]}"; do
        local persona=$(echo "$persona_entry" | cut -d':' -f1)
        
        if [[ "$persona" == "master_wayne" ]]; then
            continue  # Always included separately
        fi
        
        local persona_file="$PERSONAS_DIR/${persona}.json"
        if [[ -f "$persona_file" ]]; then
            local triggers=$(json_get "$persona_file" "activation_triggers" | jq -r '.[]?' 2>/dev/null)
            
            for trigger in $triggers; do
                if echo "$context_lower" | grep -q "$trigger"; then
                    selected+=("$persona")
                    break
                fi
            done
        fi
    done
    
    # Default personas for common commands
    case "$command" in
        "implement")
            if ! contains "frontend" "${selected[@]}" && ! contains "backend" "${selected[@]}"; then
                selected+=("frontend" "backend")
            fi
            ;;
        "architect")
            if ! contains "architect" "${selected[@]}"; then
                selected+=("architect")
            fi
            ;;
        "test")
            if ! contains "qa" "${selected[@]}"; then
                selected+=("qa")
            fi
            ;;
        "review")
            if ! contains "analyzer" "${selected[@]}"; then
                selected+=("analyzer")
            fi
            ;;
        "debug")
            if ! contains "analyzer" "${selected[@]}"; then
                selected+=("analyzer")
            fi
            ;;
    esac
    
    # Ensure at least one persona is selected
    if [[ ${#selected[@]} -eq 0 ]]; then
        selected=("analyzer")
    fi
    
    printf '%s\n' "${selected[@]}"
}

# Activate individual persona
activate_persona() {
    local persona="$1"
    local context="$2"
    
    local persona_file="$PERSONAS_DIR/${persona}.json"
    if [[ ! -f "$persona_file" ]]; then
        log_warn "Persona profile not found: $persona"
        return 1
    fi
    
    # Load persona configuration
    local display_name=$(json_get "$persona_file" "display_name")
    local greeting=$(json_get "$persona_file" "behavior.greeting")
    
    # Show persona activation
    if [[ "$persona" == "master_wayne" ]]; then
        batman_greet
        echo -e "${GRAY}🎩 Alfred: $display_name persona activated${NC}"
    else
        echo -e "${YELLOW}🎭${NC} $display_name persona activated"
    fi
    
    # Cache persona context
    cache_persona_context "$persona" "$context" "$(cat "$persona_file")"
    
    # Set persona-specific environment variables
    export CLAUDE_ACTIVE_PERSONA="$persona"
    export CLAUDE_PERSONA_DISPLAY_NAME="$display_name"
}

# Force activate specific persona
force_persona() {
    local persona="$1"
    local context="${2:-forced_activation}"
    
    # Deactivate current personas
    deactivate_all_personas
    
    # Activate the requested persona
    activate_persona "$persona" "$context"
    
    # Update active personas file
    update_active_personas "$persona"
    
    batcave_announce "Persona forced to: $persona" "info"
}

# Deactivate all personas
deactivate_all_personas() {
    # Clear active personas
    cat > "$ACTIVE_PERSONAS_FILE" <<EOF
{
    "primary_persona": "$DEFAULT_PERSONA",
    "active_personas": [],
    "context": "",
    "deactivated_at": "$(timestamp)",
    "session_id": "$(epoch_time)"
}
EOF
    
    # Clear persona environment variables
    unset CLAUDE_ACTIVE_PERSONA
    unset CLAUDE_PERSONA_DISPLAY_NAME
    
    log_info "All personas deactivated"
}

# Update active personas file
update_active_personas() {
    local personas=("$@")
    local primary_persona="${personas[0]}"
    
    local personas_json=$(printf '%s\n' "${personas[@]}" | jq -R . | jq -s .)
    
    cat > "$ACTIVE_PERSONAS_FILE" <<EOF
{
    "primary_persona": "$primary_persona",
    "active_personas": $personas_json,
    "context": "$(detect_problem_domain "$*")",
    "activated_at": "$(timestamp)",
    "session_id": "$(epoch_time)"
}
EOF
}

# Get active personas
get_active_personas() {
    if [[ -f "$ACTIVE_PERSONAS_FILE" ]]; then
        json_get "$ACTIVE_PERSONAS_FILE" "active_personas" | jq -r '.[]?' 2>/dev/null
    else
        echo "$DEFAULT_PERSONA"
    fi
}

# Get primary persona
get_primary_persona() {
    if [[ -f "$ACTIVE_PERSONAS_FILE" ]]; then
        json_get "$ACTIVE_PERSONAS_FILE" "primary_persona"
    else
        echo "$DEFAULT_PERSONA"
    fi
}

# Inject persona context into command
inject_persona_context() {
    local personas=("$@")
    
    if [[ ${#personas[@]} -eq 0 ]]; then
        return 0
    fi
    
    local context_parts=()
    
    for persona in "${personas[@]}"; do
        local persona_file="$PERSONAS_DIR/${persona}.json"
        if [[ -f "$persona_file" ]]; then
            local display_name=$(json_get "$persona_file" "display_name")
            local expertise=$(json_get "$persona_file" "expertise_areas" | jq -r 'join(", ")' 2>/dev/null)
            
            context_parts+=("$display_name: $expertise")
        fi
    done
    
    if [[ ${#context_parts[@]} -gt 0 ]]; then
        export CLAUDE_PERSONA_CONTEXT="Active personas: $(join_array " | " "${context_parts[@]}")"
    fi
}

# Get persona preferences
get_persona_mcp_preferences() {
    local persona="$1"
    local persona_file="$PERSONAS_DIR/${persona}.json"
    
    if [[ -f "$persona_file" ]]; then
        json_get "$persona_file" "mcp_preferences" | jq -r '.[]?' 2>/dev/null
    fi
}

# List available personas
list_personas() {
    echo -e "${YELLOW}🦇 Available Wayne Tech Personas:${NC}"
    echo -e "${GRAY}═══════════════════════════════════════${NC}"
    
    # Parse personas from array (bash 3.2 compatible)
    for persona_entry in "${PERSONAS[@]}"; do
        local persona=$(echo "$persona_entry" | cut -d':' -f1)
        local description=$(echo "$persona_entry" | cut -d':' -f2-)
        local display_name="$persona"
        
        if [[ -f "$PERSONAS_DIR/${persona}.json" ]]; then
            display_name=$(json_get "$PERSONAS_DIR/${persona}.json" "display_name")
        fi
        
        # Check if persona is active
        if contains "$persona" $(get_active_personas); then
            echo -e "🟢 $display_name - $description ${YELLOW}(ACTIVE)${NC}"
        else
            echo -e "⚪ $display_name - $description"
        fi
    done
    
    echo -e "${GRAY}═══════════════════════════════════════${NC}"
}

# Show persona status
show_persona_status() {
    local primary=$(get_primary_persona)
    local active_personas=($(get_active_personas))
    
    echo -e "${YELLOW}🦇 Current Persona Configuration:${NC}"
    echo -e "Primary Persona: $primary"
    echo -e "Active Personas: ${active_personas[*]}"
    
    if [[ -f "$ACTIVE_PERSONAS_FILE" ]]; then
        local activated_at=$(json_get "$ACTIVE_PERSONAS_FILE" "activated_at")
        local context=$(json_get "$ACTIVE_PERSONAS_FILE" "context")
        
        echo -e "Activated At: $activated_at"
        echo -e "Context: $context"
    fi
}

# Initialize persona system if not already done
if [[ ! -f "$ACTIVE_PERSONAS_FILE" ]]; then
    init_persona_system
fi

# Export persona functions
export -f init_persona_system create_persona_profiles activate_personas
export -f auto_select_personas activate_persona force_persona deactivate_all_personas
export -f update_active_personas get_active_personas get_primary_persona
export -f inject_persona_context get_persona_mcp_preferences
export -f list_personas show_persona_status