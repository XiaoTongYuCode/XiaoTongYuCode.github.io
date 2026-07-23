#!/usr/bin/env bash
set -euo pipefail

site_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
output_pdf="${site_root}/assets/xiaotongyu-resume.pdf"

if [[ -n "${CHROME_BIN:-}" ]]; then
  chrome_bin="${CHROME_BIN}"
elif [[ -x "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" ]]; then
  chrome_bin="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
elif command -v google-chrome >/dev/null 2>&1; then
  chrome_bin="$(command -v google-chrome)"
elif command -v chromium >/dev/null 2>&1; then
  chrome_bin="$(command -v chromium)"
else
  echo "未找到 Chrome/Chromium；可通过 CHROME_BIN 指定可执行文件。" >&2
  exit 1
fi

"${chrome_bin}" \
  --headless=new \
  --disable-gpu \
  --no-sandbox \
  --allow-file-access-from-files \
  --no-pdf-header-footer \
  --print-to-pdf="${output_pdf}" \
  "file://${site_root}/index.html"

if command -v pdfinfo >/dev/null 2>&1; then
  page_count="$(pdfinfo "${output_pdf}" | awk '/^Pages:/ {print $2}')"
  if [[ "${page_count}" != "2" ]]; then
    echo "PDF 页数异常：期望 2 页，实际 ${page_count} 页。" >&2
    exit 1
  fi
fi

echo "已生成 ${output_pdf}"
