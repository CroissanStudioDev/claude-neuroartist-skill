#!/bin/bash
# neuroartist tts - text-to-speech with optional voice cloning

set -e

API_URL="https://skill.neuroartist.ru/api/v1"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

usage() {
  echo "Usage: tts.sh \"text\" [voice_url] [voice_transcript]"
  echo ""
  echo "Arguments:"
  echo "  text             Text to speak (required)"
  echo "  voice_url        Reference audio URL for voice cloning (optional)"
  echo "  voice_transcript Transcript of reference audio (required if voice_url)"
  echo ""
  echo "Model: fal-ai/f5-tts (~2₽)"
  echo ""
  echo "Examples:"
  echo "  # Basic TTS"
  echo "  tts.sh \"Hello, this is a test message.\""
  echo ""
  echo "  # Voice cloning"
  echo "  tts.sh \"New text in cloned voice\" https://example.com/voice.mp3 \"Original text\""
  echo ""
  echo "Tips for voice cloning:"
  echo "  - Use 10-30 second clean audio sample"
  echo "  - Provide accurate transcript of reference audio"
  echo "  - Same language as target text works best"
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

TEXT="$1"
VOICE_URL="$2"
VOICE_TRANSCRIPT="$3"
MODEL="fal-ai/f5-tts"

echo "🎙️  Generating speech..."
echo "  Model: $MODEL"
echo "  Text: $TEXT"

# Build request body
if [ -n "$VOICE_URL" ]; then
  if [ -z "$VOICE_TRANSCRIPT" ]; then
    echo -e "${RED}✗ Voice transcript required for voice cloning${NC}"
    echo "Usage: tts.sh \"text\" <voice_url> \"transcript of voice sample\""
    exit 1
  fi
  echo "  Voice: $VOICE_URL"
  echo ""
  BODY="{\"m\":\"${MODEL}\",\"i\":{\"gen_text\":\"${TEXT}\",\"ref_audio_url\":\"${VOICE_URL}\",\"ref_text\":\"${VOICE_TRANSCRIPT}\"},\"s\":true}"
else
  echo ""
  BODY="{\"m\":\"${MODEL}\",\"i\":{\"gen_text\":\"${TEXT}\"},\"s\":true}"
fi

RESPONSE=$(curl -s -X POST "${API_URL}/generate" \
  -H "Authorization: Bearer ${NEUROARTIST_KEY}" \
  -H "Content-Type: application/json" \
  -d "$BODY")

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
  echo "Audio: $URL"
else
  echo -e "${RED}✗ Unexpected response${NC}"
  echo "$RESPONSE"
  exit 1
fi
