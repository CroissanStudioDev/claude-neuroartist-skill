#!/bin/bash
# neuroartist upscale - upscale images 4x

set -e

API_URL="https://skill.neuroartist.ru/api/v1"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

usage() {
  echo "Usage: upscale.sh <image_url> [model]"
  echo ""
  echo "Arguments:"
  echo "  image_url  URL of image to upscale (required)"
  echo "  model      Model ID (default: fal-ai/aura-sr)"
  echo ""
  echo "Models:"
  echo "  fal-ai/aura-sr         Fast 4x upscale (~2₽)"
  echo "  fal-ai/clarity-upscaler Upscale + enhance (~3₽)"
  echo ""
  echo "Examples:"
  echo "  upscale.sh https://example.com/photo.jpg"
  echo "  upscale.sh https://example.com/photo.jpg fal-ai/clarity-upscaler"
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

IMAGE_URL="$1"
MODEL="${2:-fal-ai/aura-sr}"

echo "🔍 Upscaling..."
echo "  Model: $MODEL"
echo "  Image: $IMAGE_URL"
echo ""

RESPONSE=$(curl -s -X POST "${API_URL}/generate" \
  -H "Authorization: Bearer ${NEUROARTIST_KEY}" \
  -H "Content-Type: application/json" \
  -d "{\"m\":\"${MODEL}\",\"i\":{\"image_url\":\"${IMAGE_URL}\"},\"s\":true}")

# Check for error
if echo "$RESPONSE" | grep -q '"e":'; then
  ERROR=$(echo "$RESPONSE" | grep -o '"e":"[^"]*"' | cut -d'"' -f4)
  echo -e "${RED}✗ Error: ${ERROR}${NC}"
  exit 1
fi

# Extract URL and time
URL=$(echo "$RESPONSE" | grep -o '"url":"[^"]*"' | cut -d'"' -f4)
MS=$(echo "$RESPONSE" | grep -o '"ms":[0-9]*' | cut -d: -f2)

if [ -n "$URL" ]; then
  echo -e "${GREEN}✓ Done in ${MS}ms${NC}"
  echo ""
  echo "Result: $URL"
else
  echo -e "${RED}✗ Unexpected response${NC}"
  echo "$RESPONSE"
  exit 1
fi
