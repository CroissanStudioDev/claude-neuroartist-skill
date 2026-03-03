#!/bin/bash
set -e

REPO="https://github.com/CroissanStudioDev/neuroartist-skill-agents"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo "🎨 Installing neuroartist plugin..."
echo ""

installed=0

# Claude Code (plugin system)
if command -v claude &> /dev/null; then
  echo -e "${GREEN}✓${NC} Claude Code detected"
  CLAUDE_PLUGINS="$HOME/.claude/plugins"
  mkdir -p "$CLAUDE_PLUGINS"
  if [ ! -d "$CLAUDE_PLUGINS/neuroartist" ]; then
    git clone --depth 1 "$REPO.git" "$CLAUDE_PLUGINS/neuroartist" 2>/dev/null
    echo "  Installed to ~/.claude/plugins/neuroartist"
    echo -e "  ${YELLOW}Run: /plugin marketplace add CroissanStudioDev/neuroartist-skill-agents${NC}"
  else
    echo "  Already installed at ~/.claude/plugins/neuroartist"
  fi
  installed=$((installed + 1))
fi

# OpenClaw
if command -v openclaw &> /dev/null || command -v claw &> /dev/null; then
  echo -e "${GREEN}✓${NC} OpenClaw detected"
  OPENCLAW_SKILLS="$HOME/.openclaw/skills"
  mkdir -p "$OPENCLAW_SKILLS"
  if [ ! -d "$OPENCLAW_SKILLS/neuroartist" ]; then
    git clone --depth 1 "$REPO.git" "$OPENCLAW_SKILLS/neuroartist" 2>/dev/null
    echo "  Installed to ~/.openclaw/skills/neuroartist"
  else
    echo "  Already installed at ~/.openclaw/skills/neuroartist"
  fi
  installed=$((installed + 1))
fi

# Cursor
CURSOR_DIR=""
if [ -d "$HOME/.cursor" ]; then
  CURSOR_DIR="$HOME/.cursor"
elif [ -d "$HOME/Library/Application Support/Cursor" ]; then
  CURSOR_DIR="$HOME/Library/Application Support/Cursor"
elif [ -d "$HOME/.config/Cursor" ]; then
  CURSOR_DIR="$HOME/.config/Cursor"
fi

if [ -n "$CURSOR_DIR" ]; then
  echo -e "${GREEN}✓${NC} Cursor detected"
  CURSOR_SKILLS="$HOME/.cursor/skills"
  mkdir -p "$CURSOR_SKILLS"
  if [ ! -d "$CURSOR_SKILLS/neuroartist" ]; then
    git clone --depth 1 "$REPO.git" "$CURSOR_SKILLS/neuroartist" 2>/dev/null
    echo "  Installed to ~/.cursor/skills/neuroartist"
  else
    echo "  Already installed at ~/.cursor/skills/neuroartist"
  fi
  installed=$((installed + 1))
fi

# Windsurf
WINDSURF_DIR=""
if [ -d "$HOME/.windsurf" ]; then
  WINDSURF_DIR="$HOME/.windsurf"
elif [ -d "$HOME/Library/Application Support/Windsurf" ]; then
  WINDSURF_DIR="$HOME/Library/Application Support/Windsurf"
elif [ -d "$HOME/.config/Windsurf" ]; then
  WINDSURF_DIR="$HOME/.config/Windsurf"
fi

if [ -n "$WINDSURF_DIR" ]; then
  echo -e "${GREEN}✓${NC} Windsurf detected"
  WINDSURF_SKILLS="$HOME/.windsurf/skills"
  mkdir -p "$WINDSURF_SKILLS"
  if [ ! -d "$WINDSURF_SKILLS/neuroartist" ]; then
    git clone --depth 1 "$REPO.git" "$WINDSURF_SKILLS/neuroartist" 2>/dev/null
    echo "  Installed to ~/.windsurf/skills/neuroartist"
  else
    echo "  Already installed at ~/.windsurf/skills/neuroartist"
  fi
  installed=$((installed + 1))
fi

echo ""

if [ $installed -eq 0 ]; then
  echo -e "${YELLOW}No supported AI agents found.${NC}"
  echo ""
  echo "Supported agents:"
  echo "  • Claude Code (claude CLI)"
  echo "  • OpenClaw (openclaw/claw CLI)"
  echo "  • Cursor (~/.cursor)"
  echo "  • Windsurf (~/.windsurf)"
  echo ""
  echo "Manual installation:"
  echo "  git clone $REPO.git <your-agent-skills-dir>/neuroartist"
  exit 1
fi

echo -e "${GREEN}✓ Done!${NC} Installed for $installed agent(s)"
echo ""
echo "Restart your agent to load the plugin."
echo "Docs: https://neuroartist.ru/docs"
