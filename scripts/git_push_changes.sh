#!/bin/bash

set -e
git config --global user.name 'GitHub Actions'
git config --global user.email 'actions@users.noreply.github.com'
git add .

if ! git diff --cached --exit-code; then
  IST_DATE=$(TZ='Asia/Kolkata' date +'%a %b %d %H:%M:%S IST %Y')
  git commit -m "Smart Scan Update: $IST_DATE"
  git pull --rebase origin main
  git push origin main
else
  echo "No changes to commit"
fi
