# Claude Code Agentic System

A portable Claude Code configuration system designed for rapid deployment on workstations, HPC clusters, and GPU nodes. Clone, configure secrets, install.

## Quick Start

```bash
git clone https://github.com/JNK234/Claude-Agentic-Files.git
cd Claude-Agentic-Files

# 1. Set up secrets
cp .env.example .env
# Edit .env with your API keys

# 2. Install
chmod +x install.sh
./install.sh
```

### Quick Start for HPC / GPU Clusters

```bash
git clone https://github.com/JNK234/Claude-Agentic-Files.git
cd Claude-Agentic-Files
cp .env.example .env && vim .env    # Fill in API keys
./install.sh --hpc
```

The `--hpc` flag auto-detects SLURM/PBS/SGE environments and skips GUI, MCP server, and shell RC modifications. It also runs non-interactively.

Other flags:
- `--non-interactive` — Skip all prompts, use defaults
- `--skip-mcp` — Skip MCP server installation
- `--skip-shell` — Skip shell RC modifications

## Directory Structure

```
.
├── CLAUDE.md                          # Core development guidelines
├── install.sh                         # Installer (interactive + HPC modes)
├── settings.json                      # Claude Code settings (sanitized)
├── settings.local.json.example        # Local MCP server selection template
├── claude_desktop_config.example.json # Desktop MCP config template
├── .env.example                       # Required environment variables
├── statusline-script.sh               # Status bar script
├── policy-limits.json                 # Policy restrictions
├── mcp-servers-config.json            # MCP server catalog with presets
│
├── agents/                            # Specialized sub-agent definitions
│   ├── meta-agent.md                  # Agent that creates other agents
│   ├── code-quality-analyzer.md       # Code quality analysis
│   └── codebase-deep-analyzer.md      # Deep codebase status reporting
│
├── commands/                          # Slash commands for Claude Code
│   ├── brainstorm.md                  # Interactive specification generation
│   ├── plan.md                        # Implementation planning
│   ├── prime.md                       # Load context for new sessions
│   ├── implement.md                   # Feature implementation
│   ├── document.md                    # Documentation generation
│   ├── commit-push.md                 # Git commit workflow
│   ├── create-spec.md                 # Specification interviews
│   ├── research-papers.md             # Research paper processing
│   ├── ccl:weekly-report.md           # Weekly report generation
│   ├── all-tools.md                   # List available tools
│   ├── init.md                        # Initialize project
│   └── meta-command.md                # Create new commands
│
├── hooks/                             # Event-driven automation
│   ├── pre_tool_use/
│   │   ├── safety_guard.py            # Block dangerous operations
│   │   └── context_validator.py       # Validate tool context
│   ├── post_tool_use/
│   │   ├── auto_format.py             # Auto-format written files
│   │   ├── linter_check.py            # Lint after edits
│   │   └── progress_tracker.py        # Track task progress
│   ├── session/
│   │   ├── check_sessions.py          # Session management
│   │   ├── conversation_log.py        # Log conversations on stop
│   │   └── pre_compact.py             # Pre-compaction hook
│   └── stop/
│       └── session_logger.py          # Session end logging
│
├── skills/                            # Reusable skill modules
│   ├── apply-job/                     # Job application workflow
│   ├── ccl-demo-builder/              # NetLogo demo builder
│   ├── github-ops/                    # GitHub operations
│   ├── google-adk-agent-builder/      # Google ADK agents
│   ├── netlogo-dev/                   # NetLogo development
│   ├── obsidian-vault/                # Obsidian vault management
│   ├── research-papers/               # Research paper processing
│   ├── tailor-resume/                 # Resume tailoring
│   ├── twitter-copywriting-skill/     # Social media copywriting
│   └── learned/                       # Auto-learned patterns
│
├── profiles/                          # Model provider configurations
│   ├── claude.example.json            # Default Anthropic API
│   ├── openrouter.example.json        # OpenRouter multi-model
│   ├── minimax.example.json           # MiniMax M2
│   ├── glm.example.json               # Zhipu GLM models
│   └── kimi.example.json              # Moonshot Kimi K2
│
├── lib/                               # Shell utility libraries
│   ├── utils.sh
│   ├── batman.sh
│   ├── cache.sh
│   └── context.sh
│
├── scripts/                           # Helper scripts
└── docs/                              # Documentation
```

## Secrets Management

All secrets are managed via `.env` files, never committed to the repo.

1. Copy the template: `cp .env.example .env`
2. Fill in your API keys in `.env`
3. During `install.sh`, `envsubst` populates config templates with your keys

Required environment variables (see `.env.example` for full list):
- `OPENROUTER_API_KEY` — Multi-model routing
- `PERPLEXITY_API_KEY` — Search integration
- `BRAVE_API_KEY` — Web search
- `ELEVENLABS_API_KEY` — TTS (optional on HPC)
- `GITHUB_TOKEN` — GitHub MCP server

## Model Profiles

Switch between model providers by copying a profile to `settings.json`:

```bash
# Use OpenRouter
cp ~/.claude/profiles/openrouter.json ~/.claude/settings.json

# Use default Claude API
cp ~/.claude/profiles/claude.json ~/.claude/settings.json

# Use Kimi K2
cp ~/.claude/profiles/kimi.json ~/.claude/settings.json
```

Profile templates in `profiles/*.example.json` are populated with your `.env` secrets during installation via `envsubst`.

## Key Components

### Hooks
Event-driven Python scripts that run at specific points in the Claude Code lifecycle:
- **PreToolUse**: Safety guards and context validation before tool execution
- **PostToolUse**: Auto-formatting and linting after file changes
- **SessionStart**: Session initialization and context loading
- **PreCompact**: Save state before context compaction
- **Stop**: Conversation logging on session end

### Skills
Reusable workflow modules that provide domain-specific capabilities. Each skill is a directory containing markdown instructions that Claude loads on demand.

### Commands
Slash commands (`/brainstorm`, `/plan`, `/implement`, etc.) that provide structured workflows for common development tasks.

### Agents
Specialized sub-agent definitions for complex tasks like code quality analysis and deep codebase exploration.

## License

MIT License
