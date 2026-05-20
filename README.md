<div align="center">

# `skill-markdown-c4c`

### Swiss Modern Minimal Markdown Design System — v3.0

PDF 出力前提の Markdown を、ブランド統一品質で生成する Claude Code スキル。

[![Skills](https://img.shields.io/badge/skills.sh-v3.0.0-8A248C?style=flat-square&labelColor=040104)](https://skills.sh)
[![License](https://img.shields.io/badge/license-MIT-040104?style=flat-square&labelColor=8A248C)](LICENSE)
[![VS Code](https://img.shields.io/badge/VS_Code-Markdown_PDF-888888?style=flat-square&labelColor=040104&logo=visualstudiocode&logoColor=white)](https://marketplace.visualstudio.com/items?itemName=yzane.markdown-pdf)
[![Brand](https://img.shields.io/badge/-%238A248C%20%C2%B7%20%23888888%20%C2%B7%20%23040104-040104?style=flat-square&labelColor=8A248C)](#brand-system)

</div>

---

<table>
<tr>
<td width="50%">
<img src="docs/screenshots/01-cover-toc.png" alt="Cover page with TOC" />
</td>
<td width="50%">
<img src="docs/screenshots/02-callout-showcase.png" alt="Callout components" />
</td>
</tr>
<tr>
<td align="center"><sub><b>表紙 + 目次（ドットリーダー + クリック遷移）</b></sub></td>
<td align="center"><sub><b>Callout 5 種類（NOTE / TIP / INFO / WARNING / DANGER）</b></sub></td>
</tr>
</table>

> 全コンポーネントのギャラリーは **[docs/screenshots/gallery](docs/screenshots/gallery/)** を参照。

---

## ▍ Overview

`skill-markdown-c4c` は、**社内ドキュメント・クライアント提案書・設計書・仕様書・報告書・議事録・README** を、株式会社C4C のブランド統一で生成する Claude Code スキルです。

- **自動呼出** — Markdown 生成のトリガー語で Claude が自動でスキルを参照
- **スラッシュコマンド** — `/markdown-c4c [タイトル]` で明示呼出
- **PDF 出力前提** — VS Code Markdown PDF 拡張 (`yzane.markdown-pdf`) と完全連携
- **JP Fix 内蔵** — 日本語出力時の 7 項目セルフチェック

<table>
<tr><th align="left" width="220">コンポーネント</th><th align="left">バリエーション数</th><th align="left">用途</th></tr>
<tr><td><code>Callout</code></td><td>5 種</td><td>NOTE / TIP / INFO / WARNING / DANGER</td></tr>
<tr><td><code>Shape Box</code></td><td>5 種</td><td>標準 / filled / outline / brand / data-title</td></tr>
<tr><td><code>Divider</code></td><td>9 種</td><td>hairline / double / dot 系 6 種 / brand 菱形</td></tr>
<tr><td><code>Table</code></td><td>5 種</td><td>4辺枠線（既定）/ no-borders / compact / jp / wrap</td></tr>
<tr><td><code>TOC</code></td><td>—</td><td>ドットリーダー + クリック遷移可能目次</td></tr>
<tr><td><code>Code Block</code></td><td>—</td><td>One Dark 配色 + ファイル名ヘッダ対応</td></tr>
</table>

---

## ▍ Brand System

<table>
<tr>
<th align="left" width="180">Token</th>
<th align="left" width="120">HEX</th>
<th align="left">Role</th>
</tr>
<tr>
<td><code>--brand-primary</code></td>
<td><code>#8A248C</code></td>
<td>マゼンタパープル · アクセント 1 点</td>
</tr>
<tr>
<td><code>--brand-secondary</code></td>
<td><code>#888888</code></td>
<td>ミディアムグレー · 補助テキスト</td>
</tr>
<tr>
<td><code>--brand-ink</code></td>
<td><code>#040104</code></td>
<td>インクブラック · 本文・最強罫線</td>
</tr>
</table>

CSS の `:root` 内 3 行を差し替えるだけで別ブランドにも転用可能。

---

## ▍ Install

### A. `npx skills`（推奨・公開後）

```bash
npx skills add SarojSeenuan/skill-markdown-c4c -g -y
```

### B. ワンライナー install スクリプト

**Windows (PowerShell):**

```powershell
irm https://raw.githubusercontent.com/SarojSeenuan/skill-markdown-c4c/main/scripts/install.ps1 | iex
```

**macOS / Linux:**

```bash
curl -fsSL https://raw.githubusercontent.com/SarojSeenuan/skill-markdown-c4c/main/scripts/install.sh | bash
```

### C. 手動 git clone

```bash
git clone https://github.com/SarojSeenuan/skill-markdown-c4c.git ~/c4c-skill
cd ~/c4c-skill
./scripts/install.sh        # macOS / Linux
.\scripts\install.ps1       # Windows
```

> インストールスクリプトは `~/.claude/skills/`、`~/.claude/commands/`、`~/.claude/styles/`、`~/.claude/rules/` の 4 箇所に必要なファイルを自動配置します。

---

## ▍ Prerequisites

```bash
# Claude Code（最新版）
# https://claude.com/claude-code

# VS Code Markdown PDF 拡張
code --install-extension yzane.markdown-pdf
```

インストール後、VS Code の `settings.json` に `skill/assets/setup-vscode-settings.json` の内容をマージしてください（パスは各自のホームディレクトリに調整）。

---

## ▍ Usage

### 自動呼出（推奨）

Markdown 生成のトリガー語を含む依頼をすると、Claude が自動でこのスキルを参照します。

```
社内向けプロジェクト報告書を Markdown で作って
```

> トリガー語: Markdown / ドキュメント / 提案書 / 仕様書 / 報告書 / 議事録 / README / 設計書 / 見積書 / `.md` 編集

### スラッシュコマンド

```
/markdown-c4c 新サービス提案書 v1.0
```

引数にドキュメントタイトル or 要件を渡せます。

### テンプレートから手動開始

`skill/assets/template-document.md` を雛形としてコピー → 編集 → PDF エクスポート。

---

## ▍ Repository Structure

```
skill-markdown-c4c/
├── README.md                              ← このファイル
├── CHANGELOG.md                           ← Keep a Changelog
├── LICENSE                                ← MIT
├── package.json                           ← npx skills メタデータ
│
├── skill/                                 ▍ スキル本体
│   ├── SKILL.md                              ・ 自動呼出トリガー定義
│   ├── README.md                             ・ スキル単体ドキュメント
│   ├── command.md                            ・ /markdown-c4c コマンド定義
│   ├── assets/                               ▍ 配布アセット
│   │   ├── markdown-pdf.css                     ・ Swiss Modern v3.0 CSS
│   │   ├── markdown-generation.md               ・ 生成ルール
│   │   ├── jp-fix-checklist.md                  ・ JP Fix 7 項目
│   │   ├── setup-vscode-settings.json           ・ VS Code 設定スニペット
│   │   └── template-document.md                 ・ スタータードキュメント
│   └── references/
│       └── components.md                     ・ 全コンポーネントギャラリー
│
├── scripts/                               ▍ インストーラー
│   ├── install.sh                            ・ macOS / Linux
│   └── install.ps1                           ・ Windows PowerShell
│
└── docs/screenshots/                      ▍ ビジュアル
    ├── 01-cover-toc.png                      ・ 表紙 + TOC
    ├── 02-callout-showcase.png               ・ Callout 5 種
    └── gallery/                              ▍ 全コンポーネントギャラリー
```

---

## ▍ Header / Footer Defaults

| 位置 | 内容 |
|:---|:---|
| **ヘッダ左** | `株式会社C4C`（縦バー + uppercase + letter-spacing） |
| **ヘッダ右** | ドキュメント `<title>`（ブランド色） |
| **フッタ左** | `v1.0 · DRAFT`（資料バージョン） |
| **フッタ右** | `現在 / 総数`（例: `6 / 15`） |

個人名で出したい場合は、Claude に「個人名で」「SAROJ で」と指示すれば `SAROJ SEENUAN` に切替する差分が提示されます。

---

## ▍ Update

```bash
cd ~/c4c-skill
git pull
./scripts/install.sh         # or .\scripts\install.ps1
```

または `npx skills update` で全スキル一括更新。

---

## ▍ Uninstall

```bash
rm -rf ~/.claude/skills/markdown-c4c
rm ~/.claude/commands/markdown-c4c.md
# CSS と rules は他用途と共有の可能性あり — 手動判断
```

---

## ▍ Changelog

詳細は **[CHANGELOG.md](./CHANGELOG.md)** を参照。

**v3.0.0** — Swiss Modern Minimal 全面リライト · Callout 5 / Shape Box 5 / Divider 9 / Table 5 / TOC クリック遷移 · スラッシュコマンド対応 · JP Fix 内蔵

---

## ▍ License

[MIT](./LICENSE) © 2026 Saroj Seenuan (Ken) / 株式会社C4C

---

<div align="center">

**`#8A248C`** &nbsp; · &nbsp; **`#888888`** &nbsp; · &nbsp; **`#040104`**

<sub>Designed by Saroj Seenuan (Ken) · Built for 株式会社C4C</sub>

</div>
