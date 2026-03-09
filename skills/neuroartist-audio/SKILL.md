---
name: neuroartist-audio
description: "Text-to-speech (TTS), speech-to-text (STT), voice cloning. F5-TTS, PlayAI, Whisper. Works in Russia (CDN proxy)."
version: 1.0.0
origin: skill.neuroartist.ru
triggers:
  - text to speech
  - tts
  - speech to text
  - stt
  - transcribe
  - whisper
  - voice cloning
  - озвучь
  - озвучка
  - транскрибируй
  - расшифруй
  - голос
---

# neuroartist Audio API

**Specialized for audio: TTS, STT, voice cloning.** For images use `neuroartist-image`, for video use `neuroartist-video`.

**Base:** `https://skill.neuroartist.ru/api/v1`
**Auth:** `Authorization: Bearer na_live_xxx`
**Get key:** https://skill.neuroartist.ru/dashboard/tokens

## Text-to-Speech (TTS)

### Quick Generate

```bash
curl -X POST https://skill.neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"m":"fal-ai/f5-tts","i":{"gen_text":"Hello world! This is a test."},"s":true}'
```

**Response:** `{"id":"req_abc","url":"https://skill.neuroartist.ru/api/media/...mp3","ms":3000}`

### Models

| Model | Speed | Cost | Best For |
|-------|-------|------|----------|
| `fal-ai/f5-tts` | 3s | ~2₽ | Voice cloning, natural |
| `fal-ai/playai/tts/v3` | 2s | ~3₽ | High-quality voices |
| `fal-ai/metavoice-v1` | 4s | ~2₽ | Multi-language |

### Voice Cloning (F5-TTS)

Clone any voice with a 10-30 second audio sample:

```bash
# 1. Upload reference audio (10-30s clean sample)
curl -X POST https://skill.neuroartist.ru/api/v1/upload \
  -H "Authorization: Bearer $TOKEN" \
  -F "file=@voice_sample.mp3"

# Response: {"url":"https://skill.neuroartist.ru/api/media/uploads/..."}

# 2. Generate with cloned voice
curl -X POST https://skill.neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "m": "fal-ai/f5-tts",
    "i": {
      "gen_text": "Text to speak in the cloned voice",
      "ref_audio_url": "UPLOAD_URL",
      "ref_text": "Exact transcript of the reference audio"
    },
    "s": true
  }'
```

**Tips for voice cloning:**
- Use clean audio (no background noise/music)
- 10-30 seconds is optimal
- Provide accurate transcript of reference audio
- Same language as target text works best

### TypeScript Example

```typescript
const res = await fetch('https://skill.neuroartist.ru/api/v1/generate', {
  method: 'POST',
  headers: {
    'Authorization': `Bearer ${process.env.NEUROARTIST_KEY}`,
    'Content-Type': 'application/json'
  },
  body: JSON.stringify({
    m: 'fal-ai/f5-tts',
    i: { gen_text: 'Привет! Это тестовое сообщение.' },
    s: true
  })
});
const { url } = await res.json();
// url → https://skill.neuroartist.ru/api/media/...mp3
```

## Speech-to-Text (STT)

### Quick Transcribe

```bash
# 1. Upload audio file
curl -X POST https://skill.neuroartist.ru/api/v1/upload \
  -H "Authorization: Bearer $TOKEN" \
  -F "file=@recording.mp3"

# 2. Transcribe
curl -X POST https://skill.neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"m":"fal-ai/whisper","i":{"audio_url":"UPLOAD_URL"},"s":true}'
```

**Response:** `{"id":"req_abc","text":"Transcribed text here...","ms":5000}`

### Models

| Model | Speed | Cost | Best For |
|-------|-------|------|----------|
| `fal-ai/whisper` | 5s | ~1₽ | Accurate transcription |
| `fal-ai/wizper` | 3s | ~1.5₽ | Fast transcription |

### Transcribe from URL

```json
{
  "m": "fal-ai/whisper",
  "i": {
    "audio_url": "https://example.com/podcast.mp3"
  },
  "s": true
}
```

### Python Example

```python
import requests

# Transcribe
res = requests.post(
    'https://skill.neuroartist.ru/api/v1/generate',
    headers={'Authorization': f'Bearer {API_KEY}'},
    json={
        'm': 'fal-ai/whisper',
        'i': {'audio_url': 'https://...'},
        's': True
    }
)
print(res.json()['text'])
```

## Workflows

### Podcast Transcription

```bash
# Upload podcast episode
UPLOAD=$(curl -s -X POST .../upload -F "file=@episode.mp3" | jq -r .url)

# Transcribe
curl -X POST .../generate -d "{\"m\":\"fal-ai/whisper\",\"i\":{\"audio_url\":\"$UPLOAD\"},\"s\":true}"
```

### Voice-Over Generation

```bash
# Generate narration
curl -X POST .../generate \
  -d '{"m":"fal-ai/f5-tts","i":{"gen_text":"Welcome to our product demo. Today we will show you..."},"s":true}'
```

### Clone + Generate

```bash
# 1. Upload CEO voice sample
VOICE=$(curl -s -X POST .../upload -F "file=@ceo_sample.mp3" | jq -r .url)

# 2. Generate announcement in CEO voice
curl -X POST .../generate -d "{
  \"m\":\"fal-ai/f5-tts\",
  \"i\":{
    \"gen_text\":\"We are excited to announce our new product line...\",
    \"ref_audio_url\":\"$VOICE\",
    \"ref_text\":\"Original text from the sample\"
  },
  \"s\":true
}"
```

## Selection Guide

```
Natural TTS?        → f5-tts (~2₽)
Voice cloning?      → f5-tts + ref_audio_url (~2₽)
High-quality TTS?   → playai/tts/v3 (~3₽)
Multi-language?     → metavoice-v1 (~2₽)
Transcription?      → whisper (~1₽)
Fast transcription? → wizper (~1.5₽)
```

## Cost Estimation

| Task | Model | Est. Cost |
|------|-------|-----------|
| 1 min voice-over | f5-tts | ~8₽ |
| Clone voice + 5 messages | f5-tts | ~12₽ |
| Transcribe 10 min audio | whisper | ~3₽ |
| Podcast episode (1h) | whisper | ~15₽ |
