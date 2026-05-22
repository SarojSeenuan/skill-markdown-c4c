---
name: markdown-c4c
description: 株式会社C4C ブランドの Markdown ドキュメントを Swiss Modern Minimal v3.0 デザインシステムで生成するスキル。PDF 出力を前提に、提案書・仕様書・報告書・議事録・README・設計書・見積書・技術文書を高品質に書き起こす。Markdown / `.md` ファイル作成、ドキュメント執筆、表組み、Callout、Shape Box、TOC（目次）、ヘッダ・フッタなどが要求された場合に必ず呼び出す。
author: "株式会社C4C / Saroj Seenuan (Ken)"
version: "1.0.0-web"
license: "MIT"
tags:
  - markdown
  - pdf
  - documentation
  - design-system
  - swiss-modern
  - c4c
  - branding
  - japanese
---

# Markdown C4C — Design System Skill v1.0 (Web 配布版)

株式会社C4C の標準 Markdown ドキュメント生成スキル。
**Markdown / `.md` ファイルを生成・編集する前に、必ずこのスキルを参照すること。**

このスキルは Claude Web に登録して使う。出力された Markdown を手元の VS Code で開き、`markdown-pdf` 拡張で PDF 化することで、ブランド統一されたドキュメントが完成する。

## このスキルが必須となるトリガー

以下のいずれかに該当する場合、Claude は本スキルを必ず参照してから作業を開始する:

- 新規 Markdown ファイル (`.md`) の作成
- 既存 Markdown ファイルへの追記・編集
- ドキュメント執筆（提案書 / 仕様書 / 報告書 / 議事録 / README / 設計書 / 見積書 / 技術文書）
- PDF 出力前提の Markdown 生成
- 「Markdown で書いて」「ドキュメント作って」「提案書まとめて」など Markdown 出力が暗黙に期待される指示

## このスキルが提供する 3 つの柱

### 1. 統一デザインシステム — Swiss Modern Minimal v3.0
- **ブランドカラー**: `#8A248C`（マゼンタ） / `#888888`（グレー） / `#040104`（インク）
- **タイポグラフィ**: 見出し `Inter Tight` / 本文 `Manrope` / 等幅 `JetBrains Mono` / 和文 `Hiragino Kaku Gothic ProN`
- **トーン**: 厳密グリッド・ヘアライン罫・余白の数学的均衡

### 2. PDF 出力前提のコンポーネント群
| カテゴリ | 種類 |
|:---|:---|
| Callout | 5 種類（note / tip / info / 注意 / 重要） — **必要な時のみ使用** |
| Shape Box | 5 種類（標準 / filled / outline / brand / data-title） |
| Divider | 9 種類（hairline / double / dot 系 6種 / brand 菱形） |
| Table | 5 種類（4辺枠線デフォルト / no-borders / compact / jp / wrap） |
| **Stats / KPI** | 数値強調カード（標準 / brand / minimal） |
| **Timeline** | 横プロセスステップ（done / active / 未着手） |
| **Pull Quote** | 引用・顧客の声（標準 / brand） |
| **Comparison** | Before / After の 2 列カード |
| **Bar Chart** | 横棒グラフ（CSS `width: %` 指定） |
| **Donut Chart** | SVG 円グラフ（`stroke-dasharray` 制御） |
| **Feature List** | アイコン + タイトル + 説明 3 列グリッド（**SVG アイコン必須・絵文字禁止**） |
| **Person Card** | 人物プロフィール（avatar + name + role + body） |
| **Pricing Table** | 料金プラン（標準 / featured バッジ） |
| **API Blueprint** | REST API 仕様書（method バッジ 7 色 / params 表 / status / example） |
| TOC | クリック遷移可能目次（**ページ番号なし**: 実ページとずれるため記載禁止） |
| インライン | mark / tag / muted / brand / kbd / abbr |

詳細スニペットは `assets/components-gallery.md` 参照。

### 3. 自動適用される運用ルール
- **H2 セクションは自動で改ページ**（CSS 側で制御、命令不要）
- **TOC リンクはクリック遷移可能**（`<h2 id="sec-xxx">` 形式必須）
- **ヘッダ左 = 株式会社C4C** デフォルト固定
- **フッタ = `v1.0 · DRAFT` + `現在 / 総数`** 形式
- **日本語は JP Fix 7 項目セルフチェック**

