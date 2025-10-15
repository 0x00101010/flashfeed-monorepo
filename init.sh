#!/bin/bash

set -e

echo "🚀 Initializing FlashFeed Monorepo..."
echo ""

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Check if nodes/rblib already exists
if [ -d "nodes/rblib" ]; then
    echo -e "${YELLOW}⚠️  nodes/rblib already exists. Skipping clone.${NC}"
    echo ""
else
    echo "📦 Setting up rblib fork..."
    echo ""

    FORK_URL="git@github.com:0x00101010/rblib.git"

    echo "Cloning your fork into nodes/rblib..."
    git clone "$FORK_URL" nodes/rblib

    cd nodes/rblib

    # Add upstream remote
    echo ""
    echo "Adding flashbots/rblib as upstream remote..."
    git remote add upstream https://github.com/flashbots/rblib.git

    echo ""
    echo -e "${GREEN}✅ rblib fork set up successfully!${NC}"
    echo "   - Origin: $FORK_URL"
    echo "   - Upstream: https://github.com/flashbots/rblib.git"
    echo ""
    echo "To sync with upstream later:"
    echo "  cd nodes/rblib"
    echo "  git fetch upstream"
    echo "  git merge upstream/main"
    echo ""

    cd ../..
fi