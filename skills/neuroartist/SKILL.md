---
name: neuroartist
description: "Generate images/videos/audio with 1195+ AI models. Works in Russia (CDN proxy for blocked GCS). Token-optimized API with RU social media sizes (VK, Telegram, Instagram)."
version: 1.4.0
origin: skill.neuroartist.ru
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
  - для вк
  - для телеграм
  - сгенерируй
  - создай картинку
  - text to speech
  - tts
  - озвучь
  - transcribe
  - транскрибируй
  - whisper
---

# neuroartist API

**Works in Russia** — results delivered via our CDN (fal.ai uses blocked Google Cloud Storage).

**Base:** `https://skill.neuroartist.ru/api/v1`
**Auth:** `Authorization: Bearer na_live_xxx`
**Get key:** https://skill.neuroartist.ru/dashboard/tokens

## When to Use

- Generate images, videos, audio, or SVG
- User needs Russian social media sizes (VK, Telegram)
- User's results must be accessible in Russia
- User mentions FLUX, Kling, Nano Banana, Recraft

## Quick Start

### TypeScript
```typescript
const res = await fetch('https://skill.neuroartist.ru/api/v1/generate', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${process.env.NEUROARTIST_KEY}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    m: 'fal-ai/flux/schnell',
    i: { prompt: 'sunset over mountains', image_size: 'landscape_16_9' },
    s: true
  })
});
const { url } = await res.json();
```

### Python
```python
import requests

res = requests.post(
    'https://skill.neuroartist.ru/api/v1/generate',
    headers={'Authorization': f'Bearer {API_KEY}'},
    json={'m': 'fal-ai/flux/schnell', 'i': {'prompt': 'sunset'}, 's': True}
)
print(res.json()['url'])
```

### curl
```bash
curl -X POST https://skill.neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"m":"fal-ai/flux/schnell","i":{"prompt":"sunset"},"s":true}'
```

## CLI Commands

Scripts in `scripts/` directory for quick automation:

### Setup
```bash
export NEUROARTIST_KEY=na_live_xxx
./scripts/setup.sh
```
Validates API key, shows balance and tier.

### Search Models
```bash
./scripts/search.sh image    # Image generation models
./scripts/search.sh video    # Video models (Kling, MiniMax)
./scripts/search.sh audio    # TTS/STT models
./scripts/search.sh flux     # FLUX family
./scripts/search.sh kling    # Kling video family
```

### Generate
```bash
./scripts/generate.sh "sunset over mountains"
./scripts/generate.sh "cat portrait" fal-ai/flux/dev portrait_4_3
./scripts/generate.sh "logo NEXUS" fal-ai/recraft/v4/text-to-vector
```

### Balance
```bash
./scripts/balance.sh
```
Shows balance, tier, and estimated generations.

### Upscale
```bash
./scripts/upscale.sh https://example.com/photo.jpg
./scripts/upscale.sh https://example.com/photo.jpg fal-ai/clarity-upscaler
```
Upscales images 4x. Models: `aura-sr` (~2₽), `clarity-upscaler` (~3₽).

### Remove Background
```bash
./scripts/rembg.sh https://example.com/product.jpg
./scripts/rembg.sh https://example.com/photo.jpg fal-ai/imageutils/rembg
```
Removes background from images. Models: `birefnet` (~1₽), `rembg` (~0.5₽).

### Text-to-Speech
```bash
./scripts/tts.sh "Hello, this is a test."
./scripts/tts.sh "Clone my voice" https://example.com/voice.mp3 "Transcript"
```
TTS with optional voice cloning. Model: `f5-tts` (~2₽).

### Speech-to-Text
```bash
./scripts/stt.sh https://example.com/recording.mp3
./scripts/stt.sh https://example.com/podcast.mp3 fal-ai/wizper
```
Transcribes audio. Models: `whisper` (~1₽), `wizper` (~1.5₽).

## Generate (POST /generate)

```json
{"m":"MODEL_ID","i":{"prompt":"...","image_size":"square"},"s":true}
```

| Field | Description |
|-------|-------------|
| `m` | Model ID (required) |
| `i` | Input params (model-specific) |
| `s` | `true` = sync (wait for result), `false` = async (returns request_id) |

**Sync response:** `{"id":"req_abc","url":"https://skill.neuroartist.ru/api/media/...","ms":2100}`

