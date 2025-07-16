# Comprehensive code review with fixes

Usage: /review [focus] [--fix] [--create-issues]

Focus areas:
- security: OWASP top 10, credential leaks, injection vulnerabilities
- performance: Bottlenecks, N+1 queries, memory leaks, optimization opportunities
- quality: Code patterns, maintainability, DRY violations, complexity
- tests: Coverage gaps, edge cases, test quality, assertions
- all: Complete analysis across all dimensions

Process:

1. Scan codebase based on selected focus:
   - Use appropriate analysis patterns
   - Check against best practices
   - Identify anti-patterns

2. Security review specifics:
   - SQL injection vulnerabilities
   - XSS possibilities
   - Authentication/authorization issues
   - Sensitive data exposure
   - Dependency vulnerabilities

3. Performance review specifics:
   - Database query optimization
   - Caching opportunities
   - Algorithm complexity
   - Resource usage patterns
   - Async/parallel possibilities

4. Quality review specifics:
   - Code duplication
   - Complex methods (cyclomatic complexity > 10)
   - Long parameter lists
   - God classes/modules
   - Naming conventions

5. Test review specifics:
   - Uncovered code paths
   - Missing edge cases
   - Test readability
   - Assertion quality
   - Mock vs real data usage

6. Generate findings report:
   - Severity levels (critical/high/medium/low)
   - Specific file:line references
   - Clear problem description
   - Suggested fixes

7. If --fix flag provided:
   - Attempt automatic fixes for issues
   - Create separate commits for each fix type
   - Run tests after each fix
   - Revert if tests fail

8. If --create-issues flag provided:
   - Create GitHub issues for findings
   - Group related issues
   - Apply appropriate labels
   - Set priority based on severity

9. Update CLAUDE.md with patterns to avoid

Output: Review report to logs/review-{focus}-{timestamp}.md