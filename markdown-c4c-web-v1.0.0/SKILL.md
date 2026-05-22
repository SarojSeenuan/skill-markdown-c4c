---
name: markdown-c4c
description: Markdown 生成・編集時に必ず使用するスキル。株式会社C4C ブランドの Swiss Modern Minimal v3.5 デザインシステムで、PDF 出力を前提に社内ドキュメント・クライアント提案書・設計ドキュメント・仕様書・報告書・議事録・README を高品質に生成する。Markdown / md ファイル作成、`.md` 編集、ドキュメント執筆、提案書作成、仕様書作成、報告書作成、議事録、README、技術文書、設計書、見積書、PDF 出力、表組み、テーブル作成、Callout、Shape Box、TOC（目次）、ヘッダ・フッタのいずれかが要求された場合に必ず呼び出す。スラッシュコマンド `/markdown-c4c` でも明示的に呼び出せる。
author: "株式会社C4C"
version: "3.5.0"
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

# Markdown C4C — Design System Skill v3.5.0

株式会社C4C の標準 Markdown ドキュメント生成スキル。
**Markdown / md ファイルを生成・編集する前に、必ずこのスキルを参照すること。**

このスキルは Claude Code でも Claude Web でもそのまま使える。SKILL.md 単体で完結するように、コンポーネントの完全コード例とドキュメント種別テンプレートを内蔵している。

---

## 1. このスキルが必須となるトリガー

以下のいずれかに該当する場合、**Claude は本スキルを必ず Skill ツールで呼び出してから作業を開始する**:

- 新規 Markdown ファイル (`.md`) の作成
- 既存 Markdown ファイルへの追記・編集
- ドキュメント執筆（提案書 / 仕様書 / 報告書 / 議事録 / README / 設計書 / 見積書 / 技術文書）
- PDF 出力前提の Markdown 生成
- スラッシュコマンド `/markdown-c4c` の呼出
- 「Markdown で書いて」「ドキュメント作って」「提案書まとめて」など Markdown 出力が暗黙に期待される指示

---

## 2. 自動適用される運用ルール

| ルール | 内容 |
|:---|:---|
| 改ページ | **H2 セクションは自動で改ページ**（CSS が `page-break-before: always` を持つ。命令不要） |
| TOC リンク | クリック遷移可能（`<h2 id="sec-xxx">` 形式必須） |
| TOC ページ番号 | **記載禁止** — 実 PDF のページ数と必ずズレるため、`toc-no-page` クラスで非表示にする |
| ヘッダ左 | `株式会社C4C` をデフォルト固定（settings.json で制御） |
| ヘッダ右 | ドキュメント `<title>` がブランド色で表示される |
| **フッタ左** | **空のまま運用** — バージョンは Markdown 本文の caption 行で動的指定（settings.json の `footer-version` は空文字で固定） |
| フッタ右 | `現在 / 総数` ページ番号 |
| 日本語 | **JP Fix 8 項目セルフチェック** を送信前に必ず実行（句読点ルール含む） |
| SVG | `<svg>...</svg>` の中身は **必ず 1 行に詰める**。 内部に HTML コメントを書かない |
| アイコン | **絵文字（emoji）禁止**。 アイコンは Heroicons / Lucide / Tabler のインライン SVG のみ |
| マーカー | `<mark>...</mark>` のみ使用。 `==text==` 構文は markdown-it 非対応のため禁止 |
| 見出し ID | `{#id}` 構文禁止。 必ず `<h2 id="sec-xxx">` の HTML 直書き |

### ブランド規定

- **カラー**: `#8A248C`（マゼンタ） / `#888888`（グレー） / `#040104`（インク）
- **タイポグラフィ**: 見出し `Inter Tight` / 本文 `Manrope` / 等幅 `JetBrains Mono` / 和文 `Hiragino Kaku Gothic ProN`
- **トーン**: 厳密グリッド・ヘアライン罫・余白の数学的均衡

---

## 3. 必須生成手順

### ステップ 1: ドキュメント先頭

新規 Markdown は必ず以下の構造で開始する。 表紙が必要な場合は次節（ステップ 2）の cover-page テンプレートを併用する。

```markdown
<head>
<title>ドキュメントタイトル（拡張子なし）</title>
</head>

<!-- ここに cover-page を入れる場合あり（ステップ 2 参照） -->

# ドキュメントタイトル

<div class="caption">Author: ○○ ○○　·　Version: v1.0 · DRAFT　·　Date: YYYY-MM-DD</div>

<nav class="toc toc-no-page">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-1">セクション1</a></li>
    <li><a href="#sec-2">セクション2</a></li>
  </ol>
</nav>
```

