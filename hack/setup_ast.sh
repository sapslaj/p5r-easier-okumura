#!/bin/bash
set -euo pipefail

if ! command -v curl &> /dev/null; then
  echo "curl is not intalled. Please install curl to run this script."
  exit 1
fi
if ! command -v jq &> /dev/null; then
  echo "jq is not intalled. Please install jq to run this script."
  exit 1
fi
if ! command -v unzip &> /dev/null; then
  echo "unzip is not intalled. Please install unzip to run this script."
  exit 1
fi

latest_release="$(curl -sSL https://api.github.com/repos/tge-was-taken/Atlus-Script-Tools/releases/latest)"
download_url="$(jq -r '.assets[] | select(.content_type == "application/x-zip-compressed") | .browser_download_url' <<<"$latest_release")"
outzip="AtlusScriptToolchain.zip"
curl -sSL "$download_url" -o "$outzip"
unzip "$outzip" -d AtlusScriptToolchain
rm -f "$outzip"
