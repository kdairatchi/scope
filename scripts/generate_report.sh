#!/bin/bash

mkdir -p scans
DATE=$(date +%Y%m%d%H%M%S)
echo "# 🔍 Scan Summary - $DATE" > scans/scan_summary.md

echo "\n## 🔹 ZAP Reports" >> scans/scan_summary.md
ls zap_reports/*.html >> scans/scan_summary.md

echo "\n## 🔸 Nuclei Results" >> scans/scan_summary.md
echo '\n```' >> scans/scan_summary.md
cat nuclei.log >> scans/scan_summary.md
echo '\n```' >> scans/scan_summary.md

echo "\n## 🕵️ Sqry Dorking Results" >> scans/scan_summary.md
echo '\n```' >> scans/scan_summary.md
cat recon_output/sqry/* >> scans/scan_summary.md
echo '\n```' >> scans/scan_summary.md

echo "\n## 🕵️ Loxs IP Analysis Results" >> scans/scan_summary.md
echo '\n```' >> scans/scan_summary.md
cat recon_output/loxs/loxs_results.json >> scans/scan_summary.md
echo '\n```' >> scans/scan_summary.md
