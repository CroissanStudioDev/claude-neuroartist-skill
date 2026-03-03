# neuroartist Skill

AI image/video/audio generation skill for coding assistants. 1195+ models, token-optimized, RU-friendly.

## Supported Platforms

| Platform | Status | Installation |
|----------|--------|--------------|
| Claude Code | ✅ Native | `~/.claude/skills/neuroartist` |
| Cursor | ✅ Compatible | `~/.cursor/skills/neuroartist` |
| Cline | 🔧 MCP Server | See below |
| Windsurf | 🔧 MCP Server | See below |

## Installation

### Claude Code

```bash
git clone https://github.com/CroissanStudioDev/claude-neuroartist-skill.git ~/.claude/skills/neuroartist
```

### Cursor

Cursor natively supports Claude Code skill format:

```bash
git clone https://github.com/CroissanStudioDev/claude-neuroartist-skill.git ~/.cursor/skills/neuroartist
```

Or copy from existing Claude installation:
```bash
cp -r ~/.claude/skills/neuroartist ~/.cursor/skills/
```

### Cline / Windsurf (MCP Server)

For Cline and Windsurf, use the MCP server adapter:

1. Install the MCP server:
```bash
npm install -g @anthropic/neuroartist-mcp
```

2. Add to your MCP config (`~/.cline/mcp.json` or Windsurf settings):
```json
{
  "mcpServers": {
    "neuroartist": {
      "command": "npx",
      "args": ["@anthropic/neuroartist-mcp"],
      "env": {
        "NEUROARTIST_API_KEY": "na_live_xxx"
      }
    }
  }
}
```

## Features

- **1195+ models** — FLUX, Nano Banana, Recraft, Kling, and more
- **Token-optimized** — Lazy loading via `@file` references (~300 base tokens)
- **RU platform sizes** — VK, Telegram, Instagram, YouTube
- **Prompting guides** — Nano Banana (images), Kling 2.5/3.0 (video)

## Quick Reference

| Task | Model | Speed |
|------|-------|-------|
| Fast image | `fal-ai/flux/schnell` | 2s |
| Text in image | `fal-ai/nano-banana-pro` | 8s |
| Vector/SVG | `fal-ai/recraft/v4/text-to-vector` | 5s |
| Video | `fal-ai/kling-video/v2.5/turbo/text-to-video` | 45s |

## API Usage

```bash
curl -X POST https://neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer na_live_xxx" \
  -d '{"m":"fal-ai/flux/schnell","i":{"prompt":"sunset"},"s":true}'
```

## Files

```
├── SKILL.md                    # Main skill (always loaded)
├── references/
│   ├── models.md               # Model audit
│   ├── platforms.md            # RU platform sizes
│   ├── prompting-images.md     # Nano Banana guide
│   └── prompting-video.md      # Kling guide
└── examples/
    └── workflows.md            # Workflow examples
```

## Triggers

The skill activates on:
- "generate image", "create video"
- "flux", "nano banana", "recraft", "kling"
- "upscale", "remove background"
- "для вк", "для телеграм", "для инстаграм"

## License

MIT
