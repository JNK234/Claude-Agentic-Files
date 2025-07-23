# Generate comprehensive documentation from your work

Creates detailed markdown documentation that clearly explains what you've been working on for anyone with technical knowledge.

Usage: /document [path] [--deep]

## What It Does

1. **Analyzes Everything**: Scans your code, notebooks, files, git history, and project structure
2. **Asks Questions**: Interactive conversation to understand your work, goals, and decisions
3. **Creates Documentation**: Generates comprehensive markdown that tells the complete story

## The Process

**Analysis Phase**:
- Examines code structure, patterns, and functionality
- Reviews notebooks for research, experiments, and findings  
- Identifies technologies, frameworks, and dependencies
- Analyzes git commits for project evolution
- Maps out data flows, APIs, and integrations

**Interactive Phase**:
- "What problem does this solve?"
- "What were your key technical decisions and why?"
- "What challenges did you encounter?"
- "What's the most important thing to understand about this work?"
- "How does this fit into the bigger picture?"

**Documentation Generation**:
- **Project Overview**: Clear explanation of what you built and why
- **Technical Architecture**: How it works, key components, design decisions
- **Implementation Details**: Important code patterns, algorithms, data structures
- **Research Findings**: For notebooks - methodology, experiments, results
- **Setup & Usage**: How to run, configure, and use your work
- **Key Insights**: What you learned, what works well, what doesn't

## Output

Creates a complete documentation suite that explains:
- **What** you've been working on (the problem and solution)
- **How** it works technically (architecture, implementation, algorithms)
- **Why** you made specific decisions (trade-offs, constraints, reasoning)
- **What** someone needs to know to understand or extend your work

## Options

- **--deep**: Uses zen MCP for comprehensive analysis and deeper technical insights

**Goal**: Anyone with technical background reading your documentation should understand your work, your approach, and be able to meaningfully engage with or build upon it.