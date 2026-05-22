# Markdown C4C — Skill v3.5.0

株式会社C4C の標準 Markdown ドキュメント生成スキル。
**Swiss Modern Minimal v3.5** デザインシステムを基盤に、PDF 出力前提の Markdown を統一品質で生成する。

## 特徴

- **自動呼出** — Markdown 生成のトリガー語を検出すると Claude が自動でこのスキルを参照する
- **`/markdown-c4c` コマンド** — スラッシュコマンドで明示的に呼出可能
- **配布可能** — `scripts/build-zip.ps1` または `scripts/build-zip.sh` で Claude Web 互換 ZIP を生成
- **VS Code Markdown PDF 拡張対応** — `yzane.markdown-pdf` で PDF 化
- **自己充足型 SKILL.md** — Web 単体でも完結。 コンポーネント例コードとドキュメント種別テンプレートを内蔵

## ディレクトリ構造

```
markdown-c4c/
├── SKILL.md                          # スキル本体（claude が自動参照）
├── README.md                         # このファイル
├── assets/                           # 配布アセット
│   ├── markdown-pdf.css              # Swiss Modern v3.5 スタイルシート
│   ├── markdown-generation.md        # Markdown 生成ルール
│   ├── jp-fix-checklist.md           # 日本語 8 項目セルフチェック
│   ├── setup-vscode-settings.json    # VS Code 設定スニペット
│   ├── c4c-logo.png                  # ブランドロゴ
│   └── template-document.md          # スタータードキュメント（表紙 + 締めページ付き）
└── references/                       # 詳細リファレンス
    └── components.md                 # 全コンポーネントギャラリー
```

## 初回セットアップ

### 1. このスキルを取得

```bash
# GitHub から取得する場合
git clone <YOUR-REPO>/skill-markdown-c4c ~/.claude/skills/markdown-c4c

# 配布 ZIP を受け取った場合は ~/.claude/skills/ 配下に展開
```

### 2. アセットを所定のパスに配置

スキル内の `assets/` から、Claude グローバルディレクトリにファイルを配置:

```bash
# CSS
cp ~/.claude/skills/markdown-c4c/assets/markdown-pdf.css ~/.claude/styles/

# ルール
cp ~/.claude/skills/markdown-c4c/assets/markdown-generation.md ~/.claude/rules/
cp ~/.claude/skills/markdown-c4c/assets/jp-fix-checklist.md ~/.claude/rules/
```

または Claude に `markdown-c4c スキルの初回セットアップをして` と頼めば自動で実行する。

### 3. VS Code 拡張インストール

```
ext install yzane.markdown-pdf
```

### 4. VS Code settings.json に設定マージ

`assets/setup-vscode-settings.json` の内容を、自分の `settings.json` にマージ:

- Windows: `%APPDATA%\Code\User\settings.json`
- macOS: `~/Library/Application Support/Code/User/settings.json`
- Linux: `~/.config/Code/User/settings.json`

**重要**: `markdown-pdf.styles` のパスを自分のユーザーホームに合わせて書き換える。 Windows はバックスラッシュを `\\` と二重にエスケープ、macOS / Linux は `/` の絶対パスで OK。

### 5. CLAUDE.md にスキル参照を追加

グローバル `~/.claude/CLAUDE.md` の末尾に以下を追加（既存なら更新）:

```markdown
## Markdown Generation — Always Apply C4C Format
Markdown を生成・編集するときは必ず markdown-c4c スキルを Skill ツールで呼び出してから作業する。
出力は ~/.claude/styles/markdown-pdf.css (Swiss Modern v3.5) で PDF 化される前提のフォーマット。
ブランドカラー: #8A248C / #888888 / #040104
組織名: 株式会社C4C（ヘッダ左に常時表示、デフォルト）
```

## 使い方

### 方法 1: 自動呼出（推奨）

ユーザーが Markdown 生成のトリガー語を含む依頼をすると、Claude が自動でスキルを参照する。

トリガー語例:
- 「ドキュメント作って」「Markdown で書いて」「提案書まとめて」
- 「README 作って」「仕様書作って」「報告書作って」「議事録作って」
- `.md` ファイル作成・編集の依頼

### 方法 2: 明示呼出（スラッシュコマンド）

```
/markdown-c4c 新サービス提案書
```

引数にタイトルや要件を渡すと、それを元に新規 Markdown を生成する。

### 方法 3: テンプレートから開始

`assets/template-document.md` を雛形としてコピーして手動で書き始める。 表紙テンプレートと締めページ 4 パターンが既に組み込まれている。

## ブランド規約

| トークン | HEX | 用途 |
|:---|:---|:---|
| `--brand-primary` | `#8A248C` | アクセント（マゼンタパープル） |
| `--brand-secondary` | `#888888` | 補助テキスト・中間グレー |
| `--brand-ink` | `#040104` | 本文・最強罫線 |

CSS の `:root` 内 3 行のみを差し替えれば、別ブランドにも転用可能。

## ヘッダ/フッタ デフォルト

- **ヘッダ左**: `株式会社C4C`（縦バー + 大文字小スペース）
- **ヘッダ右**: ドキュメント `<title>`（ブランド色）
- **フッタ左**: **空のまま運用**（バージョンは Markdown 本文の caption 行で動的指定）
- **フッタ右**: `現在 / 総数`（例: `6 / 15`）

個人名で出したい場合は、プロンプトで明示すると Claude が settings.json 差分を提示する。

## 配布

```powershell
# Windows
pwsh ../scripts/build-zip.ps1
```

```bash
# macOS / Linux
../scripts/build-zip.sh
```

`markdown-c4c-v<VERSION>.zip` がリポジトリ直下に生成される。 Claude Web の Skills に手動アップロードして配布。

## ライセンス

MIT
