# Task execution engine

Usage: /execute [todo|plan|issues] [--batch N]

Modes:
- todo: Work through items in todo.md
- plan: Execute prompts from plan file
- issues: Process GitHub issues

Process:

1. Task selection based on mode:
   - todo: Find next unchecked item in todo.md
   - plan: Read next unimplemented prompt from plan file
   - issues: Fetch open issues and select based on labels/priority

2. If --batch N provided:
   - Select up to N parallelizable tasks
   - Ensure no dependency conflicts
   - Create worktrees for each task
   - Launch parallel execution

3. For each task:
   - Create feature branch if needed
   - Post plan to GitHub issue (if applicable)
   - Implement solution following TDD
   - Run tests and quality checks
   - Commit with appropriate message

4. Update tracking:
   - Check off completed todo items
   - Mark plan prompts as implemented
   - Close GitHub issues with PR reference

5. Handle failures gracefully:
   - If tests fail, attempt fixes
   - If unable to fix, document blockers
   - Create follow-up issues if needed

6. Progress reporting:
   - Show real-time progress
   - Log all actions
   - Update session metrics

7. After batch completion:
   - Merge completed branches
   - Update main todo.md
   - Generate summary report

Output: Execution summary with completed tasks and any blockers