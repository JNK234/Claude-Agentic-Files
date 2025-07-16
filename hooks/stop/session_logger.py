#!/usr/bin/env python3
"""
Session Logger Hook for Claude Code
Logs session completion and generates summary reports.
"""

import json
import sys
import os
from datetime import datetime
from pathlib import Path

# Log file location
LOG_FILE = os.path.expanduser("~/.claude/session_logs.json")
PROGRESS_FILE = os.path.expanduser("~/.claude/progress.json")

def load_logs():
    """Load existing log data."""
    if os.path.exists(LOG_FILE):
        try:
            with open(LOG_FILE, 'r') as f:
                return json.load(f)
        except (json.JSONDecodeError, IOError):
            return {"sessions": []}
    return {"sessions": []}

def load_progress():
    """Load progress data for current session."""
    if os.path.exists(PROGRESS_FILE):
        try:
            with open(PROGRESS_FILE, 'r') as f:
                return json.load(f)
        except (json.JSONDecodeError, IOError):
            return {}
    return {}

def save_logs(log_data):
    """Save log data to file."""
    try:
        # Ensure directory exists
        os.makedirs(os.path.dirname(LOG_FILE), exist_ok=True)
        
        with open(LOG_FILE, 'w') as f:
            json.dump(log_data, f, indent=2)
    except IOError:
        # Silently fail if can't write logs
        pass

def log_session_completion(stop_data):
    """
    Log the completion of a Claude Code session.
    
    Args:
        stop_data: Dictionary containing session completion information
        
    Returns:
        dict: Response with action and summary message
    """
    timestamp = datetime.now().isoformat()
    
    # Load existing logs and progress
    logs = load_logs()
    progress = load_progress()
    
    # Get current session data
    current_session = progress.get('current_session', f"session_{int(datetime.now().timestamp())}")
    session_data = progress.get('sessions', {}).get(current_session, {})
    
    # Create session summary
    session_summary = {
        'session_id': current_session,
        'end_time': timestamp,
        'start_time': session_data.get('start_time', timestamp),
        'duration_minutes': 0,
        'stats': session_data.get('stats', {
            'total_operations': 0,
            'successful_operations': 0,
            'failed_operations': 0,
            'files_modified': 0,
            'commands_executed': 0
        }),
        'operations': session_data.get('operations', []),
        'final_message': stop_data.get('message', '')
    }
    
    # Calculate duration
    try:
        start_time = datetime.fromisoformat(session_summary['start_time'])
        end_time = datetime.fromisoformat(session_summary['end_time'])
        duration = end_time - start_time
        session_summary['duration_minutes'] = round(duration.total_seconds() / 60, 2)
    except (ValueError, TypeError):
        session_summary['duration_minutes'] = 0
    
    # Add to logs
    logs['sessions'].append(session_summary)
    
    # Keep only last 50 sessions to prevent file bloat
    if len(logs['sessions']) > 50:
        logs['sessions'] = logs['sessions'][-50:]
    
    # Save logs
    save_logs(logs)
    
    # Generate summary message
    stats = session_summary['stats']
    summary = f"Session completed: {stats['successful_operations']}/{stats['total_operations']} operations successful"
    
    if session_summary['duration_minutes'] > 0:
        summary += f", {session_summary['duration_minutes']} minutes"
    
    if stats['files_modified'] > 0:
        summary += f", {stats['files_modified']} files modified"
    
    if stats['commands_executed'] > 0:
        summary += f", {stats['commands_executed']} commands executed"
    
    # Calculate success rate
    if stats['total_operations'] > 0:
        success_rate = (stats['successful_operations'] / stats['total_operations']) * 100
        summary += f", {success_rate:.1f}% success rate"
    
    return {
        "action": "allow",
        "message": summary
    }

def main():
    """Main entry point for the session logger hook."""
    try:
        # Read input from stdin
        input_data = sys.stdin.read()
        if not input_data.strip():
            print(json.dumps({"action": "allow"}))
            return
        
        # Parse JSON input
        stop_data = json.loads(input_data)
        
        # Log session completion
        response = log_session_completion(stop_data)
        
        # Output response
        print(json.dumps(response))
        
    except json.JSONDecodeError:
        # Invalid JSON input - allow by default
        print(json.dumps({"action": "allow"}))
    except Exception as e:
        # Any other error - allow by default
        print(json.dumps({
            "action": "allow",
            "message": f"Session logger error: {str(e)}"
        }))

if __name__ == "__main__":
    main()