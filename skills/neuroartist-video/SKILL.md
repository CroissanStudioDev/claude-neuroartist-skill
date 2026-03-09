---
name: neuroartist-video
description: "Video generation with Kling, MiniMax, Luma, Hunyuan. Text-to-video, image-to-video. Works in Russia (CDN proxy)."
version: 1.0.0
origin: skill.neuroartist.ru
triggers:
  - generate video
  - create video
  - kling
  - minimax
  - luma
  - hunyuan
  - text to video
  - image to video
  - сгенерируй видео
  - создай видео
  - анимируй
---

# neuroartist Video API

**Specialized for video generation.** For images use `neuroartist-image`, for audio use `neuroartist-audio`.

**Base:** `https://skill.neuroartist.ru/api/v1`
**Auth:** `Authorization: Bearer na_live_xxx`
**Get key:** https://skill.neuroartist.ru/dashboard/tokens

## Quick Generate

Video generation is async (takes 30-120s). Use `s:false` and poll/stream status.

```bash
# 1. Submit
curl -X POST https://skill.neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"m":"fal-ai/kling-video/v2.5/turbo/text-to-video","i":{"prompt":"Aerial shot of mountains at dawn"},"s":false}'

# Response: {"id":"req_abc"}

# 2. Poll status
curl https://skill.neuroartist.ru/api/v1/requests/req_abc -H "Authorization: Bearer $TOKEN"

# Response: {"id":"req_abc","status":"completed","url":"...","ms":45000}
```

## Models

### Kling (Best Control)

| Model | Duration | Time | Cost |
|-------|----------|------|------|
| `fal-ai/kling-video/v2.5/turbo/text-to-video` | 5s | 45s | ~50₽ |
| `fal-ai/kling-video/v3/text-to-video` | 15s | 90s | ~150₽ |
| `fal-ai/kling-video/v2.5/turbo/image-to-video` | 5s | 30s | ~40₽ |

**Kling 3.0 features:** 4K/60fps, multi-shot (6 shots), dialogue, audio sync

### Other Models

| Model | Duration | Time | Cost |
|-------|----------|------|------|
| `fal-ai/minimax-video/video-01` | 6s | 60s | ~30₽ |
| `fal-ai/hunyuan-video` | 5s | 120s | ~25₽ |
| `fal-ai/luma-dream-machine` | 5s | 45s | ~35₽ |
| `fal-ai/runway-gen3/turbo/image-to-video` | 5s | 30s | ~45₽ |

## Prompting Guide

**Think like a director, not a photographer.**

### Formula
```
[Camera movement] + [Subject action] + [Environment] + [Lighting] + [Mood]
```

### Camera Types
- `tracking shot` — follows subject
- `dolly in/out` — approach/retreat
- `crane shot` — camera rises
- `POV shot` — first person
- `handheld` — shaky cam effect
- `static shot` — stationary
- `slow push in` — gradual zoom

### Examples

**Bad:** "человек идёт по улице"

**Good:** "Tracking shot following a man in a long coat walking down a rain-slicked Tokyo alley at night, neon signs reflecting in puddles, camera slowly pulls back to reveal towering buildings"

**Bad:** "кошка на диване"

**Good:** "Close-up of a tabby cat slowly opening its eyes, stretching on a sunlit velvet couch, dust particles floating in golden afternoon light, camera gently drifts closer"

### Kling 3.0 Multi-Shot

```json
{
  "m": "fal-ai/kling-video/v3/text-to-video",
  "i": {
    "prompt": "Shot 1: Wide establishing shot of misty mountain lake at dawn. Shot 2: Medium shot of lone figure at water's edge. Shot 3: Close-up of hands releasing a paper boat. Shot 4: Tracking shot following boat drifting away.",
    "duration": 12
  },
  "s": false
}
```

### Kling 3.0 with Dialogue

```json
{
  "m": "fal-ai/kling-video/v3/text-to-video",
  "i": {
    "prompt": "Two friends at a coffee shop. Shot 1: Medium two-shot, they laugh together. Woman says 'Remember that trip to Paris?' Shot 2: Close-up of man smiling, he replies 'How could I forget?' Natural warm lighting.",
    "duration": 8
  },
  "s": false
}
```

## Image-to-Video

**Only describe motion, not what's in the image!**

```json
{
  "m": "fal-ai/kling-video/v2.5/turbo/image-to-video",
  "i": {
    "image_url": "https://...",
    "prompt": "She slowly turns her head to the left, a gentle breeze moves her hair, petals drift past in the wind"
  },
  "s": false
}
```

## SSE Streaming

For real-time progress updates:

```typescript
const events = new EventSource(
  `https://skill.neuroartist.ru/api/v1/requests/${id}/stream`,
  { headers: { Authorization: `Bearer ${token}` } }
);

events.onmessage = (e) => {
  const data = JSON.parse(e.data);
  console.log(`Status: ${data.status}, Progress: ${data.progress}%`);
  if (data.status === 'completed') {
    console.log('Video URL:', data.url);
    events.close();
  }
};
```

## Selection Guide

```
Quick video?         → minimax (~30₽, 60s)
Best control?        → kling-video/v2.5 (~50₽, 45s)
Multi-shot/dialogue? → kling-video/v3 (~150₽, 90s)
From image?          → kling-video/v2.5/image-to-video (~40₽)
Best quality?        → hunyuan-video (~25₽, 120s)
```
