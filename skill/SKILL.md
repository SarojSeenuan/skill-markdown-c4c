---
name: markdown-c4c
description: Markdown 生成・編集時に必ず使用するスキル。株式会社C4C ブランドの Swiss Modern Minimal v3.0 デザインシステムで、PDF 出力を前提に社内ドキュメント・クライアント提案書・設計ドキュメント・仕様書・報告書・議事録・README を高品質に生成する。Markdown / md ファイル作成、`.md` 編集、ドキュメント執筆、提案書作成、仕様書作成、報告書作成、議事録、README、技術文書、設計書、見積書、PDF 出力、表組み、テーブル作成、Callout、Shape Box、TOC（目次）、ヘッダ・フッタのいずれかが要求された場合に必ず呼び出す。スラッシュコマンド `/markdown-c4c` でも明示的に呼び出せる。
author: "Saroj Seenuan (Ken) / 株式会社C4C"
version: "3.0.0"
license: "MIT"
tags:
  - markdown
  - pdf
  - documentation
  - design-system
  - swiss-modern
  - c4c
  - branding
  - vscode
  - markdown-pdf
  - japanese
---

# Markdown C4C — Design System Skill v3.0

株式会社C4C の標準 Markdown ドキュメント生成スキル。
**Markdown / md ファイルを生成・編集する前に、必ずこのスキルを参照すること。**

## このスキルが必須となるトリガー

以下のいずれかに該当する場合、**Claude は本スキルを必ず Skill ツールで呼び出してから作業を開始する**:

- 新規 Markdown ファイル (`.md`) の作成
- 既存 Markdown ファイルへの追記・編集
- ドキュメント執筆（提案書 / 仕様書 / 報告書 / 議事録 / README / 設計書 / 見積書 / 技術文書）
- PDF 出力前提の Markdown 生成
- スラッシュコマンド `/markdown-c4c` の呼出
- 「Markdown で書いて」「ドキュメント作って」「提案書まとめて」など Markdown 出力が暗黙に期待される指示

## このスキルが提供する 3 つの柱

### 1. 統一デザインシステム — Swiss Modern Minimal v3.0
- **ブランドカラー**: `#8A248C`（マゼンタ） / `#888888`（グレー） / `#040104`（インク）
- **タイポグラフィ**: 見出し `Inter Tight` / 本文 `Manrope` / 等幅 `JetBrains Mono` / 和文 `Hiragino Kaku Gothic ProN`
- **トーン**: 厳密グリッド・ヘアライン罫・余白の数学的均衡

### 2. PDF 出力前提のコンポーネント群
| カテゴリ | 種類 |
|:---|:---|
| Callout | 5 種類（note / tip / info / warning / danger） |
| Shape Box | 5 種類（標準 / filled / outline / brand / data-title） |
| Divider | 9 種類（hairline / double / dot 系 6種 / brand 菱形） |
| Table | 5 種類（4辺枠線デフォルト / no-borders / compact / jp / wrap） |
| TOC | ドットリーダー付きクリック遷移可能目次 |
| インライン | mark / tag / muted / brand / kbd / abbr |

### 3. 自動適用される運用ルール
- **H2 セクションは自動で改ページ**（命令不要）
- **TOC リンクはクリック遷移可能**（`<h2 id="sec-xxx">` 形式必須）
- **ヘッダ左 = 株式会社C4C** デフォルト固定
- **フッタ = `v1.0 · DRAFT` + `現在 / 総数`** 形式
- **日本語は JP Fix 7 項目セルフチェック**

## 必須生成手順

### ステップ 1: ドキュメント先頭テンプレート
新規 Markdown は必ず以下の構造で開始する:

```markdown
<head>
<title>ドキュメントタイトル（拡張子なし）</title>
</head>

# ドキュメントタイトル

<div class="caption">Author: 担当者名　·　Version: v1.0　·　Date: YYYY-MM-DD</div>

<nav class="toc">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-1">セクション1</a><span class="dots"></span><span class="page">2</span></li>
    <li><a href="#sec-2">セクション2</a><span class="dots"></span><span class="page">5</span></li>
  </ol>
</nav>
```

### ステップ 2: H2 セクションは ID 付き直書き
**`{#id}` 構文は使用禁止**（markdown-it 非対応）。必ず HTML タグで:

```markdown
<h2 id="sec-overview">1. 概要</h2>
```

### ステップ 3: バリエーション使い回し（最重要ルール）

同種のコンポーネントを複数使うときは **必ず異なるバリエーション**を選んでリズムを作る:

#### Callout — 用途で 5 種類を使い分け
```html
<div class="callout callout-note">通常情報・補足</div>
<div class="callout callout-tip">推奨・ベストプラクティス</div>
<div class="callout callout-info">補足情報・参考</div>
<div class="callout callout-warning">注意喚起</div>
<div class="callout callout-danger">危険・禁止</div>
```

