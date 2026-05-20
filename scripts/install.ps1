# ─────────────────────────────────────────────────────────────────
#  skill-markdown-c4c — Installer (Windows PowerShell)
#  Usage: .\scripts\install.ps1
#         or: irm https://.../install.ps1 | iex
# ─────────────────────────────────────────────────────────────────

$ErrorActionPreference = "Stop"

# Brand colors for output (RGB)
function Write-Brand($msg)   { Write-Host $msg -ForegroundColor Magenta }
function Write-Ink($msg)     { Write-Host $msg -ForegroundColor Black -BackgroundColor White }
function Write-Gray($msg)    { Write-Host $msg -ForegroundColor DarkGray }
function Write-Section($msg) { Write-Host "▸ " -NoNewline -ForegroundColor Magenta; Write-Host $msg }

Write-Host ""
Write-Brand "╔═══════════════════════════════════════════════════════════════╗"
Write-Brand "║   skill-markdown-c4c v3.0.0 — Swiss Modern Minimal           ║"
Write-Brand "║   株式会社C4C — Markdown Document Generation Skill           ║"
Write-Brand "╚═══════════════════════════════════════════════════════════════╝"
Write-Host ""

# ─── Resolve paths ───────────────────────────────────────────────
$ClaudeHome  = if ($env:CLAUDE_HOME) { $env:CLAUDE_HOME } else { Join-Path $HOME ".claude" }
$SkillDir    = Join-Path $ClaudeHome "skills\markdown-c4c"
$CommandsDir = Join-Path $ClaudeHome "commands"
$StylesDir   = Join-Path $ClaudeHome "styles"
$RulesDir    = Join-Path $ClaudeHome "rules"

$RepoRoot = Split-Path -Parent $PSScriptRoot
$SkillSrc = Join-Path $RepoRoot "skill"

Write-Gray "Repository: $RepoRoot"
Write-Gray "Claude home: $ClaudeHome"
Write-Host ""

# ─── Verify source ───────────────────────────────────────────────
if (-not (Test-Path $SkillSrc)) {
    Write-Host "ERROR: skill\ directory not found at $SkillSrc" -ForegroundColor Red
    exit 1
}

# ─── Create target directories ───────────────────────────────────
New-Item -ItemType Directory -Force -Path $SkillDir, $CommandsDir, $StylesDir, $RulesDir | Out-Null

# ─── Install skill files ─────────────────────────────────────────
Write-Section "Installing skill to $SkillDir"
Copy-Item -Path "$SkillSrc\*" -Destination $SkillDir -Recurse -Force
$skillCommandFile = Join-Path $SkillDir "command.md"
if (Test-Path $skillCommandFile) {
    Remove-Item $skillCommandFile -Force
}

# ─── Install slash command ───────────────────────────────────────
Write-Section "Installing slash command /markdown-c4c"
Copy-Item -Path "$SkillSrc\command.md" -Destination (Join-Path $CommandsDir "markdown-c4c.md") -Force

# ─── Install CSS ─────────────────────────────────────────────────
$cssTarget = Join-Path $StylesDir "markdown-pdf.css"
Write-Section "Installing CSS to $cssTarget"
if (Test-Path $cssTarget) {
    Copy-Item -Path $cssTarget -Destination "$cssTarget.bak" -Force
    Write-Gray "  (existing file backed up to markdown-pdf.css.bak)"
}
Copy-Item -Path "$SkillSrc\assets\markdown-pdf.css" -Destination $cssTarget -Force

# ─── Install rules ───────────────────────────────────────────────
Write-Section "Installing rules to $RulesDir"
Copy-Item -Path "$SkillSrc\assets\markdown-generation.md" -Destination (Join-Path $RulesDir "markdown-generation.md") -Force
Copy-Item -Path "$SkillSrc\assets\jp-fix-checklist.md"   -Destination (Join-Path $RulesDir "jp-fix-checklist.md")    -Force

# ─── Done ────────────────────────────────────────────────────────
Write-Host ""
Write-Brand "╔═══════════════════════════════════════════════════════════════╗"
Write-Brand "║   Installation complete                                       ║"
Write-Brand "╚═══════════════════════════════════════════════════════════════╝"
Write-Host ""
Write-Host "Next steps:"
Write-Host ""
Write-Brand "  1. " -NoNewline; Write-Host "Install VS Code Markdown PDF extension:"
Write-Gray  "     code --install-extension yzane.markdown-pdf"
Write-Host ""
Write-Brand "  2. " -NoNewline; Write-Host "Merge VS Code settings.json with the template:"
Write-Gray  "     $SkillDir\assets\setup-vscode-settings.json"
Write-Gray  "     (Path: %APPDATA%\Code\User\settings.json)"
Write-Host ""
Write-Brand "  3. " -NoNewline; Write-Host "Add the following to your global ~/.claude/CLAUDE.md:"
Write-Host ""
Write-Gray  "     ## Markdown Generation"
Write-Gray  "     Always invoke 'markdown-c4c' skill before Markdown generation."
Write-Gray  "     CSS: ~/.claude/styles/markdown-pdf.css (Swiss Modern v3.0)"
Write-Host ""
Write-Brand "  4. " -NoNewline; Write-Host "Restart VS Code, then test:"
Write-Gray  "     /markdown-c4c テストドキュメント"
Write-Host ""
Write-Brand "Brand colors:" -NoNewline; Write-Host " #8A248C  ·  #888888  ·  #040104"
Write-Host ""
