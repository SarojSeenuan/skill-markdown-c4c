# skill-markdown-c4c

> 株式会社C4C ブランドの Markdown ドキュメント生成スキル — Swiss Modern Minimal v3.0

[![Skills](https://img.shields.io/badge/skills.sh-v3.0.0-8A248C?style=flat-square)](https://skills.sh)
[![License](https://img.shields.io/badge/license-MIT-040104?style=flat-square)](LICENSE)
[![VS Code](https://img.shields.io/badge/VS_Code-Markdown_PDF-888888?style=flat-square&logo=visualstudiocode)](https://marketplace.visualstudio.com/items?itemName=yzane.markdown-pdf)

PDF 出力を前提に、社内ドキュメント・クライアント提案書・設計ドキュメント・仕様書・報告書・議事録・README を統一品質で生成する Claude Code スキル。

## 特徴

- **Swiss Modern Minimal v3.0** デザインシステム
- **ブランドカラー**: `#8A248C` マゼンタ / `#888888` グレー / `#040104` インク
- **9 種類の Divider**, **5 種類の Callout**, **5 種類の Shape Box**, **5 種類の Table バリエーション**
- **自動 H2 改ページ**, **TOC クリック遷移**, **ヘッダ/フッタ自動装飾**
- **自動呼出** — Markdown 生成のトリガー語で Claude が自動で参照
- **スラッシュコマンド** — `/markdown-c4c` で明示呼出
- **JP Fix** — 日本語出力時の 7 項目セルフチェック内蔵

## インストール

### 方法 A: `npx skills` 経由（推奨・公開後）

```bash
npx skills add c4c-internal/skill-markdown-c4c -g -y
```

### 方法 B: install スクリプト

#### Windows (PowerShell)
```powershell
irm https://raw.githubusercontent.com/c4c-internal/skill-markdown-c4c/main/scripts/install.ps1 | iex
```

#### macOS / Linux
```bash
curl -fsSL https://raw.githubusercontent.com/c4c-internal/skill-markdown-c4c/main/scripts/install.sh | bash
```

### 方法 C: 手動 git clone

```bash
git clone https://github.com/c4c-internal/skill-markdown-c4c.git ~/c4c-skill
cd ~/c4c-skill
./scripts/install.sh    # macOS/Linux
# または
.\scripts\install.ps1   # Windows
```

## 前提条件

- [Claude Code](https://claude.com/claude-code) 最新版
- [VS Code](https://code.visualstudio.com/)
- [Markdown PDF 拡張](https://marketplace.visualstudio.com/items?itemName=yzane.markdown-pdf) (`yzane.markdown-pdf`)

VS Code 拡張のインストール:
```bash
code --install-extension yzane.markdown-pdf
```

## 使い方

### 自動呼出（推奨）
Claude に Markdown 生成を依頼すれば、スキルが自動で参照される:

```
社内向けのプロジェクト報告書を Markdown で作って
```

トリガー語: Markdown, ドキュメント, 提案書, 仕様書, 報告書, 議事録, README, 設計書, 見積書, `.md` 編集 etc.

### スラッシュコマンド
```
/markdown-c4c 新サービス提案書 v1.0
```

引数にタイトルや要件を渡せる。

### テンプレートから手動開始
`skill/assets/template-document.md` を雛形にコピー。

## ディレクトリ構造

```
skill-markdown-c4c/
├── README.md                              # このファイル
├── CHANGELOG.md                           # バージョン履歴
├── LICENSE                                # MIT
├── skill/                                 # スキル本体
│   ├── SKILL.md                           # スキル定義（自動呼出トリガー）
│   ├── README.md                          # スキル使い方
│   ├── command.md                         # /markdown-c4c スラッシュコマンド
│   ├── assets/                            # 配布アセット
│   │   ├── markdown-pdf.css               # Swiss Modern v3.0 CSS
│   │   ├── markdown-generation.md         # 生成ルール
│   │   ├── jp-fix-checklist.md            # 日本語 7 項目セルフチェック
│   │   ├── setup-vscode-settings.json     # VS Code 設定スニペット
│   │   └── template-document.md           # スタータードキュメント
│   └── references/
│       └── components.md                  # 全コンポーネントギャラリー
└── scripts/                               # インストールスクリプト
    ├── install.sh                         # macOS / Linux
    └── install.ps1                        # Windows PowerShell
```

## インストール後の構成

スクリプトは以下のパスにファイルを配置する:

| ファイル | 配置先 |
|:---|:---|
| `skill/` 一式 | `~/.claude/skills/markdown-c4c/` |
| `skill/command.md` | `~/.claude/commands/markdown-c4c.md` |
| `skill/assets/markdown-pdf.css` | `~/.claude/styles/markdown-pdf.css` |
| `skill/assets/markdown-generation.md` | `~/.claude/rules/markdown-generation.md` |
| `skill/assets/jp-fix-checklist.md` | `~/.claude/rules/jp-fix-checklist.md` |

VS Code 設定 (`settings.json`) は手動マージ。テンプレートは `skill/assets/setup-vscode-settings.json`。

## ブランドカラー差し替え

CSS の `:root` 内 3 行のみを変えれば、別ブランドにも転用可能:

```css
:root {
  --brand-primary:   #8A248C;   /* マゼンタ → 別色に */
  --brand-secondary: #888888;
  --brand-ink:       #040104;
}
```

## アップデート

```bash
cd ~/c4c-skill
git pull
./scripts/install.sh
```

または `npx skills update` で全スキル一括更新。

## アンインストール

```bash
rm -rf ~/.claude/skills/markdown-c4c
rm ~/.claude/commands/markdown-c4c.md
# CSS と rules は他で使うかもしれないので手動判断
```

## バージョン履歴

[CHANGELOG.md](./CHANGELOG.md) を参照。

## コントリビュート

社内利用前提。issue / PR は社内 GitHub で受け付け。

## ライセンス

[MIT](./LICENSE)

---

<sub>株式会社C4C — Saroj Seenuan (Ken)</sub>
