---
name: neuroartist
description: Generate images/videos/audio via neuroartist API (1195+ models, token-optimized, RU-friendly)
triggers:
  - generate image
  - generate video
  - create image
  - flux
  - stable diffusion
  - upscale
  - remove background
  - text to image
  - image to video
  - nano banana
  - recraft
  - kling
---

# neuroartist API

**Base:** `https://skill.neuroartist.ru/api/v1`
**Auth:** `Authorization: Bearer na_live_xxx`
**Get key:** https://skill.neuroartist.ru/dashboard/tokens

## Generate (POST /generate)

```json
{"m":"MODEL_ID","i":{"prompt":"...","image_size":"square"},"s":true}
```

| Field | Description |
|-------|-------------|
| `m` | Model ID |
| `i` | Input (model-specific) |
| `s` | Sync mode (true=wait) |

**Response:** `{"id":"req_abc","url":"https://cdn.neuroartist.ru/...","ms":2100}`

**Sizes:** `square` `square_hd` `portrait_4_3` `portrait_16_9` `landscape_4_3` `landscape_16_9`

## Models

| Task | Model | Time |
|------|-------|------|
| Fast draft | `fal-ai/flux/schnell` | 2s |
| Quality | `fal-ai/flux/dev` | 10s |
| Text/infographic | `fal-ai/nano-banana-pro` | 8s |
| Vector SVG | `fal-ai/recraft/v4/text-to-vector` | 5s |
| Video | `fal-ai/kling-video/v2.5/turbo/text-to-video` | 45s |
| Upscale 4x | `fal-ai/aura-sr` | 3s |
| Remove BG | `fal-ai/birefnet` | 2s |

Full list: @references/models.md

## Platform Sizes

| Platform | Size | image_size |
|----------|------|------------|
| VK Post | 1080x1080 | `square` |
| VK Story | 1080x1920 | `portrait_16_9` |
| Instagram | 1080x1350 | `portrait_4_3` |
| YouTube | 1280x720 | `landscape_16_9` |
| Telegram | 512x512 | `square` |

Full list: @references/platforms.md

## Guides

- Text/infographics: @references/prompting-images.md
- Video prompting: @references/prompting-video.md
- Workflows: @examples/workflows.md

## Errors

| Code | Action |
|------|--------|
| 401 | Add auth header |
| 429 | Wait, retry |
| 400 | Check model ID |
