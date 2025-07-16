# Generate comprehensive, actionable plans

Usage: /plan ["feature description"] [--prd] [--tasks]

1. Requirements analysis:
   - Parse provided description or prompt for details
   - Identify functional requirements
   - Define non-functional requirements
   - Establish success criteria

2. If --prd flag provided:
   - Generate full Product Requirements Document
   - Include user stories
   - Define acceptance criteria
   - Specify technical constraints
   - Save to tasks/prd-{feature}-{timestamp}.md

3. Create implementation plan:
   - Architecture decisions
   - Technology choices
   - Implementation phases
   - Dependencies and prerequisites
   - Risk mitigation strategies

4. Break down into atomic tasks:
   - Each task should be completable in 1-4 hours
   - Clear description and acceptance criteria
   - Dependencies between tasks
   - Priority levels (high/medium/low)

5. Estimate complexity and timeline:
   - Story points for each task
   - Total estimated hours
   - Suggested sprint allocation

6. If --tasks flag provided:
   - Create GitHub issues for each task
   - Link issues with dependencies
   - Apply appropriate labels
   - Set up project board if available

7. Generate todo.md structure:
   - Organize tasks by phase/priority
   - Include checkboxes for tracking
   - Add issue numbers if created

8. Update CLAUDE.md:
   - Document architectural decisions
   - Note technology choices
   - Record important constraints

Output: Plan saved to tasks/plan-{feature}-{timestamp}.md