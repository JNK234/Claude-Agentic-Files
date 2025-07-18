# Comprehensive code review with fixes

Usage: /review [focus] [--fix] [--create-issues] [--spec <spec-file>]

Focus areas:
- security: OWASP top 10, credential leaks, injection vulnerabilities (Security persona)
- performance: Bottlenecks, N+1 queries, memory leaks, optimization opportunities (Performance persona)
- quality: Code patterns, maintainability, DRY violations, complexity (Analyzer persona)
- tests: Coverage gaps, edge cases, test quality, assertions (QA persona)
- spec: Validate implementation against specification requirements (Architect persona)
- all: Complete analysis across all dimensions (Multi-persona coordination)

Process:

1. Scan codebase based on selected focus:
   - Use appropriate analysis patterns
   - Activate appropriate personas for specialized analysis
   - Use MCP servers for enhanced analysis (Sequential for deep reasoning)
   - Check against best practices
   - If --spec provided: Load spec file and validate implementation

2. Security review specifics (Security persona):
   - SQL injection vulnerabilities
   - XSS possibilities
   - Authentication/authorization issues
   - Sensitive data exposure
   - Dependency vulnerabilities

3. Performance review specifics (Performance persona):
   - Database query optimization
   - Caching opportunities
   - Algorithm complexity
   - Resource usage patterns
   - Async/parallel possibilities

4. Quality review specifics (Analyzer persona):
   - Code duplication
   - Complex methods (cyclomatic complexity > 10)
   - Long parameter lists
   - God classes/modules
   - Naming conventions

5. Test review specifics (QA persona):
   - Uncovered code paths
   - Missing edge cases
   - Test readability
   - Assertion quality
   - Mock vs real data usage
   - E2E test coverage with Playwright MCP

6. Spec validation specifics (Architect persona):
   - Verify all requirements are implemented
   - Check acceptance criteria compliance
   - Validate technical specifications
   - Ensure success metrics are measurable
   - Compare implementation against spec roadmap

7. Generate findings report:
   - Severity levels (critical/high/medium/low)
   - Specific file:line references
   - Clear problem description
   - Suggested fixes

8. If --fix flag provided:
   - Attempt automatic fixes for identified issues
   - Create separate commits for each fix type
   - Run tests after each fix
   - Revert if tests fail

9. If --create-issues flag provided:
   - Create GitHub issues for findings
   - Group related issues
   - Apply appropriate labels
   - Set priority based on severity

10. Update CLAUDE.md with patterns to avoid

Options:
- --fix: Attempt automatic fixes for identified issues
- --create-issues: Create GitHub issues for findings
- --spec: Validate implementation against specification requirements
- --personas: Override automatic persona selection for specialized reviews
- --mcp: Specify MCP servers for enhanced analysis capabilities
- --severity: Filter findings by severity level (critical|high|medium|low)
- --parallel: Run parallel analysis for large codebases

Output: Review report to logs/review-{focus}-{timestamp}.md
Note: When using --spec, review will validate implementation compliance with specification requirements using MCP integration and multi-persona coordination.