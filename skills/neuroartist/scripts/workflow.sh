#!/bin/bash
# neuroartist workflow - chain multiple operations

set -e

API_URL="https://skill.neuroartist.ru/api/v1"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

usage() {
  echo "Usage: workflow.sh <workflow> [options]"
  echo ""
  echo "Workflows:"
  echo "  product <image_url>          Remove BG + Upscale 4x"
  echo "  hero <prompt>                Generate + Upscale 4x"
  echo "  social <prompt> <platform>   Generate for platform (vk, instagram, youtube, telegram)"
  echo "  animate <image_url> <motion> Image to video (Kling)"
  echo "  voiceover <text> [voice_url] Generate audio, optionally clone voice"
  echo ""
  echo "Examples:"
  echo "  workflow.sh product https://example.com/item.jpg"
  echo "  workflow.sh hero \"epic mountain landscape at sunset\""
  echo "  workflow.sh social \"cozy cafe interior\" vk"
  echo "  workflow.sh animate https://example.com/portrait.jpg \"she smiles and blinks\""
  echo "  workflow.sh voiceover \"Welcome to our channel\" https://example.com/voice.mp3"
  exit 1
}

if [ -z "$1" ]; then
  usage
fi

if [ -z "$NEUROARTIST_KEY" ]; then
  echo -e "${RED}✗ NEUROARTIST_KEY not set${NC}"
  echo "Run: export NEUROARTIST_KEY=na_live_xxx"
  exit 1
fi

WORKFLOW="$1"
shift

# Helper: generate sync and extract URL
generate_sync() {
  local model="$1"
  local input="$2"
  local response

  response=$(curl -s -X POST "${API_URL}/generate" \
    -H "Authorization: Bearer ${NEUROARTIST_KEY}" \
    -H "Content-Type: application/json" \
    -d "{\"m\":\"${model}\",\"i\":${input},\"s\":true}")

  if echo "$response" | grep -q '"e":'; then
    local error=$(echo "$response" | grep -o '"e":"[^"]*"' | cut -d'"' -f4)
    echo -e "${RED}✗ Error: ${error}${NC}" >&2
    exit 1
  fi

  echo "$response" | grep -o '"url":"[^"]*"' | cut -d'"' -f4
}

# Helper: generate async and return request ID
generate_async() {
  local model="$1"
  local input="$2"
  local response

  response=$(curl -s -X POST "${API_URL}/generate" \
    -H "Authorization: Bearer ${NEUROARTIST_KEY}" \
    -H "Content-Type: application/json" \
    -d "{\"m\":\"${model}\",\"i\":${input},\"s\":false}")

  if echo "$response" | grep -q '"e":'; then
    local error=$(echo "$response" | grep -o '"e":"[^"]*"' | cut -d'"' -f4)
    echo -e "${RED}✗ Error: ${error}${NC}" >&2
    exit 1
  fi

  echo "$response" | grep -o '"id":"[^"]*"' | cut -d'"' -f4
}

# Helper: poll until complete
poll_status() {
  local request_id="$1"
  local max_wait="${2:-120}"
  local elapsed=0

  while [ $elapsed -lt $max_wait ]; do
    local response=$(curl -s "${API_URL}/requests/${request_id}" \
      -H "Authorization: Bearer ${NEUROARTIST_KEY}")

    local status=$(echo "$response" | grep -o '"status":"[^"]*"' | cut -d'"' -f4)

    if [ "$status" = "completed" ]; then
      echo "$response" | grep -o '"url":"[^"]*"' | cut -d'"' -f4
      return 0
    elif [ "$status" = "failed" ]; then
      echo -e "${RED}✗ Generation failed${NC}" >&2
      exit 1
    fi

    echo -ne "\r  Status: ${status} (${elapsed}s)..." >&2
    sleep 5
    elapsed=$((elapsed + 5))
  done

  echo -e "${RED}✗ Timeout after ${max_wait}s${NC}" >&2
  exit 1
}

# Workflow: product (remove bg + upscale)
workflow_product() {
  local image_url="$1"

  if [ -z "$image_url" ]; then
    echo -e "${RED}✗ Image URL required${NC}"
    echo "Usage: workflow.sh product <image_url>"
    exit 1
  fi

  echo -e "${CYAN}📦 Product Workflow${NC}"
  echo "  Input: $image_url"
  echo ""

  echo -e "  ${YELLOW}Step 1/2: Removing background...${NC}"
  local nobg_url=$(generate_sync "fal-ai/birefnet" "{\"image_url\":\"${image_url}\"}")
  echo -e "  ${GREEN}✓${NC} Background removed"

  echo -e "  ${YELLOW}Step 2/2: Upscaling 4x...${NC}"
  local final_url=$(generate_sync "fal-ai/aura-sr" "{\"image_url\":\"${nobg_url}\"}")
  echo -e "  ${GREEN}✓${NC} Upscaled"

  echo ""
  echo -e "${GREEN}✓ Done!${NC}"
  echo "Result: $final_url"
}

