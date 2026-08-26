#!/usr/bin/env bash
# Publish local edits to https://dsafjk0024.github.io
#     ./publish.sh                 -> commits edits to files already on the site
#     ./publish.sh "새 결과 추가"   -> same, with your own commit message
#
# Only files git already tracks are committed. New files are listed, not added:
# this directory also holds raw footage, PDFs and personal documents, and one
# `git add -A` is all it takes to publish one of them to the open internet.
# To add a genuinely new page or asset:  git add <path>  then ./publish.sh
set -euo pipefail
cd "$(dirname "$0")"

untracked="$(git ls-files --others --exclude-standard)"
if [ -n "$untracked" ]; then
  echo "새 파일 (이번에 안 올라감 — 올리려면 git add <path>):"
  echo "$untracked" | sed 's/^/  /'
  echo
fi

if git diff --quiet && git diff --cached --quiet; then
  echo "변경 없음 — 올릴 것이 없습니다."
  exit 0
fi

git add -u                      # tracked files only
git status --short
git commit -m "${1:-Update site ($(date +%Y-%m-%d))}"
git push

echo
echo "푸시 완료. 30~60초 후 반영: https://dsafjk0024.github.io"
echo "브라우저에 옛 화면이 남으면 Cmd+Shift+R 로 강제 새로고침."
