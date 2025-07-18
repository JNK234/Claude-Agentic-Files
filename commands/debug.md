# Advanced debugging and problem analysis

Systematic debugging approach with root cause analysis and comprehensive investigation.

Usage: /debug [issue_description] [--reproduce] [--logs <path>] [--systematic] [--performance]

## Debugging Methodology

1. **Issue Reproduction**:
   - Create minimal reproduction case
   - Identify consistent reproduction steps
   - Document environmental factors
   - Capture error conditions and triggers

2. **Evidence Collection**:
   - Gather relevant logs and error messages
   - Capture system state and configuration
   - Document stack traces and error contexts
   - Collect performance metrics and timing data

3. **Root Cause Analysis**:
   - Apply systematic debugging techniques
   - Use binary search and divide-and-conquer
   - Implement hypothesis-driven investigation
   - Trace execution flow and data flow

4. **Problem Classification**:
   - Categorize issue type (logic, performance, integration, environment)
   - Assess severity and impact scope
   - Identify affected components and systems
   - Determine urgency and priority level

5. **Solution Development**:
   - Generate multiple solution hypotheses
   - Evaluate solution trade-offs and risks
   - Implement and test potential fixes
   - Verify fix effectiveness and side effects

6. **Prevention Strategy**:
   - Identify contributing factors and patterns
   - Implement monitoring and alerting
   - Create regression tests and safeguards
   - Document lessons learned and best practices

## Debugging Techniques

### Systematic Investigation
- **5 Whys Analysis**: Iterative root cause drilling
- **Fishbone Diagram**: Cause and effect mapping
- **Timeline Analysis**: Chronological event reconstruction
- **Binary Search**: Efficient problem space reduction
- **Rubber Duck Debugging**: Verbal problem explanation

### Code Analysis
- **Static Analysis**: Code review and pattern detection
- **Dynamic Analysis**: Runtime behavior observation
- **Profiling**: Performance and memory analysis
- **Tracing**: Execution path tracking
- **Logging**: Strategic log placement and analysis

### Environment Investigation
- **Configuration Audit**: Settings and environment variables
- **Dependency Analysis**: Version conflicts and compatibility
- **Resource Monitoring**: CPU, memory, disk, network usage
- **Infrastructure Check**: Services, databases, external APIs
- **Security Review**: Permissions and access controls

## Debugging Tools and Techniques

### Browser Debugging
- **DevTools**: Console, Network, Performance, Memory tabs
- **Breakpoints**: Conditional and strategic placement
- **Network Analysis**: Request/response inspection
- **Performance Profiling**: Runtime performance analysis
- **Memory Debugging**: Leak detection and optimization

### Server-Side Debugging
- **Log Analysis**: Structured logging and aggregation
- **APM Tools**: Application performance monitoring
- **Database Debugging**: Query analysis and optimization
- **API Debugging**: Request tracing and monitoring
- **Container Debugging**: Docker and Kubernetes troubleshooting

### Testing and Validation
- **Unit Test Debugging**: Isolated component testing
- **Integration Testing**: System interaction validation
- **End-to-End Testing**: User workflow verification
- **Load Testing**: Performance under stress
- **Chaos Engineering**: Resilience and failure testing

## Common Issue Categories

### Logic Errors
- **Conditional Logic**: Boolean expressions and control flow
- **Loop Logic**: Iteration and termination conditions
- **Data Transformation**: Input/output processing
- **State Management**: Application state consistency
- **Error Handling**: Exception and error propagation

### Performance Issues
- **Slow Queries**: Database optimization and indexing
- **Memory Leaks**: Resource cleanup and garbage collection
- **CPU Bottlenecks**: Algorithm optimization and profiling
- **Network Latency**: Request optimization and caching
- **Rendering Performance**: UI optimization and virtual DOM

### Integration Problems
- **API Integration**: Service communication and contracts
- **Database Connection**: Connection pooling and timeouts
- **Third-Party Services**: External dependency failures
- **Authentication**: User session and token management
- **Cross-Origin Issues**: CORS and security policies

### Environment Issues
- **Configuration Problems**: Settings and environment variables
- **Dependency Conflicts**: Version incompatibilities
- **Resource Constraints**: Memory, CPU, disk limitations
- **Network Issues**: Connectivity and firewall problems
- **Permission Errors**: File system and service access

## Debugging Process

### Phase 1: Problem Definition
1. **Reproduce the Issue**: Create consistent reproduction steps
2. **Gather Information**: Collect logs, error messages, system state
3. **Define Success Criteria**: Clear problem resolution definition
4. **Assess Impact**: Understand scope and severity

### Phase 2: Investigation
1. **Hypothesis Formation**: Generate potential root causes
2. **Evidence Collection**: Gather supporting or contradicting data
3. **Systematic Testing**: Test hypotheses methodically
4. **Pattern Recognition**: Identify recurring themes or patterns

### Phase 3: Resolution
1. **Solution Development**: Create and test fixes
2. **Impact Assessment**: Evaluate fix effectiveness and side effects
3. **Implementation**: Deploy fix with proper testing
4. **Verification**: Confirm problem resolution

### Phase 4: Prevention
1. **Root Cause Documentation**: Record findings and solutions
2. **Process Improvement**: Update practices and procedures
3. **Monitoring Enhancement**: Implement better detection
4. **Knowledge Sharing**: Document lessons learned

## Options

- **--reproduce**: Focus on creating minimal reproduction case
- **--logs**: Specify log file paths for analysis
- **--systematic**: Use structured debugging methodology
- **--performance**: Focus on performance-related issues
- **--environment**: Investigate environment-specific problems
- **--integration**: Debug integration and API issues
- **--security**: Security-focused debugging approach
- **--timeline**: Create chronological analysis of events

## Debugging Examples

### Application Crash
```bash
claude /debug "Application crashes on user login" --reproduce --logs /var/log/app.log
```

### Performance Issue
```bash
claude /debug "Page load times increased by 300%" --performance --systematic
```

### Integration Problem
```bash
claude /debug "API returns 500 errors intermittently" --integration --logs
```

### Environment Issue
```bash
claude /debug "Feature works locally but fails in production" --environment
```

## Output Artifacts

1. **Debug Report**: Comprehensive analysis and findings
2. **Reproduction Guide**: Step-by-step issue recreation
3. **Root Cause Analysis**: Systematic investigation results
4. **Solution Implementation**: Code fixes and configuration changes
5. **Prevention Strategy**: Monitoring and safeguards
6. **Test Cases**: Regression tests and validation
7. **Documentation**: Lessons learned and best practices

## Success Criteria

- **Issue Resolution**: Problem is completely fixed
- **Root Cause Identified**: Underlying cause is understood
- **Prevention Implemented**: Safeguards prevent recurrence
- **Documentation Complete**: Knowledge is captured and shared
- **Testing Validated**: Fix is thoroughly tested
- **Monitoring Enhanced**: Better detection is in place

Output: Complete debugging package with analysis, solution, and prevention strategy
Note: Debugging follows systematic methodology to ensure thorough investigation and lasting solutions