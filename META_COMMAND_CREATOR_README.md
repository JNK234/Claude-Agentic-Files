# Meta Command Creator - Documentation

## Overview
The Meta Command Creator is a powerful tool that automatically generates custom slash commands based on requirements specified in a text file.

## Installation
The command has been created at: `commands/create-command.md`

## Usage

```bash
/create-command path/to/requirements.txt
```

## How It Works

1. **Reads Requirements**: Parses your requirements file
2. **Analyzes Tools**: Automatically selects the best tools from 100+ available
3. **Generates Command**: Creates a custom slash command tailored to your needs
4. **Saves Command**: Places it in project or personal commands directory

## Requirements File Format

Your requirements file should describe:
- What the command should do
- Any specific constraints or preferences
- Expected input/output
- Whether it's project-specific or for personal use

### Example Requirements File

```text
Command Requirement: [Name/Purpose]

I need a command that:
1. [First task/requirement]
2. [Second task/requirement]
3. [Additional requirements...]

The command should [behavior/constraints].
Should work on [scope/target].
```

## Available Tool Categories

The meta creator intelligently selects from:

- **File Operations**: Read, Write, Edit, Glob, Grep
- **Code Analysis**: Code review, debugging, refactoring, security audit
- **AI Tools**: Multi-model chat, consensus, planning
- **Development**: Bash, GitHub, browser automation
- **Research**: Web search, documentation lookup
- **Testing**: Test generation, validation

## Example Commands Generated

### Code Quality Checker
- Tools: `Glob`, `mcp__zen__codereview`, `Write`
- Purpose: Analyze code quality across project

### Security Scanner
- Tools: `Glob`, `mcp__zen__secaudit`, `mcp__github__create_issue`
- Purpose: Security audit with issue creation

### Test Generator
- Tools: `Read`, `mcp__zen__testgen`, `Write`
- Purpose: Generate comprehensive test suites

## Tips

1. **Be Specific**: Clear requirements = better commands
2. **Scope**: Specify if command is project or personal
3. **Arguments**: Mention if command needs parameters
4. **Output**: Describe expected results

## Testing

Test file created at: `sample-requirement.txt`

Run:
```bash
/create-command sample-requirement.txt
```

This will generate a custom command based on the sample requirements.

## Benefits

- **Automation**: No manual tool selection needed
- **Consistency**: Generates well-structured commands
- **Flexibility**: Adapts to any requirement
- **Simplicity**: Just describe what you need

## Next Steps

1. Create your requirements file
2. Run `/create-command your-requirements.txt`
3. Follow prompts for project/personal placement
4. Use your new command with `/your-command-name`