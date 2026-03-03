#!/bin/bash
set -e

REPO="https://github.com/CroissanStudioDev/neuroartist-skill-agents"
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Install or update plugin to a directory
install_or_update() {
  local target_dir="$1"
  local display_path="$2"
  local extra_msg="$3"

  mkdir -p "$(dirname "$target_dir")"

  if [ ! -d "$target_dir" ]; then
    git clone --depth 1 "$REPO.git" "$target_dir" >/dev/null 2>&1
    echo -e "  ${GREEN}Installed${NC} to $display_path"
    [ -n "$extra_msg" ] && echo -e "  ${YELLOW}$extra_msg${NC}"
  else
    cd "$target_dir"
    git fetch origin main --depth 1 >/dev/null 2>&1
    LOCAL=$(git rev-parse HEAD 2>/dev/null)
    REMOTE=$(git rev-parse origin/main 2>/dev/null)

    if [ "$LOCAL" != "$REMOTE" ]; then
      git reset --hard origin/main >/dev/null 2>&1
      echo -e "  ${BLUE}Updated${NC} at $display_path"
    else
      echo -e "  Already up to date at $display_path"
    fi
    cd - > /dev/null
  fi
}

# Check if agent is available
detect_claude() { command -v claude &> /dev/null; }
detect_openclaw() { command -v openclaw &> /dev/null || command -v claw &> /dev/null; }
detect_cursor() {
  [ -d "$HOME/.cursor" ] || [ -d "$HOME/Library/Application Support/Cursor" ] || [ -d "$HOME/.config/Cursor" ]
}
detect_windsurf() {
  [ -d "$HOME/.windsurf" ] || [ -d "$HOME/Library/Application Support/Windsurf" ] || [ -d "$HOME/.config/Windsurf" ]
}
detect_opencode() {
  command -v opencode &> /dev/null || [ -d "$HOME/.opencode" ] || [ -d "$HOME/.config/opencode" ]
}

# Install for specific agent
install_claude() {
  echo -e "${GREEN}→${NC} Claude Code"
  install_or_update "$HOME/.claude/plugins/neuroartist" "~/.claude/plugins/neuroartist" \
    "Run: /plugin marketplace add CroissanStudioDev/neuroartist-skill-agents"
}

install_openclaw() {
  echo -e "${GREEN}→${NC} OpenClaw"
  install_or_update "$HOME/.openclaw/skills/neuroartist" "~/.openclaw/skills/neuroartist"
}

install_cursor() {
  echo -e "${GREEN}→${NC} Cursor"
  install_or_update "$HOME/.cursor/skills/neuroartist" "~/.cursor/skills/neuroartist"
}

install_windsurf() {
  echo -e "${GREEN}→${NC} Windsurf"
  install_or_update "$HOME/.windsurf/skills/neuroartist" "~/.windsurf/skills/neuroartist"
}

install_opencode() {
  echo -e "${GREEN}→${NC} OpenCode"
  install_or_update "$HOME/.opencode/skills/neuroartist" "~/.opencode/skills/neuroartist"
}

show_help() {
  echo "🎨 neuroartist plugin installer"
  echo ""
  echo "Usage: $0 [agents...]"
  echo ""
  echo "Agents:"
  echo "  claude     Claude Code (~/.claude/plugins)"
  echo "  opencode   OpenCode (~/.opencode/skills)"
  echo "  openclaw   OpenClaw (~/.openclaw/skills)"
  echo "  cursor     Cursor (~/.cursor/skills)"
  echo "  windsurf   Windsurf (~/.windsurf/skills)"
  echo "  all        All detected agents (default)"
  echo ""
  echo "Examples:"
  echo "  $0                    # Auto-detect and install all"
  echo "  $0 claude             # Install for Claude Code only"
  echo "  $0 claude cursor      # Install for Claude Code and Cursor"
  echo ""
  echo "Via curl:"
  echo "  curl -sSL https://raw.githubusercontent.com/CroissanStudioDev/neuroartist-skill-agents/main/install.sh | bash"
  echo "  curl -sSL ... | bash -s -- claude cursor"
  exit 0
}

# Parse arguments
AGENTS=()
for arg in "$@"; do
  case "$arg" in
    -h|--help) show_help ;;
    claude|opencode|openclaw|cursor|windsurf|all) AGENTS+=("$arg") ;;
    *) echo "Unknown agent: $arg. Use -h for help."; exit 1 ;;
  esac
done

echo "🎨 neuroartist plugin installer"
echo ""

installed=0

# If no agents specified or "all" - auto-detect
if [ ${#AGENTS[@]} -eq 0 ] || [[ " ${AGENTS[*]} " =~ " all " ]]; then
  # Auto-detect mode
  if detect_claude; then
    install_claude
    installed=$((installed + 1))
  fi
  if detect_opencode; then
    install_opencode
    installed=$((installed + 1))
  fi
  if detect_openclaw; then
    install_openclaw
    installed=$((installed + 1))
  fi
  if detect_cursor; then
    install_cursor
    installed=$((installed + 1))
  fi
  if detect_windsurf; then
    install_windsurf
    installed=$((installed + 1))
  fi
else
  # Specific agents mode
  for agent in "${AGENTS[@]}"; do
    case "$agent" in
      claude)
        if detect_claude; then
          install_claude
          installed=$((installed + 1))
        else
          echo -e "${YELLOW}⚠${NC} Claude Code not found (claude CLI not in PATH)"
        fi
        ;;
      opencode)
        if detect_opencode; then
          install_opencode
          installed=$((installed + 1))
        else
          echo -e "${YELLOW}⚠${NC} OpenCode not found (opencode CLI not in PATH)"
        fi
        ;;
      openclaw)
        if detect_openclaw; then
          install_openclaw
          installed=$((installed + 1))
        else
          echo -e "${YELLOW}⚠${NC} OpenClaw not found (openclaw/claw CLI not in PATH)"
        fi
        ;;
      cursor)
        if detect_cursor; then
          install_cursor
          installed=$((installed + 1))
        else
          echo -e "${YELLOW}⚠${NC} Cursor not found (~/.cursor directory not found)"
        fi
        ;;
      windsurf)
        if detect_windsurf; then
          install_windsurf
          installed=$((installed + 1))
        else
          echo -e "${YELLOW}⚠${NC} Windsurf not found (~/.windsurf directory not found)"
        fi
        ;;
    esac
  done
fi

echo ""

if [ $installed -eq 0 ]; then
  echo -e "${YELLOW}No agents installed.${NC}"
  echo ""
  echo "Supported agents: claude, opencode, openclaw, cursor, windsurf"
  echo "Use -h for help."
  exit 1
fi

echo -e "${GREEN}✓ Done!${NC} Processed $installed agent(s)"
echo ""
echo "Restart your agent to load changes."
echo "Docs: https://neuroartist.ru/docs"
