#!/bin/bash
# neuroartist rembg - remove background from images

set -e

API_URL="https://skill.neuroartist.ru/api/v1"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

usage() {
  echo "Usage: rembg.sh <image_url> [model]"
  echo ""
  echo "Arguments:"
  echo "  image_url  URL of image to process (required)"
  echo "  model      Model ID (default: fal-ai/birefnet)"
  echo ""
  echo "Models:"
  echo "  fal-ai/birefnet         High quality (~1₽)"
  echo "  fal-ai/imageutils/rembg Fast processing (~0.5₽)"
  echo ""
  echo "Examples:"
  echo "  rembg.sh https://example.com/product.jpg"
  echo "  rembg.sh https://example.com/photo.jpg fal-ai/imageutils/rembg"
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
MODEL="${2:-fal-ai/birefnet}"

echo "✂️  Removing background..."
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
