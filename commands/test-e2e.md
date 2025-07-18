# End-to-end testing with browser automation

Comprehensive E2E testing with Playwright integration and advanced browser automation.

Usage: /test-e2e [test_description] [--browsers <list>] [--headless] [--parallel] [--record]

## E2E Testing Process

1. **Test Planning**:
   - Analyze application user flows and critical paths
   - Identify test scenarios and edge cases
   - Define test data and environment requirements
   - Plan test execution strategy and coverage

2. **Test Scenario Design**:
   - Create user persona-based test scenarios
   - Design happy path and error condition tests
   - Plan boundary and stress testing scenarios
   - Document expected outcomes and assertions

3. **Test Implementation**:
   - Generate Playwright test scripts
   - Implement page object model patterns
   - Create reusable test utilities and helpers
   - Set up test data management and cleanup

4. **Cross-Browser Testing**:
   - Execute tests across multiple browsers (Chromium, Firefox, WebKit)
   - Validate browser-specific functionality
   - Test responsive design and viewport variations
   - Verify accessibility across different browsers

5. **Test Execution**:
   - Run tests in parallel for faster execution
   - Capture screenshots and videos for debugging
   - Generate detailed test reports and metrics
   - Handle test failures and retries

6. **Reporting and Analysis**:
   - Create comprehensive test execution reports
   - Analyze test results and failure patterns
   - Generate performance metrics and timing data
   - Provide actionable insights and recommendations

## Testing Capabilities

### Browser Automation
- **Multi-Browser Support**: Chromium, Firefox, WebKit
- **Mobile Testing**: Device emulation and responsive testing
- **Parallel Execution**: Concurrent test execution across browsers
- **Headless Mode**: Faster execution without GUI
- **Screenshots/Videos**: Visual debugging and documentation

### User Interaction Simulation
- **Click Actions**: Buttons, links, and interactive elements
- **Form Filling**: Input fields, dropdowns, checkboxes
- **Navigation**: Page routing and URL handling
- **File Upload**: File selection and upload testing
- **Drag and Drop**: Complex user interactions

### Advanced Testing Features
- **Visual Testing**: Screenshot comparison and visual regression
- **Performance Testing**: Page load times and resource monitoring
- **Network Interception**: API mocking and request manipulation
- **Accessibility Testing**: ARIA, keyboard navigation, screen readers
- **Authentication**: Login flows and session management

## Test Patterns and Best Practices

### Page Object Model
- **Page Classes**: Encapsulate page elements and actions
- **Component Objects**: Reusable UI component interactions
- **Locator Strategies**: Robust element selection methods
- **Action Methods**: High-level user action abstractions

### Test Data Management
- **Test Fixtures**: Reusable test data and setup
- **Data Factories**: Dynamic test data generation
- **Environment Configuration**: Multi-environment test support
- **Database Seeding**: Test data initialization and cleanup

### Assertion Strategies
- **Element Assertions**: Visibility, text content, attributes
- **State Assertions**: Application state and data validation
- **Performance Assertions**: Timing and resource usage
- **Visual Assertions**: Screenshot and layout validation

## Testing Scenarios

### User Authentication
- **Login Flow**: Username/password authentication
- **Social Login**: OAuth and third-party authentication
- **Password Reset**: Recovery and reset workflows
- **Session Management**: Login persistence and timeouts
- **Multi-Factor Authentication**: 2FA and security flows

### E-commerce Testing
- **Product Browsing**: Catalog navigation and search
- **Shopping Cart**: Add/remove items and quantity updates
- **Checkout Process**: Payment and order completion
- **User Account**: Profile management and order history
- **Inventory Management**: Stock levels and availability

### Form Testing
- **Form Validation**: Client-side and server-side validation
- **Error Handling**: Invalid input and error messages
- **Multi-Step Forms**: Wizard and progress flows
- **File Upload**: Document and image upload testing
- **Auto-Save**: Draft saving and recovery

