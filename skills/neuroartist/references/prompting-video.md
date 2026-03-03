# Kling Video Prompting

## Models

| Model | Duration | Features |
|-------|----------|----------|
| Kling 2.5 Turbo | 5s | Start/End frame, fast |
| Kling 3.0 | 15s | 4K/60fps, multi-shot, dialogue |

## Formula

```
[Camera movement] + [Subject action] + [Environment] + [Lighting]
```

**Think like director, not photographer.** Describe motion, not static scene.

## Camera Terms

| Term | Description |
|------|-------------|
| `tracking shot` | Follows subject |
| `dolly in/out` | Moves toward/away |
| `crane shot` | Rises up |
| `POV shot` | First-person |
| `static shot` | No movement |
| `slow push in` | Gradual approach |
| `orbit/arc` | Circles subject |

## Examples

**Bad:** `person walking on street`
**Good:** `Tracking shot following man in coat down rain-slicked Tokyo alley at night, neon reflecting in puddles, camera pulls back to reveal buildings`

**Bad:** `cat on couch`
**Good:** `Close-up of tabby cat opening eyes, stretching on sunlit velvet couch, dust in golden light, camera drifts closer to face`

## Multi-Shot (Kling 3.0)

Up to 6 shots in one generation:
```
Shot 1: Wide establishing shot of mountain lake at dawn
Shot 2: Medium shot of figure at water's edge
Shot 3: Close-up of hands releasing paper boat
Shot 4: Tracking shot following boat drifting
```

## Dialogue (Kling 3.0)

```
"Coffee shop. Shot 1: Two-shot, they laugh. Woman says 'Remember Paris?' Shot 2: Close-up man replies 'How could I forget?'"
```
Use `"enable_audio": true`

## Image-to-Video

**Only describe motion, not what's in image!**

**Bad:** `Woman in red dress in garden`
**Good:** `She turns head left, breeze moves hair, petals drift past`

## Start/End Frame (Kling 2.5)

```json
{"m":"fal-ai/kling-video/v2.5/turbo/text-to-video","i":{"prompt":"...","start_frame_url":"url","end_frame_url":"url"}}
```

## Templates

**Product:** `Slow 360-degree orbit around [product] on white, soft lighting, completes arc, settles on front view`

**Lifestyle:** `Tracking shot following [person] through [location], natural light, they [action], camera pulls back`

**Cinematic:** `Crane shot rising from ground, revealing [landscape] at golden hour, settles on wide shot`
