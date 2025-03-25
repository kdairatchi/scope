#!/bin/bash
# recon.sh - Smart Recon Module

set -e
mkdir -p recon_output

cat inscope_domains.txt newdata_inscope_domains.txt | sort -u > all_targets.txt

subfinder -dL all_targets.txt -silent | tee recon_output/subs.txt

katana -list recon_output/subs.txt -d 2 -silent | tee recon_output/katana.txt

waybackurls < recon_output/subs.txt | tee recon_output/wayback.txt

cat recon_output/katana.txt recon_output/wayback.txt | grep -E '^https?://' | sort -u > recon_output/all_urls.txt

DATE=$(date +%Y%m%d%H%M%S)
echo "\n[RECON $DATE]" >> scans/history.log
cat recon_output/all_urls.txt >> scans/history.log


# zap_scan.sh - Smart ZAP Scan
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
