#!/usr/bin/env bash
# Publish local edits to https://dsafjk0024.github.io
#     ./publish.sh                 -> commits everything with a timestamp message
#     ./publish.sh "새 결과 추가"   -> commits with your own message
set -euo pipefail
cd "$(dirname "$0")"

if git diff --quiet && git diff --cached --quiet && [ -z "$(git status --porcelain)" ]; then
  echo "변경 없음 — 올릴 것이 없습니다."
  exit 0
fi

git add -A
git status --short
git commit -m "${1:-Update site ($(date +%Y-%m-%d))}"
git push

echo
echo "푸시 완료. 30~60초 후 반영: https://dsafjk0024.github.io"
echo "브라우저에 옛 화면이 남으면 Cmd+Shift+R 로 강제 새로고침."
