# Interactive brainstorming and specification generation

Usage: /brainstorm [topic] [--interactive] [--specs] [--research]

1. Enter interactive brainstorming mode for the given topic
2. Ask clarifying questions to understand requirements
3. Conduct Q&A session to explore different aspects:
   - Technical requirements
   - User experience considerations
   - Architecture options
   - Implementation challenges
   - Success criteria
4. Research existing codebase for related patterns
5. Generate comprehensive specifications based on findings
6. Create actionable implementation plans
7. Generate comprehensive specification document saved to tasks/spec-{topic}-{timestamp}.md
8. Save session summary to logs/brainstorm-session-{timestamp}.md

Options:
- --interactive: Enable guided Q&A mode (default)
- --specs: Focus on generating detailed specifications
- --research: Include deep research phase before brainstorming

Process:
1. **Discovery Phase**: Ask targeted questions about goals, constraints, and requirements
2. **Research Phase**: Analyze existing codebase and similar implementations
3. **Ideation Phase**: Generate multiple solution approaches with pros/cons
4. **Specification Phase**: Create detailed technical and functional specifications
5. **Planning Phase**: Break down into actionable implementation steps

Output:
- tasks/spec-{topic}-{timestamp}.md - Complete specification including:
  - Requirements analysis
  - Technical specifications
  - Implementation roadmap
  - Risk assessment
  - Success metrics
- logs/brainstorm-session-{timestamp}.md - Session summary and decisions

This command is designed for collaborative specification creation through interactive dialogue, generating a single comprehensive specification document in the tasks/ directory.