### ステップ 2: 表紙テンプレート（ツール型）

ドキュメントの 1 ページ目を真っ白にしないため、外部資料・提案書・見積書では表紙を入れる。 軽量な技術メモや内部議事録では省略可。

```html
<div class="cover-page">
  <div class="cover-logo"><img src="assets/c4c-logo.png" alt="C4C" width="100"></div>
  <hr class="cover-divider">
  <h1 class="cover-title">ドキュメントタイトル</h1>
  <p class="cover-subtitle">サブタイトル / 一行説明</p>
  <hr class="cover-divider">
  <table class="cover-meta">
    <tr><th>DOCUMENT</th><td>クライアント提案書</td></tr>
    <tr><th>VERSION</th><td>v1.0 · DRAFT</td></tr>
    <tr><th>DATE</th><td>YYYY-MM-DD</td></tr>
    <tr><th>AUTHOR</th><td>○○ ○○ / 役職</td></tr>
    <tr><th>RECIPIENT</th><td>株式会社○○ 御中</td></tr>
  </table>
  <p class="cover-footer muted center">株式会社C4C · https://c4c.co.jp</p>
</div>
<div class="page-break"></div>
```

### ステップ 3: H2 セクションは ID 付き直書き

```markdown
<h2 id="sec-overview">1. 概要</h2>
```

`{#id}` 構文は使わない（markdown-it 非対応）。

### ステップ 4: 締めページ（4 パターンから 1 つ選択）

最終ページが「— END OF DOCUMENT —」だけだと余白が目立つ。 用途別に 4 パターンから選択する。

#### パターン①: C4C メインメッセージ + お礼（社外提案書のデフォルト）

```html
<div class="closing-page closing-message">
  <hr class="divider-brand">
  <p class="closing-thanks">ご覧いただき、ありがとうございました。</p>
  <p class="closing-credo brand">「カタチ」に残すだけじゃない、<br>「ココロ」に残る仕事を。</p>
  <p class="closing-org muted">株式会社C4C</p>
</div>
```

#### パターン②: CTA — 行動喚起（社外資料向け、社内資料では不要）

```html
<div class="closing-page closing-cta">
  <hr class="divider-brand">
  <h2 class="closing-cta-title">ご相談・お問い合わせ</h2>
  <p class="closing-cta-body">本ご提案にご興味をお持ちいただけましたら、お気軽にご連絡ください。</p>
  <p class="closing-cta-button center"><a href="https://portal.c4c.co.jp/contact">→ portal.c4c.co.jp/contact</a></p>
</div>
```

#### パターン③: 連絡先骨組み（Prompt または後編集で具体化）

担当者の氏名・連絡先は Prompt 側か後編集で埋める。 SKILL.md 内には実名を書かない。

```html
<div class="closing-page closing-contact">
  <hr class="divider-brand">
  <h2>連絡先</h2>
  <dl>
    <dt>担当</dt><dd>○○ ○○ / WEB エンジニア</dd>
    <dt>Email</dt><dd>name@c4c.co.jp</dd>
    <dt>Tel</dt><dd>080-XXXX-XXXX</dd>
    <dt>Web</dt><dd>https://portal.c4c.co.jp</dd>
  </dl>
</div>
```

#### パターン④: ビジュアル + 名言（ブランド資料・コーポレート向け）

```html
<div class="closing-page closing-visual">
  <hr class="divider-brand">
  <figure>
    <img src="assets/visual.png" alt="">
    <figcaption class="brand">名言 / メッセージ</figcaption>
  </figure>
</div>
```

### ステップ 5: 組織名・バージョン切替

#### 組織名（ヘッダ左）

| 指示 | 対応 |
|:---|:---|
| 何も言われない | `株式会社C4C` のまま（デフォルト） |
| 「個人名で」「○○ で」 | settings.json の `class='header-org'` を指定された名前に書き換える差分提示 |

#### バージョン（caption 行で動的指定）

**フッタ左は空のまま**。 バージョンは Markdown 本文の caption 行に書く — ドキュメントごとに動的に変えるためこの方式に統一。

```markdown
<div class="caption">Author: ○○ ○○　·　Version: v2.3 · FINAL　·　Date: 2026-05-22</div>
```

