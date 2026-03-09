# Kling Video Prompting

## Models

| Model | Duration | Features |
|-------|----------|----------|
| Kling 2.5 Turbo | 5s | Start/End frame, fast |
| Kling 3.0 | 15s | 4K/60fps, multi-shot, dialogue |

## Formula

```
[Camera] + [Subject] + [Action] + [Environment] + [Lighting] + [Atmosphere]
```

**Think like director, not photographer.** Describe motion and emotion, not static scene.

## Camera Movements

### Basic
| Term | Description | Use For |
|------|-------------|---------|
| `tracking shot` | Follows subject | Walking scenes |
| `dolly in/out` | Moves toward/away | Reveal, emphasis |
| `crane shot` | Rises/descends | Epic reveals |
| `static shot` | No movement | Dialogue, tension |
| `slow push in` | Gradual approach | Building tension |

### Advanced
| Term | Description | Use For |
|------|-------------|---------|
| `orbit/arc` | Circles subject | Product, hero |
| `handheld` | Shaky, organic | Documentary, action |
| `whip pan` | Fast horizontal | Transitions |
| `Dutch angle` | Tilted frame | Unease, disorientation |
| `Steadicam` | Smooth follow | Long takes |
| `rack focus` | Shift depth of field | Attention shift |
| `zoom` | Lens zoom in/out | Surprise, comedy |

### Framing
| Term | Description |
|------|-------------|
| `extreme close-up` | Eyes, details |
| `close-up` | Face, object |
| `medium shot` | Waist up |
| `wide shot` | Full body + environment |
| `establishing shot` | Location context |
| `over-the-shoulder` | Dialogue perspective |
| `two-shot` | Two people in frame |

## Lighting Terms

| Term | Effect |
|------|--------|
| `golden hour` | Warm, romantic |
| `blue hour` | Cool, melancholic |
| `high key` | Bright, minimal shadows |
| `low key` | Dark, dramatic shadows |
| `rim lighting` | Silhouette outline |
| `neon lighting` | Cyberpunk, urban |
| `candlelight` | Intimate, warm |
| `moonlight` | Cold, mysterious |
| `volumetric light` | God rays, atmospheric |

## Atmosphere/Texture

Add physical details for realism:
- `dust particles floating`
- `rain drops on lens`
- `steam rising`
- `fog rolling`
- `leaves falling`
- `snow drifting`
- `lens flare`
- `shallow depth of field`
- `motion blur`

## Examples

**Bad:** `person walking on street`
**Good:** `Tracking shot following man in coat down rain-slicked Tokyo alley at night, neon signs reflecting in puddles, handheld camera slowly pulls back to reveal towering buildings, volumetric fog`

**Bad:** `cat on couch`
**Good:** `Extreme close-up of tabby cat slowly opening eyes, stretching on sunlit velvet couch, dust particles floating in golden afternoon light, shallow depth of field, camera drifts closer to face`

**Bad:** `car driving`
**Good:** `Low angle tracking shot of vintage Mustang speeding down desert highway at golden hour, dust trail behind, whip pan to driver's determined face, lens flare from setting sun`

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

## Genre Templates

### Product/Commercial
```
Slow 360-degree orbit around [product] on seamless white background, soft diffused lighting, camera completes smooth arc, settles on hero angle with subtle rim light
```

### Lifestyle
```
Steadicam tracking shot following [person] through [location], natural light spilling through windows, they [action], camera gracefully pulls back to reveal environment
```

### Cinematic/Epic
```
Crane shot rising from ground level, slowly revealing [landscape] at golden hour, volumetric light through clouds, settles on majestic wide shot
```

### Horror/Thriller
```
Slow dolly in through dark corridor, single flickering light source, Dutch angle gradually increasing, shadows creeping at edges, sudden stop at doorway
```

### Action
```
Handheld tracking shot following [character] running through [location], whip pans to obstacles, motion blur on fast movements, dust/debris in air
```

### Romance
```
Soft focus two-shot of [characters] at golden hour, rack focus between faces, warm rim lighting, slow push in as they [action], bokeh lights in background
```

### Documentary
```
Handheld medium shot observing [subject] at work, natural available light, occasional rack focus to details, organic camera movements following action
```

### Music Video
```
Dynamic orbit shot around [performer], dramatic colored lighting shifts (blue to purple), smoke/haze in air, rhythmic camera movements, lens flares
```

### Food/Cooking
```
Extreme close-up macro shot of [food], steam rising, slow dolly revealing full dish, warm key light, shallow depth of field, droplets/texture visible
```

### Real Estate
```
Steadicam wide shot entering through doorway, smooth reveal of [room], natural light from windows, slow pan across features, high key lighting
```

## Pacing Guide

| Mood | Camera Speed | Cut Length |
|------|-------------|------------|
| Calm/Peaceful | Very slow | 8-15s |
| Romantic | Slow | 5-10s |
| Documentary | Medium | 4-8s |
| Action | Fast | 1-3s |
| Horror buildup | Slow then fast | 5s → 1s |

## Common Mistakes

❌ Describing what's in frame (AI already sees the prompt)
❌ Too many movements in one shot
❌ Conflicting lighting (moonlight + golden hour)
❌ Static descriptions for video (use verbs!)
❌ Forgetting atmosphere/texture

✅ One clear camera movement per shot
✅ Describe motion and change
✅ Consistent lighting logic
✅ Physical details (dust, rain, fog)
✅ Emotional intent (tension, joy, mystery)
