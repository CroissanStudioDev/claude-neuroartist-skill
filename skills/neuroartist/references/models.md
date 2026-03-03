# Model Audit

Complete model reference for neuroartist API. Updated March 2026.

## Nano Banana Family (Google Gemini)

Best for: text rendering, infographics, multi-image composition.

| Model | Speed | Quality | Cost | Best For |
|-------|-------|---------|------|----------|
| `fal-ai/nano-banana-2` | 3s | Excellent | ~7P | Fast generation, good text |
| `fal-ai/nano-banana-pro` | 8s | Best | ~13P | 4K, perfect text, infographics |
| `fal-ai/gemini-25-flash-image` | 2s | Good | ~4P | Quick iterations |

**Advantages:**
- 94% text accuracy (vs 60% for FLUX)
- Multi-image: up to 14 references in one request
- Character consistency across generations
- Search Grounding: real-time data from Google Search
- Native 4K resolution

**Best prompting:** Natural language, detailed descriptions. See @prompting-images.md

## FLUX Family (Black Forest Labs)

Best for: universal image generation, fast iterations, photorealism.

| Model | Speed | Quality | Cost | Best For |
|-------|-------|---------|------|----------|
| `fal-ai/flux/schnell` | 2s | Good | 0.27P | Drafts, quick iterations |
| `fal-ai/flux/dev` | 10s | High | 1.35P | Final images |
| `fal-ai/flux-pro/v1.1` | 15s | Best | 5P | Professional content |
| `fal-ai/flux-pro/v1.1-ultra` | 20s | Best | 8P | High-res (4MP) |

**Variants:**
- `fal-ai/flux/dev/image-to-image` - style transfer
- `fal-ai/flux-lora` - with custom LoRA weights

## Recraft V4 Family

Best for: professional design, marketing, vector graphics.

| Model | Output | Cost | Best For |
|-------|--------|------|----------|
| `fal-ai/recraft/v4` | Raster | ~4P | Design content, marketing |
| `fal-ai/recraft/v4/pro` | Raster HD | ~22P | Print, high resolution |
| `fal-ai/recraft/v4/text-to-vector` | SVG | ~7P | Logos, icons, illustrations |
| `fal-ai/recraft/v4/pro/text-to-vector` | SVG HD | ~25P | Complex vector graphics |

**Advantages:**
- **Native SVG** - real paths and geometry, not raster tracing
- **Design Taste** - intentional composition, lighting, color relationships
- **Palette Control** - exact RGB colors in request
- **Ready to use** - opens in Figma/Illustrator/Sketch

**SVG Example:**
```json
{
  "m": "fal-ai/recraft/v4/text-to-vector",
  "i": {
    "prompt": "minimalist geometric logo letter M, two peaks forming the letter, navy blue #1a365d on white background",
    "colors": [{"r": 26, "g": 54, "b": 93}]
  }
}
```

## Kling Family (Kuaishou)

Best for: video generation with precise control.

| Model | Duration | Speed | Quality | Notes |
|-------|----------|-------|---------|-------|
| `fal-ai/kling-video/v2.5/turbo/text-to-video` | 5s | 45s | High | Start/End Frame |
| `fal-ai/kling-video/v3/text-to-video` | 15s | 90s | Best | 4K/60fps, multi-shot, dialogue |
| `fal-ai/kling-video/v1/standard/image-to-video` | 5s | 60s | High | Product animation |
| `fal-ai/kling-video/v2.5/turbo/image-to-video` | 5s | 30s | High | Fast i2v |

**Kling 3.0 Features:**
- Native 4K/60fps output
- 15-second videos
- Multi-shot sequences (up to 6 shots)
- Native audio with dialogue
- Character consistency

See @prompting-video.md for detailed prompting guide.

## Other Video Models

| Model | Duration | Speed | Quality | Best For |
|-------|----------|-------|---------|----------|
| `fal-ai/minimax-video/video-01` | 6s | 60s | Good | General video |
| `fal-ai/hunyuan-video` | 5s | 120s | Best | Highest quality |
| `fal-ai/luma-dream-machine` | 5s | 45s | Good | Cinematic |
| `fal-ai/runway-gen3/turbo/image-to-video` | 5s | 30s | High | Fast i2v |

## Image Processing

| Model | Use Case | Speed | Notes |
|-------|----------|-------|-------|
| `fal-ai/aura-sr` | Upscale 4x | 3s | Best quality |
| `fal-ai/clarity-upscaler` | Upscale + enhance | 5s | Adds detail |
| `fal-ai/birefnet` | Remove background | 2s | Best accuracy |
| `fal-ai/imageutils/rembg` | Remove BG | 1s | Fastest |

## Specialized Models

| Model | Use Case | Speed | Notes |
|-------|----------|-------|-------|
| `fal-ai/ideogram/v2` | Text in images | 12s | Alternative to Nano Banana |
| `fal-ai/recraft-v3` | Vector design | 8s | Legacy, use V4 |
| `fal-ai/stable-diffusion-v3-medium` | SD3 | 8s | Open source |

## Model Selection Guide

```
Need text/infographics? -> Nano Banana Pro
Need vector (SVG)? -> Recraft V4 Text-to-Vector
Logo/icons? -> Recraft V4 Vector
Quick draft? -> FLUX Schnell or Nano Banana 2
High quality photo? -> FLUX Pro or Nano Banana Pro
Marketing design? -> Recraft V4
Video with control? -> Kling 2.5/3.0
Video fast? -> MiniMax or Luma
Upscale? -> Aura SR
Remove background? -> BiRefNet
```

## Pricing Notes

- P = Russian rubles (approximately)
- Prices include platform markup
- Actual cost may vary by resolution and options
- Check /api/v1/models for current pricing
