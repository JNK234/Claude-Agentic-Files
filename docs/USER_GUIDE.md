# Claude Agnetic System v3.0 - Complete User Guide

> *"A hero can be anyone, even someone doing something as simple as writing clean, maintainable code."*

This comprehensive guide will help you master the Claude Agnetic System and become a development superhero.

## Table of Contents

1. [Getting Started](#getting-started)
2. [Core Concepts](#core-concepts)
3. [Command Reference](#command-reference)
4. [Persona System](#persona-system)
5. [MCP Integration](#mcp-integration)
6. [Wave Orchestration](#wave-orchestration)
7. [Advanced Features](#advanced-features)
8. [Best Practices](#best-practices)
9. [Troubleshooting](#troubleshooting)

## Getting Started

### Installation

The Claude Agnetic System installs with a single command:

```bash
git clone https://github.com/your-username/claude-agnetic-system.git
cd claude-agnetic-system
./install.sh
```

### First Steps

After installation, reload your shell and test the system:

```bash
source ~/.zshrc  # or ~/.bashrc
claude /sync
```

You should see a Batman-themed welcome message confirming the system is active.

### Basic Usage

The system enhances Claude Code with intelligent personas and MCP integration while maintaining familiar commands:

```bash
# Enhanced thinking with Sequential MCP
claude /think "Design authentication system"

# Intelligent implementation with persona auto-selection
claude /implement "Create user dashboard"

# Comprehensive review with security persona
claude /review security --fix
```

## Core Concepts

### The Batman Theme

The Claude Agnetic System adds a professional Batman theme to your development experience:

- **Master Wayne Persona**: Your default professional persona
- **Batcave Progress**: Batman-themed progress indicators
- **Alfred Notifications**: Voice notifications in Alfred's style
- **Wayne Tech Standards**: Enterprise-level code quality

### Intelligence Layer

The system adds an intelligence layer that:
- Analyzes your project context
- Selects appropriate personas automatically
- Activates relevant MCP servers
- Orchestrates complex tasks through waves

### Quality Focus

Every feature is designed with quality in mind:
- Wayne Enterprise coding standards
- Comprehensive testing requirements
- Security-first approach
- Performance optimization

## Command Reference

### Enhanced Core Commands

#### `/think` - Advanced Reasoning System

The `/think` command now includes Sequential MCP integration and intelligent persona selection:

```bash
# Standard deep thinking
claude /think "How to optimize database queries"

# Extended analysis with personas
claude /think "Design microservices architecture" --harder --personas architect,performance

# Maximum depth with wave orchestration
claude /think "Complex distributed system design" --ultra

# Specification-guided thinking
claude /think "Implement OAuth 2.0 flow" --spec tasks/oauth-spec.md
```

**Key Features:**
- Sequential MCP for step-by-step reasoning
- Automatic persona activation based on domain
- Context caching for similar problems
- Wave orchestration for ultra-complex problems

#### `/ship` - Complete Development Cycle

Enhanced shipping process with persona coordination:

```bash
# Standard feature shipping
claude /ship "Add user notifications"

# Parallel execution for large features
claude /ship "E-commerce checkout flow" --parallel

# Specification validation
claude /ship "Payment processing" --spec tasks/payment-spec.md --validate-spec

# Override persona selection
claude /ship "Security audit" --personas security,analyst
```

**New Features:**
- Persona-based task assignment
- MCP integration for documentation and analysis
- Parallel execution capabilities
- Specification validation

#### `/review` - Comprehensive Code Review

Multi-dimensional code review with specialized personas:

```bash
# Security-focused review
claude /review security --fix --personas security,analyzer

# Performance optimization review
claude /review performance --create-issues

# Complete analysis with all personas
claude /review all --parallel --severity high

# Specification compliance review
claude /review spec --spec tasks/requirements.md
```

**Enhanced Capabilities:**
- Specialized persona activation
- MCP-powered analysis
- Parallel review processing
- Automated fix generation

### New Power Commands

#### `/implement` - Intelligent Implementation

The most powerful new command for feature implementation:

```bash
# Auto-detected implementation
claude /implement "Create responsive navigation component"

# Specify complexity level
claude /implement "Real-time chat system" --complexity high

# UI-focused implementation
claude /implement "User dashboard with analytics" --ui-only --design-system material

# API-focused implementation
claude /implement "GraphQL API for user management" --api-only --security

# Full-stack implementation
claude /implement "E-commerce product catalog" --personas frontend,backend,qa
```

**Features:**
- Automatic complexity analysis
- Intelligent persona selection
- MCP server coordination
- Quality gate enforcement

#### `/architect` - System Design

Professional system architecture with architect persona:

```bash
# Basic architecture design
claude /architect "Scalable web application"

# Specific patterns and scale
claude /architect "Microservices platform" --patterns microservices --scale enterprise

# Performance-focused architecture
claude /architect "High-throughput API system" --performance --constraints resources.md

# Cloud-native design
claude /architect "Serverless data processing" --cloud --patterns serverless
```

**Outputs:**
- Comprehensive architecture documents
- Component diagrams
- API specifications
- Deployment guides

#### `/ui` - Component Generation

Advanced UI component creation with Magic MCP:

```bash
# React component with accessibility
claude /ui "Contact form with validation" --framework react --a11y

# Vue component with design system
claude /ui "Product card component" --framework vue --design-system tailwind

# Responsive dashboard layout
claude /ui "Analytics dashboard" --responsive --dark-mode --testing

# Component library integration
claude /ui "Button component variants" --storybook --typescript
```

**Features:**
- Multi-framework support
- Design system integration
- Accessibility compliance
- Responsive design

#### `/debug` - Advanced Debugging

Systematic debugging with analyzer persona:

```bash
# Performance debugging
claude /debug "API response times increased 300%" --performance --systematic

# Integration debugging
claude /debug "Third-party service failing intermittently" --integration --logs /var/log/api.log

# Environment-specific debugging
claude /debug "Works locally but fails in production" --environment

# Security debugging
claude /debug "Potential security vulnerability in auth flow" --security
```

**Methodology:**
- Systematic investigation approach
- Root cause analysis
- Solution development
- Prevention strategy

#### `/test-e2e` - End-to-End Testing

Comprehensive E2E testing with Playwright MCP:

```bash
# Multi-browser testing
claude /test-e2e "User registration flow" --browsers all --record

# Mobile responsive testing
claude /test-e2e "Shopping cart functionality" --browsers webkit --headless

# Performance testing
claude /test-e2e "Page load performance" --parallel --performance

# Accessibility testing
claude /test-e2e "Form accessibility" --a11y --screenshots
```

**Capabilities:**
- Cross-browser testing
- Visual regression testing
- Performance monitoring
- Accessibility validation

## Persona System

### Available Personas

#### Master Wayne (Default)
- **Role**: Professional Batman-themed leadership persona
- **Expertise**: Strategic planning, system architecture, team coordination
- **Activation**: Default persona, always active
- **Style**: Professional, authoritative, protective

#### Technical Personas

**Architect**
- **Role**: System design and architecture specialist
- **Expertise**: Architecture patterns, scalability, system design
- **Activation**: /architect command, complex system design
- **Style**: Methodical, comprehensive, strategic

**Frontend**
- **Role**: Frontend development and UI/UX expert
- **Expertise**: React, Vue, Angular, CSS, responsive design
- **Activation**: UI-related tasks, component development
- **Style**: User-centric, design-focused, modern

**Backend**
- **Role**: Backend systems and API development
- **Expertise**: APIs, databases, server architecture, microservices
- **Activation**: API development, server-side tasks
- **Style**: Scalable, secure, performance-focused

**Security**
- **Role**: Security analysis and vulnerability assessment
- **Expertise**: OWASP, penetration testing, secure coding
- **Activation**: Security reviews, vulnerability analysis
- **Style**: Thorough, risk-aware, compliance-focused

**Performance**
- **Role**: Performance optimization and monitoring
- **Expertise**: Profiling, optimization, monitoring, benchmarking
- **Activation**: Performance issues, optimization tasks
- **Style**: Data-driven, metric-focused, systematic

#### Process Personas

**QA**
- **Role**: Quality assurance and testing specialist
- **Expertise**: Testing strategies, automation, quality metrics
- **Activation**: Testing tasks, quality reviews
- **Style**: Thorough, systematic, quality-focused

**DevOps**
- **Role**: DevOps, CI/CD, and infrastructure expert
- **Expertise**: Docker, Kubernetes, CI/CD, infrastructure
- **Activation**: Deployment, infrastructure tasks
- **Style**: Automated, scalable, reliable

**Analyzer**
- **Role**: Code analysis and problem-solving specialist
- **Expertise**: Debugging, code analysis, investigation
- **Activation**: Analysis tasks, debugging, troubleshooting
- **Style**: Systematic, investigative, logical

**Refactorer**
- **Role**: Code refactoring and optimization expert
- **Expertise**: Code improvement, patterns, maintainability
- **Activation**: Refactoring tasks, code cleanup
- **Style**: Incremental, pattern-focused, maintainable

#### Knowledge Personas

**Mentor**
- **Role**: Technical mentorship and knowledge sharing
- **Expertise**: Teaching, best practices, guidance
- **Activation**: Learning tasks, explanations
- **Style**: Educational, supportive, comprehensive

**Scribe**
- **Role**: Documentation and technical writing expert
- **Expertise**: Documentation, technical writing, guides
- **Activation**: Documentation tasks, writing
- **Style**: Clear, comprehensive, structured

### Persona Management

#### Automatic Activation

The system automatically selects personas based on:
- Command type
- Project context
- Task complexity
- Domain keywords

```bash
# These automatically activate appropriate personas:
claude /ui "Button component" # → frontend, qa
claude /architect "API design" # → architect, backend
claude /debug "Performance issue" # → analyzer, performance
```

#### Manual Activation

```bash
# Activate specific personas
claude /personas activate frontend backend

# Force single persona
claude /personas force security

# List available personas
claude /personas list

# Check current persona status
claude /personas status
```

#### Environment Variables

```bash
# Set default personas
export CLAUDE_PERSONAS="frontend,qa"

# Force specific persona for session
CLAUDE_PERSONAS="security" claude /review all
```

## MCP Integration

### Available MCP Servers

#### Context7 - Documentation and Best Practices
- **Purpose**: Access to official documentation and community guides
- **Activation**: Documentation needs, implementation questions
- **Capabilities**: Documentation lookup, code examples, best practices

#### Sequential - Deep Analysis and Reasoning
- **Purpose**: Step-by-step reasoning and complex problem solving
- **Activation**: Complex analysis, debugging, architectural decisions
- **Capabilities**: Deep analysis, systematic reasoning, problem decomposition

#### Magic - UI Component Generation
- **Purpose**: Intelligent UI component creation and design
- **Activation**: UI development, component creation, design tasks
- **Capabilities**: Component generation, responsive design, accessibility

#### Playwright - E2E Testing and Automation
- **Purpose**: Browser automation and end-to-end testing
- **Activation**: Testing tasks, browser automation, E2E scenarios
- **Capabilities**: Cross-browser testing, automation, performance testing

### MCP Server Management

```bash
# Check MCP server status
claude /mcp status

# Start/stop servers
claude /mcp start sequential
claude /mcp stop magic

# Restart all servers
claude /mcp restart

# Health check
claude /mcp health
```

### Manual MCP Selection

```bash
# Specify MCP servers for command
claude /think "API design patterns" --mcp sequential,context7

# Use specific MCP for implementation
claude /implement "UI component" --mcp magic,context7

# Disable MCP for command
claude /review code --no-mcp
```

## Wave Orchestration

### Wave Execution Modes

#### Sequential Mode
- **Purpose**: Step-by-step execution with dependencies
- **Use Case**: Complex features requiring specific order
- **Example**: Database migration → API updates → UI changes

#### Parallel Mode
- **Purpose**: Concurrent execution of independent tasks
- **Use Case**: Large features with independent components
- **Example**: Frontend + Backend + Tests in parallel

#### Adaptive Mode (Default)
- **Purpose**: Dynamic execution based on task analysis
- **Use Case**: Mixed complexity with automatic optimization
- **Example**: Automatically determines parallel vs sequential

#### Systematic Mode
- **Purpose**: Thorough validation at each step
- **Use Case**: Critical features requiring comprehensive verification
- **Example**: Security-critical implementations

### Wave Configuration

```bash
# Manual wave execution
claude /implement "E-commerce platform" --wave systematic

# Specify wave stages
claude /ship "User system" --stages "analyze,design,implement,test,validate"

# Parallel wave execution
claude /architect "Microservices platform" --wave parallel --max-parallel 3
```

### Wave Monitoring

```bash
# Check wave status
claude /wave status

# View wave logs
claude /wave logs session-123456

# Wave performance metrics
claude /wave metrics
```

## Advanced Features

### Project Context Analysis

The system automatically analyzes your project:

```bash
# View project analysis
claude /context analyze

# Cache project context
claude /context cache

# Update project context
claude /context refresh
```

### Parallel Development

```bash
# Create parallel worktrees
claude /parallel --feature "authentication" --branches "auth-frontend,auth-backend"

# Parallel command execution
claude /parallel --commands "/implement frontend,/implement backend"
```

### Caching System

```bash
# View cache statistics
claude /cache stats

# Clear specific cache
claude /cache clear mcp

# Warm cache for project
claude /cache warm

# Cache cleanup
claude /cache cleanup --days 7
```

### Performance Monitoring

```bash
# View performance metrics
claude /metrics

# Profile command execution
claude /profile /implement "feature"

# System resource usage
claude /resources
```

## Best Practices

### Command Usage

1. **Start with /sync** to understand your project
2. **Use /think** for complex problems before implementation
3. **Let personas auto-activate** unless you have specific needs
4. **Leverage MCP servers** for enhanced capabilities
5. **Use wave orchestration** for complex features

### Persona Selection

1. **Trust auto-activation** for most tasks
2. **Combine personas** for complex requirements
3. **Use Master Wayne** for strategic decisions
4. **Specialist personas** for domain-specific work

### Performance Optimization

1. **Cache frequently used contexts**
2. **Use parallel execution** for independent tasks
3. **Monitor MCP server health** regularly
4. **Clean up cache** periodically

### Quality Assurance

1. **Always include testing** in implementations
2. **Use security persona** for security-critical code
3. **Validate specifications** before and after implementation
4. **Follow Wayne Enterprise standards**

## Troubleshooting

### Common Issues

#### Persona Not Activating
```bash
# Check persona status
claude /personas status

# Force persona activation
claude /personas force architect

# Reset persona system
claude /personas reset
```

#### MCP Server Issues
```bash
# Check server health
claude /mcp health

# Restart specific server
claude /mcp restart sequential

# Check server logs
tail -f ~/.claude/mcp/logs/sequential.log
```

#### Performance Issues
```bash
# Clear cache
claude /cache clear

# Check system resources
claude /resources

# Profile slow command
claude /profile /implement "feature"
```

#### Wave Execution Problems
```bash
# Check wave status
claude /wave status

# View wave logs
claude /wave logs --session latest

# Restart wave system
claude /wave restart
```

### Debug Mode

```bash
# Enable debug mode
export CLAUDE_DEBUG=true

# Verbose logging
export CLAUDE_LOG_LEVEL=debug

# Debug specific component
export CLAUDE_DEBUG_COMPONENT=personas
```

### Log Locations

```bash
# Main system logs
~/.claude/logs/system.log

# MCP server logs
~/.claude/mcp/logs/

# Persona activation logs
~/.claude/personas/logs/

# Wave execution logs
~/.claude/orchestrator/logs/
```

### Getting Help

```bash
# Built-in help
claude /help

# Command-specific help
claude /help implement

# Batman-themed help
batman /help

# Alfred assistance
alfred
```

---

*"The night is darkest just before the dawn. Master the Claude Agnetic System and bring dawn to your development challenges."*

**Ready to protect Gotham's codebase? Let's begin.**