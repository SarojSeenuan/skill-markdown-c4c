<head>
<title>Release Notes — markdown-c4c v5.0.0</title>
</head>

<div class="cover-page">
  <div class="cover-body">
    <span class="cover-eyebrow">RELEASE</span>
    <h1 class="cover-title">markdown-c4c<br>v5.0.0 Release Notes</h1>
    <p class="cover-subtitle">テンプレート全廃 + Q&A 必須化・closing-page Editorial 再設計・
円形 SVG アイコンバッジ標準化（v5.0.0〜v5.0.4 統合版）</p>
  </div>
  <table class="cover-meta">
    <tr><th>VERSION</th><td>v5.0.0 — v5.0.4</td></tr>
    <tr><th>DATE</th><td>2026-05-24</td></tr>
    <tr><th>STATUS</th><td>RELEASED</td></tr>
    <tr><th>AUTHOR</th><td>株式会社C4C</td></tr>
  </table>
</div>

<div class="no-break">

# Release Notes — v5.0.0 〜 v5.0.4

<div class="caption">Version: v5.0.0 — v5.0.4 · RELEASED　·　Date: 2026-05-24　·　株式会社C4C</div>

<nav class="toc toc-no-page">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-overview">統合リリースの位置づけ</a></li>
    <li><a href="#sec-breaking">破壊的変更（v5.0.0）</a></li>
    <li><a href="#sec-added-500">v5.0.0 — 追加</a></li>
    <li><a href="#sec-changed-500">v5.0.0 — 変更</a></li>
    <li><a href="#sec-501">v5.0.1 — TOC 改ページ修正</a></li>
    <li><a href="#sec-502">v5.0.2 — closing-contact Block-based + watermark 拡大</a></li>
    <li><a href="#sec-503">v5.0.3 — closing-contact Editorial 再設計</a></li>
    <li><a href="#sec-504">v5.0.4 — 円形 SVG アイコンバッジ標準化</a></li>
    <li><a href="#sec-migration">移行ガイド</a></li>
  </ol>
</nav>

</div>

<h2 id="sec-overview">1. 統合リリースの位置づけ</h2>

このノートは v5.0.0 から v5.0.4 までのパッチ群を 1 つにまとめたものです。 v5.0.0 がメジャーリリースとして「テンプレート全廃 + Q&A 必須化」を実施し、その後 v5.0.1〜v5.0.4 で実 PDF レビューを反映するパッチを連続投入しました。 v5 系の機能セットを一度に俯瞰したいときは、このノートを参照してください。

<h2 id="sec-breaking">2. 破壊的変更（v5.0.0）</h2>

| 変更点 | 影響 |
|:---|:---|
| **SKILL.md セクション 4「ドキュメント種別テンプレート（5 種）」を完全削除** | テンプレートに依存していたフローはすべて Q&A 経由に切り替え |
| **Markdown 生成前に Q&A 確認（最低 5 項目）を必須化** | AskUserQuestion 経由で 種別 / 読者 / 主要メッセージ / コンポーネント / トーンを毎回確定 |
| **`cover-mark` / `cover-footer` を cover-page から撤去** | CSS は `display: none !important` で防御、テンプレ側からも削除 |
| **`docs/markdown-c4c-reference.md` をテンプレート集 → 参考スニペット集に格下げ** | 冒頭に「コピペ元ではない」と明示 |

<h2 id="sec-added-500">3. v5.0.0 — 追加</h2>

- CSS: `.pricing` を `grid-template-columns: repeat(3, 1fr)` 固定 + `:has()` ベースの子要素数自動分岐（2 プラン → 2 列、 1 プラン → 中央配置）
- CSS: `.stats-grid` を `repeat(4, 1fr)` 固定 + `:has()` ベース自動分岐（3 → 3 列、 2 → 2 列、 1 → 中央）
- CSS: 手動上書きクラス `.pricing.cols-N` / `.stats-grid.cols-N`（`:has()` 非対応環境の fallback）
- ルール: 強調ラベル直後の区切りに「。」ではなくコロン「：」を使う（SKILL.md ステップ 7 配下に追加）

<h2 id="sec-changed-500">4. v5.0.0 — 変更</h2>

| 対象 | 変更内容 |
|:---|:---|
| `closing-credo` | 32pt → 22pt（1.5 段ダウン）、 line-height 1.9 → 1.8、 letter-spacing 0.1em → 0.08em |
| `closing-thanks` | Inter Tight 17pt 800 + `var(--brand-ink)` に強調（旧: Noto Sans JP 14pt 500 gray-60） |
| `watermark-logo` | opacity 0.06 → 0.12 / width 130mm → 110mm |
| `closing-cta-body` | 中央寄せ明示 + `white-space: pre-line` で改行尊重 / font-size 12pt → 11.5pt / max-width 120mm → 110mm |
| `cover-subtitle` | 中央寄せ明示 + `white-space: pre-line` で改行尊重 + `margin: 0 auto` |

<h2 id="sec-501">5. v5.0.1 — TOC 改ページ修正</h2>

### Fixed

