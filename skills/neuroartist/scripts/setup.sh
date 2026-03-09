#!/bin/bash
# neuroartist setup - verify API key and show account info

set -e

API_URL="https://skill.neuroartist.ru/api/v1"
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Check for API key
if [ -z "$NEUROARTIST_KEY" ]; then
  echo -e "${RED}✗ NEUROARTIST_KEY not set${NC}"
  echo ""
  echo "Set your API key:"
  echo "  export NEUROARTIST_KEY=na_live_xxx"
  echo ""
  echo "Get key at: https://skill.neuroartist.ru/dashboard/tokens"
  exit 1
fi

echo "🎨 neuroartist setup"
echo ""

# Check API key validity and get balance
echo -n "Checking API key... "
BALANCE_RESPONSE=$(curl -s -w "\n%{http_code}" "${API_URL}/balance" \
  -H "Authorization: Bearer ${NEUROARTIST_KEY}")

HTTP_CODE=$(echo "$BALANCE_RESPONSE" | tail -n 1)
BODY=$(echo "$BALANCE_RESPONSE" | sed '$d')

if [ "$HTTP_CODE" = "200" ]; then
  echo -e "${GREEN}✓ Valid${NC}"

  BALANCE_RUB=$(echo "$BODY" | grep -o '"balance_rub":[0-9.]*' | cut -d: -f2)
  TIER=$(echo "$BODY" | grep -o '"tier":[0-9]*' | cut -d: -f2)

  echo ""
  echo "Account:"
  echo "  Balance: ${BALANCE_RUB}₽"
  echo "  Tier: ${TIER}"
elif [ "$HTTP_CODE" = "401" ]; then
  echo -e "${RED}✗ Invalid key${NC}"
  echo ""
  echo "Check your API key at: https://skill.neuroartist.ru/dashboard/tokens"
  exit 1
else
  echo -e "${RED}✗ Error (HTTP ${HTTP_CODE})${NC}"
  exit 1
fi

echo ""
echo -e "${GREEN}✓ Setup complete!${NC}"
echo ""
echo "Quick commands:"
echo "  Generate image:  curl -X POST ${API_URL}/generate -H 'Authorization: Bearer \$NEUROARTIST_KEY' -d '{\"m\":\"fal-ai/flux/schnell\",\"i\":{\"prompt\":\"...\"},\"s\":true}'"
echo "  Check balance:   curl ${API_URL}/balance -H 'Authorization: Bearer \$NEUROARTIST_KEY'"
echo ""
echo "Docs: https://skill.neuroartist.ru/docs"
