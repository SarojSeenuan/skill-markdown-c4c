# Components Gallery — Markdown C4C v3.0

全コンポーネントのコピペ用スニペット集。各セクションは独立して使える。

## 1. ドキュメント骨格

### 最小スケルトン
```markdown
<head>
<title>ドキュメントタイトル</title>
</head>

# ドキュメントタイトル

<div class="caption">Author: 名前　·　Version: v1.0　·　Date: 2026-05-21</div>
```

### TOC（目次）
```html
<nav class="toc">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-1">セクション1</a><span class="dots"></span><span class="page">2</span></li>
    <li><a href="#sec-2">セクション2</a><span class="dots"></span><span class="page">5</span></li>
    <li><a href="#sec-3">セクション3</a><span class="dots"></span><span class="page">8</span></li>
  </ol>
</nav>
```

### H2 見出し（ID 付き直書き、必須）
```markdown
<h2 id="sec-overview">1. 概要</h2>
```

## 2. インライン要素

| 用途 | コード |
|:---|:---|
| 黄色マーカー | `<mark>テキスト</mark>` |
| ブランド色マーカー | `<mark class="brand">テキスト</mark>` |
| タグラベル | `<span class="tag">DRAFT</span>` |
| 補助テキスト | `<span class="muted">補足</span>` |
| ブランド色強調 | `<span class="brand">強調</span>` |
| キーボードキー | `<kbd>Ctrl</kbd>+<kbd>S</kbd>` |
| 略語ツールチップ | `<abbr title="...">略語</abbr>` |

## 3. Callout（5 種類）

```html
<div class="callout callout-note">
  <p><strong>情報。</strong>通常情報・補足。</p>
</div>

<div class="callout callout-tip">
  <p><strong>推奨。</strong>ベストプラクティス・成功事例。</p>
</div>

<div class="callout callout-info">
  <p><strong>補足。</strong>参考情報。</p>
</div>

<div class="callout callout-warning">
  <p><strong>注意。</strong>誤操作で問題が起こる可能性。</p>
</div>

<div class="callout callout-danger">
  <p><strong>危険。</strong>データ損失・不可逆な変更の警告。</p>
</div>
```

## 4. Shape Box（5 種類）

```html
<div class="shape-box">
<p>標準枠 — 軽い区画化</p>
</div>

<div class="shape-box shape-filled">
<p>塗り背景 — 補足コラム</p>
</div>

<div class="shape-box shape-outline">
<p>太枠 — サマリー・結論</p>
</div>

<div class="shape-box shape-brand">
<p>ブランド色強調 — キーメッセージ</p>
</div>

<div class="shape-box" data-title="VISUAL ASSET">
<p><img src="..." alt="..." style="max-width:200px;margin:0 auto 12px auto;"></p>
<p><strong>タイトル</strong>　·　画像の文脈を説明するテキスト。</p>
</div>
```

## 5. Divider（9 種類）

```html
<hr>                              <!-- hairline -->
<hr class="divider-double">       <!-- 二重線 -->
<hr class="divider-dot">          <!-- ドット 3 個 -->
<hr class="divider-dot-5">        <!-- ドット 5 個 -->
<hr class="divider-dot-line">     <!-- 横一面ドット線 -->
<hr class="divider-dot-dense">    <!-- 密ドット線 -->
<hr class="divider-dot-brand">    <!-- ブランドカラードット -->
<hr class="divider-morse">        <!-- モールス風 (— · — · —) -->
<hr class="divider-brand">        <!-- ブランド菱形 -->
```

## 6. テーブル

### デフォルト（4 辺枠線 + ブランド色ヘッダ）
```markdown
| ID | Component | Status | Version |
|:---:|:---|:---:|---:|
| 001 | Typography | Stable | v3.0 |
| 002 | Tables | Stable | v3.0 |
```

### バリエーション
```html
<table class="no-borders">  <!-- 横罫のみ Swiss Style -->
<table class="compact">     <!-- コンパクト・長文表 -->
<table class="jp">          <!-- 日本語 keep-all -->
<div class="table-wrap"><table>...</table></div>  <!-- 横スクロール -->
```

### TH のアラインメントは TD に必ず継承させる
```markdown
| Label | Name | Qty | Price |
|:---:|:---|:---:|---:|
```
- `:---:` = 中央
- `:---` = 左
- `---:` = 右

## 7. コードブロック

### 標準（言語指定）
````markdown
```typescript
const brand = "#8A248C";
```
````

### ファイル名付き
```html
<pre data-filename="src/styles/tokens.css"><code>:root {
  --brand-primary: #8A248C;
}</code></pre>
```

## 8. リスト

### 無順序（入れ子）
```markdown
- 第一階層
  - 第二階層
    - 第三階層
```

### 順序リスト
```markdown
1. 最初
2. 次
   1. ネスト
3. 三番目
```

### Task List
```markdown
- [x] 完了タスク
- [ ] 未完了タスク
```

### 定義リスト
```html
<dl>
  <dt>用語</dt>
  <dd>定義。</dd>
</dl>
```

## 9. 引用

### 標準 blockquote
```markdown
> 引用テキスト。
> — 出典
```

### GFM Alerts（Callout として表示）
```markdown
> [!NOTE]
> 情報

> [!WARNING]
> 警告
```

## 10. 画像

### 標準（単独画像）
```markdown
![alt](path/to/image.png)
```

### figure + figcaption
```html
<figure>
  <img src="path" alt="...">
  <figcaption>FIGURE 1.　キャプション</figcaption>
</figure>
```

### ★画像 + 説明テキスト（重要なビジュアルは必ずこの形式）
```html
<div class="shape-box" data-title="VISUAL ASSET">
<p><img src="path" alt="..." style="max-width:200px;margin:0 auto 12px auto;"></p>
<p><strong>タイトル</strong>　·　文脈を説明するテキスト。</p>
</div>
```

## 11. ユーティリティ

| クラス | 用途 |
|:---|:---|
| `<div class="page-break"></div>` | 強制改ページ |
| `<div class="no-break">...</div>` | 改ページさせない |
| `<p class="center">...</p>` | 中央寄せ |
| `<p class="right">...</p>` | 右寄せ |
| `<p class="caption">...</p>` | キャプション体 |
| `<p class="muted">...</p>` | 薄色テキスト |
