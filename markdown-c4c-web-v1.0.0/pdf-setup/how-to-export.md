<head>
<title>Markdown を PDF にする日常運用ガイド</title>
</head>

# Markdown を PDF にする日常運用ガイド

<div class="caption">対象: セットアップ済みの方　·　所要時間: 1 分</div>

セットアップ完了後の日常運用フロー。

<h2 id="sec-flow">1. 基本フロー</h2>

##### EVERYDAY WORKFLOW

1. Claude Web で `markdown-c4c` スキルを使って Markdown を生成してもらう
2. 出力をコピーして、ローカルの `.md` ファイルとして保存
3. VS Code で `.md` を開く
4. プレビュー確認（任意）: `Ctrl + Shift + V`
5. 右クリック → `Markdown PDF: Export (pdf)`
6. 同じフォルダに同名の `.pdf` が生成される

<div class="callout callout-tip">
<p><strong>ファイル名のルール。</strong>`提案書_2026-05-22.md` → `提案書_2026-05-22.pdf` のように、拡張子だけ置き換わった名前で同フォルダに出力される。</p>
</div>

<h2 id="sec-shortcut">2. ショートカット</h2>

| 操作 | キー |
|:---|:---:|
| プレビューを横に開く | `Ctrl` + `Shift` + `V` |
| コマンドパレット | `Ctrl` + `Shift` + `P` |
| エクスプローラー切替 | `Ctrl` + `Shift` + `E` |
| settings.json を開く | `Ctrl` + `Shift` + `P` → `Open User Settings (JSON)` |

<h2 id="sec-customize">3. カスタマイズ</h2>

### 3.1 組織名を変える

ヘッダ左の `株式会社C4C` を別の名前にしたい場合、`settings.json` の `markdown-pdf.headerTemplate` 内にある以下の部分を変更:

```html
<span class='header-org' ...>株式会社C4C</span>
```

例: 個人名で出したい時は `SAROJ SEENUAN` などに置換。

### 3.2 バージョン表記を変える

フッタ左の `v1.0 · DRAFT` を変えたい場合、同じく `settings.json` の `markdown-pdf.footerTemplate` 内:

```html
<span class='footer-version' ...>v1.0 &nbsp;·&nbsp; DRAFT</span>
```

| 用途 | 表記例 |
|:---|:---|
| ドラフト | `v1.0 · DRAFT` |
| 確定版 | `v2.0 · FINAL` |
| 社外秘 | `v1.2 · 社外秘` |
| 日付管理 | `Rev. 2026-05-22` |

<div class="callout callout-info">
<p><strong>ドキュメントごとに変えたい場合。</strong>毎回 settings.json を書き換えるのは現実的でないので、共通の社内ドラフト用 / 社外提案用などで使い分けるのが現実的。本格運用するなら複数の VS Code プロファイルを切り替える方法もある。</p>
</div>

<h2 id="sec-tips">4. 運用のコツ</h2>

<div class="shape-box shape-filled">
<ul>
<li><strong>長い資料は H2 単位で改ページされる</strong> — H1 はドキュメントタイトル 1 つだけ、各セクションは H2 で始める</li>
<li><strong>TOC は手書き</strong> — Claude が生成する Markdown に最初から TOC が含まれる</li>
<li><strong>画像は <code>file:///</code> で絶対パス指定</strong> — 相対パスも使えるが、フォルダ移動時に切れやすい</li>
<li><strong>PDF はバージョン管理対象外</strong> — 元の <code>.md</code> だけ Git 管理すれば十分</li>
</ul>
</div>

<hr class="divider-dot-brand">

<p class="center muted">— 詳しい設定変更は <code>README-PDF-SETUP.md</code> を参照 —</p>