| 指示 | caption 行の書き方 |
|:---|:---|
| 何も言われない | `Version: v1.0 · DRAFT` |
| 「v2.3 で」 | `Version: v2.3` |
| 「FINAL で」 | `Version: v2.3 · FINAL` |
| 「社外秘で」 | `Version: v1.2 · 社外秘` |

⚠️ **settings.json のフッタは触らない** — `<span class='footer-version'>` は空のまま運用する。

### ステップ 6: SVG / HTML コメントの制約（重要）

markdown-it は `<svg>` の中身に改行や HTML コメント `<!-- ... -->` があると、SVG を壊してコードブロックとして出力する。

```html
<!-- NG（壊れる） -->
<svg>
  <!-- グリッド -->
  <line x1="0" y1="0" x2="100" y2="100"/>
</svg>

<!-- OK（1 行に詰める、コメントなし） -->
<svg><line x1="0" y1="0" x2="100" y2="100"/></svg>
```

ルール:
- `<svg>...</svg>` の中身は **必ず 1 行に詰める**
- SVG 内に `<!-- ... -->` コメントを書かない
- `<div>` 直下の `<svg>` は OK。 SVG 内部だけが NG
- 凡例 `<div class="lg-legend">` などの **SVG 外の要素は普通に改行 OK**

---

## 4. ドキュメント種別テンプレート（5 種）

ドキュメント種別ごとに、TOC 骨格 + 推奨表紙 + 推奨締め + 推奨コンポーネントが決まっている。 該当する種別が分かったら、まずこのテンプレートをベースにして肉付けする。

### 4.1 提案書（外部・営業）

```text
種別     : クライアント提案書
表紙     : 必須（cover-page）
締め     : パターン① C4C メッセージ + パターン② CTA を 2 ページ続けて配置
caption  : Version: v1.0 · DRAFT
推奨章   : 概要 → 背景 → ご提案 → 機能 → 導入効果 → スケジュール → 料金 → チーム → 連絡先
推奨部品 : Stats / KPI、Pull Quote、Comparison、Pricing、Person Card、Timeline、Bar Chart
```

TOC 例:

```html
<nav class="toc toc-no-page">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-overview">概要</a></li>
    <li><a href="#sec-background">背景</a></li>
    <li><a href="#sec-proposal">ご提案内容</a></li>
    <li><a href="#sec-features">提供価値</a></li>
    <li><a href="#sec-compare">導入前後の比較</a></li>
    <li><a href="#sec-plan">スケジュール</a></li>
    <li><a href="#sec-pricing">料金プラン</a></li>
    <li><a href="#sec-team">プロジェクトチーム</a></li>
  </ol>
</nav>
```

### 4.2 仕様書（内部・技術）

```text
種別     : 機能 / API 仕様書
表紙     : 任意（cover-page 簡略版 or 省略）
締め     : パターン③ 連絡先のみ
caption  : Version: v0.3 · DRAFT
推奨章   : 概要 → 用語定義 → 機能一覧 → API 仕様 → エラーコード → 制約事項 → 付録
推奨部品 : API Blueprint、Table（compact / with-v-lines）、Callout（warning / danger）、Code Block
```

### 4.3 設計書（内部・技術）

```text
種別     : システム設計書 / DB 設計書 / 画面設計書
表紙     : 簡略（タイトル + バージョン + 改訂履歴のみ）
締め     : パターン③ 連絡先のみ
caption  : Version: v1.2
推奨章   : 概要 → 全体構成 → コンポーネント設計 → データモデル → 非機能要件 → 改訂履歴
推奨部品 : Shape Box（data-title でアーキテクチャ図）、Table、Comparison、Code Block、Callout（info / warning）
```

### 4.4 工数見積書（外部・商談）

```text
種別     : 工数見積書
表紙     : 必須（RECIPIENT 行に客先社名）
締め     : パターン② CTA
caption  : Version: v1.0 · 仮見積
推奨章   : 表紙 → 前提条件 → スコープ → 見積内訳 → 想定スケジュール → 注意事項
推奨部品 : Table（compact、合計行は <strong>）、Stats / KPI、Callout（danger で「仮見積につき要件定義後再見積」）、Timeline
```

### 4.5 README（OSS / 社内パッケージ）

```text
種別     : OSS / 配布パッケージの README
表紙     : 不要（H1 + caption から開始）
締め     : パターン① または シンプルな divider のみ
caption  : Version: v3.5.0
推奨章   : What is X → Features → Install → Usage → Configuration → Components → License
推奨部品 : Feature List、Comparison（Before/After）、Code Block（ファイル名付き）、Pricing（プラン紹介系のみ）、Stats
```

