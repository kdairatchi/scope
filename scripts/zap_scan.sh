#!/bin/bash

mkdir -p zap_reports
DATE=$(date +%Y%m%d%H%M%S)
grep -E '^https?://' recon_output/all_urls.txt | sort -u > recon_output/zap_targets.txt

while read -r target; do
  if [[ -n "$target" ]]; then
    echo "\n⚔️ Running ZAP on $target"
    docker run --rm -v $(pwd):/zap/wrk/:rw -t owasp/zap2docker-stable zap-full-scan.py \
      -t "$target" \
      -r "zap_reports/zap_${DATE}_${target//[^a-zA-Z0-9]/_}.html" \
      -g gen.conf \
      -J "zap_reports/zap_${DATE}_${target//[^a-zA-Z0-9]/_}.json" \
      -z "-config view.locale=en_GB"
  fi
done < recon_output/zap_targets.txt
