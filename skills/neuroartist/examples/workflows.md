# Workflow Examples

Common multi-step workflows using neuroartist API.

## Image Generation Workflows

### 1. Generate + Upscale

Generate image, then upscale 4x for print quality.

```bash
# Step 1: Generate base image
curl -X POST https://neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "m": "fal-ai/flux/dev",
    "i": {"prompt": "professional portrait, studio lighting"},
    "s": true
  }'
# Response: {"url": "https://cdn.neuroartist.ru/abc123.jpg", ...}

# Step 2: Upscale 4x
curl -X POST https://neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "m": "fal-ai/aura-sr",
    "i": {"image_url": "https://cdn.neuroartist.ru/abc123.jpg"},
    "s": true
  }'
```

### 2. Generate + Remove Background

Create product photo with transparent background.

```bash
# Step 1: Generate product image
curl -X POST https://neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "m": "fal-ai/flux/schnell",
    "i": {"prompt": "red sneaker on white background, product photography"},
    "s": true
  }'

# Step 2: Remove background
curl -X POST https://neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer $TOKEN" \
  -d '{
    "m": "fal-ai/birefnet",
    "i": {"image_url": "https://cdn.neuroartist.ru/product.jpg"},
    "s": true
  }'
```

### 3. Draft -> Refine -> Final

Iterate from quick draft to final quality.

```bash
# Step 1: Quick draft with FLUX Schnell (2s, cheap)
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d '{"m": "fal-ai/flux/schnell", "i": {"prompt": "..."}, "s": true}'

# Step 2: Refine with FLUX Dev (better quality)
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d '{"m": "fal-ai/flux/dev", "i": {"prompt": "refined prompt..."}, "s": true}'

# Step 3: Final with FLUX Pro (best quality)
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d '{"m": "fal-ai/flux-pro/v1.1", "i": {"prompt": "final prompt..."}, "s": true}'
```

## Video Workflows

### 4. Image to Video

Animate a static image.

```bash
# Step 1: Generate hero image
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d '{
    "m": "fal-ai/flux/dev",
    "i": {"prompt": "woman looking at camera, portrait, studio lighting"},
    "s": true
  }'

# Step 2: Animate with Kling
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d '{
    "m": "fal-ai/kling-video/v2.5/turbo/image-to-video",
    "i": {
      "image_url": "https://cdn.neuroartist.ru/portrait.jpg",
      "prompt": "She slowly smiles, blinks naturally, subtle head movement"
    },
    "s": false
  }'
# Poll /api/v1/requests/{id} until complete
```

### 5. Multi-Shot Video Story

Create a short narrative with Kling 3.0.

```bash
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d '{
    "m": "fal-ai/kling-video/v3/text-to-video",
    "i": {
      "prompt": "Shot 1: Wide shot of empty cafe at dawn, soft light through windows. Shot 2: Medium shot of barista preparing espresso machine. Shot 3: Close-up of coffee being poured into cup, steam rising. Shot 4: Wide shot as first customer enters, bell chimes.",
      "duration": 12
    },
    "s": false
  }'
```

## Design Workflows

### 6. Logo Design (SVG)

Generate vector logo for brand.

```bash
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d '{
    "m": "fal-ai/recraft/v4/text-to-vector",
    "i": {
      "prompt": "minimalist geometric logo for tech startup NEXUS, letter N formed by two diagonal lines intersecting, navy blue on white background, clean vector style",
      "colors": [{"r": 26, "g": 54, "b": 93}]
    },
    "s": true
  }'
# Returns SVG file URL
```

### 7. Social Media Pack

Generate images for multiple platforms.

```bash
# VK Post (1:1)
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d '{"m": "fal-ai/flux/schnell", "i": {"prompt": "...", "image_size": "square"}, "s": true}'

# Instagram Feed (4:5)
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d '{"m": "fal-ai/flux/schnell", "i": {"prompt": "...", "image_size": "portrait_4_3"}, "s": true}'

# YouTube Thumbnail (16:9)
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d '{"m": "fal-ai/flux/schnell", "i": {"prompt": "...", "image_size": "landscape_16_9"}, "s": true}'

# Story/Reels (9:16)
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d '{"m": "fal-ai/flux/schnell", "i": {"prompt": "...", "image_size": "portrait_16_9"}, "s": true}'
```

### 8. Infographic with Nano Banana

Create data visualization.

```bash
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d '{
    "m": "fal-ai/nano-banana-pro",
    "i": {
      "prompt": "Infographic titled \"5 Steps to Better Sleep\" with numbered circles 1-5, each containing an icon: 1-moon (set schedule), 2-phone with X (no screens), 3-bed (comfortable environment), 4-cup (no caffeine), 5-book (wind down routine). Soft blue and purple gradient background, modern flat design, clean sans-serif typography."
    },
    "s": true
  }'
```

## Batch Processing

### 9. Generate Multiple Variations

Generate several options in parallel.

```bash
# Submit multiple async requests
for i in {1..5}; do
  curl -X POST https://neuroartist.ru/api/v1/generate \
    -d "{\"m\": \"fal-ai/flux/schnell\", \"i\": {\"prompt\": \"variation $i: product photo, sneaker...\"}, \"s\": false}"
done

# Poll all requests until complete
```

### 10. A/B Test Models

Compare outputs from different models.

```bash
# Same prompt, different models
PROMPT="professional headshot, studio lighting, neutral background"

# FLUX
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d "{\"m\": \"fal-ai/flux/dev\", \"i\": {\"prompt\": \"$PROMPT\"}, \"s\": true}"

# Nano Banana
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d "{\"m\": \"fal-ai/nano-banana-2\", \"i\": {\"prompt\": \"$PROMPT\"}, \"s\": true}"

# Recraft
curl -X POST https://neuroartist.ru/api/v1/generate \
  -d "{\"m\": \"fal-ai/recraft/v4\", \"i\": {\"prompt\": \"$PROMPT\"}, \"s\": true}"
```

## Error Handling

### Retry on Rate Limit

```bash
response=$(curl -s -w "\n%{http_code}" -X POST https://neuroartist.ru/api/v1/generate \
  -H "Authorization: Bearer $TOKEN" \
  -d '{"m": "fal-ai/flux/schnell", "i": {"prompt": "..."}, "s": true}')

http_code=$(echo "$response" | tail -1)
body=$(echo "$response" | head -1)

if [ "$http_code" = "429" ]; then
  retry_after=$(echo "$body" | jq -r '.reset')
  echo "Rate limited. Retry after $retry_after seconds"
  sleep $retry_after
  # Retry request
fi
```

### Poll Async Request

```bash
request_id="req_abc123"
while true; do
  status=$(curl -s "https://neuroartist.ru/api/v1/requests/$request_id" \
    -H "Authorization: Bearer $TOKEN" | jq -r '.status')

  if [ "$status" = "completed" ]; then
    echo "Done!"
    break
  elif [ "$status" = "failed" ]; then
    echo "Failed!"
    break
  fi

  sleep 5
done
```
