# Workflows

## Image Pipelines

### Generate + Upscale
```json
{"m":"fal-ai/flux/dev","i":{"prompt":"portrait, studio lighting"},"s":true}
→ {"m":"fal-ai/aura-sr","i":{"image_url":"RESULT_URL"},"s":true}
```

### Generate + Remove BG
```json
{"m":"fal-ai/flux/schnell","i":{"prompt":"sneaker on white"},"s":true}
→ {"m":"fal-ai/birefnet","i":{"image_url":"RESULT_URL"},"s":true}
```

### Draft → Refine → Final
```
schnell (draft) → dev (refine) → flux-pro/v1.1 (final)
```

## Video Pipelines

### Image to Video
```json
{"m":"fal-ai/flux/dev","i":{"prompt":"woman portrait"},"s":true}
→ {"m":"fal-ai/kling-video/v2.5/turbo/image-to-video","i":{"image_url":"RESULT_URL","prompt":"She smiles, blinks"},"s":false}
```

### Multi-Shot (Kling 3.0)
```json
{"m":"fal-ai/kling-video/v3/text-to-video","i":{"prompt":"Shot 1: Wide cafe at dawn. Shot 2: Barista preparing espresso. Shot 3: Close-up coffee pour. Shot 4: Customer enters.","duration":12},"s":false}
```

## Design

### Vector Logo (SVG)
```json
{"m":"fal-ai/recraft/v4/text-to-vector","i":{"prompt":"minimalist logo NEXUS, letter N, diagonal lines","colors":[{"r":26,"g":54,"b":93}]},"s":true}
```

### Social Media Pack
| Platform | image_size |
|----------|------------|
| VK Post | `square` |
| Instagram | `portrait_4_3` |
| YouTube | `landscape_16_9` |
| Story | `portrait_16_9` |

### Infographic
```json
{"m":"fal-ai/nano-banana-pro","i":{"prompt":"Infographic '5 Steps to Better Sleep', numbered circles 1-5 with icons, blue-purple gradient, flat design"},"s":true}
```

## Patterns

### Batch (parallel)
```bash
for i in {1..5}; do
  curl -X POST .../generate -d '{"m":"...","i":{...},"s":false}'
done
```

### A/B Test
Same prompt → `flux/dev`, `nano-banana-2`, `recraft/v4` → compare

### Poll Async
```bash
while status != "completed"; do
  GET /api/v1/requests/$ID → check status
  sleep 5
done
```

## Error Handling

| Code | Action |
|------|--------|
| 429 | Wait `reset` seconds, retry |
| 400 | Check model/params |
| 401 | Check auth header |