---

## 5. コンポーネント完全例コード集

SKILL.md 単体で完結するため、全コンポーネントを表 + コード例 1 セットで掲載する。 Web 単体運用でも `references/components.md` を参照しなくて済む。

### 5.1 Callout — 5 種類（必要な時のみ使う）

**使用ルール:**
- 本当に強調が必要な箇所のみ。 装飾目的で使わない
- 普通の段落・太字で意図が伝わるなら不要
- 連続して 2 個以上並べない
- 判断軸: 「Callout を外しても文章として成立するか？」→ 成立するなら使わない

**5 種類:**

| 表示 : 用途 | クラス |
|:---|:---|
| NOTE : 通常の補足 | `callout-note` |
| TIP : 推奨・ベストプラクティス | `callout-tip` |
| INFO : 参考情報・出典 | `callout-info` |
| **注意** : 誤操作・期日の注意喚起 | `callout-warning` |
| **重要** : データ損失・契約上の禁止事項 | `callout-danger` |

```html
<div class="callout callout-note">
  <p><strong>NOTE。</strong> ステークホルダー全員の合意が前提です。</p>
</div>
<div class="callout callout-tip">
  <p><strong>TIP。</strong> 初回はサンプルデータで動作確認すると安全。</p>
</div>
<div class="callout callout-info">
  <p><strong>INFO。</strong> 出典: 業界レポート 2026 年度版。</p>
</div>
<div class="callout callout-warning">
  <p><strong>注意。</strong> 連休期間中はバッファ 2 週間を見込み。</p>
</div>
<div class="callout callout-danger">
  <p><strong>重要。</strong> 本見積もりは仮見積もり。 要件定義後に再見積もり。</p>
</div>
```

### 5.2 Shape Box — 5 種類

| 表示 : 用途 | クラス |
|:---|:---|
| 標準枠 : 軽い区画化 | `shape-box` |
| 塗り背景 : 補足コラム | `shape-filled` |
| 太枠 : サマリー / 結論 | `shape-outline` |
| ブランド色 : キーメッセージ | `shape-brand` |
| タイトル付き : 画像 + 説明セット ★お気に入りパターン | `shape-box data-title` |

```html
<div class="shape-box">標準枠</div>
<div class="shape-box shape-filled">塗り背景・補足コラム</div>
<div class="shape-box shape-outline">太枠・サマリー / 結論</div>
<div class="shape-box shape-brand">
  <p><strong>提案コンセプト。</strong> ○○を△△で実現することにより課題を一気に解消。</p>
</div>
<div class="shape-box" data-title="SYSTEM ARCHITECTURE">
  <p><img src="path/to/architecture.png" alt="アーキテクチャ図" style="max-width:100%;margin:0 auto 12px auto;"></p>
  <p><strong>3 層構成。</strong> フロントエンド (Next.js) / API (FastAPI) / DB (PostgreSQL) の構成です。</p>
</div>
```

### 5.3 Divider — 9 種類

| 表示 : 用途 | クラス |
|:---|:---|
| ヘアライン : 標準区切り | `<hr>` |
| 二重線 : 強めの区切り | `divider-double` |
| ドット 3 個 : 控えめ | `divider-dot` |
| ドット 5 個 : 控えめ（横長） | `divider-dot-5` |
| 横一面ドット線 : 点線フル幅 | `divider-dot-line` |
| 密ドット線 : 細かい点線 | `divider-dot-dense` |
| ブランドカラードット : アクセント | `divider-dot-brand` |
| モールス風 : 装飾的 | `divider-morse` |
| ブランド菱形 : 章末締めくくり | `divider-brand` |

```html
<hr>
<hr class="divider-double">
<hr class="divider-dot">
<hr class="divider-dot-5">
<hr class="divider-dot-line">
<hr class="divider-dot-dense">
<hr class="divider-dot-brand">
<hr class="divider-morse">
<hr class="divider-brand">
```

### 5.4 Table — 5 種類

| 表示 : 用途 | クラス |
|:---|:---|
| 標準 : 4 辺枠線 + ブランド色ヘッダ | （なし） |
| 縦罫あり : すべてのセル境界 | `with-v-lines` |
| コンパクト : 長文表 | `compact` |
| 和文 : 単語途中折返し回避 | `jp` |
| 横スクロール : 列数の多い表 | `<div class="table-wrap">` で囲む |

