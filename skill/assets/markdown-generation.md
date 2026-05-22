# Markdown Generation Rules

Markdown を生成・編集するときは、必ず以下のルールに従う。
これは `C:\Users\kensu\.claude\styles\markdown-pdf.css` (Swiss Modern v3.0) で PDF 化される前提のフォーマット。

## 必須スタイル要素

- **見出し階層**:
  - H1 = ドキュメントタイトル
  - H2 = セクション
  - H3 = サブセクション
  - H4 = グループ
  - H5 = タグ風オーバーライン (uppercase + letter-spacing)
  - H6 = キャプション系
- **強調**: 太字 (`**...**`) と inline code (`` `...` ``) を積極使用
- **マーカー強調**: `<mark>...</mark>` を使う（黄色ハイライト）。ブランド色版は `<mark class="brand">...</mark>`。**`==text==` 構文は markdown-it 非対応のため使わない**
- **テーブル**: GFM 構文 + アライメント (`|:---|---:|`) を活用。長文セルは自動折返しが効くので恐れず使う
- **コード**: ```` ```lang ```` で言語指定すれば One Dark Pro 配色でハイライト
- **チェックリスト**: `- [ ]` `- [x]` でカスタムチェックボックス表示

## 拡張コンポーネント（HTML 埋め込み）

PDF を意識した出力では以下の HTML スニペットを必要に応じて使う。

### Callout 5 種類

```html
<div class="callout callout-note">通常情報</div>
<div class="callout callout-tip">推奨・成功</div>
<div class="callout callout-info">補足情報</div>
<div class="callout callout-warning">注意</div>
<div class="callout callout-danger">危険・禁止</div>
```

### 図形ボックス 4 種類

```html
<div class="shape-box">標準枠</div>
<div class="shape-box shape-filled">塗り背景</div>
<div class="shape-box shape-outline">太枠強調</div>
<div class="shape-box shape-brand">ブランド色強調</div>
<div class="shape-box" data-title="セクション名">タイトル付き</div>
```

### ファイル名付きコードブロック

```html
<pre data-filename="src/main.ts"><code>...</code></pre>
```

### 区切り線バリエーション

```html
<hr>                              <!-- 標準: hairline -->
<hr class="divider-double">       <!-- 二重線 -->
<hr class="divider-dot">          <!-- ドット 3 個（控えめ）-->
<hr class="divider-dot-5">        <!-- ドット 5 個（横長）-->
<hr class="divider-dot-line">     <!-- 横一面ドット線（点線フル幅）-->
<hr class="divider-dot-dense">    <!-- 密ドット線 -->
<hr class="divider-dot-brand">    <!-- ブランドカラードット -->
<hr class="divider-morse">        <!-- モールス風 (— · — · —) -->
<hr class="divider-brand">        <!-- 中央にブランド菱形 -->
```

### 目次（Index / TOC）

**重要: ページ番号は記載禁止。** Markdown PDF は出力時にページ番号を自動採番しないため、TOC に `<span class="page">` を書くと **実 PDF のページ数と必ずズレる**。`<nav>` には必ず `class="toc toc-no-page"` を付ける。

```html
<nav class="toc toc-no-page">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-1">セクション名</a></li>
    <li><a href="#sec-2">セクション名</a></li>
  </ol>
</nav>
```

### テーブルバリエーション

```html
<table class="with-v-lines">  <!-- 縦罫あり -->
<table class="compact">        <!-- コンパクト（長文表用） -->
<table class="jp">             <!-- 日本語 keep-all（単語途中折返し回避）-->
<div class="table-wrap"><table>...</table></div>  <!-- 横スクロール対応 -->
```

### ユーティリティクラス

```html
<span class="tag">LABEL</span>
<span class="muted">補足テキスト</span>
<span class="brand">ブランド強調</span>
<div class="page-break"></div>
<div class="no-break">改ページさせたくない</div>
<p class="caption">キャプション</p>
<p class="center">中央寄せ</p>
<p class="right">右寄せ</p>
```

### 画像

```markdown
![alt](path)                                    <!-- 標準 -->
```

```html
<figure>
  <img src="path" alt="...">
  <figcaption>FIGURE 1.　キャプション</figcaption>