### API Integration Testing
- **REST API Testing**: HTTP methods and response validation
- **GraphQL Testing**: Query and mutation testing
- **WebSocket Testing**: Real-time communication
- **Third-Party APIs**: External service integration
- **Error Handling**: API failure and timeout scenarios

## Browser Configuration

### Chromium Testing
- **Chrome DevTools**: Advanced debugging capabilities
- **Extension Testing**: Chrome extension compatibility
- **Performance Profiling**: Detailed performance metrics
- **Security Testing**: CSP and security policy validation

### Firefox Testing
- **Gecko Engine**: Firefox-specific behavior validation
- **Developer Tools**: Firefox DevTools integration
- **Add-on Testing**: Firefox extension compatibility
- **Privacy Features**: Tracking protection and privacy testing

### WebKit Testing
- **Safari Compatibility**: Safari-specific feature testing
- **iOS Simulation**: Mobile Safari behavior
- **WebKit Features**: Safari-specific web standards
- **Performance Testing**: WebKit engine performance

## Test Execution Options

### Execution Modes
- **Interactive Mode**: Real-time test execution with debugging
- **Headless Mode**: Faster execution without browser GUI
- **Debug Mode**: Step-by-step execution with breakpoints
- **Record Mode**: Test recording and playback functionality

### Parallel Testing
- **Browser Parallelism**: Multiple browsers simultaneously
- **Test Parallelism**: Multiple tests in parallel
- **Shard Testing**: Distribute tests across multiple machines
- **Resource Management**: Optimal resource utilization

### Reporting and Documentation
- **HTML Reports**: Interactive test result visualization
- **JSON Reports**: Programmatic result processing
- **JUnit Reports**: CI/CD integration compatibility
- **Allure Reports**: Advanced reporting with trends

## Options

- **--browsers**: Specify browsers to test (chromium|firefox|webkit|all)
- **--headless**: Run tests in headless mode
- **--parallel**: Enable parallel test execution
- **--record**: Record test execution videos
- **--screenshots**: Capture screenshots on failure
- **--slow-mo**: Slow down test execution for debugging
- **--debug**: Enable debug mode with breakpoints
- **--trace**: Enable detailed execution tracing
- **--timeout**: Set custom timeout values
- **--retries**: Configure test retry attempts

## Testing Examples

### User Registration Flow
```bash
claude /test-e2e "Test user registration and email verification" --browsers all --record
```

### E-commerce Checkout
```bash
claude /test-e2e "Test complete purchase workflow" --parallel --screenshots
```

### API Integration
```bash
claude /test-e2e "Test real-time chat functionality" --browsers chromium --debug
```

### Mobile Responsive
```bash
claude /test-e2e "Test mobile responsive design" --browsers webkit --headless
```

## Output Artifacts

1. **Test Scripts**: Playwright test implementations
2. **Page Objects**: Reusable page interaction classes
3. **Test Data**: Fixtures and test data management
4. **Configuration**: Test environment and browser setup
5. **Reports**: Detailed test execution results
6. **Screenshots**: Visual test documentation
7. **Videos**: Test execution recordings
8. **Performance Metrics**: Timing and resource usage data

## Quality Metrics

- **Test Coverage**: Percentage of user flows tested
- **Pass Rate**: Successful test execution percentage
- **Execution Time**: Test suite performance metrics
- **Flakiness**: Test stability and reliability
- **Browser Compatibility**: Cross-browser success rate
- **Performance**: Page load and interaction timing

## Success Criteria

- **Comprehensive Coverage**: All critical user flows tested
- **Cross-Browser Compatibility**: Consistent behavior across browsers
- **Reliable Execution**: Stable and repeatable test results
- **Fast Feedback**: Quick test execution and reporting
- **Maintainable Tests**: Easy to update and extend
- **Clear Reporting**: Actionable test results and insights

Output: Complete E2E testing suite with scripts, reports, and documentation
Note: Tests follow Playwright best practices and modern web testing standards