#!/usr/bin/env node
/* eslint-disable */
/**
 * skill-markdown-c4c — Cross-platform installer (Node.js)
 *
 * Works on Windows / macOS / Linux without any shell dependency.
 *
 * Usage:
 *   node scripts/install.js
 *   npx -y skill-markdown-c4c           (after npm publish)
 *   npx -y file:.                       (local checkout)
 *   markdown-c4c-skill                  (after `npm link`)
 *
 * Environment:
 *   CLAUDE_HOME  override default ~/.claude location
 */

'use strict';

const fs   = require('fs');
const os   = require('os');
const path = require('path');

// ─── ANSI color helpers (no chalk dep) ──────────────────────────────────
const isTTY = process.stdout.isTTY;
const c = (code, s) => (isTTY ? `\x1b[${code}m${s}\x1b[0m` : s);
const brand = (s) => c('38;2;138;36;140', s);   // #8A248C
const gray  = (s) => c('38;2;136;136;136', s);
const ink   = (s) => c('1', s);
const err   = (s) => c('31', s);
const ok    = (s) => c('32', s);

// ─── Banner ─────────────────────────────────────────────────────────────
console.log('');
console.log(brand('╔═══════════════════════════════════════════════════════════════╗'));
console.log(brand('║   skill-markdown-c4c v5.1.1 — Swiss Modern Minimal           ║'));
console.log(brand('║   株式会社C4C — Markdown Document Generation Skill           ║'));
console.log(brand('╚═══════════════════════════════════════════════════════════════╝'));
console.log('');

// ─── Resolve paths ──────────────────────────────────────────────────────
const claudeHome  = process.env.CLAUDE_HOME || path.join(os.homedir(), '.claude');
const skillDir    = path.join(claudeHome, 'skills', 'markdown-c4c');
const commandsDir = path.join(claudeHome, 'commands');
const stylesDir   = path.join(claudeHome, 'styles');
const rulesDir    = path.join(claudeHome, 'rules');

const repoRoot = path.resolve(__dirname, '..');
const skillSrc = path.join(repoRoot, 'skill');

console.log(gray('Repository:  ') + repoRoot);
console.log(gray('Claude home: ') + claudeHome);
console.log(gray('Platform:    ') + `${process.platform} (node ${process.version})`);
console.log('');

// ─── Verify source ──────────────────────────────────────────────────────
if (!fs.existsSync(skillSrc) || !fs.statSync(skillSrc).isDirectory()) {
  console.error(err(`ERROR: skill/ directory not found at ${skillSrc}`));
  process.exit(1);
}

const skillMd = path.join(skillSrc, 'SKILL.md');
if (!fs.existsSync(skillMd)) {
  console.error(err(`ERROR: SKILL.md not found at ${skillMd}`));
  process.exit(1);
}

// ─── Helpers ────────────────────────────────────────────────────────────
function mkdirp(dir) {
  fs.mkdirSync(dir, { recursive: true });
}

function copyTree(src, dst) {
  // Node 16.7+: fs.cpSync with recursive
  if (typeof fs.cpSync === 'function') {
    fs.cpSync(src, dst, { recursive: true, force: true });
    return;
  }
  // Fallback (Node < 16.7)
  mkdirp(dst);
  for (const entry of fs.readdirSync(src, { withFileTypes: true })) {
    const s = path.join(src, entry.name);
    const d = path.join(dst, entry.name);
    if (entry.isDirectory()) copyTree(s, d);
    else fs.copyFileSync(s, d);
  }
}

function backupIfExists(file) {
  if (fs.existsSync(file)) {
    const bak = file + '.bak';
    fs.copyFileSync(file, bak);
    console.log(gray(`  (existing file backed up to ${path.basename(bak)})`));
  }
}

const section = (msg) => console.log(brand('▸ ') + msg);

// ─── Create target directories ──────────────────────────────────────────
[skillDir, commandsDir, stylesDir, rulesDir].forEach(mkdirp);

// ─── Install skill files ────────────────────────────────────────────────
section(`Installing skill to ${ink(skillDir)}`);
copyTree(skillSrc, skillDir);

// Remove command.md from skill dir (it goes to commands/)
const strayCommand = path.join(skillDir, 'command.md');
if (fs.existsSync(strayCommand)) fs.unlinkSync(strayCommand);

// ─── Install slash command ──────────────────────────────────────────────
section('Installing slash command /markdown-c4c');
fs.copyFileSync(
  path.join(skillSrc, 'command.md'),
  path.join(commandsDir, 'markdown-c4c.md'),
);

// ─── Install CSS ────────────────────────────────────────────────────────
const cssDst = path.join(stylesDir, 'markdown-pdf.css');
section(`Installing CSS to ${ink(cssDst)}`);
backupIfExists(cssDst);
fs.copyFileSync(path.join(skillSrc, 'assets', 'markdown-pdf.css'), cssDst);

// ─── Install rules ──────────────────────────────────────────────────────
section(`Installing rules to ${ink(rulesDir)}`);
fs.copyFileSync(
  path.join(skillSrc, 'assets', 'markdown-generation.md'),
  path.join(rulesDir, 'markdown-generation.md'),
);
fs.copyFileSync(
  path.join(skillSrc, 'assets', 'jp-fix-checklist.md'),
  path.join(rulesDir, 'jp-fix-checklist.md'),
);

// ─── Done ───────────────────────────────────────────────────────────────
console.log('');
console.log(brand('╔═══════════════════════════════════════════════════════════════╗'));
console.log(brand('║   ') + ok('Installation complete') + brand('                                      ║'));
console.log(brand('╚═══════════════════════════════════════════════════════════════╝'));
console.log('');
console.log('Next steps:');
console.log('');
console.log(brand('  1. ') + 'Install VS Code Markdown PDF extension:');
console.log(gray('     code --install-extension yzane.markdown-pdf'));
console.log('');
console.log(brand('  2. ') + 'Open Claude Code and try the skill:');
console.log(gray('     /markdown-c4c  または  「Markdown で提案書を作って」'));
console.log('');
console.log(brand('  3. ') + 'PDF 出力時にスタイルが効かない場合、VS Code settings.json で');
console.log(gray('     markdown-pdf.styles に CSS のフルパスを追加してください:'));
console.log(gray(`     ${cssDst}`));
console.log('');
