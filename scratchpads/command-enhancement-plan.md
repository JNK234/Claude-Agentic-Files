# Command Enhancement Plan

## Overview
Enhance existing commands with MCP server integration, persona activation, and orchestration capabilities while adding powerful new commands from SuperClaude.

## Enhanced Command Architecture

### Command Structure
```bash
#!/bin/bash
# Enhanced command template

# Command metadata
COMMAND_NAME="command_name"
COMMAND_VERSION="2.0"
COMMAND_CAPABILITIES="mcp personas orchestration"

# Load core libraries
source "$CLAUDE_HOME/lib/utils.sh"
source "$CLAUDE_HOME/lib/context.sh"
source "$CLAUDE_HOME/mcp/lib/mcp_utils.sh"
source "$CLAUDE_HOME/personas/lib/activation.sh"
source "$CLAUDE_HOME/orchestrator/lib/orchestrator.sh"

# Command execution
main() {
  local args=("$@")
  
  # Context analysis
  local context=$(analyze_context "$PWD" "${args[@]}")
  local complexity=$(calculate_complexity "$context")
  
  # Persona activation
  local personas=($(activate_personas "$context" "$COMMAND_NAME"))
  inject_persona_context "${personas[@]}"
  
  # MCP server selection
  local mcp_servers=($(select_mcp_servers "$COMMAND_NAME" "$complexity"))
  activate_mcp_servers "${mcp_servers[@]}"
  
  # Orchestration decision
  if should_use_orchestration "$complexity"; then
    orchestrate_command "$COMMAND_NAME" "${args[@]}"
  else
    execute_direct "$COMMAND_NAME" "${args[@]}"
  fi
}

main "$@"
```

## Enhanced Existing Commands

### 1. /think Enhancement
```bash
#!/bin/bash
# commands/think.sh

# Original features preserved:
# - Deep reasoning modes (--harder, --ultra)
# - Spec file support
# - Scratchpad output

# New enhancements:
enhance_think_command() {
  # Auto-activate Sequential MCP for complex reasoning
  if [[ "$1" == "--ultra" ]]; then
    activate_mcp_server "sequential" --mode "ultra"
    set_token_limit 32000
  elif [[ "$1" == "--harder" ]]; then
    activate_mcp_server "sequential" --mode "hard"
    set_token_limit 10000
  else
    activate_mcp_server "sequential" --mode "standard"
    set_token_limit 4000
  fi
  
  # Activate appropriate personas based on domain
  local domain=$(detect_problem_domain "$@")
  case "$domain" in
    "architecture")
      activate_personas "architect" "analyzer"
      ;;
    "performance")
      activate_personas "performance" "analyzer"
      ;;
    "security")
      activate_personas "security" "analyzer"
      ;;
    *)
      activate_personas "analyzer"
      ;;
  esac
  
  # Enable wave mode for ultra-complex problems
  if [[ "$1" == "--ultra" ]]; then
    enable_wave_mode "systematic" \
      --stages "explore analyze design validate document"
  fi
}
```

### 2. /ship Enhancement
```bash
#!/bin/bash
# commands/ship.sh

# Complete feature delivery with orchestration
enhance_ship_command() {
  # Analyze feature complexity
  local feature="$1"
  local complexity=$(analyze_feature_complexity "$feature")
  
  # Multi-stage shipping process
  if [[ "$complexity" == "high" ]]; then
    # Use wave orchestration
    orchestrate_waves "ship" \
      --stages "analyze design implement test document deploy" \
      --personas "architect frontend backend qa devops" \
      --mcp "sequential magic playwright"
  else
    # Standard shipping
    execute_stages "implement" "test" "deploy"
  fi
  
  # Auto-generate PR with context
  generate_pr_with_context \
    --include-tests \
    --include-docs \
    --batman-theme
}
```

### 3. /review Enhancement
```bash
#!/bin/bash
# commands/review.sh

# Multi-dimensional code review
enhance_review_command() {
  # Activate review personas
  activate_personas "qa" "security" "performance" "refactorer"
  
  # Run parallel analysis with different MCP servers
  parallel_analysis() {
    # Security analysis with Sequential
    analyze_security --mcp "sequential" &
    
    # Performance analysis 
    analyze_performance --mcp "sequential" &
    
    # Code quality with Context7
    analyze_quality --mcp "context7" &
    
    # Test coverage with Playwright
    analyze_coverage --mcp "playwright" &
    
    wait
  }
  
  # Generate comprehensive report
  generate_review_report \
    --auto-fix-simple-issues \
    --suggest-improvements \
    --batman-approval-rating
}
```

