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

# neuroartist API Skill

Token-optimized AI generation API with 1195+ models. Supports images, videos, vectors, and audio.

## Quick Start

```bash
curl -X POST https://neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer na_live_xxx" \
  -H "Content-Type: application/json" \
  -d '{"m":"fal-ai/flux/schnell","i":{"prompt":"sunset over mountains"},"s":true}'
```

Response: `{"id":"req_abc","url":"https://cdn.neuroartist.ru/...","ms":2100}`

## API Reference

### Auth
```
Header: Authorization: Bearer na_live_xxx
Get key: https://neuroartist.ru/dashboard/tokens
```

### Generate (POST /api/v1/generate)

**Request:**
```json
{
  "m": "fal-ai/flux/schnell",
  "i": {
    "prompt": "your prompt here",
    "image_size": "landscape_16_9"
  },
  "s": true
}
```

| Field | Type | Description |
|-------|------|-------------|
| `m` | string | Model ID (required) |
| `i` | object | Input params (model-specific) |
| `s` | boolean | Sync mode (true = wait for result) |

**Response (sync):**
```json
{"id":"req_abc","url":"https://cdn.neuroartist.ru/...","ms":2100}
```

### Image Sizes
```
square (1024x1024) | square_hd (1536x1536)
portrait_4_3 | portrait_16_9
landscape_4_3 | landscape_16_9
```

### Get Status (GET /api/v1/requests/{id})
For async requests, poll status until `status: "completed"`.

## Model Selection

### Quick Picks
| Task | Model | Speed | Cost |
|------|-------|-------|------|
| Fast draft | `fal-ai/flux/schnell` | 2s | 0.27P |
| Quality image | `fal-ai/flux/dev` | 10s | 1.35P |
| Text in image | `fal-ai/nano-banana-pro` | 8s | 13P |
| Vector/SVG | `fal-ai/recraft/v4/text-to-vector` | 5s | 7P |
| Video | `fal-ai/kling-video/v2.5/turbo/text-to-video` | 45s | 50P |
| Upscale 4x | `fal-ai/aura-sr` | 3s | 2P |
| Remove BG | `fal-ai/birefnet` | 2s | 1P |

### Full Model Reference
For detailed model audit by category see @references/models.md

## Prompting Guides

### Images (Nano Banana)
For text rendering and infographics see @references/prompting-images.md

### Video (Kling 2.5/3.0)
For video prompting with multi-shot and dialogue see @references/prompting-video.md

## Platform Sizes (RU)

For VK, Telegram, Instagram, YouTube sizes see @references/platforms.md

### Quick Reference
| Platform | Format | Size |
|----------|--------|------|
| VK Post | 1:1 | 1080x1080 |
| VK Story | 9:16 | 1080x1920 |
| Telegram Sticker | 1:1 | 512x512 |
| Instagram Feed | 4:5 | 1080x1350 |
| YouTube Thumbnail | 16:9 | 1280x720 |

## Examples

### Generate image for VK post
```json
{"m":"fal-ai/flux/schnell","i":{"prompt":"cozy cafe interior","image_size":"square"},"s":true}
```

### Generate video with Kling
```json
{"m":"fal-ai/kling-video/v2.5/turbo/text-to-video","i":{"prompt":"Tracking shot of a cat walking through a sunlit garden"},"s":false}
```

### Generate SVG logo
```json
{"m":"fal-ai/recraft/v4/text-to-vector","i":{"prompt":"minimalist geometric logo letter N, navy blue on white"},"s":true}
```

### Upscale image 4x
```json
{"m":"fal-ai/aura-sr","i":{"image_url":"https://..."},"s":true}
```

For more workflow examples see @examples/workflows.md

## Error Handling

| Status | Code | Action |
|--------|------|--------|
| 401 | `no key` | Add Authorization header |
| 429 | `RATE_LIMIT_EXCEEDED` | Wait and retry |
| 400 | `invalid model` | Check model ID |
