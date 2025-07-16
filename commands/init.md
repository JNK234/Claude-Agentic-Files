# Initialize Claude Code with full power features

Usage: /init [--type auto|python|js|go] [--parallel] [--mcp]

1. Run claude init to scan codebase and generate CLAUDE.md if it doesn't exist
2. Set up required directories:
   - tasks/ - For PRDs and implementation plans
   - scratchpads/ - For thinking and planning
   - logs/ - For session tracking
3. Create initial todo.md structure with template
4. Configure project-specific hooks based on detected project type
5. If --mcp flag is provided, install relevant MCP servers based on project
6. Create .gitignore entries for Claude-specific files
7. Run diagnostic checks to ensure everything is configured properly

Options:
- --type: Specify project type (auto-detects if not provided)
- --parallel: Configure for parallel development with worktrees
- --mcp: Auto-install relevant MCP servers

Output comprehensive setup report to logs/init-{timestamp}.md