## 出力形式

Claude は **Markdown テキストを返す**。HTML 化や PDF 化は行わない。
ユーザーは出力された Markdown をコピーして手元の `.md` ファイルに保存し、VS Code + `markdown-pdf` 拡張で PDF 化する。

## 必須生成手順

### ステップ 1: ドキュメント先頭テンプレート
新規 Markdown は必ず以下の構造で開始する:

```markdown
<head>
<title>ドキュメントタイトル（拡張子なし）</title>
</head>

# ドキュメントタイトル

<div class="caption">Author: 担当者名　·　Version: v1.0　·　Date: YYYY-MM-DD</div>

<nav class="toc toc-no-page">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-1">セクション1</a></li>
    <li><a href="#sec-2">セクション2</a></li>
  </ol>
</nav>

<!-- ⚠️ TOC 内に <span class="page">N</span> を書いてはいけない。
     実 PDF のページ数と必ずズレるため、ページ番号は記載禁止。
     クラスは toc-no-page を必ず付ける（dots / page を CSS で非表示にする）。 -->
```

### ステップ 2: H2 セクションは ID 付き直書き
**`{#id}` 構文は使用禁止**（markdown-it 非対応）。必ず HTML タグで:

```markdown
<h2 id="sec-overview">1. 概要</h2>
```

### ステップ 3: バリエーション使い回し（最重要ルール）

同種のコンポーネントを複数使うときは **必ず異なるバリエーション**を選んでリズムを作る:

#### Callout — 必要な時のみ使う（多用禁止）

**使用ルール:**
- 本当に強調が必要な箇所のみ。装飾目的で使わない
- 普通の段落・太字で意図が伝わるなら Callout 不要
- 連続して 2 個以上並べない、機械的に全セクションに 1 個ずつ置かない
- 判断軸: 「Callout を外しても文章として成立するか？」→ 成立するなら使わない

**5 種類とラベル（`warning` `danger` のみ日本語表示）:**

| クラス | 表示 | 用途 |
|:---|:---|:---|
| `callout-note` | NOTE | 通常の補足 |
| `callout-tip` | TIP | 推奨・ベストプラクティス |
| `callout-info` | INFO | 参考情報・出典 |
| `callout-warning` | **注意** | 誤操作・期日の注意喚起 |
| `callout-danger` | **重要** | データ損失・契約上の禁止事項 |

```html
<div class="callout callout-warning">
  <p><strong>注意。</strong>連休期間中はバッファ 2 週間を見込み。</p>
</div>
<div class="callout callout-danger">
  <p><strong>重要。</strong>本見積もりは仮見積もり。要件定義後に再見積もり。</p>
</div>
```

#### Shape Box — 5 種類を使い分け
```html
<div class="shape-box">標準枠</div>
<div class="shape-box shape-filled">塗り背景・補足コラム</div>
<div class="shape-box shape-outline">太枠・サマリー / 結論</div>
<div class="shape-box shape-brand">ブランド色強調・キーメッセージ</div>
<div class="shape-box" data-title="VISUAL ASSET">画像 + 説明セット ★お気に入り</div>
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

#### 組織名（ヘッダ左）
| 指示 | 対応 |
|:---|:---|
| 何も言われない | `株式会社C4C` のまま（デフォルト） |
| 「個人名で」「SAROJ で」 | settings.json の `class='header-org'` を `SAROJ SEENUAN` に変更する差分提示 |

#### バージョン（caption 行で動的指定）
**フッタ左は空。バージョンは Markdown 本文の caption 行に書く** — ドキュメントごとに動的に変えられるようにこの方式に統一。

```markdown
<div class="caption">Author: 担当者名　·　Version: v1.0 · DRAFT　·　Date: YYYY-MM-DD</div>
```

| 指示 | 対応 |
|:---|:---|
| 「v2.3 で」「FINAL で」「社外秘で」 | caption 行の `Version: ...` 部分を書き換える |
| 何も言われない | `Version: v1.0 · DRAFT` をデフォルト |

⚠️ **settings.json のフッタは触らない** — フッタの `<span class='footer-version'>` は空のまま運用する。

### ステップ 6: SVG / HTML コメントの制約（重要）

**markdown-it は `<svg>` の中身に改行や HTML コメント `<!-- ... -->` があると、SVG を壊してコードブロックとして出力する。**

#### NG（壊れる）
```html
<svg>
  <!-- グリッド -->
  <line x1="0" y1="0" x2="100" y2="100"/>
