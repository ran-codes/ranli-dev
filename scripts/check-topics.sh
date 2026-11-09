#!/usr/bin/env sh
# Every `topics:` value in a tidbit's front matter must name a folder under glossary/.
# Usage: scripts/check-topics.sh   (exit 1 on any unknown topic)
cd "$(dirname "$0")/.." || exit 1
fail=0
for f in tidbits/*.md tidbits/*.qmd tidbits/*/index.qmd; do
  [ -f "$f" ] || continue
  line=$(grep -m1 '^topics:' "$f") || continue
  for t in $(printf '%s' "$line" | sed 's/^topics:[[:space:]]*\[\(.*\)\].*/\1/' | tr ',' ' '); do
    [ -d "glossary/$t" ] || { echo "$f: unknown topic '$t' (no glossary/$t/)"; fail=1; }
  done
done
[ $fail -eq 0 ] && echo "topics ok"
exit $fail
