#!/bin/bash
# dastardly_scan.sh - Automated Dastardly scan using Docker

set -e

# Ensure output directory exists
mkdir -p dastardly_reports
mkdir -p scans

# Validate input file
URL_LIST="recon_output/all_urls.txt"
if [ ! -f "$URL_LIST" ]; then
  echo "❌ URL list not found at $URL_LIST"
  exit 1
fi

# Loop through URLs and scan
while read -r url; do
  if [[ -n "$url" ]]; then
    SAFE_NAME=$(echo "$url" | tr -cd '[:alnum:]' | cut -c1-40)
    REPORT_NAME="dastardly_reports/report_${SAFE_NAME}.xml"

    echo "🚀 Scanning $url with Dastardly..."

    docker run --rm \
      -v "$(pwd)":/github/workspace \
      --add-host=host.docker.internal:host-gateway \
      ghcr.io/portswigger/dastardly:latest \
      "$url" || echo "⚠️ Scan failed for $url"

    # Dastardly writes to a default location; move report
    if [ -f dastardly-report.xml ]; then
      mv dastardly-report.xml "$REPORT_NAME"
    fi
  fi
done < "$URL_LIST"

# Log summary
ls -lh dastardly_reports | tee scans/dastardly_summary.log | notify -p discord -c notify.conf

echo "✅ All Dastardly scans completed. Reports saved in dastardly_reports/"
