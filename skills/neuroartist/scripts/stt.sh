#!/bin/bash
# neuroartist stt - speech-to-text transcription

set -e

API_URL="https://skill.neuroartist.ru/api/v1"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

usage() {
  echo "Usage: stt.sh <audio_url> [model]"
  echo ""
  echo "Arguments:"
  echo "  audio_url  URL of audio to transcribe (required)"
  echo "  model      Model ID (default: fal-ai/whisper)"
  echo ""
  echo "Models:"
  echo "  fal-ai/whisper  Accurate transcription (~1₽)"
  echo "  fal-ai/wizper   Fast transcription (~1.5₽)"
  echo ""
  echo "Supported formats: mp3, wav, m4a, ogg, webm"
  echo ""
  echo "Examples:"
  echo "  stt.sh https://example.com/recording.mp3"
  echo "  stt.sh https://example.com/podcast.mp3 fal-ai/wizper"
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

AUDIO_URL="$1"
MODEL="${2:-fal-ai/whisper}"

echo "📝 Transcribing..."
echo "  Model: $MODEL"
echo "  Audio: $AUDIO_URL"
echo ""

RESPONSE=$(curl -s -X POST "${API_URL}/generate" \
  -H "Authorization: Bearer ${NEUROARTIST_KEY}" \
  -H "Content-Type: application/json" \
  -d "{\"m\":\"${MODEL}\",\"i\":{\"audio_url\":\"${AUDIO_URL}\"},\"s\":true}")

# Check for error
if echo "$RESPONSE" | grep -q '"e":'; then
  ERROR=$(echo "$RESPONSE" | grep -o '"e":"[^"]*"' | cut -d'"' -f4)
  echo -e "${RED}✗ Error: ${ERROR}${NC}"
  exit 1
fi

# Extract text and time
TEXT=$(echo "$RESPONSE" | grep -o '"text":"[^"]*"' | cut -d'"' -f4)
MS=$(echo "$RESPONSE" | grep -o '"ms":[0-9]*' | cut -d: -f2)

if [ -n "$TEXT" ]; then
  echo -e "${GREEN}✓ Done in ${MS}ms${NC}"
  echo ""
  echo "Transcript:"
  echo "$TEXT"
else
  echo -e "${RED}✗ Unexpected response${NC}"
  echo "$RESPONSE"
  exit 1
fi
