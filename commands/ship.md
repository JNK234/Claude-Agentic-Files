# Complete development cycle with zero friction

Usage: /ship [task|issue|"description"] [--parallel] [--spec <spec-file>] [--validate-spec]

1. Work item selection:
   - If task ID provided: Select from todo.md
   - If issue number: Fetch from GitHub
   - If description: Create new work item
   - If --spec provided: Load spec file and use as implementation guide
   - Persona activation: Auto-select based on feature complexity

2. Plan approach using scratchpads/:
   - Break down into implementation steps
   - Identify test scenarios (QA persona activation)
   - Consider edge cases
   - If --spec provided: Ensure implementation aligns with spec requirements
   - MCP integration: Context7 for documentation, Sequential for analysis

3. Create feature branch:
   - Branch name: feature/{task-id} or feature/{issue-number}
   - Set up tracking with main branch

4. Implement with TDD:
   - Write failing tests first (QA persona)
   - Implement minimal code to pass (appropriate dev persona)
   - Refactor while keeping tests green (Refactorer persona)

5. Code quality checks:
   - Auto-format based on project conventions
   - Run linting
   - Execute full test suite

6. Commit with semantic message:
   - Type: feat/fix/refactor/test/docs
   - Scope: affected component
   - Description: clear and concise

7. Create detailed PR:
   - Link to issue/task
   - Describe changes
   - Include test results
   - Add screenshots if UI changes (Magic MCP integration)

8. Update tracking:
   - Mark todo item as complete
   - Update CLAUDE.md with learnings
   - Log session progress

9. If --parallel specified:
   - Identify sub-tasks that can be parallelized
   - Execute: ~/.claude/scripts/worktree.sh {task-id} for each sub-task
   - Launch parallel Claude instances with persona specialization
   - Orchestrated wave execution for complex features

10. If --validate-spec provided:
    - Compare final implementation against spec requirements
    - Verify all acceptance criteria are met
    - Generate compliance report

11. Trigger deployment preview if configured

Options:
- --parallel: Split into sub-tasks for parallel execution with persona specialization
- --spec: Use existing spec file as implementation guide
- --validate-spec: Validate final implementation against spec requirements
- --personas: Override automatic persona selection
- --mcp: Specify MCP servers to use during implementation
- --complexity: Override complexity analysis (low|medium|high|ultra)

Output: PR URL and deployment preview link
Note: When using --spec, implementation will be guided by and validated against the specification using MCP integration and persona coordination.