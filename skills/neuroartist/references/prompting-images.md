# Nano Banana Prompting Guide

Best practices for Google's Nano Banana models (Gemini 2.5 Flash / Gemini 3 Pro).

## Why Nano Banana?

- **94% text accuracy** - best-in-class text rendering
- **Multi-image fusion** - up to 14 references in one request
- **Character consistency** - maintain identity across generations
- **Search Grounding** - real-time data from Google Search
- **Physics-aware** - understands spatial relationships

## Prompt Formula

```
[Subject + Adjectives] doing [Action] in [Location] with [Style]
```

### 5 Key Variables

1. **Subject** - specific details, not generic descriptions
2. **Composition** - camera angle and framing
3. **Action** - movement and energy
4. **Location** - atmosphere and setting
5. **Style** - artistic medium and aesthetics

## Examples: Good vs Bad

### Portrait
```
Bad: "girl in cafe"

Good: "young woman with curly auburn hair, reading a worn paperback book,
cozy corner booth in a vintage Parisian cafe, warm afternoon light streaming
through lace curtains, shot on medium format film with shallow depth of field"
```

### Logo
```
Bad: "company logo"

Good: "minimalist geometric logo for a tech startup called 'NEXUS',
letter N formed by two intersecting diagonal lines, deep navy blue (#1a365d)
on pure white background, vector style, clean precise lines, suitable for app icon"
```

### Product
```
Bad: "coffee cup"

Good: "ceramic coffee cup with steam rising, placed on weathered wooden table,
morning sunlight from left creating soft shadows, artisanal bakery background
slightly blurred, warm color palette, commercial product photography style"
```

## Text in Images (Unique Feature)

Nano Banana excels at text rendering. Always:
- Put text in quotes
- Specify font style (bold, handwritten, serif)
- Describe placement (top, centered, on the object)

### Examples
```
Good: "Vintage movie poster with bold text 'LAST TRAIN TO NOWHERE' at the top,
art deco style, golden rays behind a steam locomotive, dramatic shadows"

Good: "Coffee shop menu board, handwritten chalk style, listing:
'Espresso $3 | Latte $5 | Cappuccino $4.50', rustic wooden frame"

Good: "Business card design, clean minimal layout, text 'JOHN SMITH' in
uppercase sans-serif, 'Creative Director' smaller below, white card on
dark marble surface"
```

## Infographics

Structure your prompt with clear sections:

```
Good: "Infographic showing '5 Steps to Better Sleep', numbered circles 1-5,
each with an icon (moon, bed, phone-off, clock, tea), soft blue and purple
gradient background, modern flat design, clean sans-serif typography"

Good: "Pie chart infographic titled 'Market Share 2026', three segments:
blue 45% labeled 'Product A', green 35% labeled 'Product B', gray 20%
labeled 'Others', minimalist corporate style, white background"
```

## Multi-Image Composition

Nano Banana can combine multiple reference images:

```json
{
  "m": "fal-ai/nano-banana-pro",
  "i": {
    "prompt": "Product photo combining all reference images into one cohesive scene",
    "reference_images": [
      "https://cdn.example.com/product.jpg",
      "https://cdn.example.com/background.jpg",
      "https://cdn.example.com/props.jpg"
    ]
  }
}
```

## Character Consistency

To maintain character identity across generations:

```
Prompt: "Portrait of [Character Name], a woman in her 30s with short
black hair and green eyes, wearing a red jacket. [Character Name] is
smiling at the camera, studio lighting, white background"
```

Use the same character description prefix in subsequent prompts.

## Search Grounding

For current events or factual accuracy:

```
Good: "Infographic showing 'Top 5 Smartphones of 2026' with current models,
accurate specifications and prices, modern tech blog style"
```

Nano Banana will use Google Search to get accurate current information.

## API Examples

### Text-Heavy Image
```json
{
  "m": "fal-ai/nano-banana-pro",
  "i": {
    "prompt": "Sale banner with large text 'BLACK FRIDAY 50% OFF' in bold white letters on black background, subtle gold accents, modern retail style"
  },
  "s": true
}
```

### Infographic
```json
{
  "m": "fal-ai/nano-banana-pro",
  "i": {
    "prompt": "Step-by-step guide infographic titled 'How to Make Coffee', 5 illustrated steps with icons, warm brown color palette, hand-drawn style"
  },
  "s": true
}
```

### Product with Text
```json
{
  "m": "fal-ai/nano-banana-pro",
  "i": {
    "prompt": "Coffee bag packaging design, text 'MORNING ROAST' in vintage serif font, 'Premium Arabica' subtitle, illustration of coffee beans, kraft paper texture"
  },
  "s": true
}
```

## Common Mistakes

1. **Too vague** - "nice picture" won't work, be specific
2. **No style** - always specify artistic medium or photography style
3. **Text without quotes** - always put desired text in quotes
4. **Conflicting instructions** - don't mix incompatible styles
5. **Too many elements** - focus on key subjects, don't overcrowd

## Model Selection

| Task | Model | Notes |
|------|-------|-------|
| Text rendering | `fal-ai/nano-banana-pro` | Best accuracy |
| Quick iterations | `fal-ai/nano-banana-2` | 4x faster |
| Simple images | `fal-ai/gemini-25-flash-image` | Cheapest |
