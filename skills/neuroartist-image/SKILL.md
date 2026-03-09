---
name: neuroartist-image
description: "Image generation with FLUX, Nano Banana, Recraft. Upscale, remove BG, style transfer. Works in Russia (CDN proxy)."
version: 1.0.0
origin: skill.neuroartist.ru
triggers:
  - generate image
  - create image
  - flux
  - stable diffusion
  - nano banana
  - recraft
  - upscale
  - remove background
  - text to image
  - image to image
  - для вк
  - для телеграм
  - сгенерируй картинку
  - создай изображение
  - убери фон
  - увеличь разрешение
---

# neuroartist Image API

**Specialized for image generation.** For video use `neuroartist-video`, for audio use `neuroartist-audio`.

**Base:** `https://skill.neuroartist.ru/api/v1`
**Auth:** `Authorization: Bearer na_live_xxx`
**Get key:** https://skill.neuroartist.ru/dashboard/tokens

## Quick Generate

```bash
curl -X POST https://skill.neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"m":"fal-ai/flux/schnell","i":{"prompt":"sunset over mountains","image_size":"landscape_16_9"},"s":true}'
```

**Response:** `{"id":"req_abc","url":"https://skill.neuroartist.ru/api/media/...","ms":2100}`

## Models

### Text-to-Image

| Model | Speed | Cost | Best For |
|-------|-------|------|----------|
| `fal-ai/flux/schnell` | 2s | ~0.3₽ | Fast drafts |
| `fal-ai/flux/dev` | 10s | ~1.4₽ | Quality images |
| `fal-ai/flux-pro/v1.1` | 15s | ~5₽ | Professional |
| `fal-ai/flux-pro/v1.1-ultra` | 20s | ~8₽ | 4MP high-res |
| `fal-ai/nano-banana-2` | 3s | ~7₽ | Good text |
| `fal-ai/nano-banana-pro` | 8s | ~13₽ | Perfect text, 4K |
| `fal-ai/recraft/v4` | 5s | ~4₽ | Marketing design |

### Vector (SVG)

| Model | Speed | Cost | Best For |
|-------|-------|------|----------|
| `fal-ai/recraft/v4/text-to-vector` | 5s | ~7₽ | Logos, icons |
| `fal-ai/recraft/v4/pro/text-to-vector` | 8s | ~25₽ | Complex vector |

**SVG with colors:**
```json
{"m":"fal-ai/recraft/v4/text-to-vector","i":{"prompt":"logo NEXUS","colors":[{"r":26,"g":54,"b":93}]},"s":true}
```

### Processing

| Model | Use | Speed | Cost |
|-------|-----|-------|------|
| `fal-ai/aura-sr` | Upscale 4x | 3s | ~2₽ |
| `fal-ai/clarity-upscaler` | Upscale+enhance | 5s | ~3₽ |
| `fal-ai/birefnet` | Remove BG | 2s | ~1₽ |
| `fal-ai/imageutils/rembg` | Remove BG (fast) | 1s | ~0.5₽ |
| `fal-ai/flux/dev/image-to-image` | Style transfer | 12s | ~1.5₽ |
| `fal-ai/face-swap` | Face swap | 3s | ~2₽ |

## Image Sizes

```
square (1024×1024) | square_hd (1536×1536)
portrait_4_3 | portrait_16_9
landscape_4_3 | landscape_16_9
```

## Platform Sizes (RU)

| Platform | Size | image_size |
|----------|------|------------|
| VK Post | 1080x1080 | `square` |
| VK Story | 1080x1920 | `portrait_16_9` |
| VK Cover | 1920x768 | custom* |
| Instagram Feed | 1080x1350 | `portrait_4_3` |
| YouTube Thumbnail | 1280x720 | `landscape_16_9` |
| Telegram Sticker | 512x512 | `square` |

## Workflows

### Generate + Upscale
```
1. {"m":"fal-ai/flux/dev","i":{"prompt":"portrait"},"s":true}
2. {"m":"fal-ai/aura-sr","i":{"image_url":"RESULT_URL"},"s":true}
```

### Generate + Remove BG
```
1. {"m":"fal-ai/flux/schnell","i":{"prompt":"sneaker"},"s":true}
2. {"m":"fal-ai/birefnet","i":{"image_url":"RESULT_URL"},"s":true}
```

### Upload + Style Transfer
```bash
# 1. Upload
curl -X POST .../upload -F "file=@photo.jpg"
# → {"url":"..."}

# 2. Style transfer
{"m":"fal-ai/flux/dev/image-to-image","i":{"image_url":"UPLOAD_URL","prompt":"oil painting"},"s":true}
```

## Selection Guide

```
Text/infographics? → nano-banana-pro (~13₽)
Vector (SVG)?      → recraft/v4/text-to-vector (~7₽)
Quick draft?       → flux/schnell (~0.3₽)
Quality photo?     → flux/dev (~1.4₽)
Professional?      → flux-pro/v1.1 (~5₽)
Upscale?           → aura-sr (~2₽)
Remove BG?         → birefnet (~1₽)
```
