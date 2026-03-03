# Kling 2.5/3.0 Video Prompting Guide

Best practices for Kuaishou's Kling video models.

## Model Overview

| Model | Duration | Resolution | Features |
|-------|----------|------------|----------|
| Kling 2.5 Turbo | 5s | 1080p | Start/End Frame, fast |
| Kling 3.0 | 15s | 4K/60fps | Multi-shot, dialogue, audio |

## Core Principle

**Think like a director, not a photographer.**

Video prompts need motion, not just description. Describe how the shot moves.

## 6 Prompt Elements

1. **Camera** - shot type and movement (FIRST!)
2. **Subject** - who/what and their action
3. **Environment** - where the scene takes place
4. **Lighting** - light source and mood
5. **Texture** - physical details for realism
6. **Emotion** - mood of the moment

## Prompt Formula

```
[Camera movement] + [Subject action] + [Environment] + [Lighting] + [Mood]
```

## Examples: Good vs Bad

### Basic Scene
```
Bad: "person walking on street"

Good: "Tracking shot following a man in a long coat walking down a
rain-slicked Tokyo alley at night, neon signs reflecting in puddles,
camera slowly pulls back to reveal the towering buildings"
```

### Animal
```
Bad: "cat on couch"

Good: "Close-up of a tabby cat slowly opening its eyes, stretching on
a sunlit velvet couch, dust particles floating in golden afternoon light,
camera gently drifts closer, settles on the cat's face"
```

### Product
```
Bad: "watch spinning"

Good: "Slow dolly around a luxury watch on black velvet, dramatic side
lighting catching the metal surfaces, watch face reflecting studio lights,
camera completes 180-degree arc, cinematic commercial style"
```

## Camera Types (Use Exact Terms)

| Term | Description |
|------|-------------|
| `tracking shot` | Camera follows the subject |
| `dolly in/out` | Camera moves toward/away |
| `crane shot` | Camera rises up |
| `POV shot` | First-person perspective |
| `handheld` | Shaky, documentary feel |
| `static shot` | Camera doesn't move |
| `slow push in` | Gradual approach |
| `pan left/right` | Camera rotates horizontally |
| `tilt up/down` | Camera rotates vertically |
| `orbit/arc` | Camera circles subject |

## Kling 3.0: Multi-Shot Sequences

Kling 3.0 supports up to 6 shots in one generation. Label each shot:

```
Shot 1: Wide establishing shot of a misty mountain lake at dawn
Shot 2: Medium shot of a lone figure standing at the water's edge
Shot 3: Close-up of their hands releasing a paper boat
Shot 4: Tracking shot following the boat as it drifts away
Shot 5: Wide shot pulling back, figure now small against vast landscape
```

### Multi-Shot API
```json
{
  "m": "fal-ai/kling-video/v3/text-to-video",
  "i": {
    "prompt": "Shot 1: Wide shot of coffee shop interior. Shot 2: Close-up of espresso being poured. Shot 3: Medium shot of barista smiling. Shot 4: Close-up of latte art being created.",
    "duration": 10
  }
}
```

## Kling 3.0: Dialogue

Native audio with voice attribution:

```
"Two friends at a coffee shop. Shot 1: Medium two-shot, they laugh together.
Woman says 'Remember that trip to Paris?' Shot 2: Close-up of man smiling,
he replies 'How could I forget?' Natural warm lighting, shallow depth of field."
```

### Dialogue API
```json
{
  "m": "fal-ai/kling-video/v3/text-to-video",
  "i": {
    "prompt": "Business meeting. Shot 1: Wide shot of conference room. Man in suit says 'Let's discuss the quarterly results.' Shot 2: Close-up of woman nodding, she responds 'The numbers look promising.'",
    "enable_audio": true
  }
}
```

## Image-to-Video

**CRITICAL: Only describe motion, not what's in the image!**

```
Bad: "A woman in red dress standing in a garden, flowers around her"

Good: "She slowly turns her head to the left, a gentle breeze moves
her hair, petals drift past in the wind"
```

### I2V API
```json
{
  "m": "fal-ai/kling-video/v2.5/turbo/image-to-video",
  "i": {
    "image_url": "https://cdn.example.com/portrait.jpg",
    "prompt": "She blinks slowly, a subtle smile forms on her lips,
    slight head tilt to the right"
  }
}
```

## Start/End Frame (Kling 2.5)

Control exact beginning and ending:

```json
{
  "m": "fal-ai/kling-video/v2.5/turbo/text-to-video",
  "i": {
    "prompt": "Woman walking through garden",
    "start_frame_url": "https://cdn.example.com/start.jpg",
    "end_frame_url": "https://cdn.example.com/end.jpg"
  }
}
```

## Motion Endpoints

Always specify where motion ends to prevent glitches:

```
Bad: "Camera zooms in on face"

Good: "Camera slowly pushes in on face, then settles into a close-up"
```

## Common Mistakes

1. **No camera movement** - creates static, boring video
2. **Too many elements** - Kling 2.5 handles 3-4 elements max
3. **Redescribing image** - for I2V, only describe motion
4. **Open-ended motion** - always specify motion endpoints
5. **Vague spatial language** - use specific directions (left, right, up)

## Model Selection

| Task | Model | Notes |
|------|-------|-------|
| Fast preview | Kling 2.5 Turbo | 45s generation |
| Quality video | Kling 3.0 | 4K/60fps, longer |
| Product animation | Kling 2.5 I2V | From product photo |
| Storytelling | Kling 3.0 Multi-shot | Up to 6 shots |
| With dialogue | Kling 3.0 | Native audio |

## Quick Templates

### Product Showcase
```
"Slow 360-degree orbit around [product] on white cyclorama, soft studio
lighting, product slowly rotates on turntable, camera settles on front view"
```

### Lifestyle Scene
```
"Tracking shot following [person] through [location], natural lighting,
they [action], camera pulls back to establish environment"
```

### Cinematic Opener
```
"Crane shot rising from ground level, revealing [landscape] at golden hour,
dramatic clouds moving slowly, camera settles on wide establishing shot"
```
