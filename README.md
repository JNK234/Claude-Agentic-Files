# 🚀 Claude Code Ultimate Power Pack

Transform Claude Code into an unstoppable development powerhouse with zero permission fatigue, parallel execution, and enterprise-ready automation.

## 🎯 What is This?

A comprehensive enhancement system for Claude Code that provides:
- **Dangerous mode by default** with smart safety filters
- **8 powerful commands** covering all development workflows  
- **Parallel execution** with Git worktrees and tmux
- **MCP integration** for databases, browsers, and APIs
- **Automated workflows** from idea to deployed PR
- **Fun personas** to keep coding engaging

## 🏃 Quick Start

```bash
# Clone and install
git clone https://github.com/jnk789/claude-power-pack
cd claude-power-pack
chmod +x install.sh
./install.sh

# Start using in any project
cd /your/project
claude /init
claude /ship "implement user authentication"
```

## 📦 What's Included

### Core Commands

1. **`/init`** - Smart project initialization with auto-detection
2. **`/think`** - Deep reasoning mode for complex problems
3. **`/ship`** - Complete feature delivery from idea to PR
4. **`/plan`** - Strategic planning with PRD generation
5. **`/review`** - Multi-dimensional code analysis
6. **`/execute`** - Systematic task execution engine
7. **`/sync`** - Codebase synchronization and learning
8. **`/session`** - Progress tracking and insights

### Safety Features

- **Smart pre-hooks** block only truly dangerous operations
- **Auto-formatting** after file modifications
- **Voice notifications** for important events
- **Session logging** for complete auditability

### Automation Scripts

- **`worktree.sh`** - Create isolated Git worktrees for parallel work
- **`parallel.sh`** - Launch multiple Claude instances (Claude Squad)
- **`mcp_setup.sh`** - Configure external tool integrations

## 🛠️ Installation

### Prerequisites

- Claude Code (`npm install -g @anthropic-ai/claude-code`)
- Git
- Python 3
- tmux (for parallel execution)

### Install Steps

1. Clone this repository
2. Run `./install.sh`
3. (Optional) Source your shell RC file for aliases

## 🎮 Usage Examples

### Basic Workflow
```bash
# Initialize a project
claude /init --type python --mcp

# Deep thinking for architecture
claude /think "What's the best way to implement real-time chat?"

# Plan a feature
claude /plan "Build user authentication system" --prd --tasks

# Ship it
claude /ship "implement JWT authentication"
```

### Parallel Development
```bash
# Work on specific task in isolated worktree
~/.claude/scripts/worktree.sh issue-123

# Launch 5 parallel Claude instances
~/.claude/scripts/parallel.sh 5
```

### Code Review
```bash
# Security audit with auto-fixes
claude /review security --fix --create-issues

# Complete review
claude /review all
```

## ⚙️ Configuration

### Global Settings
Located at `~/.claude/settings.json`:
- Dangerous mode enabled by default
- Smart hooks for safety
- Voice notifications
- Auto-formatting

### Project Settings
Create `.claude/settings.json` in your project for overrides.

### Personas
Customize Claude's personality in `~/.claude/personas/dr_biz.md`

## 🔒 Security

While dangerous mode is enabled by default, the system includes multiple safety layers:

1. **Pre-execution hooks** block:
   - Destructive file operations (`rm -rf /`)
   - Credential exposure
   - System modifications
   - Network attacks

2. **Allowed operations**:
   - All normal development tasks
   - Testing and deployment
   - File creation and editing
   - Package management

## 🤝 Contributing

Feel free to submit issues and enhancement requests!

## 📝 License

MIT License - Use freely in your projects

## 🙏 Acknowledgments

Built with insights from the Claude Code community and extensive research into optimal AI-assisted development workflows.

---

**Happy coding, Doctor Biz! 🚀**