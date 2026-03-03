# neuroartist Plugin

AI image/video/audio generation plugin for coding assistants. 1195+ models, token-optimized, RU-friendly.

## Supported Platforms

| Platform | Status | Native Install |
|----------|--------|----------------|
| Claude Code | ✅ Plugin | `/plugin marketplace add` |
| OpenCode | ✅ Compatible | git clone |
| Cursor | ✅ Compatible | git clone |
| Windsurf | ✅ Compatible | git clone |
| OpenClaw | ✅ CLI | `openclaw skills install` |

## Quick Install

```bash
curl -sSL https://raw.githubusercontent.com/CroissanStudioDev/neuroartist-skill-agents/main/install.sh | bash
```

The script auto-detects installed AI agents and installs for each.

## Installation

### Claude Code (recommended)

**Via plugin system:**
```bash
# 1. Add marketplace (one time)
/plugin marketplace add CroissanStudioDev/neuroartist-skill-agents

# 2. Install plugin
/plugin install neuroartist@CroissanStudioDev-neuroartist-skill-agents
```

**Manual:**
```bash
git clone https://github.com/CroissanStudioDev/neuroartist-skill-agents.git ~/.claude/plugins/neuroartist
```

### OpenClaw

**CLI (recommended):**
```bash
openclaw skills install github:CroissanStudioDev/neuroartist-skill-agents
# or shorter
claw install github:CroissanStudioDev/neuroartist-skill-agents
```

**Manual:**
```bash
git clone https://github.com/CroissanStudioDev/neuroartist-skill-agents.git ~/.openclaw/skills/neuroartist
```

### Cursor

```bash
git clone https://github.com/CroissanStudioDev/neuroartist-skill-agents.git ~/.cursor/skills/neuroartist
```

### OpenCode

```bash
git clone https://github.com/CroissanStudioDev/neuroartist-skill-agents.git ~/.opencode/skills/neuroartist
```

### Windsurf

```bash
git clone https://github.com/CroissanStudioDev/neuroartist-skill-agents.git ~/.windsurf/skills/neuroartist
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
├── install.sh                  # Universal installer
├── .claude-plugin/
│   └── plugin.json             # Plugin manifest
└── skills/
    └── neuroartist/
        ├── SKILL.md            # Main skill
        ├── references/
        │   ├── models.md       # Model audit
        │   ├── platforms.md    # RU platform sizes
        │   ├── prompting-images.md
        │   └── prompting-video.md
        └── examples/
            └── workflows.md
```

## Triggers

The skill activates on:
- "generate image", "create video"
- "flux", "nano banana", "recraft", "kling"
- "upscale", "remove background"
- "для вк", "для телеграм", "для инстаграм"

## License

GPL v3 - форки должны оставаться открытыми.
