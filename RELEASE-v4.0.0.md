<head>
<title>Release Notes — markdown-c4c v4.0.0</title>
</head>

<div class="cover-page">
  <div class="cover-body">
    <span class="cover-eyebrow">RELEASE</span>
    <h1 class="cover-title">markdown-c4c<br>v4.0.0 Release Notes</h1>
    <p class="cover-subtitle">cover / closing デザイン全面刷新・
フォント体系引き上げ・コンテンツ密度ルール・Q&A ワークフロー導入</p>
  </div>
  <table class="cover-meta">
    <tr><th>VERSION</th><td>v4.0.0</td></tr>
    <tr><th>DATE</th><td>2026-05-23</td></tr>
    <tr><th>STATUS</th><td>RELEASED</td></tr>
    <tr><th>AUTHOR</th><td>株式会社C4C</td></tr>
  </table>
</div>

<div class="no-break">

# Release Notes — v4.0.0

<div class="caption">Version: v4.0.0 · RELEASED　·　Date: 2026-05-23　·　株式会社C4C</div>

<nav class="toc toc-no-page">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-highlights">ハイライト</a></li>
    <li><a href="#sec-cover">cover-page 全面書き直し</a></li>
    <li><a href="#sec-closing">closing-page 全面書き直し</a></li>
    <li><a href="#sec-pagebug">ページ構造バグ修正</a></li>
    <li><a href="#sec-fonts">フォント体系刷新</a></li>
    <li><a href="#sec-density">コンテンツ密度ルール</a></li>
    <li><a href="#sec-writing">文言ルール統一</a></li>
    <li><a href="#sec-breaking">破壊的変更</a></li>
    <li><a href="#sec-migration">移行ガイド</a></li>
    <li><a href="#sec-install">インストール</a></li>
  </ol>
</nav>

</div>

<h2 id="sec-highlights">1. ハイライト</h2>

v3.5.0 リリース後の実 PDF レビューで判明した構造的欠陥を解消するメジャーリリースです。 表紙・締めページの全面刷新、フォント体系の引き上げ、コンテンツ密度ルールの追加が中心。

<h2 id="sec-cover">2. cover-page 全面書き直し</h2>

流行デザイン（Linear / Vercel / Stripe / Notion 系）を踏まえた Swiss Modern 強化版へ。

- 3 ゾーン縦配分（上端 mark / 中央 body / 下端 meta + footer）
- Noto Sans JP Black 38pt のタイトル、 Medium 13pt のサブタイトル
- 種別 eyebrow タグ（`PROPOSAL` / `SPECIFICATION` / `DESIGN` / `MINUTES` / `ESTIMATE` / `REPORT` / `OVERVIEW`）
- HTML inline `width` 属性に勝つ `!important` ロゴサイズ強制

<h2 id="sec-closing">3. closing-page 全面書き直し</h2>

4 パターンすべてを刷新。 各パターンに固有 eyebrow、フォントサイズ・letter-spacing の数値強化。

- **closing-message** — クレドを 32pt Black / line-height 1.9 / letter-spacing 0.1em に強化
- **closing-watermark（NEW）** — 大きな C4C ロゴを `opacity: 0.06` で背景透かしし、テキストを前面に重ねる提案書最終ページ用パターン
- **closing-cta** — eyebrow `CONTACT` 追加、 button を `<a>` 直書きに（位置安定）、 body の「御社」→「貴社」
- **closing-contact** — `<dl>` を捨て `contact-card + contact-row` 構造へ、ラベルは英字固定（MEMBER / EMAIL / WEB / TEL / ADDRESS）

<h2 id="sec-pagebug">4. ページ構造バグ修正</h2>

- cover-page 直後の `<div class="page-break"></div>` を廃止（2 重改ページ事故の解消）
- H1 + caption + TOC を `<div class="no-break">` で囲む運用ルールを導入
- closing-page 内に `<hr>` 系を書かない方針（紫菱形だけの空白ページ事故を根絶）
- `.closing-page > hr` / `.divider-brand` を CSS 側で `display: none` 防御

<h2 id="sec-fonts">5. フォント体系刷新</h2>

- Google Fonts `@import` 追加（Noto Sans JP / Inter Tight / Manrope / Zen Kaku Gothic New / JetBrains Mono）
- `:root` に CSS 変数（`--font-sans-en` / `--font-sans-jp` / `--font-display` / `--font-mono`）
- 見出し weight を 700 → 800 / 800 → 900 に引き上げ（H2 / cover-title / closing-credo / closing-cta-title）
- body のフォントスタックを Noto Sans JP 優先に変更