## New Commands to Implement

### 1. /implement (from SuperClaude)
```bash
#!/bin/bash
# commands/implement.sh

# Intelligent feature implementation
implement_command() {
  local feature="$1"
  shift
  local options=("$@")
  
  # Feature analysis
  echo "🦇 Analyzing feature requirements, Master Wayne..."
  
  # Auto-detect implementation needs
  local needs=$(analyze_feature_needs "$feature")
  
  # Activate appropriate personas
  case "$needs" in
    *"ui"*)
      activate_personas "frontend" "qa"
      activate_mcp_server "magic"
      ;;
    *"api"*)
      activate_personas "backend" "security"
      activate_mcp_server "sequential"
      ;;
    *"full-stack"*)
      activate_personas "architect" "frontend" "backend"
      activate_mcp_servers "magic" "sequential" "context7"
      ;;
  esac
  
  # Implementation stages
  implement_stages=(
    "requirements_analysis"
    "design_architecture"
    "implement_core"
    "add_tests"
    "integrate_feature"
    "update_documentation"
  )
  
  # Execute with progress tracking
  for stage in "${implement_stages[@]}"; do
    execute_stage "$stage" "$feature" || handle_stage_failure "$stage"
  done
}
```

### 2. /architect (New Power Command)
```bash
#!/bin/bash
# commands/architect.sh

# System design and architecture command
architect_command() {
  local system="$1"
  local requirements="$2"
  
  echo "🦇 Engaging Batcave architectural systems, Master Wayne..."
  
  # Force architect persona
  force_persona "architect"
  
  # Activate Sequential for deep analysis
  activate_mcp_server "sequential" --mode "architecture"
  
  # Architecture workflow
  architecture_workflow() {
    # 1. Analyze requirements
    analyze_requirements "$requirements"
    
    # 2. Design system architecture
    design_architecture \
      --patterns "microservices event-driven serverless" \
      --constraints "$requirements"
    
    # 3. Create component diagrams
    generate_diagrams \
      --type "component sequence deployment" \
      --style "batman-theme"
    
    # 4. Define interfaces
    define_interfaces \
      --style "rest graphql grpc" \
      --documentation "openapi"
    
    # 5. Create implementation plan
    create_implementation_roadmap \
      --phases "mvp scaling optimization" \
      --milestones true
  }
  
  # Execute and save outputs
  architecture_workflow > "tasks/architecture-${system}-$(date +%s).md"
}
```

### 3. /ui (Magic MCP Integration)
```bash
#!/bin/bash
# commands/ui.sh

# UI component generation with Magic MCP
ui_command() {
  local component="$1"
  local framework="${2:-react}"
  local options="${3:-}"
  
  echo "🦇 Activating Wayne Tech UI systems..."
  
  # Activate frontend persona and Magic MCP
  activate_personas "frontend" "qa"
  activate_mcp_server "magic"
  
  # Component generation workflow
  generate_ui_component() {
    # 1. Analyze component requirements
    local requirements=$(analyze_ui_requirements "$component")
    
    # 2. Generate component with Magic
    magic_generate \
      --component "$component" \
      --framework "$framework" \
      --theme "dark-knight" \
      --accessibility "wcag-aa" \
      --responsive true
    
    # 3. Generate tests
    generate_component_tests \
      --framework "$framework" \
      --coverage "comprehensive"
    
    # 4. Create Storybook story
    create_storybook_story "$component"
    
    # 5. Add to component library
    update_component_library "$component"
  }
  
  generate_ui_component
}
```

