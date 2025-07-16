# Complete development cycle with zero friction

Usage: /ship [task|issue|"description"] [--parallel] [--spec <spec-file>] [--validate-spec]

1. Work item selection:
   - If task ID provided: Select from todo.md
   - If issue number: Fetch from GitHub
   - If description: Create new work item
   - If --spec provided: Load spec file and use as implementation guide

2. Plan approach using scratchpads/:
   - Break down into implementation steps
   - Identify test scenarios
   - Consider edge cases
   - If --spec provided: Ensure implementation aligns with spec requirements

3. Create feature branch:
   - Branch name: feature/{task-id} or feature/{issue-number}
   - Set up tracking with main branch

4. Implement with TDD:
   - Write failing tests first
   - Implement minimal code to pass
   - Refactor while keeping tests green

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
   - Add screenshots if UI changes

8. Update tracking:
   - Mark todo item as complete
   - Update CLAUDE.md with learnings
   - Log session progress

9. If --parallel specified:
   - Identify sub-tasks that can be parallelized
   - Create worktrees for each
   - Launch parallel Claude instances

10. If --validate-spec provided:
    - Compare final implementation against spec requirements
    - Verify all acceptance criteria are met
    - Generate compliance report

11. Trigger deployment preview if configured

Options:
- --parallel: Split into sub-tasks for parallel execution
- --spec: Use existing spec file as implementation guide (e.g., tasks/spec-feature-timestamp.md)
- --validate-spec: Validate final implementation against spec requirements

Output: PR URL and deployment preview link
Note: When using --spec, implementation will be guided by and validated against the specification