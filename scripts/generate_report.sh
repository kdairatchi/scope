mkdir -p scans
DATE=$(date +%Y%m%d%H%M%S)
echo "# 🔍 Scan Summary - $DATE" > scans/scan_summary.md
echo "\n## 🔹 ZAP Reports" >> scans/scan_summary.md
ls zap_reports/*.html >> scans/scan_summary.md
echo "\n## 🔸 Nuclei Results" >> scans/scan_summary.md
echo '\n\`\`\`' >> scans/scan_summary.md
cat nuclei.log >> scans/scan_summary.md
echo '\n\`\`\`' >> scans/scan_summary.md