- **TOC が caption と同じページに収まらず別ページに送られる問題** — `.toc h2`（Index 見出し）に `page-break-before: auto` を明示し、グローバル `h2 { page-break-before: always }` の上書きが効くようにした
- 保険として `.no-break h2` 全般に対しても改ページ抑止を追加（no-break ラッパ内の h2 で同じ事故が起きないようにする）

<h2 id="sec-502">6. v5.0.2 — closing-contact Block-based + watermark 拡大</h2>

### Changed

- **closing-contact を Block-based + Motion-Driven デザインに刷新** — contact-card を 2 列グリッドに変更、各 contact-row を独立ブロック化（左端ブランド色アクセントバー / 上下 2 段の階層 / 右上に動きを示す `↗` アイコン / 偶数行は影とアクセント色を変えてリズム化）
- **closing-watermark のロゴサイズ拡大** — width 110mm → 170mm。 紙面のほぼ全幅を覆う「背景全体がロゴ」の存在感
- **closing-thanks のサイズ調整** — 17pt → 12.5pt、 Inter Tight 800 → Noto Sans JP 700 に変更、 `white-space: nowrap` 追加で「最後までご覧いただき、誠にありがとうございました。」が確実に 1 行に収まる
- closing-contact の `contact-card` を子要素数で自動分岐（1 個 = 中央 1 列 / 3 個 = 1 行 3 列 / それ以外 = 2 列）

<h2 id="sec-503">7. v5.0.3 — closing-contact Editorial 再設計</h2>

### Changed

- **closing-contact を Editorial スタイルに全面再設計** — 参考デザイン準拠で、 box 囲み + left-border カードの「AI 量産デザイン」を完全撤廃。 大型 "Contact" タイポ + 左短縦バー + 短ヘアライン + ミッション文 + `Country for Country` タグライン + 円形ブランドカラーアイコン付き連絡先リスト + 下端 `Country for Country` ブランド署名で構成。 右上ドットパターン + 右下ブランドカラーアーク装飾
- **closing-cta も同 Editorial 語彙に再設計** — center-stack を脱却し左寄せ。 大型 "Contact" タイポ + 左短縦バー + 右上ドット + 右下アーク。 CTA ボタンは uppercase + letter-spacing 0.18em で印象を強化。 closing-cta-meta に `Country for Country` ブランド署名を配置
- HTML 構造変更: `closing-cta-eyebrow` / `closing-contact-eyebrow` を廃止（CSS は display:none で防御）。 `closing-cta-title` / `closing-contact h2` 内に `<small>` で日本語サブタイトルを埋める構造に変更
- closing-contact に `contact-mission` / `contact-tagline` / `contact-rule` / `contact-footer-tagline` の 4 要素を新設

<h2 id="sec-504">8. v5.0.4 — 円形 SVG アイコンバッジ標準化</h2>

### Added

- **SKILL.md セクション 5.19「円形アイコンバッジ — ★最お気に入りパターン」を新設** — ブランド色塗りつぶし円 + 白 stroke の SVG アイコンを、連絡先・属性リスト・特徴リスト・人物属性・価格特典などで積極使用するルール化。 8 種類の標準 SVG アイコン（user / envelope / globe / building / phone / location / calendar / shield）をコピペで使えるコードスニペット付きで掲載
- チェックリストに「連絡先・属性リスト・特徴リストには円形 SVG アイコンバッジを積極使用している」を追加

### Changed

- **closing-contact の contact-label を SVG アイコンに置換** — 英字テキスト（MEMBER / EMAIL / WEB / COMPANY）を Heroicons 系インライン SVG（user / envelope / globe / building-office）に置換。 円形バッジ内に 5.5mm の白色 stroke で描画
- **closing-contact / closing-cta の右下リング装飾を撤去** — `::after` のブランドアーク + グレーリングを display:none に。 右上ドットパターンは残置でバランスを取る
- closing-contact / closing-cta テンプレートを SVG アイコン版に書き換え（SKILL.md / docs/markdown-c4c-reference.md / docs/markdown-c4c-cover-closing-preview.md の 3 か所）

<h2 id="sec-migration">9. 移行ガイド</h2>

v4.0.0 以前から v5.0 系へ上げるとき、以下を確認してください。

### 9.1 ドキュメント生成フロー

- **テンプレートから書き始めない** — 必ず AskUserQuestion で最低 5 項目を確認してからゼロ構成
- **`docs/markdown-c4c-reference.md` はコピペ元ではない** — 部品ショーケースとして見比べる用

### 9.2 cover-page

- `cover-mark` / `cover-mark-label` / `cover-footer` を削除
- `cover-body`（eyebrow + title + subtitle）+ `cover-meta` の 2 要素のみに簡素化

### 9.3 closing-contact

- `<dl>` ではなく `contact-card` + `contact-row` 構造を使う
- ラベルは v5.0.4 以降、英字テキストではなく円形 SVG アイコンバッジを推奨

<div class="closing-page closing-message">
  <p class="closing-thanks">最後までご覧いただき、誠にありがとうございました。</p>
  <p class="closing-credo">「カタチ」に残すだけじゃない、<br>「ココロ」に残る仕事を。</p>
  <p class="closing-org">株式会社C4C</p>
</div>