```html
<!-- 標準（GFM 構文 + アラインメント） -->
| 項目 | 内容 | 金額 |
|:---|:---|---:|
| 要件定義 | ヒアリング + 確定 | ¥1,000,000 |
| 設計 | API + DB + 画面 | ¥2,000,000 |

<!-- 縦罫あり -->
<table class="with-v-lines">
  <thead><tr><th>機能</th><th align="left">名称</th><th align="center">優先度</th><th align="right">工数</th></tr></thead>
  <tbody>
    <tr><td>認証</td><td>SSO 連携</td><td align="center">A</td><td align="right">5d</td></tr>
  </tbody>
</table>

<!-- コンパクト -->
<table class="compact">...</table>
```

### 5.5 Stats / KPI — 8 アクセント色

数値カードを 2〜4 列のグリッドで並べる。 `accent-*` で色を切り替え。

```html
<div class="stats-grid">
  <div class="stat-card accent-red">
    <span class="stat-label">作業時間削減</span>
    <span class="stat-value">40<span class="stat-unit">%</span><span class="stat-trend up">↗</span></span>
    <span class="stat-delta up">+12.4% from last month</span>
  </div>
  <div class="stat-card accent-green">
    <span class="stat-label">ROI</span>
    <span class="stat-value">312<span class="stat-unit">%</span><span class="stat-trend up">↗</span></span>
    <span class="stat-delta up">+8.6% from last quarter</span>
  </div>
  <div class="stat-card accent-brand">
    <span class="stat-label">アクティブ顧客</span>
    <span class="stat-value">847<span class="stat-unit">社</span><span class="stat-trend up">↗</span></span>
    <span class="stat-delta up">+9.1% this month</span>
  </div>
</div>
```

利用可能 accent : `accent-red` `accent-green` `accent-blue` `accent-brand` `accent-amber` `accent-orange` `accent-pink` `accent-gray`

### 5.6 Timeline — 3 状態（done / active / 未着手）

```html
<div class="timeline">
  <div class="step done">
    <span class="step-meta">DONE · M1</span>
    <span class="step-title">要件定義</span>
    <p class="step-body">業務ヒアリング 10 社 / 要件定義書確定</p>
  </div>
  <div class="step active">
    <span class="step-meta">NOW · M2-3</span>
    <span class="step-title">設計</span>
    <p class="step-body">API・DB・画面設計書を集約単位で並列作成</p>
  </div>
  <div class="step">
    <span class="step-meta">NEXT · M4-6</span>
    <span class="step-title">実装</span>
    <p class="step-body">フェーズごとに α 版リリース</p>
  </div>
</div>
```

### 5.7 Pull Quote — 2 種類（標準 / brand）

```html
<div class="pullquote brand">
  <p class="pq-body">導入後 3 ヶ月で受注プロセスの作業時間が 40% 削減。 営業がコア業務に集中できる環境が整いました。</p>
  <span class="pq-cite">お客様 A 様 · 営業本部長</span>
</div>

<div class="pullquote">
  <p class="pq-body">想定の倍速で機能拡張が進む。 本気で驚いています。</p>
  <span class="pq-cite">お客様 B 様 · CTO</span>
</div>
```

### 5.8 Comparison — Before / After 2 列カード

```html
<div class="compare">
  <div class="cmp before">
    <span class="cmp-label">BEFORE</span>
    <span class="cmp-title">手作業ベースの集計</span>
    <ul>
      <li>月次レポート作成に 3 日</li>
      <li>転記ミスが月平均 4 件</li>
      <li>担当者が休むと業務停止</li>
    </ul>
  </div>
  <div class="cmp after">
    <span class="cmp-label">AFTER</span>
    <span class="cmp-title">自動集計ダッシュボード</span>
    <ul>
      <li>レポートはリアルタイム生成</li>
      <li>転記ミス ゼロ</li>
      <li>誰でも閲覧・操作可能</li>
    </ul>
  </div>
</div>
```

### 5.9 Bar Chart — 横バー / 縦バー