### 4. /debug (Enhanced Debugging)
```bash
#!/bin/bash
# commands/debug.sh

# Deep debugging with Sequential MCP
debug_command() {
  local issue="$1"
  local context="$2"
  
  echo "🦇 Deploying Batcave detective mode..."
  
  # Activate analyzer persona and Sequential
  activate_personas "analyzer" "backend"
  activate_mcp_server "sequential" --mode "debug"
  
  # Systematic debugging
  debug_workflow() {
    # 1. Reproduce issue
    reproduce_issue "$issue" "$context"
    
    # 2. Collect evidence
    collect_evidence \
      --logs true \
      --stack-traces true \
      --system-state true
    
    # 3. Root cause analysis
    perform_root_cause_analysis \
      --method "5-whys binary-search"
    
    # 4. Generate hypothesis
    generate_debug_hypothesis
    
    # 5. Test and verify fix
    test_hypothesis_and_fix
    
    # 6. Prevent regression
    add_regression_tests
  }
  
  debug_workflow
}
```

### 5. /test-e2e (Playwright Integration)
```bash
#!/bin/bash
# commands/test-e2e.sh

# E2E testing with Playwright MCP
test_e2e_command() {
  local target="$1"
  local browsers="${2:-all}"
  
  echo "🦇 Initializing Batcave testing protocols..."
  
  # Activate QA persona and Playwright
  activate_personas "qa" "frontend"
  activate_mcp_server "playwright"
  
  # E2E testing workflow
  e2e_test_workflow() {
    # 1. Analyze application
    analyze_test_targets "$target"
    
    # 2. Generate test scenarios
    generate_test_scenarios \
      --coverage "critical-paths edge-cases" \
      --personas "user admin guest"
    
    # 3. Create Playwright tests
    playwright_generate_tests \
      --browsers "$browsers" \
      --parallel true \
      --screenshots "on-failure" \
      --videos "retain-on-failure"
    
    # 4. Run tests
    playwright_run \
      --reporters "html json junit" \
      --retry 2
    
    # 5. Analyze results
    analyze_test_results \
      --generate-report true \
      --batman-rating true
  }
  
  e2e_test_workflow
}
```

## Command Intelligence Features

### 1. Context-Aware Activation
```bash
# lib/command_intelligence.sh

# Detect project type and activate appropriate tools
detect_and_configure() {
  local project_type=$(detect_project_type)
  
  case "$project_type" in
    "react-app")
      default_personas=("frontend" "qa")
      default_mcp=("magic" "playwright")
      ;;
    "api-server")
      default_personas=("backend" "security")
      default_mcp=("sequential" "context7")
      ;;
    "full-stack")
      default_personas=("architect" "frontend" "backend")
      default_mcp=("magic" "sequential" "context7" "playwright")
      ;;
  esac
}
```

### 2. Command Chaining
```bash
# Allow commands to trigger other commands
chain_commands() {
  # Example: /implement triggers /test automatically
  implement_with_testing() {
    /implement "$@" && /test --auto-generate
  }
  
  # Example: /ship triggers full pipeline
  ship_with_pipeline() {
    /implement "$@" && \
    /test --comprehensive && \
    /review --auto-fix && \
    /document --auto-generate && \
    /deploy --staging
  }
}
```

### 3. Progress Persistence
```bash
# Save command state for resumption
save_command_state() {
  local command="$1"
  local state="$2"
  
  cat > "$CLAUDE_HOME/state/${command}-$(date +%s).json" <<EOF
{
  "command": "$command",
  "state": $state,
  "personas": $(get_active_personas),
  "mcp_servers": $(get_active_mcp),
  "progress": $(get_command_progress),
  "timestamp": "$(date -Iseconds)"
}
EOF
}

# Resume interrupted commands
resume_command() {
  local state_file="$1"
  local state=$(jq -r '.' "$state_file")
  
  # Restore context
  restore_personas "$state"
  restore_mcp_servers "$state"
  restore_progress "$state"
  
  # Continue execution
  continue_command "$state"
}
```

## Implementation Priority

### Phase 1: Core Enhancements
1. Enhance /think with Sequential MCP
2. Enhance /ship with orchestration
3. Enhance /review with parallel analysis
4. Implement /implement command

### Phase 2: New Power Commands
1. Add /architect for system design
2. Add /ui for component generation
3. Add /debug for deep debugging
4. Add /test-e2e for browser testing

### Phase 3: Intelligence Layer
1. Implement context-aware activation
2. Add command chaining
3. Create progress persistence
4. Build command composition

## Success Metrics

- All commands support MCP integration
- Persona auto-activation accuracy > 80%
- Command completion time improved by 30%
- User satisfaction with enhancements
- Zero regression in existing functionality