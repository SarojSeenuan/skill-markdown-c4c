#!/usr/bin/env bash
# markdown-c4c skill パッケージを Claude Web 互換 ZIP として生成する (macOS / Linux)
#
# - skill/ 配下を ZIP ルートの markdown-c4c/ に再配置
# - 標準 zip コマンドは forward slash `/` を使うため OK
# - SKILL.md frontmatter から version を読み取り、出力名を自動設定
# - __MACOSX / .DS_Store / Thumbs.db / *.pdf / .git は除外

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="${1:-$SCRIPT_DIR/../skill}"
OUTPUT_DIR="${2:-$SCRIPT_DIR/..}"
SKILL_NAME="markdown-c4c"

SOURCE_DIR="$(cd "$SOURCE_DIR" && pwd)"
OUTPUT_DIR="$(cd "$OUTPUT_DIR" && pwd)"

# ─── Read version from SKILL.md frontmatter ──────────────────────────────
SKILL_MD="$SOURCE_DIR/SKILL.md"
if [[ ! -f "$SKILL_MD" ]]; then
  echo "ERROR: SKILL.md not found at $SKILL_MD" >&2
  exit 1
fi

VERSION="$(grep -E '^version:' "$SKILL_MD" | head -n1 | sed -E 's/^version:[[:space:]]*"?([^"]+)"?[[:space:]]*$/\1/')"
if [[ -z "$VERSION" ]]; then
  echo "ERROR: Could not read version from $SKILL_MD" >&2
  exit 1
fi

echo "[build-zip] Detected version: $VERSION"

ZIP_NAME="${SKILL_NAME}-v${VERSION}.zip"
ZIP_PATH="$OUTPUT_DIR/$ZIP_NAME"

[[ -f "$ZIP_PATH" ]] && rm -f "$ZIP_PATH"

# ─── Stage to temp dir so ZIP root is exactly $SKILL_NAME/ ───────────────
TMP_DIR="$(mktemp -d)"
trap 'rm -rf "$TMP_DIR"' EXIT

STAGE="$TMP_DIR/$SKILL_NAME"
mkdir -p "$STAGE"

# Copy skill/ contents into stage. Prefer rsync when available, fallback to cp.
if command -v rsync >/dev/null 2>&1; then
  rsync -a \
    --exclude '__MACOSX' \
    --exclude '.DS_Store' \
    --exclude 'Thumbs.db' \
    --exclude '.git/' \
    --exclude '.gitignore' \
    --exclude '*.pdf' \
    "$SOURCE_DIR/" "$STAGE/"
else
  cp -r "$SOURCE_DIR/." "$STAGE/"
  find "$STAGE" \( \
       -name '__MACOSX' -o \
       -name '.DS_Store' -o \
       -name 'Thumbs.db' -o \
       -name '.git' -o \
       -name '.gitignore' -o \
       -name '*.pdf' \
       \) -prune -exec rm -rf {} +
fi

# ─── Build ZIP — try zip cmd first, fallback to Python (zipfile always uses /) ─
if command -v zip >/dev/null 2>&1; then
  (
    cd "$TMP_DIR"
    zip -r -q "$ZIP_PATH" "$SKILL_NAME"
  )
elif PY="$(command -v python || command -v python3)" && [[ -n "$PY" ]]; then
  # Convert MSYS/Cygwin paths to Windows paths if running under Git Bash
  if command -v cygpath >/dev/null 2>&1; then
    PY_TMP_DIR="$(cygpath -w "$TMP_DIR")"
    PY_ZIP_PATH="$(cygpath -w "$ZIP_PATH")"
  else
    PY_TMP_DIR="$TMP_DIR"
    PY_ZIP_PATH="$ZIP_PATH"
  fi
  "$PY" - "$PY_TMP_DIR" "$PY_ZIP_PATH" "$SKILL_NAME" <<'EOF'
import os, sys, zipfile
root, out, skill = sys.argv[1], sys.argv[2], sys.argv[3]
with zipfile.ZipFile(out, 'w', compression=zipfile.ZIP_DEFLATED) as zf:
    for d, _, files in os.walk(os.path.join(root, skill)):
        for fn in files:
            full = os.path.join(d, fn)
            arc = os.path.relpath(full, root).replace(os.sep, '/')
            zf.write(full, arc)
EOF
else
  echo "ERROR: neither 'zip' nor 'python3' available. Install one to continue." >&2
  exit 1
fi

# ─── Self-verify (Python — works on any platform, no awk/grep quirks) ────
if PY="$(command -v python || command -v python3)" && [[ -n "$PY" ]]; then
  if command -v cygpath >/dev/null 2>&1; then
    PY_ZIP_PATH="$(cygpath -w "$ZIP_PATH")"
  else
    PY_ZIP_PATH="$ZIP_PATH"
  fi
  "$PY" - "$PY_ZIP_PATH" "$SKILL_NAME" <<'EOF'
import sys, zipfile
zp, skill = sys.argv[1], sys.argv[2]
zf = zipfile.ZipFile(zp)
ents = zf.namelist()
bad = [n for n in ents if '\\' in n]
if bad:
    print(f'ERROR: {len(bad)} entries contain backslash', file=sys.stderr); sys.exit(1)
outside = [n for n in ents if not n.startswith(f'{skill}/')]
if outside:
    print(f'ERROR: {len(outside)} entries outside {skill}/', file=sys.stderr); sys.exit(1)
print(f'[build-zip] Wrote {len(ents)} entries to {zp}')
print(f'[build-zip] Verified: all entries use / under {skill}/')
EOF
else
  echo "[build-zip] Skipped self-verify (no python available)" >&2
fi

echo ""
echo "Output: $ZIP_PATH"
echo "Size:   $(du -h "$ZIP_PATH" | cut -f1)"