```html
<!-- 横バー -->
<div class="bar-chart">
  <div class="bar-row">
    <span class="bar-label">作業時間削減</span>
    <div class="bar-track"><div class="bar-fill intensity-4" style="width:78%"></div></div>
    <span class="bar-value">78%</span>
  </div>
  <div class="bar-row">
    <span class="bar-label">エラー削減</span>
    <div class="bar-track"><div class="bar-fill intensity-4" style="width:95%"></div></div>
    <span class="bar-value">95%</span>
  </div>
</div>

<!-- 縦バー -->
<div class="bar-chart-v">
  <div class="col"><span class="col-value">312%</span><div class="col-bar intensity-4" style="height:90%"></div></div>
  <div class="col"><span class="col-value">258%</span><div class="col-bar intensity-3" style="height:78%"></div></div>
  <div class="col"><span class="col-value">184%</span><div class="col-bar intensity-3" style="height:60%"></div></div>
</div>
<div class="bar-chart-v-labels">
  <span class="x-label">営業</span>
  <span class="x-label">CS</span>
  <span class="x-label">経理</span>
</div>
```

intensity 値は `intensity-1` (薄) 〜 `intensity-4` (濃)。

### 5.10 Line Graph — SVG ベース（X / Y 軸）

SVG 内部は **必ず 1 行に詰める**。 凡例 `lg-legend` は普通に改行 OK。

```html
<div class="line-graph">
  <span class="lg-title">MONTHLY REVENUE · 2025-2026</span>
  <svg viewBox="0 0 400 160" preserveAspectRatio="xMidYMid meet"><line class="lg-grid" x1="40" y1="20" x2="390" y2="20"/><line class="lg-grid" x1="40" y1="55" x2="390" y2="55"/><line class="lg-axis" x1="40" y1="20" x2="40" y2="140"/><line class="lg-axis" x1="40" y1="140" x2="390" y2="140"/><polyline class="lg-line" points="55,118 90,108 125,92 160,84 195,70 230,58 265,52 300,40 335,38 370,28"/><polyline class="lg-line secondary" points="55,120 90,112 125,100 160,92 195,82 230,72 265,62 300,52 335,42 370,32"/></svg>
  <div class="lg-legend">
    <span class="lg-legend-item"><span class="lg-swatch"></span>実績</span>
    <span class="lg-legend-item"><span class="lg-swatch secondary"></span>計画</span>
  </div>
</div>
```

### 5.11 Feature List — アイコン + タイトル + 説明 3 列グリッド

**SVG アイコン必須・絵文字禁止**。 アイコンは Heroicons / Lucide / Tabler のいずれかから。

```html
<div class="features">
  <div class="feature">
    <span class="feature-icon">
      <svg viewBox="0 0 24 24" stroke="currentColor" fill="none" stroke-width="1.5"><path d="M3 12 L9 18 L21 6"/></svg>
    </span>
    <span class="feature-title">即時レポート</span>
    <p class="feature-body">月次レポートをリアルタイムに自動生成。</p>
  </div>
  <div class="feature brand">
    <span class="feature-icon">
      <svg viewBox="0 0 24 24" stroke="currentColor" fill="none" stroke-width="1.5"><circle cx="12" cy="12" r="9"/><path d="M12 7 V12 L15 14"/></svg>
    </span>
    <span class="feature-title">24/7 監視</span>
    <p class="feature-body">障害検知から復旧支援までを自動化。</p>
  </div>
  <div class="feature">
    <span class="feature-icon">
      <svg viewBox="0 0 24 24" stroke="currentColor" fill="none" stroke-width="1.5"><path d="M12 2 L20 8 V20 H4 V8 Z"/><path d="M9 13 H15 M9 17 H15"/></svg>
    </span>
    <span class="feature-title">SOC2 準拠</span>
    <p class="feature-body">エンタープライズ水準のセキュリティ。</p>
  </div>
</div>
```

### 5.12 Person Card — 人物プロフィール

```html
<div class="person-grid">
  <div class="person">
    <img class="person-avatar" src="" alt="">
    <span class="person-name">○○ ○○</span>
    <span class="person-role">Project Manager</span>
    <p class="person-body">大規模 SaaS の PM 経験 8 年。 要件定義からリリースまで一貫対応。</p>
    <span class="person-meta">JP · EN</span>
  </div>
  <div class="person">
    <img class="person-avatar" src="" alt="">
    <span class="person-name">○○ ○○</span>
    <span class="person-role">Lead Engineer</span>
    <p class="person-body">Next.js / FastAPI に精通。 フロントとバックエンドの両領域に対応。</p>
    <span class="person-meta">JP · EN</span>
  </div>
</div>
```

### 5.13 Pricing — 標準 / featured

