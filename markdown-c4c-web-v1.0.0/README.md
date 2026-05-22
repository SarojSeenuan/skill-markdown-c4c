<head>
<title>markdown-c4c-web v1.0.0 配布パッケージ</title>
</head>

<p class="center"><img src="assets/c4c-logo.png" alt="C for 4C — 株式会社C4C" width="120" height="120"></p>

# markdown-c4c-web v1.0.0

<div class="caption">配布元: 株式会社C4C　·　Version: v1.0.0　·　Date: 2026-05-23</div>

Claude Web の無料アカウントと、お手元の VS Code だけで、株式会社C4C ブランドの **Swiss Modern v3.4** PDF ドキュメントが作れる配布パッケージ。

<nav class="toc toc-no-page">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-what">これは何？</a></li>
    <li><a href="#sec-need">必要なもの</a></li>
    <li><a href="#sec-flow">全体の流れ</a></li>
    <li><a href="#sec-files">ファイル構成</a></li>
    <li><a href="#sec-support">サポート</a></li>
  </ol>
</nav>

<h2 id="sec-what">1. これは何？</h2>

##### OVERVIEW

`markdown-c4c` は、Claude（AI）に株式会社C4C のブランドガイドラインに沿った Markdown ドキュメントを書いてもらうためのスキル。

提案書・仕様書・報告書・議事録・README・設計書・見積書など、社内外で使うドキュメントを **デザインを気にせず中身に集中して書ける** ようになる。

<div class="shape-box shape-brand">
<p><strong>このパッケージの価値。</strong>C4C 公式環境とまったく同じクオリティーの PDF が、Word も Illustrator も使わずに、Markdown を書くだけで完成する。</p>
</div>

### このパッケージでできること

- Claude Web に登録するだけでスキルが使える
- VS Code 上で `.md` を右クリック → PDF 化で完成
- ヘッダ・フッタ・カラー・タイポグラフィすべてブランド統一
- Callout / Shape Box / Divider などの装飾コンポーネントが豊富

<h2 id="sec-need">2. 必要なもの</h2>

| 項目 | 内容 | 費用 |
|:---|:---|:---:|
| Claude Web アカウント | 無料プランで OK | 無料 |
| Windows / macOS / Linux の PC | OS は不問 | — |
| VS Code | 公式から DL | 無料 |
| Markdown PDF 拡張 | yzane 製 | 無料 |
| インターネット接続 | 初回セットアップ時のみ大量通信 | — |

<div class="callout callout-info">
<p><strong>追加料金は一切なし。</strong>すべて無料のツールで動く構成。</p>
</div>

<h2 id="sec-flow">3. 全体の流れ</h2>

##### THREE STEPS

セットアップから日常運用まで、3 ステップで完了する。

### ステップ 1: Claude Web にスキルを登録

このパッケージ内の `SKILL.md` を Claude Web の Skill 機能に登録する。
（登録手順は後日別資料で配布予定）

### ステップ 2: VS Code セットアップ

`pdf-setup\README-PDF-SETUP.md` の手順に沿って、VS Code と Markdown PDF 拡張を設定する。所要時間は約 15 分。

<div class="callout callout-tip">
<p><strong>画像付きで手順を解説。</strong>Word しか触ったことがなくても進められるよう、画面キャプチャを 6 枚入れている。</p>
</div>

### ステップ 3: 使い始める

1. Claude Web で「○○の提案書を markdown-c4c で書いて」のように依頼
2. 出てきた Markdown をコピーして `.md` ファイルに保存
3. VS Code で開いて右クリック → `Markdown PDF: Export (pdf)`
4. 完成

詳しい運用フローは `pdf-setup\how-to-export.md` を参照。

<h2 id="sec-files">4. ファイル構成</h2>

```
markdown-c4c-web-v1.0.0/
├── README.md                          ← このファイル
├── SKILL.md                           ← Claude Web に登録する本体（v3.5.0、自己充足型）
│
├── assets/
│   ├── template-document.md          ← スタータードキュメント（表紙 + 締めページ付き）
│   ├── components-gallery.md         ← 全コンポーネント一覧（オプション参照）
│   ├── jp-fix-checklist.md           ← 日本語チェック 8 項目
│   └── c4c-logo.png                  ← ブランドロゴ
│
└── pdf-setup/
    ├── README-PDF-SETUP.md            ← セットアップ手順書（画像付き · 3 OS 対応）
    ├── how-to-export.md               ← 日常運用ガイド
    ├── markdown-pdf.css               ← Swiss Modern v3.5 スタイル定義
    ├── settings.json.sample           ← VS Code 設定サンプル
    └── images/                        ← 手順書用スクリーンショット 6 枚
```

### 各ファイルの役割

| ファイル | 役割 |
|:---|:---|
| `SKILL.md` | Claude に「ブランドに沿った Markdown を書く」よう指示するスキル本体 |
| `assets\template-document.md` | コピペで使えるドキュメント雛形 |
| `assets\components-gallery.md` | Callout / Shape Box / Divider などのコピペ集 |
| `assets\jp-fix-checklist.md` | 日本語生成時のセルフチェック項目 |
| `pdf-setup/markdown-pdf.css` | **★クオリティーの核心**。2500 行超の Swiss Modern v3.5 CSS |
| `pdf-setup/settings.json.sample` | VS Code に追記する設定（ヘッダ・フッタ・余白） |
| `pdf-setup/README-PDF-SETUP.md` | 環境構築の全手順（Windows / macOS / Linux 対応） |
| `pdf-setup/how-to-export.md` | 日常運用フロー |

<hr class="divider-dot-line">

<h2 id="sec-support">5. サポート</h2>

##### CONTACT

導入で詰まったり、追加機能の相談があれば気軽に連絡を。

<dl>
  <dt>配布元</dt>
  <dd>株式会社C4C</dd>
  <dt>連絡手段</dt>
  <dd>https://portal.c4c.co.jp/contact</dd>
  <dt>このパッケージのバージョン</dt>
  <dd>v1.0.0（2026-05-23）</dd>
</dl>

<div class="callout callout-warning">
<p><strong>バージョン更新について。</strong>CSS やスキル本体が更新された場合は、新しい ZIP パッケージとして配布する。設定だけで使い続けたい場合は、CSS と settings.json だけ差し替えれば最新スタイルに追従できる。</p>
</div>

<hr class="divider-brand">

<p class="center muted">— READY TO BUILD BRANDED DOCUMENTS —</p>
