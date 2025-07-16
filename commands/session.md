# Generate insights and track progress

Usage: /session [--summary] [--metrics] [--next]

1. Gather session data:
   - All commands executed
   - Files created/modified
   - Tests run and results
   - Issues created/resolved
   - Commits made
   - PRs opened

2. Generate accomplishments list:
   - Completed tasks from todo.md
   - Implemented features
   - Fixed bugs
   - Improved code quality
   - Documentation updates

3. Calculate metrics:
   - Lines of code added/removed
   - Test coverage change
   - Files touched
   - Token usage
   - Time elapsed
   - Efficiency score

4. Identify patterns:
   - Most edited files
   - Common error types
   - Frequent refactoring needs
   - Testing gaps

5. Document blockers:
   - Unresolved issues
   - Failed attempts
   - Missing dependencies
   - Knowledge gaps

6. Extract learnings:
   - New patterns discovered
   - Effective solutions
   - Things to avoid
   - Process improvements

7. If --next flag provided:
   - Analyze remaining todos
   - Suggest priority order
   - Identify quick wins
   - Estimate completion time

8. Update visualizations:
   - Progress charts
   - Burndown graphs
   - Coverage trends
   - Productivity metrics

9. Save comprehensive report:
   - Session summary
   - Key decisions made
   - Technical debt noted
   - Follow-up actions

Output: Session report to logs/sessions/session-{timestamp}.md