**Async response:** `{"id":"req_abc"}` — then poll or stream status.

**Sizes:** `square` `square_hd` `portrait_4_3` `portrait_16_9` `landscape_4_3` `landscape_16_9`

## Upload (POST /upload)

Upload images for image-to-image, upscaling, or video generation:

```bash
# Upload file
curl -X POST https://skill.neuroartist.ru/api/v1/upload \
  -H "Authorization: Bearer $TOKEN" \
  -F "file=@image.png"

# Response
{"url":"https://skill.neuroartist.ru/api/media/uploads/...","key":"uploads/..."}
```

Use the returned `url` in `image_url` parameters.

## Balance (GET /balance)

```bash
curl https://skill.neuroartist.ru/api/v1/balance \
  -H "Authorization: Bearer $TOKEN"

# Response
{"balance_kopecks":10000,"balance_rub":100.00,"tier":2}
```

## Status Polling (GET /requests/{id})

For async requests (`s:false`):

```bash
# Poll status
curl https://skill.neuroartist.ru/api/v1/requests/req_abc \
  -H "Authorization: Bearer $TOKEN"

# Response
{"id":"req_abc","status":"completed","url":"...","ms":2100}
```

**Statuses:** `queued` → `processing` → `completed` | `failed`

## Streaming (GET /requests/{id}/stream)

Real-time SSE updates for long operations (video):

```typescript
const events = new EventSource(
  `https://skill.neuroartist.ru/api/v1/requests/${id}/stream`,
  { headers: { Authorization: `Bearer ${token}` } }
);
events.onmessage = (e) => {
  const data = JSON.parse(e.data);
  if (data.status === 'completed') console.log(data.url);
};
```

## Models

| Task | Model | Time | Cost |
|------|-------|------|------|
| Fast draft | `fal-ai/flux/schnell` | 2s | ~0.3₽ |
| Quality | `fal-ai/flux/dev` | 10s | ~1.4₽ |
| Text/infographic | `fal-ai/nano-banana-pro` | 8s | ~13₽ |
| Vector SVG | `fal-ai/recraft/v4/text-to-vector` | 5s | ~7₽ |
| Video 5s | `fal-ai/kling-video/v2.5/turbo/text-to-video` | 45s | ~50₽ |
| Upscale 4x | `fal-ai/aura-sr` | 3s | ~2₽ |
| Remove BG | `fal-ai/birefnet` | 2s | ~1₽ |
| TTS | `fal-ai/f5-tts` | 3s | ~2₽ |

Full list with all categories: @references/models.md

## Platform Sizes (RU)

| Platform | Size | image_size |
|----------|------|------------|
| VK Post | 1080x1080 | `square` |
| VK Story | 1080x1920 | `portrait_16_9` |
| VK Cover | 1920x768 | custom* |
| Instagram | 1080x1350 | `portrait_4_3` |
| YouTube | 1280x720 | `landscape_16_9` |
| Telegram Sticker | 512x512 | `square` |

*Custom sizes: generate with `landscape_16_9` then resize locally.

Full list: @references/platforms.md

## Guides

- Prompting for text/infographics: @references/prompting-images.md
- Video prompting (Kling): @references/prompting-video.md
- Multi-step workflows: @examples/workflows.md

## Troubleshooting

### 401 Unauthorized
```
{"e":"no key"} or {"e":"invalid key"}
```
**Fix:** Add `Authorization: Bearer na_live_xxx` header. Get key at https://skill.neuroartist.ru/dashboard/tokens

### 402 Insufficient Balance
```
{"e":"insufficient balance","cost":13}
```
**Fix:** Top up at https://skill.neuroartist.ru/dashboard/billing. Cost shown in rubles.

### 429 Rate Limited
```
{"e":"rate limit","reset":30}
```
**Fix:** Wait `reset` seconds, then retry. Tier upgrades increase limits.

### 400 Bad Request
```
{"e":"unknown model"} or {"e":"missing input"}
```
**Fix:** Check model ID exists. Verify required params (usually `prompt`).

### 500 Generation Failed
```
{"e":"generation failed"}
```
**Fix:** Retry once. If persists, try different model or simplify prompt.

### Timeout (video)
Video generation can take 60-120s. Use `s:false` (async) and poll/stream status.
