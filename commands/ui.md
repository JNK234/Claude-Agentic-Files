# UI component generation and design

Advanced UI component creation with design systems and accessibility.

Usage: /ui [component_description] [--framework <name>] [--design-system <name>] [--responsive] [--a11y]

## UI Generation Process

1. **Component Analysis**:
   - Parse component requirements and specifications
   - Identify component type (atom, molecule, organism, template)
   - Determine state management needs
   - Analyze interaction patterns

2. **Framework Integration**:
   - Generate framework-specific code (React, Vue, Angular, Svelte)
   - Apply framework best practices and conventions
   - Implement proper component lifecycle
   - Handle framework-specific optimizations

3. **Design System Application**:
   - Apply design tokens (colors, typography, spacing)
   - Use component library patterns
   - Implement consistent styling approach
   - Follow design system guidelines

4. **Responsive Design**:
   - Mobile-first responsive implementation
   - Breakpoint-based layout adaptation
   - Flexible grid and layout systems
   - Touch-friendly interaction design

5. **Accessibility Implementation**:
   - WCAG 2.1 AA compliance
   - ARIA labels and semantic HTML
   - Keyboard navigation support
   - Screen reader optimization
   - Focus management and indicators

6. **Interactive Behavior**:
   - Event handling and state management
   - Animation and micro-interactions
   - Form validation and error handling
   - Loading states and feedback

7. **Testing and Documentation**:
   - Unit tests for component logic
   - Visual regression testing
   - Storybook stories and examples
   - API documentation and prop types

## Supported Frameworks

### React Components
- Functional components with hooks
- TypeScript support and prop types
- State management integration (Redux, Zustand)
- Styling solutions (CSS Modules, Styled Components, Emotion)
- Testing with Jest and React Testing Library

### Vue Components
- Composition API and Options API
- TypeScript support
- Vuex/Pinia state management
- Scoped styling and CSS modules
- Vue Test Utils testing

### Angular Components
- Component architecture and lifecycle
- TypeScript by default
- RxJS reactive programming
- Angular Material integration
- Jasmine and Karma testing

### Svelte Components
- Reactive programming model
- Built-in state management
- Scoped styling by default
- Lightweight bundle size
- Testing with @testing-library/svelte

## Design System Integration

### Material Design
- Material UI components and theming
- Material Design 3 token system
- Component variants and states
- Elevation and motion guidelines

### Ant Design
- Ant Design component library
- Theme customization and tokens
- Form components and validation
- Table and data display components

### Chakra UI
- Simple and modular components
- Theme-based design system
- Responsive design utilities
- Accessibility-first approach

### Tailwind CSS
- Utility-first CSS framework
- Custom component classes
- Responsive design utilities
- Dark mode support

### Custom Design Systems
- Design token implementation
- Component variant system
- Brand-specific styling
- Consistent spacing and typography

## Component Types

### Atomic Components
- Buttons, inputs, labels, icons
- Typography and text components
- Basic form elements
- Loading indicators

### Molecular Components
- Form groups and validation
- Search bars and filters
- Card components
- Navigation elements

### Organism Components
- Headers and navigation bars
- Data tables and lists
- Forms and wizards
- Dashboard layouts

### Template Components
- Page layouts and grids
- Application shells
- Modal and overlay systems
- Responsive templates

## Styling Approaches

### CSS-in-JS
- Styled Components implementation
- Emotion.js integration
- Runtime theme switching
- Component-scoped styles

### CSS Modules
- Scoped CSS classes
- Composition and theming
- Build-time optimization
- TypeScript support

### Utility CSS
- Tailwind CSS integration
- Custom utility classes
- Responsive utilities
- Dark mode utilities

### Traditional CSS
- BEM methodology
- SCSS/Sass preprocessing
- CSS custom properties
- PostCSS processing

## Options

- **--framework**: Target framework (react|vue|angular|svelte)
- **--design-system**: Design system to use (material|ant|chakra|tailwind|custom)
- **--responsive**: Generate responsive design implementation
- **--a11y**: Enhanced accessibility features
- **--typescript**: Generate TypeScript components
- **--testing**: Include comprehensive test suite
- **--storybook**: Generate Storybook stories
- **--dark-mode**: Dark mode support
- **--animations**: Include micro-interactions and animations

## Generation Examples

### Button Component
```bash
claude /ui "Create primary button with loading state" --framework react --design-system material --a11y
```

### Form Component
```bash
claude /ui "Build contact form with validation" --framework vue --responsive --testing
```

### Data Table
```bash
claude /ui "Design responsive data table with sorting" --framework angular --design-system ant
```

### Dashboard Layout
```bash
claude /ui "Create responsive dashboard layout" --framework react --design-system custom --dark-mode
```

## Output Artifacts

1. **Component Code**: Framework-specific implementation
2. **Styling**: CSS/SCSS/CSS-in-JS styles
3. **Type Definitions**: TypeScript interfaces and types
4. **Tests**: Unit and integration tests
5. **Stories**: Storybook documentation
6. **Documentation**: Usage examples and API docs
7. **Assets**: Icons, images, and static resources

## Quality Standards

- **Performance**: Optimized rendering and bundle size
- **Accessibility**: WCAG 2.1 AA compliance
- **Responsiveness**: Mobile-first design
- **Maintainability**: Clean, documented code
- **Reusability**: Flexible and composable components
- **Testing**: Comprehensive test coverage

Output: Complete UI component package with code, tests, documentation, and examples
Note: Components follow framework best practices and modern web standards