# Workflow: hero (generate + upscale)
workflow_hero() {
  local prompt="$1"

  if [ -z "$prompt" ]; then
    echo -e "${RED}✗ Prompt required${NC}"
    echo "Usage: workflow.sh hero \"prompt\""
    exit 1
  fi

  echo -e "${CYAN}🦸 Hero Image Workflow${NC}"
  echo "  Prompt: $prompt"
  echo ""

  echo -e "  ${YELLOW}Step 1/2: Generating with FLUX Pro...${NC}"
  local gen_url=$(generate_sync "fal-ai/flux-pro/v1.1" "{\"prompt\":\"${prompt}\",\"image_size\":\"landscape_16_9\"}")
  echo -e "  ${GREEN}✓${NC} Generated"

  echo -e "  ${YELLOW}Step 2/2: Upscaling 4x...${NC}"
  local final_url=$(generate_sync "fal-ai/aura-sr" "{\"image_url\":\"${gen_url}\"}")
  echo -e "  ${GREEN}✓${NC} Upscaled"

  echo ""
  echo -e "${GREEN}✓ Done!${NC}"
  echo "Result: $final_url"
}

# Workflow: social (generate for platform)
workflow_social() {
  local prompt="$1"
  local platform="$2"

  if [ -z "$prompt" ] || [ -z "$platform" ]; then
    echo -e "${RED}✗ Prompt and platform required${NC}"
    echo "Usage: workflow.sh social \"prompt\" <platform>"
    echo "Platforms: vk, instagram, youtube, telegram, story"
    exit 1
  fi

  local size
  case "$platform" in
    vk)        size="square" ;;
    instagram) size="portrait_4_3" ;;
    youtube)   size="landscape_16_9" ;;
    telegram)  size="square" ;;
    story)     size="portrait_16_9" ;;
    *)
      echo -e "${RED}✗ Unknown platform: $platform${NC}"
      echo "Supported: vk, instagram, youtube, telegram, story"
      exit 1
      ;;
  esac

  echo -e "${CYAN}📱 Social Media Workflow${NC}"
  echo "  Platform: $platform"
  echo "  Size: $size"
  echo "  Prompt: $prompt"
  echo ""

  echo -e "  ${YELLOW}Generating...${NC}"
  local url=$(generate_sync "fal-ai/flux/dev" "{\"prompt\":\"${prompt}\",\"image_size\":\"${size}\"}")

  echo ""
  echo -e "${GREEN}✓ Done!${NC}"
  echo "Result: $url"
}

# Workflow: animate (image to video)
workflow_animate() {
  local image_url="$1"
  local motion="$2"

  if [ -z "$image_url" ] || [ -z "$motion" ]; then
    echo -e "${RED}✗ Image URL and motion description required${NC}"
    echo "Usage: workflow.sh animate <image_url> \"motion description\""
    exit 1
  fi

  echo -e "${CYAN}🎬 Animation Workflow${NC}"
  echo "  Image: $image_url"
  echo "  Motion: $motion"
  echo ""

  echo -e "  ${YELLOW}Generating video (this may take 30-60s)...${NC}"
  local request_id=$(generate_async "fal-ai/kling-video/v2.5/turbo/image-to-video" "{\"image_url\":\"${image_url}\",\"prompt\":\"${motion}\"}")

  echo "  Request ID: $request_id"
  local url=$(poll_status "$request_id" 120)
  echo ""

  echo ""
  echo -e "${GREEN}✓ Done!${NC}"
  echo "Video: $url"
}

# Workflow: voiceover (TTS with optional voice cloning)
workflow_voiceover() {
  local text="$1"
  local voice_url="$2"

  if [ -z "$text" ]; then
    echo -e "${RED}✗ Text required${NC}"
    echo "Usage: workflow.sh voiceover \"text\" [voice_url]"
    exit 1
  fi

  echo -e "${CYAN}🎙️ Voiceover Workflow${NC}"
  echo "  Text: $text"

  local input
  if [ -n "$voice_url" ]; then
    echo "  Voice: $voice_url (cloning)"
    echo ""
    echo -e "  ${YELLOW}Note: For voice cloning, provide transcript as 3rd argument${NC}"
    input="{\"gen_text\":\"${text}\",\"ref_audio_url\":\"${voice_url}\"}"
  else
    echo ""
    input="{\"gen_text\":\"${text}\"}"
  fi

  echo -e "  ${YELLOW}Generating audio...${NC}"
  local url=$(generate_sync "fal-ai/f5-tts" "$input")

  echo ""
  echo -e "${GREEN}✓ Done!${NC}"
  echo "Audio: $url"
}

# Run workflow
case "$WORKFLOW" in
  product)   workflow_product "$@" ;;
  hero)      workflow_hero "$@" ;;
  social)    workflow_social "$@" ;;
  animate)   workflow_animate "$@" ;;
  voiceover) workflow_voiceover "$@" ;;
  *)
    echo -e "${RED}✗ Unknown workflow: $WORKFLOW${NC}"
    usage
    ;;
esac
