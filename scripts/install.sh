#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────
#  skill-markdown-c4c — Installer (macOS / Linux)
#  Usage: ./scripts/install.sh
#         or: curl -fsSL https://.../install.sh | bash
# ─────────────────────────────────────────────────────────────────

set -euo pipefail

# Colors
BRAND='\033[38;2;138;36;140m'   # #8A248C
INK='\033[38;2;4;1;4m'
GRAY='\033[38;2;136;136;136m'
RESET='\033[0m'

echo ""
echo -e "${BRAND}╔═══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BRAND}║   skill-markdown-c4c v3.0.0 — Swiss Modern Minimal           ║${RESET}"
echo -e "${BRAND}║   株式会社C4C — Markdown Document Generation Skill           ║${RESET}"
echo -e "${BRAND}╚═══════════════════════════════════════════════════════════════╝${RESET}"
echo ""

# ─── Resolve paths ───────────────────────────────────────────────
CLAUDE_HOME="${CLAUDE_HOME:-$HOME/.claude}"
SKILL_DIR="$CLAUDE_HOME/skills/markdown-c4c"
COMMANDS_DIR="$CLAUDE_HOME/commands"
STYLES_DIR="$CLAUDE_HOME/styles"
RULES_DIR="$CLAUDE_HOME/rules"

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL_SRC="$REPO_ROOT/skill"

echo -e "${GRAY}Repository:${RESET} $REPO_ROOT"
echo -e "${GRAY}Claude home:${RESET} $CLAUDE_HOME"
echo ""

# ─── Verify source ───────────────────────────────────────────────
if [ ! -d "$SKILL_SRC" ]; then
  echo "ERROR: skill/ directory not found at $SKILL_SRC"
  exit 1
fi

# ─── Create target directories ───────────────────────────────────
mkdir -p "$SKILL_DIR" "$COMMANDS_DIR" "$STYLES_DIR" "$RULES_DIR"

# ─── Install skill files ─────────────────────────────────────────
echo -e "${BRAND}▸${RESET} Installing skill to ${INK}$SKILL_DIR${RESET}"
cp -r "$SKILL_SRC/." "$SKILL_DIR/"

# Remove command.md from skill dir (it goes to commands/)
rm -f "$SKILL_DIR/command.md"

# ─── Install slash command ───────────────────────────────────────
echo -e "${BRAND}▸${RESET} Installing slash command /markdown-c4c"
cp "$SKILL_SRC/command.md" "$COMMANDS_DIR/markdown-c4c.md"

# ─── Install CSS ─────────────────────────────────────────────────
echo -e "${BRAND}▸${RESET} Installing CSS to ${INK}$STYLES_DIR/markdown-pdf.css${RESET}"
if [ -f "$STYLES_DIR/markdown-pdf.css" ]; then
  cp "$STYLES_DIR/markdown-pdf.css" "$STYLES_DIR/markdown-pdf.css.bak"
  echo -e "  ${GRAY}(existing file backed up to markdown-pdf.css.bak)${RESET}"
fi
cp "$SKILL_SRC/assets/markdown-pdf.css" "$STYLES_DIR/markdown-pdf.css"

# ─── Install rules ───────────────────────────────────────────────
echo -e "${BRAND}▸${RESET} Installing rules to ${INK}$RULES_DIR${RESET}"
cp "$SKILL_SRC/assets/markdown-generation.md" "$RULES_DIR/markdown-generation.md"
cp "$SKILL_SRC/assets/jp-fix-checklist.md"   "$RULES_DIR/jp-fix-checklist.md"

# ─── Done ────────────────────────────────────────────────────────
echo ""
echo -e "${BRAND}╔═══════════════════════════════════════════════════════════════╗${RESET}"
echo -e "${BRAND}║   Installation complete                                       ║${RESET}"
echo -e "${BRAND}╚═══════════════════════════════════════════════════════════════╝${RESET}"
echo ""
echo "Next steps:"
echo ""
echo -e "  ${BRAND}1.${RESET} Install VS Code Markdown PDF extension:"
echo -e "     ${GRAY}code --install-extension yzane.markdown-pdf${RESET}"
echo ""
echo -e "  ${BRAND}2.${RESET} Merge VS Code settings.json with the template:"
echo -e "     ${GRAY}$SKILL_DIR/assets/setup-vscode-settings.json${RESET}"
echo -e "     (Linux: ~/.config/Code/User/settings.json)"
echo -e "     (macOS: ~/Library/Application Support/Code/User/settings.json)"
echo ""
echo -e "  ${BRAND}3.${RESET} Add the following to your global ~/.claude/CLAUDE.md:"
echo ""
echo -e "${GRAY}     ## Markdown Generation${RESET}"
echo -e "${GRAY}     Always invoke 'markdown-c4c' skill before Markdown generation.${RESET}"
echo -e "${GRAY}     CSS: ~/.claude/styles/markdown-pdf.css (Swiss Modern v3.0)${RESET}"
echo ""
echo -e "  ${BRAND}4.${RESET} Restart VS Code, then test:"
echo -e "     ${GRAY}/markdown-c4c テストドキュメント${RESET}"
echo ""
echo -e "${BRAND}Brand colors:${RESET} #8A248C  ·  #888888  ·  #040104"
echo ""