```html
<div class="pricing">
  <div class="price-card">
    <span class="price-name">STARTER</span>
    <span class="price-amount">¥48,000<span class="price-unit">/月</span></span>
    <span class="price-tagline">スモールチーム向け。 導入は最短 1 週間。</span>
    <ul>
      <li>ユーザー 10 名まで</li>
      <li>標準サポート（営業時間内）</li>
      <li class="dim">SSO 連携</li>
    </ul>
  </div>
  <div class="price-card featured">
    <span class="price-name">BUSINESS</span>
    <span class="price-amount">¥148,000<span class="price-unit">/月</span></span>
    <span class="price-tagline">中規模組織の標準プラン。</span>
    <ul>
      <li>ユーザー 50 名まで</li>
      <li>24/7 サポート</li>
      <li>SSO・SCIM 連携</li>
    </ul>
  </div>
</div>
```

`featured` を付けると RECOMMENDED バッジが自動で出る。

### 5.14 API Blueprint — REST API 仕様書

method は GET / POST / PUT / PATCH / DELETE / HEAD / OPTIONS の 7 色対応。

```html
<div class="api-endpoint">
  <div class="api-head">
    <span class="api-method get">GET</span>
    <span class="api-path">/api/v1/users/<span class="param">:id</span></span>
    <span class="api-auth">Private</span>
  </div>
  <div class="api-body">
    <p class="api-desc">指定された ID のユーザー情報を取得します。</p>

    <div class="api-section">
      <span class="api-section-title">Path Parameters</span>
      <table class="api-params">
        <thead><tr><th>Name</th><th>Type</th><th>Required</th><th>Description</th></tr></thead>
        <tbody>
          <tr><td class="name">id</td><td class="type">string (UUID)</td><td class="req"><span class="required">Required</span></td><td class="desc">取得したいユーザーの UUID</td></tr>
        </tbody>
      </table>
    </div>

    <div class="api-section">
      <span class="api-section-title">Response Status</span>
      <div class="api-status-list">
        <span class="api-status success"><span class="api-status-code">200</span><span class="api-status-text">OK</span></span>
        <span class="api-status client-err"><span class="api-status-code">401</span><span class="api-status-text">Unauthorized</span></span>
        <span class="api-status client-err"><span class="api-status-code">404</span><span class="api-status-text">User not found</span></span>
      </div>
    </div>
  </div>
</div>
```

コンパクト一覧表示も可能:

```html
<div class="api-endpoint compact">
  <div class="api-head">
    <span class="api-method get">GET</span>
    <span class="api-path">/api/v1/users</span>
  </div>
</div>
```

### 5.15 インライン要素 — 6 種

| 表示 : 用途 | コード |
|:---|:---|
| 黄色マーカー : 通常強調 | `<mark>text</mark>` |
| ブランド色マーカー : 重要強調 | `<mark class="brand">text</mark>` |
| タグチップ : ラベル表示 | `<span class="tag">DRAFT</span>` |
| 補助テキスト : 注釈 | `<span class="muted">text</span>` |
| ブランド色強調 : 一語のみ | `<span class="brand">text</span>` |
| キーボードキー : ショートカット | `<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>` |

### 5.16 TOC（クリック遷移可能・ページ番号なし）

```html
<nav class="toc toc-no-page">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-overview">概要</a></li>
    <li><a href="#sec-features">機能一覧</a></li>
    <li><a href="#sec-pricing">料金プラン</a></li>
  </ol>
</nav>
```

⚠️ `<span class="page">N</span>` は **絶対に書かない**。 実 PDF のページ数とズレるため `toc-no-page` を必ず付ける。

### 5.17 コードブロック — ファイル名付き

````html
<pre data-filename="src/main.ts"><code class="language-typescript">
import { createApp } from 'vue';
import App from './App.vue';

createApp(App).mount('#app');
</code></pre>
````

通常のフェンス記法も One Dark Pro 配色でハイライトされる:

````markdown
```typescript
const greeting = "Hello, world!";
```
````

### 5.18 画像 — 3 パターン

```markdown
<!-- 標準: シンプル単独画像 -->
![alt](path/to/image.png)
```

```html
<!-- キャプション付き: figure -->
<figure>
  <img src="path/to/image.png" alt="">
  <figcaption>FIGURE 1. キャプション</figcaption>
</figure>

<!-- ★お気に入りパターン: shape-box data-title + 画像 + 説明 -->
<div class="shape-box" data-title="VISUAL ASSET">
  <p><img src="path/to/image.png" alt="" style="max-width:100%;margin:0 auto 12px auto;"></p>
  <p><strong>説明文。</strong> 何を示しているかを簡潔に。</p>
</div>
```

