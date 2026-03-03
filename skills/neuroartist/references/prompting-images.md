# Nano Banana Prompting

## Formula

```
[Subject + details] doing [Action] in [Location] with [Style]
```

**5 elements:** Subject, Composition, Action, Location, Style

## Examples

**Portrait:**
```
Bad: "girl in cafe"
Good: "young woman with curly auburn hair reading book, vintage Parisian cafe, warm light through lace curtains, medium format film, shallow DOF"
```

**Logo:**
```
Bad: "company logo"
Good: "minimalist geometric logo 'NEXUS', letter N from diagonal lines, navy #1a365d on white, vector style, clean lines"
```

**Product:**
```
Bad: "coffee cup"
Good: "ceramic coffee cup with steam, weathered wooden table, morning sunlight from left, artisanal bakery blurred background, commercial photography"
```

## Text in Images

Nano Banana = best text accuracy. Always:
- Put text in "quotes"
- Specify font style
- Describe placement

```
"Movie poster with bold 'LAST TRAIN' at top, art deco style, golden rays, dramatic shadows"

"Menu board: 'Espresso $3 | Latte $5', handwritten chalk style, wooden frame"
```

## Infographics

```
"Infographic '5 Steps to Better Sleep', numbered circles 1-5 with icons (moon, bed, phone-off, clock, tea), blue-purple gradient, flat design"
```

## Multi-Image

```json
{"m":"fal-ai/nano-banana-pro","i":{"prompt":"Combine references into one scene","reference_images":["url1","url2"]}}
```

## Character Consistency

Use same description prefix:
```
"Portrait of [Name], woman 30s, short black hair, green eyes, red jacket. [Name] is smiling, studio lighting"
```

## Model Selection

| Task | Model |
|------|-------|
| Text rendering | `nano-banana-pro` |
| Quick iterations | `nano-banana-2` |
| Simple images | `gemini-25-flash-image` |