</figure>
```

## ヘッダ / フッタの組織名・バージョン ルール

PDF ヘッダ左に表示される組織名は **デフォルトで「株式会社C4C」** に設定されている（settings.json の `markdown-pdf.headerTemplate` 固定）。

### 個人名で出したい場合
プロンプトで「SAROJ SEENUAN で」「個人名で」「Ken 名義で」と明示された場合のみ、settings.json の `class='header-org'` のテキスト部分を `SAROJ SEENUAN` に切り替える差分を提示する。
変更コードを出すだけで、Ken が手動で settings.json を書き換える。

### バージョン表記
フッタ左の `class='footer-version'` 部分は資料バージョンを示す（例: `v1.0 · DRAFT` / `v2.3 · FINAL` / `v1.2 · 社外秘` / `Rev. 2026-05-21`）。
ドキュメントごとに異なる場合は、Markdown 冒頭でバージョンを伝えれば、Claude は settings.json の該当箇所のみの差分を提示する。

## ドキュメント先頭の `<title>` 必須

PDF ヘッダの右側に表示されるタイトルは、HTML の `<title>` タグの値が使われる（puppeteer 仕様）。
**ファイル名がそのまま表示されると `.md` 拡張子も出てしまう**ため、Markdown ファイル先頭に必ず `<head><title>` を埋め込む。

```markdown
<head>
<title>ドキュメントタイトル（拡張子なし）</title>
</head>

# ドキュメントタイトル

