#!/bin/bash
# recon.sh - Smart Recon Module

set -e
mkdir -p recon_output scans

# ✅ Correct file paths
cat data/Domains/inscope_domains.txt data/NewData/newdata_inscope_domains.txt | sort -u > all_targets.txt

# Run recon tools
subfinder -dL all_targets.txt -silent | tee recon_output/subs.txt
katana -list recon_output/subs.txt -d 2 -silent | tee recon_output/katana.txt
waybackurls < recon_output/subs.txt | tee recon_output/wayback.txt

# Merge URLs
cat recon_output/katana.txt recon_output/wayback.txt | grep -E '^https?://' | sort -u > recon_output/all_urls.txt

# Log output to history
DATE=$(date +%Y%m%d%H%M%S)
echo -e "\n[RECON $DATE]" >> scans/history.log
cat recon_output/all_urls.txt >> scans/history.log

