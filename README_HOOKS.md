# 🦇 Claude Code Batcave Hook System

A comprehensive hook system for Claude Code with linting, formatting, and Batman-themed feedback.

## 🚀 Quick Installation

```bash
# Run the setup script
./setup_hooks.sh

# Verify installation
python3 test_hooks.py
```

## 📋 What Gets Installed

### 🛡️ Pre-Tool Hooks (Run BEFORE tools execute)
- **Safety Guard** - Blocks dangerous Bash commands (fork bombs, system destruction)
- **Context Validator** - Validates file paths and prevents system file modifications

### 🔧 Post-Tool Hooks (Run AFTER tools execute)
- **Auto Formatter** - Formats code files (Prettier, Black, gofmt, rustfmt)
- **Linter Check** - Validates TypeScript/Python code quality
- **Progress Tracker** - Batman-themed status updates and session statistics

### 🔔 Notification & Logging
- **Voice Notifications** - Batman-themed TTS announcements
- **Session Logger** - Detailed mission reports with success rates

## 🛠️ Dependencies

### Required Tools

**JavaScript/TypeScript:**
```bash
npm install -g prettier eslint typescript @typescript-eslint/parser @typescript-eslint/eslint-plugin
```

**Python:**
```bash
pip install black flake8 mypy pylint
```

**Optional (for additional language support):**
- Go: `gofmt` (comes with Go installation)
- Rust: `rustfmt` (comes with Rust installation)  
- Ruby: `gem install rubocop`

## 🎯 What You'll See

When you create or edit files, Claude will receive messages like:

### ✅ Success Messages
```
🦇 Batcave Auto-Format: ✅ app.py: Formatted with black
🦇 Batcave: ✅ component.tsx: All 3 linting checks passed
🦇 Batcave Report: All 5 operations successful. Gotham remains secure.
```

### 🚨 Error Messages
```
🦇 Batcave Alert: 🚨 LINTING ERRORS in component.tsx:
  • Line 45: Missing semicolon (semi)
  • Line 52: Unused variable 'data' (no-unused-vars)

🦇 Batcave Auto-Format: 🚨 FORMATTING FAILED for script.js: Unexpected token
```

### 🛡️ Security Blocks
```
🛡️ BLOCKED: Fork bomb detected
Command: :(){ :|:& }
```

## 🔧 Manual Configuration

If you prefer manual setup:

1. **Copy hooks to Claude directory:**
```bash
cp -r hooks/* ~/.claude/hooks/
chmod +x ~/.claude/hooks/**/*.py
```

2. **Update settings.json:**
```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "Bash",
        "hooks": [
          {"type": "command", "command": "python ~/.claude/hooks/pre_tool_use/safety_guard.py"},
          {"type": "command", "command": "python ~/.claude/hooks/pre_tool_use/context_validator.py"}
        ]
      }
    ],
    "PostToolUse": [
      {
        "matcher": "Write|Edit|MultiEdit",
        "hooks": [
          {"type": "command", "command": "python ~/.claude/hooks/post_tool_use/auto_format.py"},
          {"type": "command", "command": "python ~/.claude/hooks/post_tool_use/linter_check.py"}
        ]
      }
    ]
  }
}
```

## 🧪 Testing

Run the verification script to test all hooks:
```bash
python3 test_hooks.py
```

Expected output:
```
🦇 BATCAVE HOOK VERIFICATION
============================
✅ safety_guard.py: Hook executed successfully
✅ context_validator.py: Hook executed successfully
✅ auto_format.py: 🦇 Batcave Auto-Format: No formatter configured for test.py
✅ linter_check.py: 🦇 Batcave: ⚠️ test.py: No linters available for this file type
✅ progress_tracker.py: 🦇 Batcave Report: All 1 operations successful. Gotham remains secure.
```

## 🎭 Batman Theme

All messages are styled with Batman/Gotham theming:
- 🦇 Batcave operations and status
- Master Wayne notifications
- Wayne Tech efficiency ratings  
- Gotham security confirmations

## 🔧 Troubleshooting

**Hooks not running?**
- Check Claude Code settings: `cat ~/.claude/settings.json`
- Verify hook permissions: `ls -la ~/.claude/hooks/**/*.py`
- Test individual hooks: `echo '{"tool":"Write","input":{"file_path":"/tmp/test.py"}}' | python3 ~/.claude/hooks/post_tool_use/linter_check.py`

**Linters not working?**
- Install missing dependencies (see Dependencies section)
- Check tool availability: `which prettier`, `which black`, `which eslint`
- Review hook logs in Claude Code output

**Voice notifications not working?**
- macOS: `say` should be available by default
- Linux: Install `espeak` or `festival`
- Windows: PowerShell TTS should work automatically

## 🚀 Advanced Usage

**Customize linter rules:** Edit hook files to add/remove linters or change configurations
**Add new languages:** Extend `FORMATTERS` and `LINTERS` dictionaries in hook files
**Modify Batman theme:** Update message templates in hook files

Master Wayne, your Batcave is ready for operations! 🦇