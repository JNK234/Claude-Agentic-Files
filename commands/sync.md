# Update mental model with latest changes

Usage: /sync [--since "1 day ago"] [--pr]

1. Analyze recent changes:
   - Git log for specified time period
   - If --pr specified, focus on PR changes
   - Identify modified files and patterns

2. Review commits for:
   - New features added
   - Bug fixes implemented
   - Refactoring changes
   - Dependency updates
   - Configuration changes

3. Update CLAUDE.md with:
   - New patterns discovered
   - Deprecated approaches
   - Technology updates
   - Architecture changes
   - Important decisions made

4. Identify potential issues:
   - Breaking changes
   - Inconsistent patterns
   - Technical debt introduced
   - Missing documentation

5. Scan for learning opportunities:
   - Clever solutions to document
   - Patterns to replicate
   - Anti-patterns to avoid

6. Check for consistency:
   - Naming conventions
   - Code style adherence
   - Test coverage maintenance

7. Generate recommendations:
   - Refactoring opportunities
   - Documentation needs
   - Test gaps to fill
   - Performance improvements

8. Update project understanding:
   - Refresh mental model
   - Note team preferences
   - Update coding standards

Output: Sync report to logs/sync-{timestamp}.md with actionable insights