本文...
```

これを書かないと、ヘッダ右側に `MARKDOWN-PDF-TEST.MD` のようにファイル名がそのまま出る。

## 生成ルール

1. **長文ドキュメント（5 セクション以上）には必ず TOC を先頭に配置**
2. **重要な注意 / 警告は callout を使う** — 普通の太字や「注」だけで済ませない
3. **比較・分類・手順は迷わず表にする** — 表は Swiss Style で美しく描画される
4. **コードブロックには言語と可能ならファイル名を指定** (`<pre data-filename="...">`)
5. **見出し階層を飛ばさない** — H1 → H2 → H3 の順、いきなり H4 や H5 から始めない
6. **shape-box は乱用しない** — ドキュメント全体で 2〜3 個まで。 多用するとノイズになる
7. **タグ風 H5 は「セクション種類ラベル」用** — 「概要」「目的」「補足」「重要」など
8. **画像は figure + figcaption でキャプション付き表示が美しい**
9. **強調の三重がけ禁止** — 太字 + 色 + サイズの 3 軸のうち 1 軸のみで強調
10. **英単語の直後に「。」を付けない** — `KPI: Key Performance Indicator。重要業績評価指標` は NG。 `—` か `:` を使う
11. **「。」のあとに文章が続く場合は半角スペース 1 つを入れる** — `本見積もりは仮見積もりです。要件定義後に...` は NG、`本見積もりは仮見積もりです。 要件定義後に...` が OK

## バリエーション使い回しルール（積極使用）

同じコンポーネントを何度も使うときは**毎回違うバリエーションを選ぶ**ことで、ドキュメントに視覚的リズムが生まれる。

### Callout — 5 種類すべてを使い回す
- `callout-note`（青）= 通常情報・補足
- `callout-tip`（緑）= 推奨・成功・ベストプラクティス
- `callout-info`（青）= 補足情報・参考
- `callout-warning`（橙）= 注意喚起
- `callout-danger`（赤）= 危険・禁止事項

**運用**: 同じセクションに 2 つ以上 Callout を入れる場合、種類を必ず変える。例: 推奨は tip、注意は warning と使い分ける。

### Shape Box — 5 種類を使い分ける
- `shape-box`（標準）= 軽い区画化
- `shape-filled`（塗り背景）= 補足コラム
- `shape-outline`（太枠）= サマリー・結論
- `shape-brand`（ブランド色強調）= 提案コンセプト・キーメッセージ（ドキュメントで 1〜2 個まで）
- `shape-box data-title`（タイトル付き）= 画像 + 説明セットなど

**Ken のお気に入り**: `<div class="shape-box" data-title="VISUAL ASSET">` で画像 + 説明テキストを組み合わせるパターン。重要なビジュアルは必ずこの形式で出す。

### Divider — 9 種類でリズムを作る
セクション内の小区切りに使うときは種類を変える:
- `<hr>`（標準）= 通常区切り
- `divider-double` = やや強い区切り
- `divider-dot` / `divider-dot-5` = 控えめな視覚アクセント
- `divider-dot-line` / `divider-dot-dense` = 水平ドット線
- `divider-dot-brand` = ブランドアクセント区切り
- `divider-morse` = 装飾的区切り
- `divider-brand` = 章末締めくくり

### インライン要素 — 表現を変化させる
- `<mark>` 黄色マーカー / `<mark class="brand">` ブランド色マーカー
- `<span class="tag">DRAFT</span>` ラベルチップ
- `<span class="muted">` 補助テキスト
- `<span class="brand">` ブランド色強調
- `<kbd>` キーボードキー
- `<abbr title="">` 略語ツールチップ

### リスト — 4 種類を文脈で使い分ける
- 無順序 `-` = 並列項目
- 順序 `1.` = 手順・優先順位
- Task List `- [ ]` `- [x]` = チェックリスト・進捗
- 定義リスト `<dl><dt><dd>` = 用語集・項目別解説

### 画像 — 3 パターンを使い分ける（特に重要）
- 標準 `![alt](path)` = シンプル
- `<figure>` + `<figcaption>` = キャプション付き
- **`<div class="shape-box" data-title="...">` + 画像 + 説明** = Ken お気に入り。**重要なビジュアルは必ずこの形式**

## チェックリスト（生成後セルフレビュー）

ドキュメント生成後、以下を確認:
- [ ] H2 セクションがすべて `<h2 id="sec-xxx">` 形式になっているか
- [ ] TOC のリンクが H2 の ID と一致しているか
- [ ] TOC に `<span class="page">N</span>` を書いていないか（**ページ番号は実 PDF とズレるため記載禁止**）
- [ ] TOC の `<nav>` に `class="toc toc-no-page"` が付いているか
- [ ] `<head><title>...</title></head>` が冒頭にあるか
- [ ] Callout を使った場合、種類を使い分けているか
- [ ] Divider を 2 個以上使った場合、種類が違うか
- [ ] 画像を入れた場合、重要なものは `shape-box data-title` 形式か
- [ ] テーブルのアラインメント (`|:---:|---:|`) が適切に指定されているか
- [ ] `<mark>` または `==text==` 構文を使っていないか（`<mark>` のみ使う）

## 改ページルール（自動 + 手動）

### 自動改ページ（CSS で強制）
- **H2 セクションは必ず新しいページから開始**される（CSS の `page-break-before: always` で自動適用）。
- 命令なしで「3. リスト」終了 → 「4. テーブル」開始は自動的に別ページになる。
- 例外: TOC 直後の最初の H2 / `h2.no-page-break` クラスを付けた H2 は改ページしない。

### 手動改ページ
- 任意の場所で改ページしたい場合は `<div class="page-break"></div>` を挿入。
- 改ページさせたくないブロックには `<div class="no-break">...</div>` で囲む（Callout / Shape Box / TOC は既定で内部分割回避）。

## TOC / 見出しリンク（クリック遷移）

Markdown PDF（puppeteer ベース）は `<a href="#id">` 形式のアンカーリンクをクリック遷移可能にする。
ただし `{#id}` 構文は markdown-it でパースされないため、**見出しに id を付与するときは HTML タグで直接書く**:

### ✅ OK（クリック遷移する）
```markdown
<h2 id="sec-tables">4. テーブル</h2>
```
TOC 側:
```html
<li><a href="#sec-tables">テーブル</a></li>
```

### ❌ NG（id が振られない）
```markdown
## 4. テーブル {#tables}
```

### TOC 命名規則
- すべての H2 セクションに `id="sec-xxx"` を付ける（`sec-` プレフィックスで衝突回避）
- TOC の `<a href="#sec-xxx">` と一致させる
- **TOC にページ番号を書かない**（実 PDF とズレるため）。`<nav class="toc toc-no-page">` で必ず非表示にする

## 参照

- スタイル定義: `C:\Users\kensu\.claude\styles\markdown-pdf.css`
- 検証ドキュメント: `C:\Users\kensu\.claude\styles\markdown-pdf-test.md`
- PDF 出力設定: `C:\Users\kensu\AppData\Roaming\Code\User\settings.json` の `markdown-pdf.*` 設定群
- ブランドカラー: `#8A248C`（マゼンタ） `#888888`（グレー） `#040104`（インク）
