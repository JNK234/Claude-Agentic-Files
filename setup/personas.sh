#!/bin/bash
# setup/personas.sh - Persona system setup and configuration

source "${CLAUDE_HOME:-$HOME/.claude}/lib/utils.sh"
source "${CLAUDE_HOME:-$HOME/.claude}/lib/batman.sh"

# Persona setup function
setup_personas() {
    local claude_home="$1"
    
    batcave_announce "Setting up Wayne Tech persona system..." "info"
    
    # Create persona directories
    ensure_directory "$claude_home/personas/profiles"
    ensure_directory "$claude_home/personas/lib"
    
    # Copy persona libraries
    if [[ -f "${BASH_SOURCE[0]%/*}/../personas/lib/activation.sh" ]]; then
        cp "${BASH_SOURCE[0]%/*}/../personas/lib/activation.sh" "$claude_home/personas/lib/"
    fi
    
    # Copy persona profiles
    if [[ -f "${BASH_SOURCE[0]%/*}/../personas/profiles/master_wayne.json" ]]; then
        cp "${BASH_SOURCE[0]%/*}/../personas/profiles/master_wayne.json" "$claude_home/personas/profiles/"
    fi
    
    # Create persona management script
    create_persona_manager "$claude_home"
    
    # Create persona selector script
    create_persona_selector "$claude_home"
    
    # Initialize persona system (disable strict mode temporarily)
    (set +u; CLAUDE_HOME="$claude_home" source "$claude_home/personas/lib/activation.sh"; init_persona_system)
    
    batcave_announce "Persona system activated successfully" "info"
}

# Create persona management script
create_persona_manager() {
    local claude_home="$1"
    
    cat > "$claude_home/personas/manage.sh" <<'EOF'
#!/bin/bash
# Persona Management Script

set -euo pipefail

CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
source "$CLAUDE_HOME/lib/utils.sh"
source "$CLAUDE_HOME/lib/batman.sh"
source "$CLAUDE_HOME/personas/lib/activation.sh"

show_usage() {
    echo "Usage: $0 {list|activate|deactivate|status|create}"
    echo ""
    echo "Commands:"
    echo "  list       - List all available personas"
    echo "  activate   - Activate specific persona(s)"
    echo "  deactivate - Deactivate all personas"
    echo "  status     - Show current persona status"
    echo "  create     - Create a new persona profile"
    echo ""
    echo "Examples:"
    echo "  $0 list"
    echo "  $0 activate frontend backend"
    echo "  $0 status"
}

activate_personas_cmd() {
    local personas=("$@")
    
    if [[ ${#personas[@]} -eq 0 ]]; then
        echo "Error: No personas specified"
        echo "Available personas:"
        list_personas
        exit 1
    fi
    
    batcave_announce "Activating personas: ${personas[*]}" "info"
    
    local context="manual_activation"
    activate_personas "$context" "" "${personas[@]}"
    
    echo "Personas activated successfully"
}

deactivate_personas_cmd() {
    batcave_announce "Deactivating all personas..." "info"
    deactivate_all_personas
    echo "All personas deactivated"
}

create_persona_cmd() {
    local persona_name="$1"
    local display_name="$2"
    local description="$3"
    
    if [[ -z "$persona_name" || -z "$display_name" || -z "$description" ]]; then
        echo "Error: Missing required parameters"
        echo "Usage: $0 create <persona_name> <display_name> <description>"
        exit 1
    fi
    
    local persona_file="$CLAUDE_HOME/personas/profiles/${persona_name}.json"
    
    if [[ -f "$persona_file" ]]; then
        echo "Error: Persona '$persona_name' already exists"
        exit 1
    fi
    
    cat > "$persona_file" <<JSON
{
    "name": "$persona_name",
    "display_name": "$display_name",
    "description": "$description",
    "expertise_areas": [],
    "activation_triggers": [],
    "mcp_preferences": ["context7", "sequential"],
    "behavior": {
        "greeting": "$display_name persona activated.",
        "working_message": "Working with $display_name expertise...",
        "approach": "specialized_focus"
    }
}
JSON
    
    batcave_announce "Created new persona: $persona_name" "info"
    echo "Persona profile created at: $persona_file"
    echo "You can now edit this file to customize the persona"
}

case "${1:-}" in
    list)
        list_personas
        ;;
    activate)
        shift
        activate_personas_cmd "$@"
        ;;
    deactivate)
        deactivate_personas_cmd
        ;;
    status)
        show_persona_status
        ;;
    create)
        shift
        create_persona_cmd "$@"
        ;;
    *)
        show_usage
        exit 1
        ;;
esac
EOF
    
    chmod +x "$claude_home/personas/manage.sh"
}

# Create persona selector script
create_persona_selector() {
    local claude_home="$1"
    
    cat > "$claude_home/personas/select.sh" <<'EOF'
#!/bin/bash
# Interactive Persona Selector

set -euo pipefail

CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
source "$CLAUDE_HOME/lib/utils.sh"
source "$CLAUDE_HOME/lib/batman.sh"
source "$CLAUDE_HOME/personas/lib/activation.sh"

show_interactive_menu() {
    echo -e "${YELLOW}🦇 Wayne Tech Persona Selector${NC}"
    echo -e "${GRAY}═══════════════════════════════════════${NC}"
    echo ""
    
    # Parse personas from array (bash 3.2 compatible)
    local personas=()
    for persona_entry in "${PERSONAS[@]}"; do
        local persona=$(echo "$persona_entry" | cut -d':' -f1)
        personas+=("$persona")
    done
    local i=1
    
    for persona in "${personas[@]}"; do
        local display_name="$persona"
        local description=""
        
        # Find description from original array
        for persona_entry in "${PERSONAS[@]}"; do
            if [[ "$(echo "$persona_entry" | cut -d':' -f1)" == "$persona" ]]; then
                description=$(echo "$persona_entry" | cut -d':' -f2-)
                break
            fi
        done
        
        if [[ -f "$PERSONAS_DIR/${persona}.json" ]]; then
            display_name=$(json_get "$PERSONAS_DIR/${persona}.json" "display_name")
        fi
        
        # Check if persona is active
        if contains "$persona" $(get_active_personas); then
            echo -e "$i) $display_name - $description ${YELLOW}(ACTIVE)${NC}"
        else
            echo -e "$i) $display_name - $description"
        fi
        
        i=$((i + 1))
    done
    
    echo ""
    echo "Enter persona numbers (space-separated) or 'q' to quit:"
    read -r selection
    
    if [[ "$selection" == "q" ]]; then
        exit 0
    fi
    
    # Parse selection
    local selected_personas=()
    for num in $selection; do
        if [[ "$num" =~ ^[0-9]+$ && "$num" -ge 1 && "$num" -le ${#personas[@]} ]]; then
            local persona_index=$((num - 1))
            selected_personas+=("${personas[$persona_index]}")
        fi
    done
    
    if [[ ${#selected_personas[@]} -eq 0 ]]; then
        echo "No valid personas selected"
        exit 1
    fi
    
    # Activate selected personas
    batcave_announce "Activating personas: ${selected_personas[*]}" "info"
    
    local context="interactive_selection"
    activate_personas "$context" "" "${selected_personas[@]}"
    
    echo "Personas activated successfully!"
}

# Check if running interactively
if [[ -t 0 ]]; then
    show_interactive_menu
else
    echo "This script requires interactive mode"
    exit 1
fi
EOF
    
    chmod +x "$claude_home/personas/select.sh"
}

# Export setup function
export -f setup_personas