<h2 id="sec-density">6. コンテンツ密度ルール（SKILL.md 追加）</h2>

- H2 セクション 1 つあたり最低 2 段落（合計 200 字以上）の説明文必須
- コンポーネントを使う場合は直前か直後に意味づけ段落を必ず添える
- ドキュメント種別別の字数目安: 提案書 300 字 / 仕様書 200 字 / 議事録 100 字
- NG / OK 例を SKILL.md に明示

<h2 id="sec-writing">7. 文言ルール統一</h2>

書き言葉では以下を徹底:

| NG | OK |
|:---|:---|
| 御社 | 貴社 |
| 弊社 | 当社 |
| この度 | このたび |
| 〜致します | 〜いたします |

<h2 id="sec-breaking">8. 破壊的変更</h2>

| 変更点 | 影響 |
|:---|:---|
| cover-page 内に `<div class="page-break">` を書くと 2 重改ページになる | テンプレ更新が必要 |
| closing-page 内に `<hr class="divider-brand">` を書くと CSS で非表示化される | テンプレ更新が必要 |
| cover-page のロゴ `<img>` に `width="..."` 属性を書くと CSS が上書きするが推奨は属性なし | テンプレ更新が推奨 |
| closing-contact が `<dl>` → `contact-card` 構造に変更 | 既存ドキュメントは新構造で書き直し推奨 |
| closing-contact ラベルが英字固定 | 日本語ラベル（「担当」など）は字間崩れの原因のため不可 |

<h2 id="sec-migration">9. 移行ガイド</h2>

### 9.1 cover-page を新構造に置換

旧:

```html
<div class="cover-page">
  <div class="cover-logo"><img src="..." width="100"></div>
  <hr class="cover-divider">
  <h1 class="cover-title">...</h1>
  ...
</div>
<div class="page-break"></div>
```

新（v4.0.0 時点）:

```html
<div class="cover-page">
  <div class="cover-mark">
    <img src="..." alt="C4C">
    <span class="cover-mark-label">株式会社C4C</span>
  </div>
  <div class="cover-body">
    <span class="cover-eyebrow">PROPOSAL</span>
    <h1 class="cover-title">...</h1>
    <p class="cover-subtitle">...</p>
  </div>
  <table class="cover-meta">...</table>
  <p class="cover-footer">...</p>
</div>
```

> 注: v5.0.0 で `cover-mark` / `cover-footer` は廃止されました。 v5 以降では `cover-body` + `cover-meta` のみ使います。

### 9.2 H1 + caption + TOC を no-break で囲む

```markdown
<div class="no-break">

# タイトル

<div class="caption">...</div>

<nav class="toc toc-no-page">...</nav>

</div>
```

### 9.3 closing-contact を新構造に置換

旧:

```html
<div class="closing-page closing-contact">
  <hr class="divider-brand">
  <h2>連絡先</h2>
  <dl>
    <dt>担当</dt><dd>...</dd>
  </dl>
</div>
```

新（v4.0.0 時点）:

```html
<div class="closing-page closing-contact">
  <span class="closing-contact-eyebrow">CONTACT</span>
  <h2>連絡先</h2>
  <div class="contact-card">
    <div class="contact-row">
      <span class="contact-label">MEMBER</span>
      <span class="contact-value">...</span>
    </div>
  </div>
</div>
```

> 注: v5.0.4 で contact-label は英字テキスト → 円形 SVG アイコンバッジに置換されました。 最新版の構造は SKILL.md セクション 5.19 を参照。

<h2 id="sec-install">10. インストール</h2>

```bash
# Claude Code
node scripts/install.js
# or
pwsh ./scripts/install.ps1   # Windows
bash ./scripts/install.sh    # macOS / Linux

# Claude Web
# markdown-c4c-v4.0.0.zip を Skills にアップロード
```

```bash
# ZIP ビルド
npm run build:zip
```

### 検証済み環境

- VS Code + `yzane.markdown-pdf` 拡張機能（puppeteer ベース）
- Windows 11 / macOS / Ubuntu 22.04
- A4 縦・余白 24mm 20mm 24mm 20mm

<div class="closing-page closing-message">
  <p class="closing-thanks">最後までご覧いただき、誠にありがとうございました。</p>
  <p class="closing-credo">「カタチ」に残すだけじゃない、<br>「ココロ」に残る仕事を。</p>
  <p class="closing-org">株式会社C4C</p>
</div>
