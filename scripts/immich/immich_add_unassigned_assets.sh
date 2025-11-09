#!/usr/bin/env bash

#------------------------------------------------------------------------------
# script name: immich_add_unassigned_assets.sh
# description:
#   Finds all assets in immich that are not currently assigned to any album
#   and adds them to a specified album. Supports batching and dry-run mode.
#
# usage:
#   ./immich_add_unassigned_assets.sh \
#     --api-key <API_KEY> \
#     --album-id <ALBUM_ID> \
#     [--url http://localhost:2283] \
#     [--taken-after 2020-01-01T00:00:00Z] \
#     [--batch-size 100] \
#     [--dry-run true|false]
#
# example:
#   ./immich_add_unassigned_assets.sh \
#     --api-key "123" \
#     --album-id "abc123" \
#     --url "http://immich.local:2283" \
#     --dry-run false
#
# dependencies:
#   - curl
#   - jq
#
# author: Jonathan Warykowski
#------------------------------------------------------------------------------
set -euo pipefail

IMMICH_URL="http://localhost:2283"
TAKEN_AFTER="2020-01-01T00:00:00Z"
BATCH_SIZE=100
DRY_RUN="true"
API_KEY=""
ALBUM_ID=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --api-key) API_KEY="$2"; shift 2 ;;
    --album-id) ALBUM_ID="$2"; shift 2 ;;
    --url) IMMICH_URL="$2"; shift 2 ;;
    --taken-after) TAKEN_AFTER="$2"; shift 2 ;;
    --batch-size) BATCH_SIZE="$2"; shift 2 ;;
    --dry-run) DRY_RUN="$2"; shift 2 ;;
    -h|--help)
      grep '^#' "$0" | cut -c 3-
      exit 0
      ;;
    *)
      echo "Unknown argument: $1"
      exit 1
      ;;
  esac
done

[[ -z "$API_KEY" ]] && { echo "missing required argument: --api-key"; exit 1; }
[[ -z "$ALBUM_ID" ]] && { echo "missing required argument: --album-id"; exit 1; }

echo -e "searching for assets not in any album taken after $TAKEN_AFTER"

PAGE=1
ASSET_IDS=()

while true; do
  echo -e "\nfetching page $PAGE"

  RESPONSE=$(curl -s -X POST \
    -H "Content-Type: application/json" \
    -d "{\"isNotInAlbum\": true, \"withExif\": true, \"isVisible\": true, \"takenAfter\": \"$TAKEN_AFTER\", \"page\": $PAGE}" \
    "$IMMICH_URL/api/search/metadata?apiKey=$API_KEY")

  RESPONSE_ERROR=$(echo "$RESPONSE" | jq -r '.error')

  if [[ -n "$RESPONSE_ERROR" && "$RESPONSE_ERROR" != "null" ]]; then
    echo "api error: $RESPONSE_ERROR"
    exit 1
  fi

  PAGE_ASSETS=$(echo "$RESPONSE" | jq -r '.assets.items[].id')
  NEXT_PAGE=$(echo "$RESPONSE" | jq -r '.assets.nextPage')

  if [[ -z "$PAGE_ASSETS" ]]; then
    echo "no assets found on page $PAGE"
  else
    COUNT=$(echo "$PAGE_ASSETS" | wc -l | tr -d '[:space:]')
    echo "found $COUNT assets."
    while IFS= read -r ASSET_ID; do
      ASSET_IDS+=("$ASSET_ID")
    done <<< "$PAGE_ASSETS"
  fi

  if [[ -z "$NEXT_PAGE" || "$NEXT_PAGE" == "null" ]]; then
    break
  fi

  PAGE=$((PAGE + 1))
done

TOTAL=${#ASSET_IDS[@]}

if (( TOTAL == 0 )); then
  echo "no unassigned assets found after $TAKEN_AFTER"
  exit 0
fi

echo -e "\nprocessing $TOTAL assets"

for ((i=0; i<TOTAL; i+=BATCH_SIZE)); do
  CHUNK=()
  for id in "${ASSET_IDS[@]:i:BATCH_SIZE}"; do
    [[ -n "$id" ]] && CHUNK+=("$id")
  done

  (( ${#CHUNK[@]} == 0 )) && { echo "skipping empty batch $((i/BATCH_SIZE+1))"; continue; }

  echo "processing chunk $((i/BATCH_SIZE+1)) with ${#CHUNK[@]} assets"

  [[ "$DRY_RUN" == "true" ]] && continue

  IDS_JSON=$(printf '%s\n' "${CHUNK[@]}" | jq -R . | jq -s .)

  RESPONSE=$(curl -s -X PUT \
    -H "Content-Type: application/json" \
    -d "{\"ids\": $IDS_JSON}" \
    "$IMMICH_URL/api/albums/$ALBUM_ID/assets?apiKey=$API_KEY")

  SUCCESS_COUNT=$(echo "$RESPONSE" | jq '[.[] | select(.success == true)] | length')
  ERROR_COUNT=$(echo "$RESPONSE" | jq '[.[] | select(.success == false)] | length')

  echo "successes: $SUCCESS_COUNT"
  echo "failures:  $ERROR_COUNT"

  if (( ERROR_COUNT > 0 )); then
    echo "failed asset details:"
    echo "$RESPONSE" | jq -r '.[] | select(.success == false) | "ID: \(.id), Success: \(.success), Error: \(.error)"'
    exit 1
  fi
done

if [[ "$DRY_RUN" == "true" ]]; then
    echo -e "\ndry run: skipped adding $TOTAL assets to album $ALBUM_ID"
else
    echo -e "\nadded $TOTAL assets to album $ALBUM_ID"
fi
