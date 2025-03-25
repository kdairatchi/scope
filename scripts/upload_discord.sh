#!/bin/bash

curl -H "Content-Type: application/json" \
     -X POST \
     -d '{"content": "✅ Full smart scan completed and reports uploaded."}' \
     $DISCORD_WEBHOOK
