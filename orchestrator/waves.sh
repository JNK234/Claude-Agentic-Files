#!/bin/bash
# orchestrator/waves.sh - Wave orchestration system for complex task execution

source "${CLAUDE_HOME:-$HOME/.claude}/lib/utils.sh"
source "${CLAUDE_HOME:-$HOME/.claude}/lib/context.sh"
source "${CLAUDE_HOME:-$HOME/.claude}/lib/cache.sh"
source "${CLAUDE_HOME:-$HOME/.claude}/lib/batman.sh"
source "${CLAUDE_HOME:-$HOME/.claude}/personas/lib/activation.sh"
source "${CLAUDE_HOME:-$HOME/.claude}/mcp/lib/mcp_utils.sh"

# Wave orchestration configuration
WAVE_STATE_DIR="${CLAUDE_HOME:-$HOME/.claude}/orchestrator/state"
WAVE_LOGS_DIR="${CLAUDE_HOME:-$HOME/.claude}/orchestrator/logs"
WAVE_CONFIG_FILE="${CLAUDE_HOME:-$HOME/.claude}/orchestrator/config.json"

# Wave execution modes
declare -A WAVE_MODES=(
    ["sequential"]="Execute stages one after another"
    ["parallel"]="Execute compatible stages in parallel"
    ["adaptive"]="Dynamically adjust execution based on results"
    ["systematic"]="Thorough step-by-step execution with validation"
)

# Initialize wave orchestration system
init_wave_system() {
    ensure_directory "$WAVE_STATE_DIR"
    ensure_directory "$WAVE_LOGS_DIR"
    
    # Create wave configuration
    cat > "$WAVE_CONFIG_FILE" <<EOF
{
    "version": "1.0",
    "default_mode": "adaptive",
    "max_parallel_stages": 3,
    "stage_timeout": 1800,
    "retry_attempts": 2,
    "logging": {
        "level": "info",
        "file": "$WAVE_LOGS_DIR/wave-execution.log"
    },
    "personas": {
        "auto_activation": true,
        "max_concurrent": 3,
        "fallback_persona": "analyzer"
    },
    "mcp": {
        "auto_selection": true,
        "timeout": 30,
        "retry_count": 3
    }
}
EOF
    
    alfred_service "Wave Orchestration System" "ready"
}

