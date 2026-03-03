# Models

## Image Generation

### Nano Banana (best for text)
| Model | Speed | Use |
|-------|-------|-----|
| `fal-ai/nano-banana-2` | 3s | Fast, good text |
| `fal-ai/nano-banana-pro` | 8s | 4K, perfect text |
| `fal-ai/gemini-25-flash-image` | 2s | Quick iterations |

**Features:** 94% text accuracy, multi-image (14 refs), character consistency, 4K

### FLUX (universal)
| Model | Speed | Use |
|-------|-------|-----|
| `fal-ai/flux/schnell` | 2s | Drafts |
| `fal-ai/flux/dev` | 10s | Final images |
| `fal-ai/flux-pro/v1.1` | 15s | Professional |
| `fal-ai/flux-pro/v1.1-ultra` | 20s | 4MP high-res |
| `fal-ai/flux/dev/image-to-image` | 12s | Style transfer |

### Recraft V4 (design/vector)
| Model | Output | Use |
|-------|--------|-----|
| `fal-ai/recraft/v4` | Raster | Marketing |
| `fal-ai/recraft/v4/text-to-vector` | SVG | Logos, icons |
| `fal-ai/recraft/v4/pro/text-to-vector` | SVG HD | Complex vector |

**SVG:** Native paths (not tracing), palette control via `colors:[{r,g,b}]`

## Video

### Kling (best control)
| Model | Duration | Speed |
|-------|----------|-------|
| `fal-ai/kling-video/v2.5/turbo/text-to-video` | 5s | 45s |
| `fal-ai/kling-video/v3/text-to-video` | 15s | 90s |
| `fal-ai/kling-video/v2.5/turbo/image-to-video` | 5s | 30s |

**Kling 3.0:** 4K/60fps, multi-shot (6), dialogue, audio

### Other Video
| Model | Duration | Speed |
|-------|----------|-------|
| `fal-ai/minimax-video/video-01` | 6s | 60s |
| `fal-ai/hunyuan-video` | 5s | 120s |
| `fal-ai/luma-dream-machine` | 5s | 45s |
| `fal-ai/runway-gen3/turbo/image-to-video` | 5s | 30s |

## Processing

| Model | Use | Speed |
|-------|-----|-------|
| `fal-ai/aura-sr` | Upscale 4x | 3s |
| `fal-ai/clarity-upscaler` | Upscale+enhance | 5s |
| `fal-ai/birefnet` | Remove BG | 2s |
| `fal-ai/imageutils/rembg` | Remove BG (fast) | 1s |

## Selection Guide

```
Text/infographics → nano-banana-pro
Vector (SVG) → recraft/v4/text-to-vector
Quick draft → flux/schnell
Quality photo → flux/dev or flux-pro
Video → kling-video/v2.5 or v3
Upscale → aura-sr
Remove BG → birefnet
```
