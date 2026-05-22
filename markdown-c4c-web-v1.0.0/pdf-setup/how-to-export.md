<head>
<title>Markdown を PDF にする日常運用ガイド</title>
</head>

# Markdown を PDF にする日常運用ガイド

<div class="caption">対象: セットアップ済みの方　·　所要時間: 1 分　·　対応 OS: Windows / macOS / Linux</div>

セットアップ完了後の日常運用フロー。 3 OS いずれでも手順は共通、ショートカットだけ違う。

<h2 id="sec-flow">1. 基本フロー</h2>

##### EVERYDAY WORKFLOW

1. Claude Web で `markdown-c4c` スキルを使って Markdown を生成してもらう
2. 出力をコピーして、ローカルの `.md` ファイルとして保存
3. VS Code で `.md` を開く
4. プレビュー確認（任意）
5. 右クリック → `Markdown PDF: Export (pdf)`
6. 同じフォルダに同名の `.pdf` が生成される

<div class="callout callout-tip">
<p><strong>ファイル名のルール。</strong>`提案書_2026-05-22.md` → `提案書_2026-05-22.pdf` のように、拡張子だけ置き換わった名前で同フォルダに出力される。</p>
</div>

<h2 id="sec-shortcut">2. ショートカット</h2>

| 操作 | Windows / Linux | macOS |
|:---|:---:|:---:|
| プレビューを横に開く | `Ctrl` + `Shift` + `V` | `Cmd` + `Shift` + `V` |
| コマンドパレット | `Ctrl` + `Shift` + `P` | `Cmd` + `Shift` + `P` |
| エクスプローラー切替 | `Ctrl` + `Shift` + `E` | `Cmd` + `Shift` + `E` |
| 拡張機能タブ | `Ctrl` + `Shift` + `X` | `Cmd` + `Shift` + `X` |
| settings.json を開く | コマンドパレット → `Open User Settings (JSON)` | 同左 |

<h2 id="sec-customize">3. カスタマイズ</h2>

### 3.1 組織名を変える

ヘッダ左の `株式会社C4C` を別の名前にしたい場合、`settings.json` の `markdown-pdf.headerTemplate` 内にある以下の部分を変更:

```html
<span class='header-org' ...>株式会社C4C</span>
```

例: 個人名で出したい時は `YOUR NAME` などに置換。

### 3.2 バージョン表記は Markdown 本文側で動的指定

フッタ左は **空のまま運用** が markdown-c4c v3.5 のデフォルト。 バージョンは Markdown 本文の caption 行で都度書く。

```markdown
<div class="caption">Author: ○○ ○○　·　Version: v2.3 · FINAL　·　Date: 2026-05-22</div>
```

| 用途 | caption 表記例 |
|:---|:---|
| ドラフト | `Version: v1.0 · DRAFT` |
| 確定版 | `Version: v2.0 · FINAL` |
| 社外秘 | `Version: v1.2 · 社外秘` |
| 日付管理 | `Rev. 2026-05-22` |

<div class="callout callout-info">
<p><strong>毎回 settings.json を書き換えずに済む。</strong>ドキュメントごとに caption 行を編集するだけでバージョン表記を変えられる。 settings.json の <code>footer-version</code> は空のままで OK。</p>
</div>

<h2 id="sec-tips">4. 運用のコツ</h2>

<div class="shape-box shape-filled">
<ul>
<li><strong>長い資料は H2 単位で改ページされる</strong> — H1 はドキュメントタイトル 1 つだけ、各セクションは H2 で始める</li>
<li><strong>表紙と締めページを忘れない</strong> — 1 ページ目に <code>cover-page</code>、最終ページに <code>closing-page</code> 4 パターンから 1 つ</li>
<li><strong>TOC は手書き</strong> — Claude が生成する Markdown に最初から TOC が含まれる</li>
<li><strong>画像は <code>file:///</code> で絶対パス指定</strong> — 相対パスも使えるが、フォルダ移動時に切れやすい</li>
<li><strong>PDF はバージョン管理対象外</strong> — 元の <code>.md</code> だけ Git 管理すれば十分</li>
</ul>
</div>

<hr class="divider-dot-brand">

<p class="center muted">— 詳しい設定変更は <code>README-PDF-SETUP.md</code> を参照 —</p>
