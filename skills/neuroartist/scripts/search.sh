#!/bin/bash
# neuroartist search - find models by category or name

set -e

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

usage() {
  echo "Usage: search.sh [category|query]"
  echo ""
  echo "Categories:"
  echo "  image      Text-to-image models (FLUX, Nano Banana, Recraft)"
  echo "  video      Video generation (Kling, MiniMax, Luma)"
  echo "  audio      TTS and STT (F5-TTS, Whisper)"
  echo "  upscale    Image upscaling (Aura SR, Clarity)"
  echo "  edit       Image editing (Remove BG, Face Swap)"
  echo "  vector     SVG generation (Recraft Vector)"
  echo ""
  echo "Examples:"
  echo "  search.sh image"
  echo "  search.sh flux"
  echo "  search.sh video"
  exit 1
}

if [ -z "$1" ]; then
  usage
fi

QUERY=$(echo "$1" | tr '[:upper:]' '[:lower:]')

echo "🔍 Searching models: $1"
echo ""

case "$QUERY" in
  image|text-to-image|t2i)
    echo -e "${CYAN}=== Image Generation ===${NC}"
    echo ""
    echo "Fast Draft:"
    echo "  fal-ai/flux/schnell          2s    ~0.3₽   Quick iterations"
    echo ""
    echo "Quality:"
    echo "  fal-ai/flux/dev              10s   ~1.4₽   Final images"
    echo "  fal-ai/flux-pro/v1.1         15s   ~5₽     Professional"
    echo "  fal-ai/flux-pro/v1.1-ultra   20s   ~8₽     4MP high-res"
    echo ""
    echo "Text & Infographics:"
    echo "  fal-ai/nano-banana-2         3s    ~7₽     Good text accuracy"
    echo "  fal-ai/nano-banana-pro       8s    ~13₽    Best text, 4K"
    echo ""
    echo "Design:"
    echo "  fal-ai/recraft/v4            5s    ~4₽     Marketing visuals"
    echo "  fal-ai/recraft/v4/pro        8s    ~22₽    Print quality"
    ;;

  video|text-to-video|t2v)
    echo -e "${CYAN}=== Video Generation ===${NC}"
    echo ""
    echo "Kling (best control):"
    echo "  fal-ai/kling-video/v2.5/turbo/text-to-video   5s    45s   ~50₽"
    echo "  fal-ai/kling-video/v3/text-to-video          15s   90s   ~150₽"
    echo "  fal-ai/kling-video/v2.5/turbo/image-to-video 5s    30s   ~40₽"
    echo ""
    echo "Other:"
    echo "  fal-ai/minimax-video/video-01    6s    60s   ~30₽"
    echo "  fal-ai/hunyuan-video             5s    120s  ~25₽"
    echo "  fal-ai/luma-dream-machine        5s    45s   ~35₽"
    ;;

  audio|tts|stt|speech)
    echo -e "${CYAN}=== Audio ===${NC}"
    echo ""
    echo "Text-to-Speech:"
    echo "  fal-ai/f5-tts           3s    ~2₽    Voice cloning, natural"
    echo "  fal-ai/playai/tts/v3    2s    ~3₽    High-quality voices"
    echo "  fal-ai/metavoice-v1     4s    ~2₽    Multi-language"
    echo ""
    echo "Speech-to-Text:"
    echo "  fal-ai/whisper          5s    ~1₽    Transcription"
    echo "  fal-ai/wizper           3s    ~1.5₽  Fast transcription"
    ;;

  upscale|sr|enhance)
    echo -e "${CYAN}=== Upscaling ===${NC}"
    echo ""
    echo "  fal-ai/aura-sr                  3s    ~2₽    4x upscale"
    echo "  fal-ai/clarity-upscaler         5s    ~3₽    Upscale + enhance"
    echo "  fal-ai/controlnet-tile-upscaler 8s    ~4₽    Detail preservation"
    ;;

  edit|rembg|background|face)
    echo -e "${CYAN}=== Image Editing ===${NC}"
    echo ""
    echo "Background Removal:"
    echo "  fal-ai/birefnet             2s    ~1₽    High quality"
    echo "  fal-ai/imageutils/rembg     1s    ~0.5₽  Fast"
    echo ""
    echo "Other:"
    echo "  fal-ai/face-swap            3s    ~2₽    Face replacement"
    echo "  fal-ai/flux/dev/image-to-image  12s  ~1.5₽ Style transfer"
    ;;

  vector|svg|logo)
    echo -e "${CYAN}=== Vector/SVG ===${NC}"
    echo ""
    echo "  fal-ai/recraft/v4/text-to-vector       5s    ~7₽    Logos, icons"
    echo "  fal-ai/recraft/v4/pro/text-to-vector   8s    ~25₽   Complex vector"
    echo ""
    echo "Tip: Use colors param for palette control:"
    echo '  {"colors":[{"r":26,"g":54,"b":93}]}'
    ;;

  flux*)
    echo -e "${CYAN}=== FLUX Models ===${NC}"
    echo ""
    echo "  fal-ai/flux/schnell              2s    ~0.3₽   Drafts"
    echo "  fal-ai/flux/dev                  10s   ~1.4₽   Final images"
    echo "  fal-ai/flux-pro/v1.1             15s   ~5₽     Professional"
    echo "  fal-ai/flux-pro/v1.1-ultra       20s   ~8₽     4MP high-res"
    echo "  fal-ai/flux/dev/image-to-image   12s   ~1.5₽   Style transfer"
    ;;

  nano*|banana*)
    echo -e "${CYAN}=== Nano Banana Models ===${NC}"
    echo ""
    echo "  fal-ai/nano-banana-2             3s    ~7₽     Fast, good text"
    echo "  fal-ai/nano-banana-pro           8s    ~13₽    4K, perfect text"
    echo "  fal-ai/gemini-25-flash-image     2s    ~4₽     Quick iterations"
    echo ""
    echo "Best for: Text in images, infographics, consistency"
    ;;

  recraft*)
    echo -e "${CYAN}=== Recraft Models ===${NC}"
    echo ""
    echo "Raster:"
    echo "  fal-ai/recraft/v4        5s    ~4₽     Marketing"
    echo "  fal-ai/recraft/v4/pro    8s    ~22₽    Print quality"
    echo ""
    echo "Vector (SVG):"
    echo "  fal-ai/recraft/v4/text-to-vector       5s    ~7₽"
    echo "  fal-ai/recraft/v4/pro/text-to-vector   8s    ~25₽"
    ;;

  kling*)
    echo -e "${CYAN}=== Kling Video Models ===${NC}"
    echo ""
    echo "Text-to-Video:"
    echo "  fal-ai/kling-video/v2.5/turbo/text-to-video   5s    45s   ~50₽"
    echo "  fal-ai/kling-video/v3/text-to-video          15s   90s   ~150₽"
    echo ""
    echo "Image-to-Video:"
    echo "  fal-ai/kling-video/v2.5/turbo/image-to-video 5s    30s   ~40₽"
    echo ""
    echo "Kling 3.0 features: 4K/60fps, multi-shot (6), dialogue, audio"
    ;;

  *)
    echo -e "${YELLOW}No exact match for '$1'${NC}"
    echo ""
    echo "Try one of these categories:"
    echo "  image, video, audio, upscale, edit, vector"
    echo ""
    echo "Or search by model family:"
    echo "  flux, nano, recraft, kling"
    ;;
esac

echo ""
echo -e "${GREEN}Docs:${NC} https://skill.neuroartist.ru/docs"
