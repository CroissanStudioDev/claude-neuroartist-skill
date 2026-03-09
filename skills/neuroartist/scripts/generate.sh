#!/bin/bash
# neuroartist generate - quick image generation

set -e

API_URL="https://skill.neuroartist.ru/api/v1"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

usage() {
  echo "Usage: generate.sh \"prompt\" [model] [size]"
  echo ""
  echo "Arguments:"
  echo "  prompt   Text description (required)"
  echo "  model    Model ID (default: fal-ai/flux/schnell)"
  echo "  size     Image size (default: square)"
  echo ""
  echo "Sizes: square, square_hd, portrait_4_3, portrait_16_9, landscape_4_3, landscape_16_9"
  echo ""
  echo "Examples:"
  echo "  generate.sh \"sunset over mountains\""
  echo "  generate.sh \"cat portrait\" fal-ai/flux/dev portrait_4_3"
  echo "  generate.sh \"logo NEXUS\" fal-ai/recraft/v4/text-to-vector square"
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

PROMPT="$1"
MODEL="${2:-fal-ai/flux/schnell}"
SIZE="${3:-square}"

echo "🎨 Generating..."
echo "  Model: $MODEL"
echo "  Size: $SIZE"
echo "  Prompt: $PROMPT"
echo ""

RESPONSE=$(curl -s -X POST "${API_URL}/generate" \
  -H "Authorization: Bearer ${NEUROARTIST_KEY}" \
  -H "Content-Type: application/json" \
  -d "{\"m\":\"${MODEL}\",\"i\":{\"prompt\":\"${PROMPT}\",\"image_size\":\"${SIZE}\"},\"s\":true}")

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
