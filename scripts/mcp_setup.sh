#!/bin/bash
# MCP (Model Context Protocol) server setup for Claude Code

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${BLUE}🔧 Claude Code MCP Server Setup${NC}"
echo "================================"

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

# Function to setup Postgres MCP
setup_postgres() {
    echo -e "${YELLOW}Setting up Postgres MCP...${NC}"
    
    # Check for DATABASE_URL
    if [ -z "$DATABASE_URL" ]; then
        echo -e "${RED}DATABASE_URL not found in environment${NC}"
        echo "Please set DATABASE_URL and try again"
        return 1
    fi
    
    # Install postgres MCP if not exists
    if ! command_exists postgres-mcp; then
        echo "Installing postgres-mcp..."
        npm install -g @modelcontextprotocol/postgres-server
    fi
    
    # Add to Claude
    claude mcp add postgres postgres-mcp \
        --env CONNECTION_STRING="$DATABASE_URL" \
        --description "PostgreSQL database access"
    
    echo -e "${GREEN}✅ Postgres MCP configured${NC}"
}

# Function to setup Browserbase MCP
setup_browserbase() {
    echo -e "${YELLOW}Setting up Browserbase MCP...${NC}"
    
    # Check for API key
    if [ -z "$BROWSERBASE_API_KEY" ]; then
        echo -e "${RED}BROWSERBASE_API_KEY not found${NC}"
        echo "Get your API key from https://browserbase.com"
        read -p "Enter Browserbase API key (or skip): " api_key
        if [ -z "$api_key" ]; then
            echo "Skipping Browserbase setup"
            return 1
        fi
        export BROWSERBASE_API_KEY="$api_key"
    fi
    
    # Add to Claude
    claude mcp add browserbase https://api.browserbase.com/mcp \
        --transport sse \
        --env API_KEY="$BROWSERBASE_API_KEY" \
        --description "Browser automation for UI testing"
    
    echo -e "${GREEN}✅ Browserbase MCP configured${NC}"
}

# Function to setup GitHub MCP
setup_github() {
    echo -e "${YELLOW}Setting up GitHub MCP...${NC}"
    
    # Check for GitHub token
    if [ -z "$GITHUB_TOKEN" ]; then
        echo -e "${RED}GITHUB_TOKEN not found${NC}"
        echo "Create a token at https://github.com/settings/tokens"
        read -p "Enter GitHub token (or skip): " token
        if [ -z "$token" ]; then
            echo "Skipping GitHub setup"
            return 1
        fi
        export GITHUB_TOKEN="$token"
    fi
    
    # Install GitHub MCP if not exists
    if ! command_exists github-mcp; then
        echo "Installing github-mcp..."
        npm install -g @modelcontextprotocol/github-server
    fi
    
    # Add to Claude
    claude mcp add github github-mcp \
        --env GITHUB_TOKEN="$GITHUB_TOKEN" \
        --description "GitHub repository management"
    
    echo -e "${GREEN}✅ GitHub MCP configured${NC}"
}

# Function to setup Context MCP
setup_context() {
    echo -e "${YELLOW}Setting up Context MCP...${NC}"
    
    # Add to Claude
    claude mcp add context https://context.mcp.run \
        --transport sse \
        --description "Up-to-date library documentation"
    
    echo -e "${GREEN}✅ Context MCP configured${NC}"
}

# Main menu
show_menu() {
    echo ""
    echo "Available MCP Servers:"
    echo "1) Postgres - Database queries"
    echo "2) Browserbase - UI automation"
    echo "3) GitHub - Repository management"
    echo "4) Context - Library documentation"
    echo "5) All - Install all servers"
    echo "6) Exit"
    echo ""
}

# Main loop
while true; do
    show_menu
    read -p "Select option (1-6): " choice
    
    case $choice in
        1) setup_postgres ;;
        2) setup_browserbase ;;
        3) setup_github ;;
        4) setup_context ;;
        5) 
            setup_postgres
            setup_browserbase
            setup_github
            setup_context
            ;;
        6) 
            echo -e "${BLUE}Goodbye!${NC}"
            exit 0
            ;;
        *)
            echo -e "${RED}Invalid option${NC}"
            ;;
    esac
done