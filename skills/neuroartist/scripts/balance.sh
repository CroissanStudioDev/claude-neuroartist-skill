#!/bin/bash
# neuroartist balance - check account balance

set -e

API_URL="https://skill.neuroartist.ru/api/v1"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

if [ -z "$NEUROARTIST_KEY" ]; then
  echo -e "${RED}✗ NEUROARTIST_KEY not set${NC}"
  echo "Run: export NEUROARTIST_KEY=na_live_xxx"
  exit 1
fi

RESPONSE=$(curl -s "${API_URL}/balance" \
  -H "Authorization: Bearer ${NEUROARTIST_KEY}")

# Check for error
if echo "$RESPONSE" | grep -q '"e":'; then
  ERROR=$(echo "$RESPONSE" | grep -o '"e":"[^"]*"' | cut -d'"' -f4)
  echo -e "${RED}✗ Error: ${ERROR}${NC}"
  exit 1
fi

BALANCE_KOPECKS=$(echo "$RESPONSE" | grep -o '"balance_kopecks":[0-9]*' | cut -d: -f2)
BALANCE_RUB=$(echo "$RESPONSE" | grep -o '"balance_rub":[0-9.]*' | cut -d: -f2)
TIER=$(echo "$RESPONSE" | grep -o '"tier":[0-9]*' | cut -d: -f2)

echo "💰 neuroartist Balance"
echo ""
echo "  Balance: ${BALANCE_RUB}₽"
echo "  Tier: ${TIER}"
echo ""

# Estimate what you can generate
if [ -n "$BALANCE_KOPECKS" ]; then
  FLUX_SCHNELL=$((BALANCE_KOPECKS / 30))
  FLUX_DEV=$((BALANCE_KOPECKS / 140))
  NANO_PRO=$((BALANCE_KOPECKS / 1300))
  VIDEO=$((BALANCE_KOPECKS / 5000))

  echo "Estimated generations:"
  echo "  ~${FLUX_SCHNELL} FLUX Schnell (drafts)"
  echo "  ~${FLUX_DEV} FLUX Dev (quality)"
  echo "  ~${NANO_PRO} Nano Banana Pro (text)"
  echo "  ~${VIDEO} Kling videos (5s)"
fi

echo ""
echo "Top up: https://skill.neuroartist.ru/dashboard/billing"
