# Models

Full model catalog with pricing. All prices in Russian rubles (₽).

## Image Generation

### Nano Banana (best for text)
| Model | Speed | Cost | Use |
|-------|-------|------|-----|
| `fal-ai/nano-banana-2` | 3s | ~7₽ | Fast, good text |
| `fal-ai/nano-banana-pro` | 8s | ~13₽ | 4K, perfect text |
| `fal-ai/gemini-25-flash-image` | 2s | ~4₽ | Quick iterations |

**Features:** 94% text accuracy, multi-image (14 refs), character consistency, 4K

### FLUX (universal)
| Model | Speed | Cost | Use |
|-------|-------|------|-----|
| `fal-ai/flux/schnell` | 2s | ~0.3₽ | Drafts |
| `fal-ai/flux/dev` | 10s | ~1.4₽ | Final images |
| `fal-ai/flux-pro/v1.1` | 15s | ~5₽ | Professional |
| `fal-ai/flux-pro/v1.1-ultra` | 20s | ~8₽ | 4MP high-res |
| `fal-ai/flux/dev/image-to-image` | 12s | ~1.5₽ | Style transfer |

### Recraft V4 (design/vector)
| Model | Output | Cost | Use |
|-------|--------|------|-----|
| `fal-ai/recraft/v4` | Raster | ~4₽ | Marketing |
| `fal-ai/recraft/v4/text-to-vector` | SVG | ~7₽ | Logos, icons |
| `fal-ai/recraft/v4/pro` | Raster HD | ~22₽ | Print quality |
| `fal-ai/recraft/v4/pro/text-to-vector` | SVG HD | ~25₽ | Complex vector |

**SVG:** Native paths (not tracing), palette control via `colors:[{r,g,b}]`

## Video

### Kling (best control)
| Model | Duration | Speed | Cost |
|-------|----------|-------|------|
| `fal-ai/kling-video/v2.5/turbo/text-to-video` | 5s | 45s | ~50₽ |
| `fal-ai/kling-video/v3/text-to-video` | 15s | 90s | ~150₽ |
| `fal-ai/kling-video/v2.5/turbo/image-to-video` | 5s | 30s | ~40₽ |

**Kling 3.0:** 4K/60fps, multi-shot (6), dialogue, audio

### Other Video
| Model | Duration | Speed | Cost |
|-------|----------|-------|------|
| `fal-ai/minimax-video/video-01` | 6s | 60s | ~30₽ |
| `fal-ai/hunyuan-video` | 5s | 120s | ~25₽ |
| `fal-ai/luma-dream-machine` | 5s | 45s | ~35₽ |
| `fal-ai/runway-gen3/turbo/image-to-video` | 5s | 30s | ~45₽ |

## Audio

### Text-to-Speech (TTS)
| Model | Speed | Cost | Use |
|-------|-------|------|-----|
| `fal-ai/f5-tts` | 3s | ~2₽ | Voice cloning, natural speech |
| `fal-ai/playai/tts/v3` | 2s | ~3₽ | High-quality voices |
| `fal-ai/metavoice-v1` | 4s | ~2₽ | Multi-language |

**F5-TTS:** Upload reference audio (10-30s) for voice cloning:
```json
{"m":"fal-ai/f5-tts","i":{"gen_text":"Hello world","ref_audio_url":"https://...","ref_text":"Reference transcript"}}
```

### Speech-to-Text (STT)
| Model | Speed | Cost | Use |
|-------|-------|------|-----|
| `fal-ai/whisper` | 5s | ~1₽ | Transcription |
| `fal-ai/wizper` | 3s | ~1.5₽ | Fast transcription |

## Processing

| Model | Use | Speed | Cost |
|-------|-----|-------|------|
| `fal-ai/aura-sr` | Upscale 4x | 3s | ~2₽ |
| `fal-ai/clarity-upscaler` | Upscale+enhance | 5s | ~3₽ |
| `fal-ai/birefnet` | Remove BG | 2s | ~1₽ |
| `fal-ai/imageutils/rembg` | Remove BG (fast) | 1s | ~0.5₽ |
| `fal-ai/face-swap` | Face swap | 3s | ~2₽ |
| `fal-ai/controlnet-tile-upscaler` | Upscale+detail | 8s | ~4₽ |

## Selection Guide

```
Text/infographics → nano-banana-pro (~13₽)
Vector (SVG) → recraft/v4/text-to-vector (~7₽)
Quick draft → flux/schnell (~0.3₽)
Quality photo → flux/dev (~1.4₽)
Professional → flux-pro/v1.1 (~5₽)
Video 5s → kling-video/v2.5 (~50₽)
Video 15s → kling-video/v3 (~150₽)
TTS → f5-tts (~2₽)
STT → whisper (~1₽)
Upscale → aura-sr (~2₽)
Remove BG → birefnet (~1₽)
```

## Cost Estimation

| Task | Model | Est. Cost |
|------|-------|-----------|
| 10 drafts | flux/schnell | ~3₽ |
| 5 final images | flux/dev | ~7₽ |
| Logo + 3 variants | recraft/v4/text-to-vector | ~28₽ |
| Marketing pack (10 images) | nano-banana-pro | ~130₽ |
| Promo video 5s | kling-video/v2.5 | ~50₽ |
| Voice-over 1 min | f5-tts | ~8₽ |
