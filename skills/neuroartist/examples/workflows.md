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

## Audio Pipelines

### Text-to-Speech
```json
{"m":"fal-ai/f5-tts","i":{"gen_text":"Привет! Это тестовое сообщение."},"s":true}
```

### Voice Cloning
```bash
# 1. Upload reference audio (10-30s sample)
curl -X POST https://skill.neuroartist.ru/api/v1/upload \
  -H "Authorization: Bearer $TOKEN" \
  -F "file=@voice_sample.mp3"
# → {"url":"https://skill.neuroartist.ru/api/media/uploads/..."}

# 2. Generate with cloned voice
curl -X POST https://skill.neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"m":"fal-ai/f5-tts","i":{"gen_text":"Text to speak","ref_audio_url":"UPLOAD_URL","ref_text":"Transcript of reference"},"s":true}'
```

### Speech-to-Text
```json
{"m":"fal-ai/whisper","i":{"audio_url":"https://..."},"s":true}
```
Response: `{"text":"Transcribed text here..."}`

## Upload Workflows

### Image-to-Image with Upload
```bash
# 1. Upload source image
curl -X POST https://skill.neuroartist.ru/api/v1/upload \
  -H "Authorization: Bearer $TOKEN" \
  -F "file=@photo.jpg"
# → {"url":"https://skill.neuroartist.ru/api/media/uploads/...","key":"uploads/..."}

# 2. Style transfer
curl -X POST https://skill.neuroartist.ru/api/v1/generate \
  -d '{"m":"fal-ai/flux/dev/image-to-image","i":{"image_url":"UPLOAD_URL","prompt":"oil painting style"},"s":true}'
```

### Product on White Background
```bash
# Upload → Remove BG → Upscale
UPLOAD=$(curl -s -X POST .../upload -F "file=@product.jpg" | jq -r .url)
NOBG=$(curl -s -X POST .../generate -d '{"m":"fal-ai/birefnet","i":{"image_url":"'$UPLOAD'"},"s":true}' | jq -r .url)
curl -X POST .../generate -d '{"m":"fal-ai/aura-sr","i":{"image_url":"'$NOBG'"},"s":true}'
```

## Streaming (SSE)

### Real-time Video Progress
```typescript
// For long operations like video generation
const response = await fetch('https://skill.neuroartist.ru/api/v1/generate', {
  method: 'POST',
  headers: { 'Authorization': `Bearer ${token}`, 'Content-Type': 'application/json' },
  body: JSON.stringify({
    m: 'fal-ai/kling-video/v2.5/turbo/text-to-video',
    i: { prompt: 'Aerial shot of mountains' },
    s: false  // async mode
  })
});
const { id } = await response.json();

// Connect to SSE stream
const events = new EventSource(
  `https://skill.neuroartist.ru/api/v1/requests/${id}/stream`,
  { headers: { 'Authorization': `Bearer ${token}` } }
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

## Error Handling

| Code | Error | Action |
|------|-------|--------|
| 401 | `no key` | Add Authorization header |
| 402 | `insufficient balance` | Top up balance |
| 429 | `rate limit` | Wait `reset` seconds |
| 400 | `unknown model` | Check model ID |
| 400 | `missing input` | Add required params |
| 500 | `generation failed` | Retry or simplify prompt |

### Retry Pattern
```typescript
async function generateWithRetry(params: object, maxRetries = 3) {
  for (let i = 0; i < maxRetries; i++) {
    const res = await fetch('.../generate', {
      method: 'POST',
      headers: { 'Authorization': `Bearer ${token}` },
      body: JSON.stringify(params)
    });

    if (res.status === 429) {
      const { reset } = await res.json();
      await new Promise(r => setTimeout(r, reset * 1000));
      continue;
    }

    if (res.ok) return res.json();
    throw new Error(`Failed: ${res.status}`);
  }
  throw new Error('Max retries exceeded');
}