</svg>
```

#### OK（1 行に詰める、コメントなし）
```html
<svg><line x1="0" y1="0" x2="100" y2="100"/></svg>
```

#### ルール
- `<svg>...</svg>` の中身は **必ず 1 行に詰める**
- SVG 内に `<!-- ... -->` コメントを書かない
- `<div>` の中の `<svg>` は OK（`<div>` 直下は改行可、SVG 内は不可）
- 凡例 `<div class="lg-legend">` などの **SVG 外の要素は普通に改行 OK**

該当コンポーネント: **Line Graph (`.line-graph`)**、その他 SVG を含むカスタム要素全般。

## 同梱アセット

| 役割 | パッケージ内パス |
|:---|:---|
| **CSS スタイル定義** | `pdf-setup/markdown-pdf.css` |
| **VS Code 設定サンプル** | `pdf-setup/settings.json.sample` |
| **セットアップ手順書** | `pdf-setup/README-PDF-SETUP.md` |
| **PDF エクスポート手順** | `pdf-setup/how-to-export.md` |
| **スタータードキュメント** | `assets/template-document.md` |
| **コンポーネントギャラリー** | `assets/components-gallery.md` |
| **JP Fix チェック** | `assets/jp-fix-checklist.md` |

## 自動チェックリスト（生成完了前に必ず確認）

- [ ] `<head><title>...</title></head>` が冒頭にある
- [ ] H1 はドキュメントタイトル 1 つだけ
- [ ] H2 セクションが `<h2 id="sec-xxx">` 形式
- [ ] TOC リンクの `href="#sec-xxx"` と H2 ID が一致
- [ ] TOC に **ページ番号 `<span class="page">` を書いていない**（実ページとズレるため禁止）
- [ ] TOC の `<nav>` に `class="toc toc-no-page"` が付いている
- [ ] Callout を 2 つ以上使った場合、種類が違う
- [ ] Divider を 2 つ以上使った場合、種類が違う
- [ ] 重要な画像は `shape-box data-title` 形式
- [ ] テーブルにアラインメント指定 `|:---:|---:|` がある
- [ ] `==text==` 構文を使っていない（`<mark>` のみ使う）
- [ ] 日本語の場合、JP Fix 7 項目チェック実行済み

## アイコン方針

**絵文字（emoji）の使用は禁止。** アイコンを使う場合はインライン SVG のみ。

理由: 絵文字は OS / フォント / PDF レンダラーで表示が変わり、ブランド統一が崩れる。SVG ならどの環境でも同じ見た目になる。

推奨ライブラリ（すべて MIT、商用利用可）:
- **Heroicons** (`heroicons.com`) — Tailwind 製、線細め・シンプル
- **Lucide** (`lucide.dev`) — Feather 由来、現代的
- **Tabler Icons** (`tabler-icons.io`) — 大量バリエーション

使い方: `stroke="currentColor" fill="none"` の SVG をそのまま `<span class="feature-icon">` の中に貼る。色は親要素から継承される。

## スラッシュコマンド `/markdown-c4c`

スキルを明示的に呼びたい場合は `/markdown-c4c [タイトル]` で呼出可能。

## PDF 出力までの流れ

1. Claude Web でこのスキルを使って Markdown を生成してもらう
2. 出力されたテキストをコピーし、ローカルの `.md` ファイルとして保存
3. VS Code で `.md` を開き、右クリック → `Markdown PDF: Export (pdf)` で PDF 化
4. 仕上がりは Ken の本家環境と **完全に同一** のクオリティー

初回セットアップ手順は `pdf-setup/README-PDF-SETUP.md` を参照。
