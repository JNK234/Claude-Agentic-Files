# System architecture design and analysis

Advanced system design with architectural patterns and best practices.

Usage: /architect [system_description] [--patterns <list>] [--scale <level>] [--constraints <file>]

## Architecture Design Process

1. **Requirements Analysis**:
   - Parse system requirements and constraints
   - Identify functional and non-functional requirements
   - Analyze scalability and performance needs
   - Document integration requirements

2. **Pattern Selection**:
   - Evaluate architectural patterns (microservices, monolith, serverless, event-driven)
   - Consider trade-offs for each pattern
   - Recommend optimal architecture style
   - Document pattern rationale

3. **Component Design**:
   - Define system components and boundaries
   - Design service interfaces and contracts
   - Plan data flow and state management
   - Create component dependency graph

4. **Technology Stack Recommendations**:
   - Database selection (SQL vs NoSQL, specific technologies)
   - Framework and library recommendations
   - Infrastructure and deployment considerations
   - Monitoring and observability stack

5. **Scalability Planning**:
   - Horizontal vs vertical scaling strategies
   - Load balancing and traffic distribution
   - Caching strategies and CDN usage
   - Database sharding and replication

6. **Security Architecture**:
   - Authentication and authorization design
   - API security and rate limiting
   - Data encryption and privacy considerations
   - Network security and firewalls

7. **Documentation Generation**:
   - Architecture diagrams (component, sequence, deployment)
   - API specifications and contracts
   - Database schema design
   - Deployment and infrastructure docs

## Enhanced Features

- **Pattern Library**: Access to proven architectural patterns
- **Best Practices**: Industry-standard design principles
- **Technology Matrix**: Comparison of technology choices
- **Scalability Modeling**: Performance and capacity planning
- **Security Framework**: Comprehensive security considerations

## Architecture Patterns

### Microservices Architecture
- Service decomposition strategies
- Inter-service communication patterns
- Data consistency and distributed transactions
- Service discovery and load balancing
- Circuit breaker and fault tolerance

### Event-Driven Architecture
- Event sourcing and CQRS patterns
- Message queues and event streaming
- Event schema design and versioning
- Saga patterns for distributed workflows
- Event storage and replay mechanisms

### Serverless Architecture
- Function-as-a-Service design patterns
- Event triggers and workflow orchestration
- Cold start optimization strategies
- State management in stateless functions
- Cost optimization and resource planning

### Monolithic Architecture
- Modular monolith design
- Internal service boundaries
- Database design and optimization
- Deployment and scaling strategies
- Migration paths to distributed systems

## Design Considerations

### Performance Architecture
- Caching strategies (Redis, Memcached, CDN)
- Database optimization and indexing
- Asynchronous processing patterns
- Connection pooling and resource management
- Performance monitoring and profiling

### Data Architecture
- Data modeling and schema design
- Database selection criteria
- Data migration and versioning
- Backup and disaster recovery
- Data privacy and compliance

### Infrastructure Architecture
- Container orchestration (Kubernetes, Docker Swarm)
- CI/CD pipeline design
- Infrastructure as Code (Terraform, CloudFormation)
- Monitoring and logging architecture
- Security and compliance framework

## Options

- **--patterns**: Specify architectural patterns to consider (microservices|monolith|serverless|event-driven)
- **--scale**: Target scale level (small|medium|large|enterprise)
- **--constraints**: Load constraints file (budget, timeline, team size, etc.)
- **--tech-stack**: Specify preferred technology stack
- **--security**: Enhanced security architecture focus
- **--performance**: Performance-optimized architecture
- **--cloud**: Cloud-native architecture patterns
- **--legacy**: Legacy system integration considerations

## Output Artifacts

1. **Architecture Document**: Comprehensive system design
2. **Component Diagrams**: Visual system representation
3. **API Specifications**: Service contracts and interfaces
4. **Database Schema**: Data model and relationships
5. **Deployment Guide**: Infrastructure and deployment instructions
6. **Security Assessment**: Security considerations and recommendations
7. **Performance Plan**: Scalability and performance strategy

## Architecture Examples

### E-commerce Platform
```bash
claude /architect "Build scalable e-commerce platform with payment processing" --patterns microservices --scale large
```

### Real-time Analytics System
```bash
claude /architect "Design real-time analytics dashboard for IoT data" --patterns event-driven --performance
```

### Content Management System
```bash
claude /architect "Create headless CMS with multi-tenant support" --patterns monolith --cloud
```

## Success Criteria

- **Scalability**: System can handle projected load
- **Maintainability**: Clear separation of concerns
- **Security**: Comprehensive security model
- **Performance**: Meets performance requirements
- **Cost-effectiveness**: Optimal resource utilization
- **Reliability**: High availability and fault tolerance

Output: Complete architecture package with diagrams, specifications, and implementation roadmap
Note: Architecture recommendations are based on industry best practices and current technology trends