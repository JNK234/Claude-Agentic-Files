# Intelligent feature implementation

Advanced feature implementation with automatic persona selection and MCP integration.

Usage: /implement [feature_description] [--complexity <level>] [--personas <list>] [--mcp <servers>]

## Wayne Tech Implementation Protocol

### 1. **Feature Analysis & Classification**
- Analyze feature requirements using Sequential MCP
- Detect implementation complexity (low|medium|high|ultra)
- Classify feature type (ui|api|full-stack|infrastructure)
- Determine required personas and MCP servers
- Generate Wayne Tech project classification

### 2. **Intelligent Persona Activation**
- **UI Features**: Frontend + QA personas, Magic MCP
- **API Features**: Backend + Security personas, Sequential MCP
- **Full-Stack Features**: Architect + Frontend + Backend personas, all MCPs
- **Infrastructure**: DevOps + Security personas, Sequential + Context7 MCPs
- **Complex Features**: Multi-persona coordination with Wave orchestration

### 3. **MCP Server Integration**
- **Context7**: Documentation and best practices lookup
- **Sequential**: Deep analysis and step-by-step reasoning
- **Magic**: UI component generation and design
- **Playwright**: Test automation and E2E coverage

### 4. **Implementation Workflow**
1. **Requirements Analysis** (Analyzer persona)
   - Break down feature into actionable tasks
   - Identify dependencies and constraints
   - Create acceptance criteria

2. **Architecture Design** (Architect persona)
   - Design system architecture if needed
   - Define component interfaces
   - Plan data flow and state management

3. **Core Implementation** (Appropriate dev personas)
   - Implement core functionality
   - Follow Wayne Tech coding standards
   - Apply security best practices

4. **Test Development** (QA persona)
   - Create comprehensive test suite
   - Unit tests for all components
   - Integration tests for workflows
   - E2E tests with Playwright MCP

5. **Feature Integration** (DevOps persona)
   - Integrate with existing systems
   - Update configuration and deployment
   - Verify compatibility

6. **Documentation & Polish** (Scribe persona)
   - Create user documentation
   - Update technical documentation
   - Code comments and examples

### 5. **Quality Assurance Protocol**
- Automated testing with full coverage
- Security validation and vulnerability scanning
- Performance benchmarking
- Code quality metrics and standards compliance
- Wayne Tech approval process

### 6. **Progress Tracking & Reporting**
- Real-time progress indicators with Batman themes
- Comprehensive implementation log
- Persona performance metrics
- MCP server utilization statistics
- Mission completion status

## Enhanced Features

### Automatic Context Detection
- Project type recognition (React, Node.js, Python, etc.)
- Existing codebase analysis
- Technology stack identification
- Wayne Tech standards compliance checking

### Intelligent Orchestration
- Complex features use Wave orchestration
- Parallel execution for independent components
- Dependency-aware task scheduling
- Resource optimization

### Advanced MCP Integration
- Cached responses for similar implementations
- Multi-server coordination for complex features
- Fallback mechanisms for server failures
- Performance optimization

## Command Options

- **--complexity**: Override complexity analysis (low|medium|high|ultra)
- **--personas**: Manually specify personas to activate
- **--mcp**: Specify MCP servers to use
- **--parallel**: Enable parallel execution for sub-components
- **--test-first**: Force TDD workflow
- **--security**: Enhanced security validation mode
- **--performance**: Performance-focused implementation
- **--ui-only**: Focus on UI components only
- **--api-only**: Focus on API implementation only
- **--no-tests**: Skip test generation (requires explicit authorization)

## Implementation Examples

### Simple UI Component
```bash
claude /implement "Create a responsive navigation component"
# Auto-activates: Frontend + QA personas, Magic MCP
```

### API Endpoint
```bash
claude /implement "Add user authentication endpoint with JWT"
# Auto-activates: Backend + Security personas, Sequential MCP
```

### Full-Stack Feature
```bash
claude /implement "Build complete user dashboard with analytics"
# Auto-activates: Architect + Frontend + Backend + QA personas, all MCPs
```

### Complex System
```bash
claude /implement "Design microservices architecture for payment processing" --complexity ultra
# Auto-activates: Wave orchestration with multiple personas and MCPs
```

## Master Wayne's Implementation Standards

*"A hero can be anyone, even someone doing something as simple as writing clean, maintainable code."*

### Success Criteria
- All code follows Wayne Tech standards
- Comprehensive test coverage (>90%)
- Security validation passed
- Performance benchmarks met
- Documentation complete
- Accessibility compliance (WCAG-AA)

### Quality Gates
1. **Security Gate**: No vulnerabilities detected
2. **Performance Gate**: Response times within limits
3. **Quality Gate**: Code quality metrics passed
4. **Test Gate**: All tests passing with adequate coverage
5. **Documentation Gate**: All features documented

**Output**: Complete feature implementation with tests, documentation, and Wayne Tech approval rating (saved to project directory with logs in ./logs/implement-{timestamp}.md).

**Note**: The system automatically selects the optimal combination of personas and MCP servers based on feature analysis, ensuring efficient and high-quality implementation while maintaining Wayne Enterprise standards.