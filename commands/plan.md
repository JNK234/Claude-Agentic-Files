# Generate comprehensive, actionable plans

Usage: /plan ["feature description"] [--prd] [--tasks] [--from-spec <spec-file>]

1. Requirements analysis:
   - If --from-spec provided: Load existing spec from ./tasks/ directory
   - Auto-detect and load latest architecture docs from ./docs/ directory
   - Parse provided description or prompt for details
   - Identify functional requirements from spec + architecture
   - Define non-functional requirements from architecture constraints
   - Establish success criteria

2. If --prd flag provided:
   - Generate full Product Requirements Document
   - Include user stories
   - Define acceptance criteria
   - Specify technical constraints
   - Save to ./tasks/prd-{feature}-{timestamp}.md

3. Create implementation plan based on spec + architecture:
   - Apply architecture decisions from ./docs/architecture-*.md
   - Use recommended technology choices from architecture
   - Follow architectural patterns and constraints
   - Implementation phases aligned with system design
   - Dependencies and prerequisites from architecture docs
   - Risk mitigation strategies

4. Break down into atomic tasks with detailed prompts:
   - Each task should be completable in 1-4 hours
   - **Complete implementation prompt** with:
     * Detailed requirements and context
     * TDD approach (test-first when applicable)
     * Specific files to create/modify
     * Acceptance criteria
     * Code examples and patterns to follow
   - **Automatic workflow ending**: Each prompt ends with commit + conversation clear
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

7. Generate implementation guide with ready-to-execute prompts:
   - **Complete prompt for each task** including:
     * Full context and requirements
     * "Write tests first" instruction (when applicable)
     * Specific implementation steps
     * Files to create/modify with examples
     * Acceptance criteria verification
     * "Run tests, commit changes, and clear conversation" ending
   - Organize tasks by phase/priority
   - Include checkboxes for tracking progress
   - Add issue numbers if created

8. Update CLAUDE.md:
   - Document architectural decisions
   - Note technology choices
   - Record important constraints

Options:
- --prd: Generate full Product Requirements Document
- --tasks: Auto-create GitHub issues for each task
- --from-spec: Use existing spec file as requirements source (e.g., ./tasks/spec-feature-timestamp.md)
- Architecture docs are automatically loaded from ./docs/ directory

Output: Implementation guide saved to ./tasks/plan-{feature}-{timestamp}.md

**The plan document contains:**
- Complete implementation prompts ready to execute
- Each prompt includes full context, TDD approach, and specific deliverables
- Every task ends with: "Run tests, commit with descriptive message, and run /clear"
- Progressive workflow from setup → core features → testing → deployment

Note: When using --from-spec, plan will reference and build upon the specified spec document