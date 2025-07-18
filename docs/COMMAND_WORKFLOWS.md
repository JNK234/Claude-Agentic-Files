# Claude Agnetic System - Command Workflows & Use Cases

> *"Every hero needs a plan. Here's your tactical guide to mastering the Dark Knight's development arsenal."*

## Table of Contents

1. [Complete Project Lifecycle](#complete-project-lifecycle)
2. [Scenario-Based Workflows](#scenario-based-workflows)
3. [Command Combinations](#command-combinations)
4. [Use Case Examples](#use-case-examples)
5. [Best Practices](#best-practices)

---

## Complete Project Lifecycle

### 🚀 **From Idea to Production: The Master Wayne Method**

Here's the complete workflow you requested - from brainstorming to deployment with PRD, planning, and execution:

#### **Phase 1: Ideation & Research**
```bash
# 1. Initial brainstorming and problem exploration
claude /brainstorm "E-commerce platform for local artisans"

# 2. Deep thinking and analysis
claude /think "Design scalable e-commerce platform with payment processing, inventory management, and multi-vendor support" --ultra --personas architect,analyzer

# 3. Market and technical research
claude /sync  # Understand current codebase if extending existing project
```

#### **Phase 2: Requirements & PRD**
```bash
# 4. Create comprehensive PRD and requirements
claude /architect "Multi-vendor e-commerce platform" --patterns microservices --scale medium --constraints budget.md

# 5. Technical specification and planning
claude /plan "E-commerce platform implementation" --spec tasks/ecommerce-spec.md
```

#### **Phase 3: Implementation Planning**
```bash
# 6. Break down into implementable features
claude /think "Break down e-commerce platform into weekly sprints" --harder --personas architect,devops

# 7. Set up project structure and initial codebase
claude /setup "E-commerce platform" --framework react --backend node --database postgres
```

#### **Phase 4: Feature Implementation**
```bash
# 8. Implement core features systematically
claude /implement "User authentication and registration system" --complexity high --test-first

# 9. Build UI components
claude /ui "Product catalog with search and filters" --framework react --design-system material --a11y --responsive

# 10. Backend API development
claude /implement "Product management API with inventory tracking" --api-only --security --personas backend,security
```

#### **Phase 5: Quality Assurance**
```bash
# 11. Comprehensive testing
claude /test-e2e "Complete user purchase workflow" --browsers all --record

# 12. Security and performance review
claude /review security --fix --personas security,performance
claude /review performance --create-issues

# 13. Code quality and architecture review
claude /review all --parallel --severity high
```

#### **Phase 6: Deployment & Documentation**
```bash
# 14. Ship complete features
claude /ship "User authentication system" --validate-spec --parallel

# 15. Create documentation
claude /implement "API documentation and user guides" --personas scribe,architect

# 16. Final deployment
claude /ship "E-commerce platform v1.0" --parallel --validate-spec
```

---

## Scenario-Based Workflows

### 🆕 **New Project Startup**

When starting fresh:

```bash
# Initial setup and brainstorming
claude /brainstorm "Real-time chat application with video calls"
claude /sync  # Establish project context

# Architecture and planning
claude /architect "Real-time chat with WebRTC video" --patterns event-driven --cloud
claude /think "Technical implementation roadmap for chat app" --ultra

# Project initialization
claude /implement "Project structure and development environment" --complexity medium
claude /setup "Chat application" --framework react --backend node --websockets

# Core feature development
claude /implement "Real-time messaging system" --test-first --personas frontend,backend
claude /ui "Chat interface with message history" --framework react --responsive
claude /implement "Video call integration with WebRTC" --complexity high --security
```

### 🔧 **Working with Legacy/Messy Codebase**

When dealing with existing messy code:

```bash
# Analysis and understanding
claude /sync  # Analyze existing codebase
claude /review all --severity medium  # Comprehensive code review
claude /debug "Performance issues in user dashboard" --systematic --performance

# Gradual improvement strategy
claude /think "Refactoring strategy for legacy e-commerce codebase" --harder --personas architect,refactorer
claude /architect "Migration plan from monolith to microservices" --patterns microservices --constraints legacy-constraints.md

# Systematic refactoring
claude /implement "Extract user service from monolith" --complexity high --security --test-first
claude /review code --fix --personas refactorer,qa  # Auto-fix simple issues
claude /test-e2e "Ensure no regression in user workflows" --browsers all

# Security and performance improvements
claude /review security --fix --create-issues
claude /debug "Database query performance bottlenecks" --performance --systematic
```

### 🐛 **Bug Fixing & Troubleshooting**

When dealing with issues:

```bash
# Investigation and diagnosis
claude /debug "Users can't complete checkout process" --reproduce --systematic
claude /review security --severity critical  # Check for security issues

# Root cause analysis
claude /think "Analyze payment processing failure patterns" --harder --personas analyzer,backend
claude /debug "Intermittent API timeouts during peak hours" --performance --logs /var/log/api.log

# Fix implementation and validation
claude /implement "Fix checkout process race condition" --test-first --security
claude /test-e2e "Verify checkout process under load" --performance --parallel
claude /ship "Critical checkout bug fix" --validate-spec
```

### ⚡ **Feature Enhancement**

Adding new features to existing project:

```bash
# Feature analysis and planning
claude /sync  # Update project context
claude /think "Add recommendation engine to e-commerce platform" --ultra --personas architect,backend

# Implementation with proper integration
claude /implement "Product recommendation system using collaborative filtering" --complexity high --test-first
claude /ui "Recommendation widget for product pages" --framework react --a11y
claude /review integration --personas architect,qa  # Ensure proper integration

# Testing and deployment
claude /test-e2e "Recommendation system end-to-end workflow" --browsers all
claude /ship "Product recommendation feature" --parallel --validate-spec
```

---

## Command Combinations

### 🎯 **Power Combinations for Maximum Efficiency**

#### **Analysis + Planning Combo**
```bash
# Deep project analysis followed by actionable planning
claude /think "Architecture for scalable SaaS platform" --ultra --personas architect,performance
claude /architect "Multi-tenant SaaS platform" --patterns microservices --scale enterprise
claude /plan "SaaS platform implementation roadmap" --spec tasks/saas-spec.md
```

#### **Implementation + Testing Pipeline**
```bash
# Complete feature development with testing
claude /implement "User dashboard with analytics" --test-first --personas frontend,backend
claude /ui "Analytics dashboard components" --framework react --testing --storybook
claude /test-e2e "Dashboard functionality across user types" --browsers all --parallel
claude /review quality --fix --personas qa,performance
```

#### **Security-First Development**
```bash
# Security-focused development workflow
claude /review security --severity all --create-issues
claude /implement "OAuth 2.0 authentication system" --security --test-first --personas security,backend
claude /debug "Potential security vulnerabilities in auth flow" --security --systematic
claude /test-e2e "Security testing for authentication flows" --browsers all
```

#### **Performance Optimization Workflow**
```bash
# Performance analysis and optimization
claude /review performance --create-issues --personas performance,analyzer
claude /debug "Page load performance issues" --performance --systematic
claude /implement "Performance optimizations for product catalog" --performance --test-first
claude /test-e2e "Performance testing under load" --performance --parallel
```

---

## Use Case Examples

### 💼 **Enterprise SaaS Platform**

**Scenario**: Building a multi-tenant project management SaaS

```bash
# Phase 1: Research and Architecture
claude /brainstorm "Multi-tenant project management SaaS with real-time collaboration"
claude /think "Enterprise SaaS architecture with multi-tenancy, real-time features, and scalability" --ultra --personas architect,security,performance
claude /architect "Multi-tenant SaaS platform" --patterns microservices,event-driven --scale enterprise --constraints enterprise-requirements.md

# Phase 2: Core Implementation
claude /implement "Multi-tenant authentication and authorization system" --complexity ultra --security --test-first
claude /ui "Project dashboard with real-time updates" --framework react --design-system enterprise --a11y --responsive
claude /implement "Real-time collaboration engine with WebSockets" --complexity high --performance --test-first

# Phase 3: Quality & Deployment
claude /test-e2e "Multi-tenant isolation and security" --browsers all --security
claude /review all --parallel --severity high --fix
claude /ship "SaaS platform MVP" --parallel --validate-spec
```

### 🛒 **E-commerce Marketplace**

**Scenario**: Multi-vendor e-commerce platform with payments

```bash
# Phase 1: Market Research and Planning
claude /brainstorm "Multi-vendor e-commerce marketplace with integrated payments and shipping"
claude /think "E-commerce platform with vendor management, payment processing, and order fulfillment" --ultra --personas architect,frontend,backend
claude /architect "Multi-vendor e-commerce platform" --patterns microservices --scale large --cloud

# Phase 2: Core Features
claude /implement "Vendor management system with onboarding" --complexity high --test-first --personas backend,frontend
claude /ui "Product catalog with advanced search and filters" --framework react --design-system material --responsive --a11y
claude /implement "Payment processing with Stripe integration" --security --test-first --personas backend,security
claude /implement "Order management and fulfillment system" --complexity high --test-first

# Phase 3: Advanced Features
claude /ui "Vendor dashboard for inventory and sales analytics" --framework react --responsive --testing
claude /implement "Review and rating system with moderation" --test-first --personas backend,qa
claude /test-e2e "Complete purchase workflow from product discovery to delivery" --browsers all --record

# Phase 4: Launch Preparation
claude /review security --fix --create-issues --personas security,backend
claude /review performance --fix --personas performance,backend
claude /ship "E-commerce marketplace v1.0" --parallel --validate-spec
```

### 📱 **Mobile-First Social App**

**Scenario**: Social networking app with content sharing

```bash
# Phase 1: Concept and Design
claude /brainstorm "Mobile-first social app for content creators with monetization"
claude /think "Social app architecture with content sharing, real-time messaging, and creator monetization" --ultra --personas architect,frontend,backend
claude /ui "Mobile-first social feed interface" --framework react --responsive --design-system custom --a11y

# Phase 2: Core Social Features
claude /implement "User profiles and social connections" --test-first --personas frontend,backend
claude /implement "Content sharing with media upload and processing" --complexity high --performance --test-first
claude /implement "Real-time messaging and notifications" --complexity high --test-first --personas backend,frontend

# Phase 3: Advanced Features
claude /implement "Creator monetization system with payments" --security --complexity high --test-first
claude /ui "Creator analytics dashboard" --framework react --responsive --testing
claude /test-e2e "Social interactions and content sharing workflows" --browsers webkit --record

# Phase 4: Performance and Scale
claude /review performance --fix --personas performance,backend
claude /debug "Feed loading performance optimization" --performance --systematic
claude /ship "Social app v1.0" --parallel --validate-spec
```

### 🏥 **Healthcare Management System**

**Scenario**: HIPAA-compliant patient management system

```bash
# Phase 1: Compliance and Security Focus
claude /brainstorm "HIPAA-compliant patient management system with telemedicine"
claude /think "Healthcare system architecture with HIPAA compliance, security, and patient privacy" --ultra --personas architect,security,backend
claude /architect "Healthcare management system" --patterns microservices --security --constraints hipaa-compliance.md

# Phase 2: Secure Implementation
claude /implement "HIPAA-compliant user authentication and audit logging" --security --complexity high --test-first
claude /implement "Patient data management with encryption at rest and in transit" --security --complexity ultra --test-first
claude /ui "Patient portal with accessibility compliance" --framework react --a11y --security --design-system healthcare

# Phase 3: Clinical Features
claude /implement "Appointment scheduling with provider availability" --complexity high --test-first
claude /implement "Telemedicine video consultation platform" --complexity ultra --security --test-first
claude /ui "Provider dashboard for patient management" --framework react --responsive --a11y

# Phase 4: Compliance and Testing
claude /review security --severity critical --fix --personas security,backend
claude /test-e2e "Patient data privacy and access controls" --security --browsers all
claude /review compliance --spec hipaa-requirements.md --personas security,qa
claude /ship "Healthcare management system" --validate-spec --security
```

---

## Best Practices

### 🎯 **Command Sequencing Best Practices**

#### **Always Start With Context**
```bash
# Before any major work, understand your environment
claude /sync
claude /think "Current project state and next priorities" --personas analyzer
```

#### **Security-First for Sensitive Projects**
```bash
# For any project handling sensitive data
claude /review security --severity all
claude /implement "feature" --security --test-first
claude /test-e2e "security workflows" --security
```

#### **Test-Driven Development Flow**
```bash
# Always implement with testing
claude /implement "feature" --test-first --complexity medium
claude /test-e2e "feature workflows" --browsers all
claude /review quality --fix
```

#### **Documentation as You Go**
```bash
# Document while implementing
claude /implement "feature" --test-first
claude /implement "documentation for feature" --personas scribe
```

### 🔄 **Iterative Development Patterns**

#### **Feature Development Cycle**
```bash
# 1. Analysis and planning
claude /think "feature requirements and implementation" --harder

# 2. Implementation
claude /implement "feature" --test-first --complexity auto

# 3. Quality assurance
claude /review quality --fix
claude /test-e2e "feature workflows" --browsers all

# 4. Integration and deployment
claude /ship "feature" --validate-spec
```

#### **Refactoring Cycle**
```bash
# 1. Analysis
claude /review all --severity medium
claude /debug "performance issues" --systematic

# 2. Planning
claude /think "refactoring strategy" --personas refactorer,architect

# 3. Implementation
claude /implement "refactoring changes" --test-first

# 4. Validation
claude /test-e2e "ensure no regression" --browsers all
claude /review quality --fix
```

### 🚀 **Performance Tips**

#### **Parallel Execution When Possible**
```bash
# Use parallel flags for independent tasks
claude /ship "multiple features" --parallel
claude /review all --parallel --severity medium
claude /test-e2e "workflows" --parallel --browsers all
```

#### **Persona Optimization**
```bash
# Let personas auto-activate for best results
claude /implement "ui feature"  # Auto-activates frontend, qa
claude /debug "security issue"  # Auto-activates security, analyzer

# Override only when needed
claude /implement "feature" --personas specific,combination
```

#### **Context Caching**
```bash
# Warm cache for better performance
claude /cache warm

# Use context from similar projects
claude /sync  # Analyzes and caches project context
```

---

## Git Worktrees & Parallel Development

### 🌳 **When to Use Git Worktrees**

Git worktrees allow you to work on multiple features simultaneously without branch switching overhead. Here's when and how to use them effectively:

#### **Optimal Timing in Development Flow**

**🎯 Best Times to Create Worktrees:**
1. **After Architecture Phase**: When you've planned multiple independent features
2. **During Feature Breakdown**: When a large feature can be split into parallel components
3. **For Hotfixes**: When you need to fix bugs while continuing feature development
4. **Code Review Period**: When implementing reviewer feedback while starting new features

**❌ Avoid Worktrees When:**
- Features have tight dependencies
- Working on single linear feature
- Team is small (1-2 developers)
- Debugging complex integration issues

### 🚀 **Parallel Workflow Patterns**

#### **Pattern 1: Feature Component Parallelization**
```bash
# After planning a large feature, split into parallel components
claude /think "Break down user dashboard into independent components" --harder --personas architect

# Create worktrees for parallel development
claude /parallel --feature "user-dashboard" --branches "dashboard-frontend,dashboard-api,dashboard-tests"

# In each worktree, implement specific components
# Worktree 1: dashboard-frontend
claude /ui "User dashboard layout and components" --framework react --responsive

# Worktree 2: dashboard-api  
claude /implement "Dashboard API endpoints" --api-only --test-first

# Worktree 3: dashboard-tests
claude /test-e2e "Dashboard functionality end-to-end" --browsers all
```

#### **Pattern 2: Full-Stack Feature Parallelization**
```bash
# For complex features requiring frontend, backend, and infrastructure
claude /architect "Real-time chat system" --patterns event-driven

# Setup parallel worktrees
claude /parallel --feature "chat-system" --branches "chat-frontend,chat-backend,chat-infrastructure"

# Execute in parallel across worktrees
claude /parallel --commands "/ui 'chat interface',/implement 'chat API',/implement 'WebSocket infrastructure'"
```

#### **Pattern 3: Hotfix + Feature Development**
```bash
# When production issues arise during feature development
claude /parallel --hotfix "critical-bug-fix" --continue-feature "new-payments"

# Worktree 1: Hotfix (from main/production branch)
claude /debug "Payment processing failure" --systematic --reproduce
claude /implement "Payment gateway timeout fix" --test-first --security

# Worktree 2: Continue feature development
claude /implement "Enhanced payment options UI" --framework react
```

### 🔧 **Worktree Management Commands**

#### **Creating Worktrees**
```bash
# Simple feature split
claude /parallel --feature "authentication" --branches "auth-frontend,auth-backend"

# Complex multi-component feature
claude /parallel --feature "e-commerce-checkout" --branches "checkout-ui,payment-api,inventory-service,notification-service"

# Hotfix while continuing development
claude /parallel --hotfix "security-patch" --main-branch "feature/new-dashboard"

# Experimental parallel development
claude /parallel --experimental "performance-optimization" --base-branch "develop"
```

#### **Worktree Synchronization**
```bash
# Sync all worktrees with latest changes
claude /parallel --sync-all

# Merge completed features
claude /parallel --merge "auth-frontend,auth-backend" --target "feature/authentication"

# Cross-worktree dependency management
claude /parallel --update-dependencies --source "auth-backend" --targets "auth-frontend,auth-tests"
```

### 📋 **Parallel Development Workflows**

#### **Large Feature Development**
```bash
# Phase 1: Planning and Architecture
claude /think "E-commerce platform with multiple independent services" --ultra --personas architect
claude /architect "Microservices e-commerce platform" --patterns microservices --scale large

# Phase 2: Feature Breakdown and Worktree Setup
claude /think "Break down e-commerce platform into parallel development streams" --harder
claude /parallel --feature "e-commerce-platform" --branches "user-service,product-service,order-service,payment-service,frontend-app"

# Phase 3: Parallel Implementation
# Worktree 1: User Service
claude /implement "User authentication and profile management" --api-only --security --test-first

# Worktree 2: Product Service  
claude /implement "Product catalog with search and inventory" --api-only --performance --test-first

# Worktree 3: Order Service
claude /implement "Order processing and fulfillment" --api-only --test-first

# Worktree 4: Payment Service
claude /implement "Payment processing with multiple gateways" --security --complexity high --test-first

# Worktree 5: Frontend App
claude /ui "E-commerce storefront application" --framework react --design-system material --responsive

# Phase 4: Integration and Testing
claude /parallel --integrate-all --target "feature/e-commerce-platform"
claude /test-e2e "Complete e-commerce user journey" --browsers all --parallel
```

#### **Team-Based Parallel Development**
```bash
# Setup for team with specialized roles
claude /parallel --team-setup "webapp-redesign" --roles "frontend-dev,backend-dev,qa-engineer,devops"

# Frontend Developer Worktree
claude /ui "Modern responsive dashboard redesign" --framework react --design-system custom --a11y

# Backend Developer Worktree
claude /implement "API optimization and new endpoints" --performance --security --test-first

# QA Engineer Worktree
claude /test-e2e "Comprehensive testing suite for redesign" --browsers all --parallel --record

# DevOps Worktree
claude /implement "CI/CD pipeline and deployment automation" --personas devops --complexity medium
```

### ⚡ **Advanced Parallel Patterns**

#### **Microservices Development**
```bash
# When building microservices architecture
claude /architect "Microservices platform" --patterns microservices --scale enterprise

# Create service-specific worktrees
claude /parallel --microservices "platform" --services "auth-service,user-service,notification-service,gateway-service"

# Develop services in parallel
claude /parallel --commands "/implement 'auth microservice',/implement 'user microservice',/implement 'notification microservice',/implement 'API gateway'"

# Service integration testing
claude /test-e2e "Microservices integration and communication" --parallel --performance
```

#### **A/B Testing Development**
```bash
# For developing multiple feature variants
claude /parallel --ab-testing "checkout-optimization" --variants "variant-a,variant-b,control"

# Variant A: Simplified checkout
claude /ui "Single-page checkout flow" --framework react --conversion-optimized

# Variant B: Multi-step checkout
claude /ui "Guided multi-step checkout process" --framework react --user-friendly

# Control: Current implementation improvements
claude /implement "Current checkout performance optimization" --performance
```

### 🎯 **Timing and Decision Matrix**

#### **When to Use Parallel Development**

| Scenario | Use Parallel | Command Pattern | Timing |
|----------|-------------|-----------------|---------|
| **Large Feature (5+ components)** | ✅ Yes | `/parallel --feature "name" --branches "comp1,comp2,comp3"` | After architecture design |
| **Microservices Development** | ✅ Yes | `/parallel --microservices "platform" --services "svc1,svc2"` | During service design phase |
| **Team with 3+ Developers** | ✅ Yes | `/parallel --team-setup "project" --roles "frontend,backend,qa"` | At project kickoff |
| **Hotfix + Feature Work** | ✅ Yes | `/parallel --hotfix "fix" --continue-feature "feature"` | When production issues arise |
| **A/B Testing Variants** | ✅ Yes | `/parallel --ab-testing "feature" --variants "a,b,control"` | During experimentation phase |
| **Dependent Features** | ❌ No | Use sequential `/implement` commands | When features have dependencies |
| **Single Developer, Small Feature** | ❌ No | Use regular `/implement` workflow | For simple, linear development |
| **Debugging Complex Issues** | ❌ No | Use `/debug` with focus | When investigating intricate problems |

#### **Optimal Worktree Creation Points**

```bash
# 1. After Architecture and Planning
claude /architect "system design" --patterns microservices
claude /think "implementation strategy with parallel components" --harder
claude /parallel --feature "system" --branches "component1,component2,component3"

# 2. During Sprint Planning
claude /think "Sprint backlog breakdown for parallel development" --personas qa,devops
claude /parallel --sprint "sprint-5" --features "auth-feature,dashboard-feature,api-feature"

# 3. When Scaling Team
claude /parallel --team-expansion "project" --new-members "frontend-specialist,performance-engineer"

# 4. For Release Preparation
claude /parallel --release-prep "v2.0" --tracks "features,bugfixes,docs,testing"
```

### 🔄 **Parallel Workflow Integration**

#### **Merging Parallel Work**
```bash
# Systematic merge process
claude /parallel --merge-strategy "feature-branch" --branches "auth-frontend,auth-backend"
claude /review integration --personas architect,qa
claude /test-e2e "Integrated feature testing" --browsers all
claude /ship "Complete authentication system" --validate-spec
```

#### **Conflict Resolution**
```bash
# When parallel branches have conflicts
claude /parallel --resolve-conflicts --branches "frontend-branch,backend-branch"
claude /debug "Integration conflicts between frontend and backend" --systematic
claude /implement "Conflict resolution and integration fixes" --test-first
```

#### **Cross-Worktree Communication**
```bash
# Managing dependencies between parallel work
claude /parallel --dependency-check --source "api-changes" --targets "frontend,mobile"
claude /parallel --sync-interfaces --api-branch "backend-api" --consumer-branches "frontend,mobile-app"
```

### 📊 **Performance Benefits**

#### **Development Speed Improvements**
- **3-5x faster** for independent components
- **2-3x faster** for team-based development
- **Reduced context switching** between features
- **Parallel code review** and testing cycles

#### **Quality Improvements**
- **Specialized focus** per worktree
- **Reduced merge conflicts** through early detection
- **Independent testing** of components
- **Better code review** with focused changes

---

## Quick Reference Commands

### 🎯 **Essential Command Patterns**

| Scenario | Command Pattern | Example |
|----------|----------------|---------|
| **New Feature** | `/implement "feature" --test-first` | `claude /implement "user authentication" --test-first --security` |
| **Bug Investigation** | `/debug "issue" --systematic` | `claude /debug "login failures" --systematic --security` |
| **Code Review** | `/review focus --fix` | `claude /review security --fix --create-issues` |
| **Architecture Design** | `/architect "system" --patterns type` | `claude /architect "microservices API" --patterns microservices` |
| **UI Development** | `/ui "component" --framework name` | `claude /ui "dashboard" --framework react --responsive` |
| **Testing** | `/test-e2e "workflow" --browsers all` | `claude /test-e2e "checkout process" --browsers all --record` |
| **Deployment** | `/ship "feature" --validate-spec` | `claude /ship "payment system" --parallel --validate-spec` |

### 🎭 **Persona Combinations**

| Task Type | Recommended Personas | Command Example |
|-----------|---------------------|-----------------|
| **Full-Stack Feature** | `frontend,backend,qa` | `claude /implement "user dashboard" --personas frontend,backend,qa` |
| **Security Review** | `security,analyzer` | `claude /review all --personas security,analyzer` |
| **Performance Optimization** | `performance,backend` | `claude /debug "slow queries" --personas performance,backend` |
| **Architecture Design** | `architect,security` | `claude /architect "payment system" --personas architect,security` |
| **Code Refactoring** | `refactorer,qa` | `claude /implement "code cleanup" --personas refactorer,qa` |

---

*"With great power comes great responsibility. Use these workflows wisely, Master Wayne."*

**🦇 Ready to protect Gotham's codebase with systematic excellence!**