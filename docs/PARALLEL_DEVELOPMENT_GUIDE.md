# Multi-Feature Parallel Development Guide

## 🎯 Complete Workflow Documentation

This guide covers the end-to-end process for developing multiple complex features in parallel using Claude Code with git worktrees.

---

## 📋 Table of Contents

1. [Workflow Options](#workflow-options)
2. [Example Scenarios](#example-scenarios)
3. [Planning Phase](#planning-phase)
4. [Execution Phase](#execution-phase)
5. [PR Management](#pr-management)
6. [File Reference](#file-reference)
7. [Best Practices](#best-practices)

---

## 🔄 Workflow Options

### **Option A: Full Planning Pipeline** ⭐ *RECOMMENDED*
```
Brainstorm → Think → Architect → Plan → Execute → Review → Merge
```

### **Option B: Quick Start**
```
Brainstorm → Plan → Execute → Review → Merge
```

### **Option C: Architecture-First**
```
Architect → Brainstorm → Plan → Execute → Review → Merge
```

---

## 🚀 Example Scenarios

### **Scenario 1: E-commerce Platform** 

#### **Feature Set:**
1. **User Authentication & Profiles**
2. **Product Catalog & Search**  
3. **Shopping Cart & Checkout**
4. **Order Management & Tracking**

#### **Planning Commands:**

**Feature 1: User Authentication**
```bash
# 1. Brainstorm
claude /brainstorm "User authentication system with social login, 2FA, and profile management"

# 2. Think (optional - for complex decisions)
claude /think "How to implement secure authentication with multiple providers" --spec ./tasks/spec-user-auth-20240725.md

# 3. Architect
claude /architect "JWT authentication with OAuth providers and 2FA" --patterns microservices --security

# 4. Plan
claude /plan "Complete user authentication system" --from-spec ./tasks/spec-user-auth-20240725.md --prd
```

**Outputs:**
- `./tasks/spec-user-auth-20240725.md` (Requirements)
- `./docs/architecture-auth-20240725.md` (Technical design)
- `./tasks/plan-user-auth-20240725.md` (Implementation cookbook)
- `./tasks/prd-user-auth-20240725.md` (Product requirements)

**Feature 2: Product Catalog**
```bash
claude /brainstorm "Product catalog with advanced search, filtering, and recommendations"
claude /architect "Product search with Elasticsearch and recommendation engine" --patterns microservices --performance
claude /plan "Complete product catalog system" --from-spec ./tasks/spec-product-catalog-20240725.md --prd
```

**Outputs:**
- `./tasks/spec-product-catalog-20240725.md`
- `./docs/architecture-catalog-20240725.md`
- `./tasks/plan-product-catalog-20240725.md`
- `./tasks/prd-product-catalog-20240725.md`

**Feature 3: Shopping Cart**
```bash
claude /brainstorm "Shopping cart with persistent storage, pricing calculations, and checkout flow"
claude /architect "Cart service with Redis persistence and payment integration" --patterns event-driven
claude /plan "Complete shopping cart system" --from-spec ./tasks/spec-shopping-cart-20240725.md --prd
```

**Feature 4: Order Management**
```bash
claude /brainstorm "Order management with status tracking, notifications, and fulfillment"
claude /architect "Order processing system with event sourcing" --patterns event-driven --scale large
claude /plan "Complete order management system" --from-spec ./tasks/spec-order-mgmt-20240725.md --prd
```

#### **Parallel Execution:**

```bash
# Launch 4 worktrees
claude-worktree user-auth      # Terminal 1
claude-worktree product-catalog # Terminal 2  
claude-worktree shopping-cart   # Terminal 3
claude-worktree order-mgmt      # Terminal 4

# Execute in each terminal
# Terminal 1:
cd ../ecommerce-worktrees/user-auth
claude /ship user-auth --spec ./tasks/plan-user-auth-20240725.md

# Terminal 2:
cd ../ecommerce-worktrees/product-catalog
claude /ship product-catalog --spec ./tasks/plan-product-catalog-20240725.md

# Terminal 3:
cd ../ecommerce-worktrees/shopping-cart
claude /ship shopping-cart --spec ./tasks/plan-shopping-cart-20240725.md

# Terminal 4:
cd ../ecommerce-worktrees/order-mgmt
claude /ship order-mgmt --spec ./tasks/plan-order-mgmt-20240725.md
```

---

### **Scenario 2: SaaS Analytics Platform**

#### **Feature Set:**
1. **Data Ingestion Pipeline**
2. **Real-time Dashboard**
3. **Reporting Engine**
4. **User Management & Billing**

#### **Planning Commands:**

**Feature 1: Data Ingestion**
```bash
claude /brainstorm "High-throughput data ingestion pipeline with multiple data sources and validation"
claude /think "How to handle millions of events per hour with data validation" --harder
claude /architect "Stream processing pipeline with Kafka and validation" --patterns event-driven --scale enterprise
claude /plan "Complete data ingestion system" --from-spec ./tasks/spec-data-ingestion-20240725.md --prd
```

**Feature 2: Real-time Dashboard**
```bash
claude /brainstorm "Real-time analytics dashboard with live charts and customizable widgets"
claude /architect "WebSocket-based dashboard with React and D3.js" --patterns microservices --performance
claude /plan "Complete dashboard system" --from-spec ./tasks/spec-dashboard-20240725.md --prd
```

**Feature 3: Reporting Engine**
```bash
claude /brainstorm "Automated reporting engine with scheduled reports and custom queries"
claude /architect "Report generation service with PDF export and scheduling" --patterns microservices
claude /plan "Complete reporting system" --from-spec ./tasks/spec-reporting-20240725.md --prd
```

**Feature 4: User Management & Billing**
```bash
claude /brainstorm "Multi-tenant user management with usage-based billing and team collaboration"
claude /architect "Multi-tenant architecture with Stripe billing integration" --patterns microservices --security
claude /plan "Complete user and billing system" --from-spec ./tasks/spec-user-billing-20240725.md --prd
```

---

### **Scenario 3: Healthcare Management System**

#### **Feature Set:**
1. **Patient Records & HIPAA Compliance**
2. **Appointment Scheduling**
3. **Telemedicine Integration**
4. **Billing & Insurance Processing**

#### **Planning Commands:**

**Feature 1: Patient Records**
```bash
claude /brainstorm "HIPAA-compliant patient records system with audit logging and encryption"
claude /think "How to ensure HIPAA compliance while maintaining usability" --spec ./tasks/spec-patient-records-20240725.md
claude /architect "Encrypted patient data system with audit trails" --patterns microservices --security --compliance HIPAA
claude /plan "Complete patient records system" --from-spec ./tasks/spec-patient-records-20240725.md --prd
```

**Feature 2: Appointment Scheduling**
```bash
claude /brainstorm "Advanced appointment scheduling with provider availability and patient preferences"
claude /architect "Calendar service with conflict resolution and notifications" --patterns microservices
claude /plan "Complete scheduling system" --from-spec ./tasks/spec-scheduling-20240725.md --prd
```

**Feature 3: Telemedicine**
```bash
claude /brainstorm "Telemedicine platform with video calls, screen sharing, and session recording"
claude /architect "WebRTC-based video platform with recording and compliance" --patterns microservices --security
claude /plan "Complete telemedicine system" --from-spec ./tasks/spec-telemedicine-20240725.md --prd
```

**Feature 4: Billing & Insurance**
```bash
claude /brainstorm "Healthcare billing with insurance claim processing and payment tracking"
claude /architect "Claims processing system with EDI integration" --patterns event-driven --compliance
claude /plan "Complete billing system" --from-spec ./tasks/spec-healthcare-billing-20240725.md --prd
```

---

## 📝 Planning Phase

### **Step 1: Brainstorming**
```bash
claude /brainstorm "[feature description]" [--interactive] [--specs] [--research]
```

**Input:** Feature concept or requirement
**Output:** `./tasks/spec-{feature}-{timestamp}.md`

**Contains:**
- Requirements analysis
- Technical specifications  
- Implementation roadmap
- Risk assessment
- Success metrics

### **Step 2: Deep Thinking (Optional)**
```bash
claude /think "[complex problem or decision]" [--harder|--ultra] [--spec <spec-file>]
```

**Input:** Complex technical decisions
**Output:** `./scratchpads/thinking-{timestamp}.md`

**Use when:**
- Architecture decisions are complex
- Multiple approaches need evaluation
- Risk analysis is needed

### **Step 3: Architecture Design**
```bash
claude /architect "[system description]" [--patterns <list>] [--scale <level>] [--security] [--performance]
```

**Input:** System requirements
**Output:** 
- `./docs/architecture-{timestamp}.md`
- `./docs/diagrams/` (component diagrams)
- `./docs/api-specs/` (API specifications)

### **Step 4: Implementation Planning**
```bash
claude /plan "[feature description]" --from-spec ./tasks/spec-{feature}-{timestamp}.md --prd [--tasks]
```

**Input:** Specification file from brainstorm
**Output:**
- `./tasks/plan-{feature}-{timestamp}.md` ⭐ **MAIN IMPLEMENTATION GUIDE**
- `./tasks/prd-{feature}-{timestamp}.md` (Product Requirements)

### **🤔 Plan vs PRD for Shipping?**

**Use the PLAN file for shipping:**
- **`./tasks/plan-{feature}-{timestamp}.md`** contains implementation prompts
- **`./tasks/prd-{feature}-{timestamp}.md`** contains business requirements

**Command:** `claude /ship feature --spec ./tasks/plan-{feature}-{timestamp}.md`

---

## ⚡ Execution Phase

### **Step 1: Create Git Worktrees**

#### **Option A: Manual Creation**
```bash
claude-worktree feature-1
claude-worktree feature-2  
claude-worktree feature-3
claude-worktree feature-4
```

#### **Option B: Batch Creation**
```bash
# Create all worktrees at once
for feature in auth catalog cart orders; do
    claude-worktree $feature &
done
```

**Result:**
- `../project-worktrees/feature-1/` (isolated working directory)
- `../project-worktrees/feature-2/`
- etc.

**Each worktree:**
- Has its own branch: `feature/feature-1`
- Contains copy of `.claude/`, `.env`, `CLAUDE.md`
- Opens new terminal with Claude session

### **Step 2: Parallel Implementation**

**In each terminal:**
```bash
cd ../project-worktrees/feature-name
claude /ship feature-name --spec ./tasks/plan-feature-name-{timestamp}.md
```

**What happens automatically:**
1. Reads complete plan file
2. Follows TDD methodology (tests first)
3. Implements all plan prompts sequentially
4. Commits after each major milestone
5. Creates PR when feature is complete

### **Step 3: Monitoring Progress**

**Check all worktrees:**
```bash
# In main project directory
git worktree list

# Check status of all feature branches
for branch in feature/auth feature/catalog feature/cart feature/orders; do
    echo "=== $branch ==="
    git log --oneline $branch -5
done
```

---

## 🔄 PR Management & Review Cycle

### **Automatic PR Creation**

Each `/ship` command automatically:
1. Creates descriptive PR with:
   - Feature specification
   - Implementation details
   - Test results
   - Screenshots (if UI changes)

2. Links to relevant issues (if using `--tasks`)

3. Includes commit history with semantic messages

### **Review & Feedback Workflow**

#### **Option A: Direct Approval**
```bash
# If PR looks good, merge directly
gh pr merge 123 --squash
```

#### **Option B: Request Changes**

**On GitHub:** Add review comments on specific lines

**Back to Agent:**
```bash
# In the feature's worktree
cd ../project-worktrees/feature-name
claude /review --fix --from-pr 123
```

**Or provide specific feedback:**
```bash
cd ../project-worktrees/feature-name
claude "Address the PR feedback: [paste feedback here]. Update the authentication logic to handle edge case X and add missing validation for Y."
```

**Agent will:**
1. Read PR comments
2. Implement requested changes
3. Run tests
4. Push updates to same PR
5. Request re-review

### **🤖 Should You Create an Agent for PR Resolution?**

**YES - It's highly beneficial!**

**Create a PR Resolution Agent:**
```bash
claude /ship pr-resolver --spec "Create an agent that can read PR feedback and implement requested changes automatically"
```

**Capabilities:**
- Parse GitHub PR comments
- Understand requested changes
- Implement fixes following project patterns
- Run tests and verify changes
- Update PR with resolution

**Usage:**
```bash
claude /resolve-pr 123  # Automatically fixes PR based on review comments
```

---

## 📁 File Reference

### **Planning Phase Files**
```
./tasks/
├── spec-{feature}-{timestamp}.md      # Brainstorm output
├── plan-{feature}-{timestamp}.md      # Implementation cookbook (USE FOR SHIPPING)
└── prd-{feature}-{timestamp}.md       # Product requirements

./docs/
├── architecture-{timestamp}.md        # System design
├── diagrams/                          # Visual diagrams
└── api-specs/                         # API documentation

./scratchpads/
└── thinking-{timestamp}.md           # Deep analysis output
```

### **Execution Phase Structure**
```
../project-worktrees/
├── feature-1/                        # Isolated working directory
│   ├── .git -> main-repo.git/worktrees/feature-1
│   ├── src/feature1/                 # Feature implementation
│   └── tests/feature1/               # Feature tests
├── feature-2/
├── feature-3/
└── feature-4/

Main Project/
├── tasks/                            # All plan files
├── docs/                             # Architecture docs
└── .git/worktrees/                   # Git worktree metadata
```

### **Branch Structure**
```
main                                  # Production branch
├── feature/user-auth                 # Feature 1 branch
├── feature/product-catalog           # Feature 2 branch  
├── feature/shopping-cart             # Feature 3 branch
└── feature/order-mgmt                # Feature 4 branch
```

---

## ✅ Best Practices

### **Planning Best Practices**

1. **Always use --from-spec** when creating plans to maintain consistency
2. **Include --prd flag** for business context
3. **Use specific, descriptive feature names** 
4. **Plan for file isolation** - ensure features touch different directories

### **Execution Best Practices**

1. **Monitor dependencies** - implement foundational features first
2. **Regular synchronization** - rebase feature branches from main periodically
3. **Test isolation** - ensure tests don't interfere with each other
4. **Clear commit messages** - use semantic commit format

### **Review Best Practices**

1. **Review PRs in dependency order** - merge foundational features first
2. **Use draft PRs** for work-in-progress features
3. **Automate PR resolution** where possible
4. **Maintain clean branch history** with squash merges

---

## 🎯 Complete Example Workflow

### **E-commerce Platform: 4 Features**

```bash
# === PLANNING PHASE ===
# Feature 1: Authentication
claude /brainstorm "User authentication with social login and 2FA"
claude /architect "JWT auth with OAuth providers" --security
claude /plan "Complete auth system" --from-spec ./tasks/spec-user-auth-20240725.md --prd

# Feature 2: Product Catalog  
claude /brainstorm "Product catalog with search and recommendations"
claude /architect "Search with Elasticsearch" --performance
claude /plan "Complete catalog system" --from-spec ./tasks/spec-product-catalog-20240725.md --prd

# Feature 3: Shopping Cart
claude /brainstorm "Persistent shopping cart with checkout flow"
claude /architect "Cart service with Redis" --patterns microservices
claude /plan "Complete cart system" --from-spec ./tasks/spec-shopping-cart-20240725.md --prd

# Feature 4: Order Management
claude /brainstorm "Order processing with tracking and notifications"
claude /architect "Order system with event sourcing" --patterns event-driven
claude /plan "Complete order system" --from-spec ./tasks/spec-order-mgmt-20240725.md --prd

# === EXECUTION PHASE ===
# Launch parallel worktrees
claude-worktree user-auth &
claude-worktree product-catalog &
claude-worktree shopping-cart &
claude-worktree order-mgmt &

# In Terminal 1:
cd ../ecommerce-worktrees/user-auth
claude /ship user-auth --spec ./tasks/plan-user-auth-20240725.md

# In Terminal 2:
cd ../ecommerce-worktrees/product-catalog  
claude /ship product-catalog --spec ./tasks/plan-product-catalog-20240725.md

# In Terminal 3:
cd ../ecommerce-worktrees/shopping-cart
claude /ship shopping-cart --spec ./tasks/plan-shopping-cart-20240725.md

# In Terminal 4:
cd ../ecommerce-worktrees/order-mgmt
claude /ship order-mgmt --spec ./tasks/plan-order-mgmt-20240725.md

# === REVIEW PHASE ===
# Review and merge PRs in dependency order:
gh pr merge 101 --squash  # User auth (foundation)
gh pr merge 102 --squash  # Product catalog  
gh pr merge 103 --squash  # Shopping cart (depends on products)
gh pr merge 104 --squash  # Order management (depends on cart)

# === CLEANUP ===
# Remove worktrees after merge
git worktree remove ../ecommerce-worktrees/user-auth
git worktree remove ../ecommerce-worktrees/product-catalog
git worktree remove ../ecommerce-worktrees/shopping-cart
git worktree remove ../ecommerce-worktrees/order-mgmt
```

**Result:** Complete e-commerce platform with 4 major features implemented in parallel, tested, and merged! 🚀

---

*This workflow enables true parallel development with Claude Code, allowing you to implement multiple complex features simultaneously while maintaining code quality and avoiding conflicts.*