# Wave orchestration main function
orchestrate_waves() {
    local command="$1"
    local stages_str="$2"
    local personas_str="$3"
    local mcp_servers_str="$4"
    local mode="${5:-adaptive}"
    
    # Parse input parameters
    local stages=(${stages_str//,/ })
    local personas=(${personas_str//,/ })
    local mcp_servers=(${mcp_servers_str//,/ })
    
    # Create wave session
    local wave_session_id=$(create_wave_session "$command" "$mode")
    
    # Initialize wave execution
    batcave_announce "Initiating wave orchestration for: $command" "info"
    log_info "Wave session: $wave_session_id"
    log_info "Execution mode: $mode"
    log_info "Stages: ${stages[*]}"
    
    # Execute wave based on mode
    case "$mode" in
        "sequential")
            execute_sequential_waves "$wave_session_id" "${stages[@]}"
            ;;
        "parallel")
            execute_parallel_waves "$wave_session_id" "${stages[@]}"
            ;;
        "adaptive")
            execute_adaptive_waves "$wave_session_id" "${stages[@]}"
            ;;
        "systematic")
            execute_systematic_waves "$wave_session_id" "${stages[@]}"
            ;;
        *)
            log_error "Unknown wave mode: $mode"
            return 1
            ;;
    esac
    
    # Finalize wave execution
    finalize_wave_session "$wave_session_id"
}

# Create wave session
create_wave_session() {
    local command="$1"
    local mode="$2"
    local session_id="wave-$(epoch_time)"
    
    local session_file="$WAVE_STATE_DIR/${session_id}.json"
    
    cat > "$session_file" <<EOF
{
    "session_id": "$session_id",
    "command": "$command",
    "mode": "$mode",
    "created_at": "$(timestamp)",
    "status": "initializing",
    "stages": [],
    "current_stage": null,
    "completed_stages": [],
    "failed_stages": [],
    "personas": [],
    "mcp_servers": [],
    "metrics": {
        "start_time": $(epoch_time),
        "end_time": null,
        "duration": null,
        "success_rate": 0
    }
}
EOF
    
    echo "$session_id"
}

# Execute sequential waves
execute_sequential_waves() {
    local session_id="$1"
    shift
    local stages=("$@")
    
    batcave_announce "Executing sequential wave pattern..." "info"
    
    for stage in "${stages[@]}"; do
        update_wave_status "$session_id" "executing" "$stage"
        
        if execute_wave_stage "$session_id" "$stage"; then
            mark_stage_completed "$session_id" "$stage"
            batman_progress "$stage" "$((${#stages[@]} - $(count_remaining_stages "$session_id" "${stages[@]}")))" "${#stages[@]}"
        else
            mark_stage_failed "$session_id" "$stage"
            batcave_announce "Stage failed: $stage" "warning"
            
            # Check if we should continue or abort
            if ! should_continue_after_failure "$session_id" "$stage"; then
                batcave_announce "Aborting wave execution due to critical failure" "urgent"
                return 1
            fi
        fi
    done
    
    return 0
}

# Execute parallel waves
execute_parallel_waves() {
    local session_id="$1"
    shift
    local stages=("$@")
    
    batcave_announce "Executing parallel wave pattern..." "info"
    
    local max_parallel=$(json_get "$WAVE_CONFIG_FILE" "max_parallel_stages")
    local pids=()
    local stage_index=0
    
    while [[ $stage_index -lt ${#stages[@]} ]]; do
        # Start parallel stages up to max limit
        while [[ ${#pids[@]} -lt $max_parallel && $stage_index -lt ${#stages[@]} ]]; do
            local stage="${stages[$stage_index]}"
            
            update_wave_status "$session_id" "executing" "$stage"
            
            # Execute stage in background
            execute_wave_stage "$session_id" "$stage" &
            pids+=($!)
            
            stage_index=$((stage_index + 1))
        done
        
        # Wait for at least one stage to complete
        wait_for_stage_completion pids[@]
        
        # Check completed stages
        local new_pids=()
        for pid in "${pids[@]}"; do
            if kill -0 "$pid" 2>/dev/null; then
                new_pids+=("$pid")
            fi
        done
        pids=("${new_pids[@]}")
    done
    
    # Wait for all remaining stages
    for pid in "${pids[@]}"; do
        wait "$pid"
    done
    
    return 0
}

# Execute adaptive waves
execute_adaptive_waves() {
    local session_id="$1"
    shift
    local stages=("$@")
    
    batcave_announce "Executing adaptive wave pattern..." "info"
    
    local remaining_stages=("${stages[@]}")
    local parallel_capable=()
    local sequential_only=()
    
    while [[ ${#remaining_stages[@]} -gt 0 ]]; do
        # Analyze remaining stages for parallel capability
        analyze_stage_dependencies "${remaining_stages[@]}"
        
        # Separate parallel-capable and sequential-only stages
        classify_stages "${remaining_stages[@]}"
        
        # Execute parallel stages first
        if [[ ${#parallel_capable[@]} -gt 0 ]]; then
            execute_parallel_batch "$session_id" "${parallel_capable[@]}"
        fi
        
        # Execute sequential stages
        if [[ ${#sequential_only[@]} -gt 0 ]]; then
            execute_sequential_batch "$session_id" "${sequential_only[@]}"
        fi
        
        # Update remaining stages
        update_remaining_stages "$session_id" remaining_stages
    done
    
    return 0
}

# Execute systematic waves
execute_systematic_waves() {
    local session_id="$1"
    shift
    local stages=("$@")
    
    batcave_announce "Executing systematic wave pattern..." "info"
    
    for stage in "${stages[@]}"; do
        update_wave_status "$session_id" "executing" "$stage"
        
        # Pre-stage validation
        if ! validate_stage_prerequisites "$session_id" "$stage"; then
            batcave_announce "Stage prerequisites not met: $stage" "warning"
            continue
        fi
        
        # Execute stage with comprehensive logging
        if execute_wave_stage "$session_id" "$stage" --systematic; then
            # Post-stage validation
            if validate_stage_completion "$session_id" "$stage"; then
                mark_stage_completed "$session_id" "$stage"
                batman_progress "$stage" "$((${#stages[@]} - $(count_remaining_stages "$session_id" "${stages[@]}")))" "${#stages[@]}"
            else
                batcave_announce "Stage validation failed: $stage" "warning"
                mark_stage_failed "$session_id" "$stage"
            fi
        else
            mark_stage_failed "$session_id" "$stage"
        fi
    done
    
    return 0
}

# Execute individual wave stage
execute_wave_stage() {
    local session_id="$1"
    local stage="$2"
    local options="$3"
    
    local stage_log="$WAVE_LOGS_DIR/${session_id}-${stage}.log"
    local stage_start_time=$(epoch_time)
    
    log_info "Starting wave stage: $stage"
    
    # Activate appropriate personas for stage
    local personas=($(select_personas_for_stage "$stage"))
    activate_personas "wave_stage:$stage" "$stage" "${personas[@]}"
    
    # Activate appropriate MCP servers
    local mcp_servers=($(select_mcp_servers "$stage" "medium" "wave_execution"))
    activate_mcp_servers "${mcp_servers[@]}"
    
    # Execute stage-specific logic
    local stage_result=0
    case "$stage" in
        "analyze"|"requirements_analysis")
            execute_analysis_stage "$session_id" "$stage" "$options"
            stage_result=$?
            ;;
        "design"|"architecture_design")
            execute_design_stage "$session_id" "$stage" "$options"
            stage_result=$?
            ;;
        "implement"|"implementation")
            execute_implementation_stage "$session_id" "$stage" "$options"
            stage_result=$?
            ;;
        "test"|"testing")
            execute_testing_stage "$session_id" "$stage" "$options"
            stage_result=$?
            ;;
        "deploy"|"deployment")
            execute_deployment_stage "$session_id" "$stage" "$options"
            stage_result=$?
            ;;
        "validate"|"validation")
            execute_validation_stage "$session_id" "$stage" "$options"
            stage_result=$?
            ;;
        "document"|"documentation")
            execute_documentation_stage "$session_id" "$stage" "$options"
            stage_result=$?
            ;;
        *)
            execute_generic_stage "$session_id" "$stage" "$options"
            stage_result=$?
            ;;
    esac
    
    # Record stage execution metrics
    local stage_end_time=$(epoch_time)
    local stage_duration=$((stage_end_time - stage_start_time))
    
    record_stage_metrics "$session_id" "$stage" "$stage_duration" "$stage_result"
    
    log_info "Wave stage completed: $stage (duration: ${stage_duration}s, result: $stage_result)"
    
    return $stage_result
}

# Stage-specific execution functions
execute_analysis_stage() {
    local session_id="$1"
    local stage="$2"
    local options="$3"
    
    # Activate analyzer persona and Sequential MCP
    force_persona "analyzer"
    activate_mcp_servers "sequential" "context7"
    
    # Perform analysis based on context
    local analysis_result=$(mcp_query "sequential" "analyze current context and requirements")
    
    # Store analysis results
    cache_set_advanced "wave" "$session_id" "analysis" "$analysis_result" 3600
    
    return 0
}

execute_design_stage() {
    local session_id="$1"
    local stage="$2"
    local options="$3"
    
    # Activate architect persona
    force_persona "architect"
    activate_mcp_servers "sequential" "context7"
    
    # Perform design work
    local design_result=$(mcp_query "sequential" "create system design based on analysis")
    
    # Store design results
    cache_set_advanced "wave" "$session_id" "design" "$design_result" 3600
    
    return 0
}

execute_implementation_stage() {
    local session_id="$1"
    local stage="$2"
    local options="$3"
    
    # Activate appropriate development personas
    local implementation_type=$(detect_implementation_type "$session_id")
    
    case "$implementation_type" in
        "frontend")
            activate_personas "wave_implementation" "frontend" "frontend" "qa"
            activate_mcp_servers "magic" "context7"
            ;;
        "backend")
            activate_personas "wave_implementation" "backend" "backend" "security"
            activate_mcp_servers "sequential" "context7"
            ;;
        "fullstack")
            activate_personas "wave_implementation" "fullstack" "frontend" "backend" "qa"
            activate_mcp_servers "magic" "sequential" "context7"
            ;;
    esac
    
    # Perform implementation
    local implementation_result=$(execute_implementation_logic "$session_id")
    
    # Store implementation results
    cache_set_advanced "wave" "$session_id" "implementation" "$implementation_result" 3600
    
    return 0
}

execute_testing_stage() {
    local session_id="$1"
    local stage="$2"
    local options="$3"
    
    # Activate QA persona and testing MCPs
    force_persona "qa"
    activate_mcp_servers "playwright" "sequential"
    
    # Perform testing
    local testing_result=$(mcp_query "playwright" "create comprehensive test suite")
    
    # Store testing results
    cache_set_advanced "wave" "$session_id" "testing" "$testing_result" 3600
    
    return 0
}

execute_deployment_stage() {
    local session_id="$1"
    local stage="$2"
    local options="$3"
    
    # Activate DevOps persona
    force_persona "devops"
    activate_mcp_servers "sequential" "context7"
    
    # Perform deployment
    local deployment_result=$(execute_deployment_logic "$session_id")
    
    # Store deployment results
    cache_set_advanced "wave" "$session_id" "deployment" "$deployment_result" 3600
    
    return 0
}

execute_validation_stage() {
    local session_id="$1"
    local stage="$2"
    local options="$3"
    
    # Activate analyzer persona
    force_persona "analyzer"
    activate_mcp_servers "sequential" "context7"
    
    # Perform validation
    local validation_result=$(execute_validation_logic "$session_id")
    
    # Store validation results
    cache_set_advanced "wave" "$session_id" "validation" "$validation_result" 3600
    
    return 0
}

execute_documentation_stage() {
    local session_id="$1"
    local stage="$2"
    local options="$3"
    
    # Activate scribe persona
    force_persona "scribe"
    activate_mcp_servers "context7" "sequential"
    
    # Perform documentation
    local documentation_result=$(execute_documentation_logic "$session_id")
    
    # Store documentation results
    cache_set_advanced "wave" "$session_id" "documentation" "$documentation_result" 3600
    
    return 0
}

execute_generic_stage() {
    local session_id="$1"
    local stage="$2"
    local options="$3"
    
    # Use default analyzer persona
    force_persona "analyzer"
    activate_mcp_servers "sequential" "context7"
    
    # Execute generic stage logic
    local generic_result=$(execute_generic_logic "$session_id" "$stage")
    
    # Store generic results
    cache_set_advanced "wave" "$session_id" "$stage" "$generic_result" 3600
    
    return 0
}

# Utility functions
update_wave_status() {
    local session_id="$1"
    local status="$2"
    local current_stage="$3"
    
    local session_file="$WAVE_STATE_DIR/${session_id}.json"
    
    local temp_file=$(mktemp)
    jq ".status = \"$status\" | .current_stage = \"$current_stage\" | .updated_at = \"$(timestamp)\"" \
        "$session_file" > "$temp_file" && mv "$temp_file" "$session_file"
}

mark_stage_completed() {
    local session_id="$1"
    local stage="$2"
    
    local session_file="$WAVE_STATE_DIR/${session_id}.json"
    
    local temp_file=$(mktemp)
    jq ".completed_stages += [\"$stage\"]" \
        "$session_file" > "$temp_file" && mv "$temp_file" "$session_file"
}

mark_stage_failed() {
    local session_id="$1"
    local stage="$2"
    
    local session_file="$WAVE_STATE_DIR/${session_id}.json"
    
    local temp_file=$(mktemp)
    jq ".failed_stages += [\"$stage\"]" \
        "$session_file" > "$temp_file" && mv "$temp_file" "$session_file"
}

finalize_wave_session() {
    local session_id="$1"
    local session_file="$WAVE_STATE_DIR/${session_id}.json"
    
    local end_time=$(epoch_time)
    local start_time=$(json_get "$session_file" "metrics.start_time")
    local duration=$((end_time - start_time))
    
    local temp_file=$(mktemp)
    jq ".status = \"completed\" | .metrics.end_time = $end_time | .metrics.duration = $duration" \
        "$session_file" > "$temp_file" && mv "$temp_file" "$session_file"
    
    # Generate wave execution report
    generate_wave_report "$session_id"
    
    batman_completion "wave_orchestration" "true"
}

# Generate wave execution report
generate_wave_report() {
    local session_id="$1"
    local session_file="$WAVE_STATE_DIR/${session_id}.json"
    local report_file="$WAVE_LOGS_DIR/${session_id}-report.md"
    
    cat > "$report_file" <<EOF
# Wave Execution Report

**Session ID**: $session_id
**Command**: $(json_get "$session_file" "command")
**Mode**: $(json_get "$session_file" "mode")
**Duration**: $(json_get "$session_file" "metrics.duration")s

## Execution Summary

- **Completed Stages**: $(json_get "$session_file" "completed_stages" | jq 'length')
- **Failed Stages**: $(json_get "$session_file" "failed_stages" | jq 'length')
- **Success Rate**: $(calculate_success_rate "$session_file")%

## Stage Details

$(generate_stage_details "$session_file")

## Recommendations

$(generate_recommendations "$session_file")

---
*Report generated at $(timestamp)*
EOF
    
    log_info "Wave execution report generated: $report_file"
}

# Initialize wave system if not already done
if [[ ! -f "$WAVE_CONFIG_FILE" ]]; then
    init_wave_system
fi

# Export wave orchestration functions
export -f init_wave_system orchestrate_waves create_wave_session
export -f execute_sequential_waves execute_parallel_waves execute_adaptive_waves execute_systematic_waves
export -f execute_wave_stage update_wave_status mark_stage_completed mark_stage_failed
export -f finalize_wave_session generate_wave_report