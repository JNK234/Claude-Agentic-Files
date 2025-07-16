# Advanced Claude Code project setup with full power features

Usage: /setup [--type auto|python|js|go] [--parallel] [--mcp] [--hooks]

1. Run /init first if not already done
2. Set up advanced directory structure:
   - tasks/ - For PRDs and implementation plans
   - scratchpads/ - For thinking and planning
   - logs/ - For session tracking
   - personas/ - For custom Claude personalities
3. Create initial todo.md structure with template
4. Configure project-specific hooks based on detected project type
5. If --mcp flag is provided, install relevant MCP servers based on project
6. If --parallel flag is provided, configure Git worktrees for parallel development
7. Set up advanced .gitignore entries for Claude-specific files
8. Configure automation scripts (parallel.sh, worktree.sh, etc.)
9. Run diagnostic checks to ensure everything is configured properly

Options:
- --type: Specify project type (auto-detects if not provided)
- --parallel: Configure for parallel development with worktrees
- --mcp: Auto-install relevant MCP servers
- --hooks: Configure custom hooks for automation

Output comprehensive setup report to logs/setup-{timestamp}.md

Note: This is the advanced setup command. For basic Claude Code initialization, use `/init` instead.