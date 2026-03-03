# Russian Platform Sizes

Image and video dimensions for popular Russian platforms. Updated March 2026.

## VKontakte (VK)

| Format | Size | Aspect | API image_size |
|--------|------|--------|----------------|
| Post (square) | 1080x1080 | 1:1 | `square` |
| Post (landscape) | 1200x630 | 1.9:1 | `landscape_16_9` |
| Community cover | 1920x768 | 2.5:1 | custom |
| Avatar | 400x400 | 1:1 | `square` |
| Story | 1080x1920 | 9:16 | `portrait_16_9` |
| Product card | 1000x1000 | 1:1 | `square` |
| Article cover | 1440x400 | 3.6:1 | custom |

**Recommendations:**
- Posts: use 1:1 for universal display
- Stories: always 9:16, safe zone in center
- Cover: important content in center 1590x400 area

## Telegram

| Format | Size | Aspect | API image_size |
|--------|------|--------|----------------|
| Sticker | 512x512 | 1:1 | `square` |
| Channel avatar | 640x640 | 1:1 | `square` |
| Link preview | 1280x640 | 2:1 | custom |
| Story | 1080x1920 | 9:16 | `portrait_16_9` |
| Bot inline result | 200x200 | 1:1 | custom |

**Sticker Requirements:**
- Exactly 512x512 pixels
- PNG with transparency recommended
- Max file size 512KB

## Instagram

| Format | Size | Aspect | API image_size |
|--------|------|--------|----------------|
| Post (square) | 1080x1080 | 1:1 | `square` |
| Post (portrait) | 1080x1350 | 4:5 | `portrait_4_3` |
| Post (landscape) | 1080x566 | 1.91:1 | `landscape_16_9` |
| Story/Reels | 1080x1920 | 9:16 | `portrait_16_9` |
| Profile | 320x320 | 1:1 | `square` |
| Carousel | 1080x1080 | 1:1 | `square` |

**Recommendations:**
- Feed posts: 4:5 portrait gets more screen space
- Reels: always 9:16, text in safe zone
- Carousel: consistent aspect ratio across all images

## YouTube

| Format | Size | Aspect | API image_size |
|--------|------|--------|----------------|
| Thumbnail | 1280x720 | 16:9 | `landscape_16_9` |
| Shorts | 1080x1920 | 9:16 | `portrait_16_9` |
| Channel banner | 2560x1440 | - | custom |
| Video (standard) | 1920x1080 | 16:9 | `landscape_16_9` |
| Video (4K) | 3840x2160 | 16:9 | custom |

**Thumbnail Tips:**
- High contrast, readable text
- Face close-ups perform well
- Max 2MB file size

## Yandex Zen / Dzen

| Format | Size | Aspect |
|--------|------|--------|
| Article cover | 1200x630 | 1.9:1 |
| Post image | 1080x1080 | 1:1 |
| Video | 1920x1080 | 16:9 |

## Odnoklassniki (OK)

| Format | Size | Aspect |
|--------|------|--------|
| Post | 1200x630 | 1.9:1 |
| Group cover | 1340x320 | 4.2:1 |
| Avatar | 288x288 | 1:1 |

## Quick Reference Table

| Platform | Feed Post | Story/Reels | Video |
|----------|-----------|-------------|-------|
| VK | 1080x1080 | 1080x1920 | 1920x1080 |
| Telegram | - | 1080x1920 | 1920x1080 |
| Instagram | 1080x1350 | 1080x1920 | 1080x1920 |
| YouTube | 1280x720 | 1080x1920 | 1920x1080 |

## API Examples

### VK Post
```json
{"m":"fal-ai/flux/schnell","i":{"prompt":"...","image_size":"square"},"s":true}
```

### Instagram Story
```json
{"m":"fal-ai/flux/schnell","i":{"prompt":"...","image_size":"portrait_16_9"},"s":true}
```

### YouTube Thumbnail
```json
{"m":"fal-ai/flux/schnell","i":{"prompt":"...","image_size":"landscape_16_9"},"s":true}
```

### Telegram Sticker
```json
{"m":"fal-ai/flux/schnell","i":{"prompt":"...","image_size":"square"},"s":true}
```
Note: Resize to 512x512 after generation.
