# Activate maximum cognitive capacity for complex problems

Usage: /think [problem] [--harder|--ultra] [--spec <spec-file>]

1. Enter enhanced reasoning mode based on modifier:
   - Default: Standard deep thinking (Sequential MCP)
   - --harder: Extended analysis (2x depth)
   - --ultra: Maximum depth (5x, token intensive)
   - If --spec provided: Load spec file for context and constraints

2. Analyze the problem from multiple perspectives:
   - Technical feasibility
   - Architecture implications
   - Performance considerations
   - Security aspects
   - Maintainability factors
   - If --spec provided: Alignment with specification requirements

3. Research existing codebase for:
   - Similar patterns or solutions (Context7 MCP)
   - Potential conflicts or dependencies
   - Reusable components

4. Generate solution alternatives with pros/cons matrix

5. Create decision recommendation with:
   - Recommended approach
   - Implementation strategy
   - Risk assessment
   - Success criteria

6. Output comprehensive analysis to scratchpads/thinking-{timestamp}.md

7. If solution involves multiple components, automatically create todo items

## Enhanced Features

- **MCP Integration**: Automatic Sequential MCP activation for deep reasoning
- **Persona Activation**: Auto-selects appropriate personas based on problem domain
- **Context Caching**: Caches analysis results for similar problems
- **Wave Orchestration**: For ultra-complex problems requiring systematic breakdown

Options:
- --harder: Extended analysis (2x depth)
- --ultra: Maximum depth (5x, token intensive)
- --spec: Use existing spec file for context and constraints
- --personas: Manually specify personas to activate
- --mcp: Specify MCP servers to use

Remember: Take your time, think step by step, and consider edge cases.
Note: When using --spec, thinking will be guided by and validated against specification requirements