---

## 6. 必須チェックリスト（生成完了前に必ず確認）

- [ ] `<head><title>...</title></head>` が冒頭にある
- [ ] H1 はドキュメントタイトル 1 つだけ
- [ ] H2 セクションが `<h2 id="sec-xxx">` 形式
- [ ] TOC リンクの `href="#sec-xxx"` と H2 ID が一致
- [ ] TOC に **ページ番号 `<span class="page">` を書いていない**
- [ ] TOC の `<nav>` に `class="toc toc-no-page"` が付いている
- [ ] 外部資料・提案書・見積書では `cover-page` で表紙を作っている
- [ ] 最終ページに `closing-page` の 4 パターンから 1 つ配置している
- [ ] Callout を 2 つ以上使った場合、種類が違う
- [ ] Divider を 2 つ以上使った場合、種類が違う
- [ ] 重要な画像は `shape-box data-title` 形式
- [ ] テーブルにアラインメント指定 `|:---:|---:|` がある
- [ ] `==text==` 構文を使っていない（`<mark>` のみ使う）
- [ ] SVG の中身は 1 行に詰めている / SVG 内に HTML コメントがない
- [ ] 絵文字を使っていない（インライン SVG のみ）
- [ ] 日本語の場合、JP Fix 8 項目チェック実行済み（句読点ルール含む）

---

## 7. SKILL.md の編集ルール — version bump 義務

このスキル本体を編集したら、**同一ターン内で必ずバージョンを bump する**:

| 変更内容 | bump |
|:---|:---|
| typo 修正・コメント追加・微調整 | patch +1 (`3.5.0` → `3.5.1`) |
| コンポーネント追加・テンプレート追加・大きな機能追加 | minor +1 (`3.5.0` → `3.6.0`) |
| 互換性破壊・既存クラス名の改名 | major +1 (`3.5.0` → `4.0.0`) |

bump する箇所:
1. frontmatter の `version: "3.5.0"`
2. H1 直下 `# Markdown C4C — Design System Skill v3.5.0` の表記
3. `CHANGELOG.md` の先頭にエントリを追加

Claude が Edit ツールで SKILL.md を変更した直後に、同じターンで version も上げること。 user に確認を取らずに進めてよい（このルール自体が事前合意）。

---

## 8. アイコン方針

**絵文字（emoji）の使用は禁止。** アイコンを使う場合はインライン SVG のみ。

理由: 絵文字は OS / フォント / PDF レンダラーで表示が変わり、ブランド統一が崩れる。 SVG ならどの環境でも同じ見た目になる。

推奨ライブラリ（すべて MIT、商用利用可）:

- **Heroicons** (`heroicons.com`) — Tailwind 製、線細め・シンプル
- **Lucide** (`lucide.dev`) — Feather 由来、現代的
- **Tabler Icons** (`tabler-icons.io`) — 大量バリエーション

使い方: `stroke="currentColor" fill="none"` の SVG をそのまま `<span class="feature-icon">` の中に貼る。 色は親要素から継承される。

---

## 9. 同梱アセット

| 役割 | パス（相対パス） |
|:---|:---|
| CSS スタイル定義 | `assets/markdown-pdf.css` |
| C4C ロゴ | `assets/c4c-logo.png` |
| スタータードキュメント | `assets/template-document.md` |
| JP Fix セルフチェック | `assets/jp-fix-checklist.md` |
| VS Code 設定スニペット | `assets/setup-vscode-settings.json` |
| コンポーネント詳細ギャラリー | `references/components.md` |

Claude Code 配布版ではセットアップ手順を `README.md` 参照、Claude Web 配布版では `pdf-setup/` ディレクトリの README を参照する。

---

## 10. 配布手順

```powershell
# Windows (PowerShell)
pwsh ./scripts/build-zip.ps1
```

```bash
# macOS / Linux
./scripts/build-zip.sh
```

生成された `markdown-c4c-v<VERSION>.zip` を Claude Web の Skills に手動アップロード。 ZIP のルートフォルダは skill `name` と一致する `markdown-c4c/` で、エントリは forward slash `/` セパレータ。 Anthropic の skill validator はバックスラッシュ含みの ZIP を拒否するため、専用ビルドスクリプトを必ず使う。
