#!/bin/bash
set -e

REPO="https://github.com/CroissanStudioDev/neuroartist-skill-agents"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Install or update plugin to a directory
# Usage: install_or_update <target_dir> <display_path> [extra_message]
install_or_update() {
  local target_dir="$1"
  local display_path="$2"
  local extra_msg="$3"

  mkdir -p "$(dirname "$target_dir")"

  if [ ! -d "$target_dir" ]; then
    git clone --depth 1 "$REPO.git" "$target_dir" 2>/dev/null
    echo -e "  ${GREEN}Installed${NC} to $display_path"
    [ -n "$extra_msg" ] && echo -e "  ${YELLOW}$extra_msg${NC}"
  else
    # Update existing installation
    cd "$target_dir"
    git fetch origin main --depth 1 2>/dev/null
    LOCAL=$(git rev-parse HEAD 2>/dev/null)
    REMOTE=$(git rev-parse origin/main 2>/dev/null)

    if [ "$LOCAL" != "$REMOTE" ]; then
      git reset --hard origin/main 2>/dev/null
      echo -e "  ${BLUE}Updated${NC} at $display_path"
    else
      echo -e "  Already up to date at $display_path"
    fi
    cd - > /dev/null
  fi
}

echo "🎨 neuroartist plugin installer"
echo ""

installed=0
updated=0

# Claude Code (plugin system)
if command -v claude &> /dev/null; then
  echo -e "${GREEN}✓${NC} Claude Code detected"
  install_or_update "$HOME/.claude/plugins/neuroartist" "~/.claude/plugins/neuroartist" \
    "Run: /plugin marketplace add CroissanStudioDev/neuroartist-skill-agents"
  installed=$((installed + 1))
fi

# OpenClaw
if command -v openclaw &> /dev/null || command -v claw &> /dev/null; then
  echo -e "${GREEN}✓${NC} OpenClaw detected"
  install_or_update "$HOME/.openclaw/skills/neuroartist" "~/.openclaw/skills/neuroartist"
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
  install_or_update "$HOME/.cursor/skills/neuroartist" "~/.cursor/skills/neuroartist"
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
  install_or_update "$HOME/.windsurf/skills/neuroartist" "~/.windsurf/skills/neuroartist"
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

echo -e "${GREEN}✓ Done!${NC} Processed $installed agent(s)"
echo ""
echo "Restart your agent to load changes."
echo "Docs: https://neuroartist.ru/docs"