#### Shape Box — 5 種類を使い分け
```html
<div class="shape-box">標準枠</div>
<div class="shape-box shape-filled">塗り背景・補足コラム</div>
<div class="shape-box shape-outline">太枠・サマリー / 結論</div>
<div class="shape-box shape-brand">ブランド色強調・キーメッセージ</div>
<div class="shape-box" data-title="VISUAL ASSET">画像 + 説明セット ★Ken お気に入り</div>
```

#### Divider — 9 種類でリズム作り
```html
<hr>                              <!-- hairline -->
<hr class="divider-double">       <!-- 二重線 -->
<hr class="divider-dot">          <!-- ドット 3 個 -->
<hr class="divider-dot-5">        <!-- ドット 5 個 -->
<hr class="divider-dot-line">     <!-- 横一面ドット線 -->
<hr class="divider-dot-dense">    <!-- 密ドット線 -->
<hr class="divider-dot-brand">    <!-- ブランドカラードット -->
<hr class="divider-morse">        <!-- モールス風 -->
<hr class="divider-brand">        <!-- ブランド菱形 -->
```

#### マーカー強調 — 2 種類
```html
<mark>黄色マーカー</mark>
<mark class="brand">ブランド色マーカー</mark>
```
※ `==text==` 構文は **markdown-it 非対応のため使用禁止**

#### 画像 — 3 パターンを文脈で使い分け
- 標準 `![alt](path)` = シンプル単独画像
- `<figure>` + `<figcaption>` = キャプション付き
- **`<div class="shape-box" data-title="...">` + 画像 + 説明** = ★重要なビジュアルは必ずこの形式

### ステップ 4: テーブル

- デフォルト = 4 辺すべて枠線あり + ブランド色背景ヘッダ
- アラインメント必須: `|:---:|---:|` で TH/TD 両方に反映される
- 横罫のみにしたい時のみ `<table class="no-borders">`
- 長文表は `<table class="compact">`

### ステップ 5: 組織名・バージョン切替

| 指示 | 対応 |
|:---|:---|
| 何も言われない | `株式会社C4C` のまま（デフォルト） |
| 「個人名で」「SAROJ で」 | settings.json の `class='header-org'` を `SAROJ SEENUAN` に変更する差分提示 |
| 「v2.3 で」「FINAL で」 | settings.json の `class='footer-version'` を変更する差分提示 |

## 参照ファイル

| 役割 | パス |
|:---|:---|
| **CSS スタイル定義** | `~/.claude/styles/markdown-pdf.css` |
| **生成ルール詳細** | `~/.claude/rules/markdown-generation.md` |
| **JP Fix チェック** | `~/.claude/rules/jp-fix-checklist.md` |
| **スタータードキュメント** | `~/.claude/skills/markdown-c4c/assets/template-document.md` |
| **VS Code 設定スニペット** | `~/.claude/skills/markdown-c4c/assets/setup-vscode-settings.json` |
| **CSS 配布バックアップ** | `~/.claude/skills/markdown-c4c/assets/markdown-pdf.css` |
| **配布手順** | `~/.claude/skills/markdown-c4c/README.md` |
| **コンポーネントギャラリー** | `~/.claude/skills/markdown-c4c/references/components.md` |

## 自動チェックリスト（生成完了前に必ず確認）

- [ ] `<head><title>...</title></head>` が冒頭にある
- [ ] H1 はドキュメントタイトル 1 つだけ
- [ ] H2 セクションが `<h2 id="sec-xxx">` 形式
- [ ] TOC リンクの `href="#sec-xxx"` と H2 ID が一致
- [ ] Callout を 2 つ以上使った場合、種類が違う
- [ ] Divider を 2 つ以上使った場合、種類が違う
- [ ] 重要な画像は `shape-box data-title` 形式
- [ ] テーブルにアラインメント指定 `|:---:|---:|` がある
- [ ] `==text==` 構文を使っていない（`<mark>` のみ使う）
- [ ] 日本語の場合、JP Fix 7 項目チェック実行済み

## スラッシュコマンド `/markdown-c4c`

スキルを明示的に呼びたい場合は `/markdown-c4c [タイトル]` で呼出可能。
コマンド定義: `~/.claude/commands/markdown-c4c.md`

## 配布方法（社内向け）

```bash
# パッケージ化
cd ~/.claude/skills
tar -czf markdown-c4c-v3.0.0.tar.gz markdown-c4c/

# 受け取り側
cd ~/.claude/skills && tar -xzf markdown-c4c-v3.0.0.tar.gz

# 初回セットアップ
# claude に「markdown-c4c スキルの初回セットアップをして」と頼むと
# CSS / rules / VS Code 設定の差分提示が自動で実行される
```

詳細は `README.md` を参照。
