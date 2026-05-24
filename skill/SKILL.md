---
name: markdown-c4c
description: Markdown 生成・編集時に必ず使用するスキル。株式会社C4C ブランドの Swiss Modern Minimal v5.1 デザインシステムで、PDF 出力を前提に社内ドキュメント・クライアント提案書・設計ドキュメント・仕様書・報告書・議事録・README を高品質に生成する。Markdown / md ファイル作成、`.md` 編集、ドキュメント執筆、提案書作成、仕様書作成、報告書作成、議事録、README、技術文書、設計書、見積書、PDF 出力、表組み、テーブル作成、コールアウト、図形ボックス、TOC（目次）、ヘッダ・フッタのいずれかが要求された場合に必ず呼び出す。スラッシュコマンド `/markdown-c4c` でも明示的に呼び出せる。生成前は必ず AskUserQuestion で 5 項目以上の Q&A を行うワークフロー（セクション 3.0）に従い、種別ごとの追加質問・コンポーネント提案・構成バリエーション提示・生成後 AI 臭セルフチェックまでを 1 セットで実行する。
author: "株式会社C4C"
version: "5.1.1"
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
  - setup-guide
  - claude-web
---

# Markdown C4C — Design System Skill v5.1.1

株式会社C4C の標準 Markdown ドキュメント生成スキル。
**Markdown / md ファイルを生成・編集する前に、必ずこのスキルを参照すること。**

このスキルは Claude Code でも Claude Web でもそのまま使える。SKILL.md 単体で完結するように、コンポーネントの完全コード例を内蔵している。

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

### 3.0 生成前 Q&A 必須ワークフロー（v5.1 強化版）

Markdown 生成・編集を依頼されたとき、**いきなり書き始めてはいけない**。 5 つのフェーズを順番に踏み、ユーザーの目的にぴったり寄り添った構成を作る。

```
3.0.1 基本 5 項目  →  3.0.2 種別ごとの追加質問
        ↓
3.0.3 コンポーネント提案 → 3.0.4 構成バリエーション提示
        ↓
       生成
        ↓
3.0.5 生成後 AI 臭セルフチェック 7 項目
```

**例外（Q&A を省略してよいケース）:**
- ユーザーが既に詳細仕様（章立て・読者・主要メッセージ・含めたい部品）を明示的に提示している
- 100 字未満の短文資料（Slack 用一言レポートなど）
- 既存 `.md` への軽微な追記・誤字修正・パラグラフ単位の編集

例外であっても、生成後の **3.0.5 AI 臭セルフチェック** は省略しない。

#### 3.0.1 基本 5 項目（通常のドキュメント）

1. **ドキュメント種別** — 提案書 / 仕様書 / 設計書 / 議事録 / 見積書 / 報告書 / README / その他
2. **宛先・主要読者** — クライアント名 / 社内部署 / 一般公開 など
3. **主要メッセージ** — このドキュメントで一番伝えたい一文
4. **含めたいセクション・コンポーネント** — 数値カード / 料金カード / タイムライン / API 仕様書 / 比較カード など
5. **トーン・バージョン状態** — DRAFT / FINAL / 社外秘 / Internal

短文資料（議事録・slack 用報告など）の場合は 2-3 項目で OK:
- 種別と日付
- 主要トピック / 決定事項

#### 3.0.2 種別ごとの追加質問テンプレ（v5.1 新設）

基本 5 項目だけだと「同じ顔のドキュメント」が量産される。 種別ごとに **3-5 個の追加質問**を必ず投げる。

**提案書 (PROPOSAL)** — `AskUserQuestion` で確認:
- 料金プランは何種類提示しますか？（1 / 2 / 3 / 提示しない）
- 比較対象の現行システムや代替案はありますか？
- 想定する意思決定者は誰ですか？（経営層 / 部門長 / 現場）
- 期待される ROI や削減効果の数値はありますか？
- 契約形態は？（一括 / SaaS / SES / 段階契約）

**仕様書 (SPECIFICATION):**
- API / 機能 / データモデルのどの粒度ですか？
- エンドポイント数の想定は？
- 認証方式は？（OAuth / API Key / なし）
- エラー仕様の網羅レベルは？
- バージョニング方針は？

**設計書 (DESIGN):**
- 集約数 / コンテキスト数は？
- 図はテキストで表現 or 画像差し込み？
- 対象読者は？（実装者 / 運用者 / クライアント）
- レビュー観点は？（パフォーマンス / セキュリティ / 拡張性）

**工数見積書 (ESTIMATE):**
- 工数の単位は？（人月 / 人日 / 時間）
- 内訳の粒度は？（フェーズ / タスク / WBS）
- 仮定条件は明記しますか？
- リスクバッファの計上方針は？

**議事録 (MINUTES):**
- 参加者数（フル明記 or 主要のみ）は？
- 決定事項とアクションアイテムを分離しますか？
- 次回開催日の記載は？

**報告書 (REPORT):**
- 報告期間は？
- 数値根拠の出典は？
- 反省・次月計画の有無は？

**README (OVERVIEW):**
- 想定読者の技術レベルは？
- 導入手順は何 OS 対応？
- サンプルコードを含めますか？

#### 3.0.3 コンポーネント提案フェーズ（v5.1 新設）

Q&A 回答を受けたら、**即座に書き始めず**、内容に適したコンポーネント 3-5 種を提案して承認を取る。

提案テンプレ（チャットに直接書く）:

> ご回答ありがとうございます。 これなら以下のコンポーネントが効くと思います:
> - 数値カード（Stats / KPI）— 削減効果を視覚化
> - タイムライン（Timeline）— 段階移行を示す
> - 比較カード（Comparison · Before / After）— 投資効果を示す
>
> この 3 つを軸にしたいですが、いかがでしょうか？

承認を得てから 3.0.4 へ進む。 ユーザーが「他にもこれを入れてほしい」と言えば追加し、「これは要らない」と言えば外す。

#### 3.0.4 構成バリエーション提示（v5.1 新設）

同じ「提案書」でも 3 パターンの構成案を毎回提示し、ユーザーが選択 or 折衷案を作る。 詳細は `docs/markdown-c4c-reference.md` セクション 4 を参照。

提示テンプレ（チャットに直接書く）:

> 構成は 3 パターン考えられます:
>
> **A) 課題駆動型** — 現状の問題 → 提案 → 価値（経営層向け）
> **B) 効果駆動型** — ROI 先行 → 中身（決裁スピード重視）
> **C) ストーリー型** — 顧客の声 → 業界視点 → 提案（共感重視）
>
> どれが近いですか？ 折衷案でも構いません。

ユーザーが選んだら章立てを確定し、生成開始。

#### 3.0.5 生成後 AI 臭セルフチェック 7 項目（v5.1 新設）

生成完了した瞬間、**送信前に必ず**以下 7 項目をセルフチェックする。 1 つでも引っかかれば再生成。

- [ ] 1. 抽象動詞（推進する / 紐づける / 落とし込む / 進めていく / 描く / 引き出す）が 3 つ以上連続していないか
- [ ] 2. 同じ種類のコールアウト（例: tip）を 2 個以上連続させていないか
- [ ] 3. コンポーネント（数値カード / 比較カード / タイムライン）の直前または直後に意味づけ段落（200 字以上）があるか
- [ ] 4. 「貴社・当社」「いたします・ください・できます」など書き言葉統一されているか（「御社」「弊社」「致します」「下さい」「出来ます」が含まれていない）
- [ ] 5. 数値カード・比較カードのセクションに **根拠説明**（なぜその数値か / どう実現するか）があるか
- [ ] 6. cover-eyebrow が英大文字 1 ワードの規定値（PROPOSAL / SPECIFICATION / DESIGN / MINUTES / ESTIMATE / REPORT / OVERVIEW）になっているか
- [ ] 7. 強調ラベル直後が「：」（コロン）で、「。」（句点）になっていないか

#### 3.0.6 守るべき原則 & テンプレート廃止理由

- `docs/markdown-c4c-reference.md` は **参考スニペット集**。 テンプレートではない
- Q&A で得た情報を「コピペ用テンプレ」に流し込まず、毎回ゼロから構成する
- 同じ顔のドキュメントを量産しない（cover-meta の項目もユーザーに合わせて選ぶ）
- v4.0 までは「種別別テンプレート」があったが v5.0 で廃止。 種別はあくまで eyebrow / 推奨コンポーネントの**ヒント**に留め、章立てを固定化しない

v5.0.0 で従来の「種別別テンプレート（提案書 / 仕様書 / …）」を完全削除した。 テンプレートに頼ると、毎回同じ章立て・同じ cover-meta・同じ closing パターンが量産され、ドキュメント本来の文脈に合わない出力になる。 代わりに **Q&A ワークフロー 3.0.1〜3.0.5** で項目を毎回確定し、ユーザーの目的に合わせて構成する。 `markdown-c4c-reference.md` は「こういう部品がある / こう組み合わせる / こう組み合わせない」を見比べるためのショーケースであり、コピペ元ではない。

---

### ステップ 1: ドキュメント先頭テンプレート（v5.0 構造）

新規 Markdown は **cover-page → no-break ラッパ内に H1 + caption + TOC** という構造で開始する。 軽量な技術メモなど表紙不要のものは cover-page 部分を省略可。

```markdown
<head>
<title>ドキュメントタイトル</title>
</head>

<div class="cover-page">
  <div class="cover-body">
    <span class="cover-eyebrow">PROPOSAL</span>
    <h1 class="cover-title">ドキュメントタイトル</h1>
    <p class="cover-subtitle">サブタイトルや一行説明。
読みやすい位置で改行する。</p>
  </div>
  <table class="cover-meta">
    <tr><th>CLIENT</th><td>株式会社○○ 御中</td></tr>
    <tr><th>VERSION</th><td>v1.0</td></tr>
    <tr><th>DATE</th><td>YYYY-MM-DD</td></tr>
    <tr><th>AUTHOR</th><td>性 名 / 役職</td></tr>
  </table>
</div>

<!-- 注意: ここに <div class="page-break"></div> を書いてはいけない。
     .cover-page は CSS で page-break-after: always を持つため、
     手動 page-break を追加すると 2 重改ページになり余白ページが発生する。 -->

<div class="no-break">

# ドキュメントタイトル

<div class="caption">Author: ○○ ○○　·　Version: v1.0 · DRAFT　·　Date: YYYY-MM-DD</div>

<nav class="toc toc-no-page">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-1">セクション1</a></li>
    <li><a href="#sec-2">セクション2</a></li>
  </ol>
</nav>

</div>
```

### ステップ 1.5: eyebrow タグの値（ドキュメント種別ごとに固定）

`cover-eyebrow` の中身はドキュメント種別ごとに英大文字 1 ワードで固定する。 ブランド一貫性のため自由語句は避ける。

| 種別 | eyebrow |
|:---|:---|
| 提案書 | `PROPOSAL` |
| 仕様書（API / 機能） | `SPECIFICATION` |
| 設計書 | `DESIGN` |
| 議事録 | `MINUTES` |
| 工数見積書 | `ESTIMATE` |
| 報告書 | `REPORT` |
| README | `OVERVIEW` |

### ステップ 1.6: closing-contact のラベルは英字固定

連絡先カードの `contact-label` は **英字固定**。 日本語ラベルは禁止（dt 構造を捨てた理由でもある — 日本語に letter-spacing を効かせると「担　当」のように字間崩れする）。

許容ラベル: `MEMBER` `EMAIL` `WEB` `TEL` `ADDRESS` `COMPANY` `DEPARTMENT`

### ステップ 1.7: closing-page 内に `<hr>` 系を書かない

`closing-page` 内で `<hr class="divider-brand">` などの罫線を書いてはいけない。 CSS 側で防御的に非表示にしてはいるが、テンプレ側で書かないこと。

理由: v3.5 で「紫菱形だけが浮いた空きページ」が発生していたため。 締めページは余白とタイポグラフィだけで意味を持たせる。

### ステップ 1.8: ロゴ画像に `width` 属性を書かない

cover-page 上端のロゴ（`cover-mark`）と cover-footer は **v5.0.0 で廃止**された（CSS 側で `display: none` 防御）。 残るロゴ用途は `closing-watermark` の `watermark-logo` のみ。 こちらにも HTML inline `width="..."` 属性は書かない。

```html
<!-- NG: HTML inline 属性が CSS の !important を上書きしてロゴが巨大化する -->
<img class="watermark-logo" src="assets/c4c-logo.png" alt="" width="500">

<!-- OK: CSS の強制サイズに任せる -->
<img class="watermark-logo" src="assets/c4c-logo.png" alt="">
```

### ステップ 2: 表紙テンプレート（種別別バリエーション）

ステップ 1 の cover-page をベースに、種別ごとに `cover-eyebrow` と `cover-meta` の中身を変える。

```html
<!-- 提案書 -->
<div class="cover-page">
  <div class="cover-body">
    <span class="cover-eyebrow">PROPOSAL</span>
    <h1 class="cover-title">基幹基盤システム<br>AWS 移行プロジェクト</h1>
    <p class="cover-subtitle">運用コストと事業継続性を両立する、
止めないクラウド移行のご提案</p>
  </div>
  <table class="cover-meta">
    <tr><th>CLIENT</th><td>株式会社○○ 御中</td></tr>
    <tr><th>VERSION</th><td>v1.0</td></tr>
    <tr><th>DATE</th><td>2026-05-24</td></tr>
    <tr><th>AUTHOR</th><td>シヌアン サロード / SES事業部</td></tr>
  </table>
</div>
```

### ステップ 3: H2 セクションは ID 付き直書き

```markdown
<h2 id="sec-overview">1. 概要</h2>
```

`{#id}` 構文は使わない（markdown-it 非対応）。

### ステップ 4: 締めページ（4 パターンから選択）

最終ページが「— END OF DOCUMENT —」だけだと余白が目立つ。 用途別に 4 パターンから選択。 **closing-page 内に `<hr>` 系を書かない** ことに注意（ステップ 1.7 参照）。

#### パターン①: closing-message（社外提案書のデフォルト）

```html
<div class="closing-page closing-message">
  <p class="closing-thanks">最後までご覧いただき、誠にありがとうございました。</p>
  <p class="closing-credo">「カタチ」に残すだけじゃない、<br>「ココロ」に残る仕事を。</p>
  <p class="closing-org">株式会社C4C</p>
</div>
```

#### パターン①b: closing-watermark（★ ブランド資料の最終ページに 1 回まで）

大きな C4C ロゴを薄く中央配置し、上にクレドを重ねる「背景透かし型」締めページ。 提案書・コーポレート資料の最後の 1 ページに 1 回まで使う（多用するとブランド存在感が薄まる）。

```html
<div class="closing-page closing-watermark">
  <img class="watermark-logo" src="assets/c4c-logo.png" alt="">
  <p class="closing-thanks">最後までご覧いただき、誠にありがとうございました。</p>
  <p class="closing-credo">「カタチ」に残すだけじゃない、<br>「ココロ」に残る仕事を。</p>
  <p class="closing-org">株式会社C4C</p>
</div>
```

#### パターン②: closing-cta（行動喚起、社外資料向け）

```html
<div class="closing-page closing-cta">
  <h2 class="closing-cta-title">Contact<small>お問い合わせ</small></h2>
  <p class="closing-cta-body">本ご提案にご興味をお持ちいただけましたら、お気軽にご連絡ください。 貴社の現状に合わせて、移行方式やスケジュールを個別にご相談いたします。</p>
  <a class="closing-cta-button" href="https://portal.c4c.co.jp/contact">portal.c4c.co.jp/contact →</a>
  <p class="closing-cta-meta">Country for Country<small>人と組織に自由な選択肢を。自由が広がる社会を共に創る。</small></p>
</div>
```

ポイント:
- button は `<a>` 直書き（旧 `<p class="center"><a>` で位置不安定だったため変更）
- body の自社言及は **「貴社」**（「御社」は口頭表現で書き言葉では不可）

#### パターン③: closing-contact（社内・技術文書の締め）

担当者の氏名・連絡先は Prompt 側か後編集で埋める。 SKILL.md 内には実名を書かない。 **ラベルは英字固定**（ステップ 1.6 参照）。

```html
<div class="closing-page closing-contact">
  <h2>Contact<small>連絡先</small></h2>
  <hr class="contact-rule">
  <div class="contact-card">
    <div class="contact-row">
      <span class="contact-label"><svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4.4 3.6-8 8-8s8 3.6 8 8"/></svg></span>
      <span class="contact-value">○○ ○○ / 開発チーム<small>DEVELOPMENT TEAM</small></span>
    </div>
    <div class="contact-row">
      <span class="contact-label"><svg viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 7l9 6 9-6"/></svg></span>
      <span class="contact-value">name@c4c.co.jp</span>
    </div>
    <div class="contact-row">
      <span class="contact-label"><svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M3 12h18"/><path d="M12 3c2.5 2.7 4 6.1 4 9s-1.5 6.3-4 9c-2.5-2.7-4-6.1-4-9s1.5-6.3 4-9z"/></svg></span>
      <span class="contact-value">portal.c4c.co.jp</span>
    </div>
    <div class="contact-row">
      <span class="contact-label"><svg viewBox="0 0 24 24"><path d="M5 21V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v16"/><path d="M3 21h18"/><path d="M9 7h1M14 7h1M9 11h1M14 11h1M9 15h1M14 15h1"/><path d="M10 21v-4h4v4"/></svg></span>
      <span class="contact-value">株式会社C4C<small>C4C Inc.</small></span>
    </div>
  </div>
  <p class="contact-footer-tagline">Country for Country<small>人と組織に自由な選択肢を。自由が広がる社会を共に創る。</small></p>
</div>
```

#### パターン④: closing-visual（ブランド資料・コーポレート向け、legacy）

```html
<div class="closing-page closing-visual">
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

### ステップ 6: コンテンツ密度ルール（v4.0 新規）

> H2 セクション 1 つにつき、**最低 2 段落（合計 200 字以上）の説明文**を必ず書く。 Stats / Comparison / Timeline / Bar Chart などのコンポーネントを入れる場合も、**直前または直後に意味づけ段落 1 つ以上**を添える。 「コンポーネントが情報を語ってくれる」と思って文章を省略しない — PDF で見ると白い余白が増え、読み手は説明を求める。
>
> とくに数値カード（Stats）や比較カード（Comparison）を使うセクションは、**なぜその数値か / どう実現するか**の説明文を必ず加えること。

#### ドキュメント種別別の最低字数目安

| 種別 | H2 1 セクションあたりの最低字数 |
|:---|---:|
| 提案書 | **300 字以上** |
| 仕様書 / API 仕様書 | 200 字以上 |
| 設計書 | 200 字以上 |
| 工数見積書 | 200 字以上 |
| 議事録 / 短文資料 | 100 字以上 |
| README | 100 字以上 |

#### NG / OK 例

**NG（コンポーネントだけ並ぶ）:**

```markdown
<h2 id="sec-features">4. 提供価値</h2>

<div class="stats-grid">
  <div class="stat-card accent-brand">…</div>
  <div class="stat-card accent-green">…</div>
</div>
```

**OK（コンポーネント + 意味づけ段落）:**

```markdown
<h2 id="sec-features">4. 提供価値</h2>

本プロジェクトでは、運用コスト削減と事業継続性向上を同時に達成する。 既存システムの稼働を維持しながら、AWS の Well-Architected Framework に基づいた段階的な移行を行うことで、初期投資の負担を抑えつつ運用負荷を継続的に下げる構造を作る。

主な定量効果は以下の通り。

<div class="stats-grid">
  <div class="stat-card accent-brand">…</div>
  <div class="stat-card accent-green">…</div>
</div>

それぞれの数値は、AWS マネージドサービス化による運用工数削減（30%）、Auto Scaling による無駄リソース排除（25%）、Reserved Instance 活用（15%）の合計で根拠を持つ。
```

### ステップ 7: 文言ルール（書き言葉統一）

書き言葉での文書には以下を徹底する。

| NG | OK | 理由 |
|:---|:---|:---|
| 御社 | **貴社** | 「御社」は口頭表現。 書き言葉では「貴社」 |
| 弊社 | **当社** | 文書では「当社」が標準 |
| この度 | このたび | 漢字 30-40% の目安に合わせ平仮名化 |
| 〜致します | 〜いたします | 補助動詞は平仮名 |
| 〜下さい | 〜ください | 補助動詞は平仮名 |
| 〜出来ます | 〜できます | 補助動詞は平仮名 |

文末は「です・ます」調で統一。 「である」調と混ざらないこと。

#### 強調ラベルの直後はコロン「：」を使う（v5.0 追加）

shape-box / shape-brand / Callout / shape-box data-title などで `<strong>X</strong>` ラベルを書くとき、ラベル直後の区切りは **句点「。」ではなくコロン「：」を使う**。

```html
<!-- NG -->
<div class="callout callout-warning">
  <p><strong>注意。</strong> 連休期間中はバッファ 2 週間を見込み。</p>
</div>

<!-- OK -->
<div class="callout callout-warning">
  <p><strong>注意：</strong> 連休期間中はバッファ 2 週間を見込み。</p>
</div>
```

理由: 句点「。」はセンテンスの終端を示す記号なので、ラベル直後に置くと「ラベルが文として完結してしまった」印象を与え、その後に続く本文との結びつきが弱くなる。 コロン「：」は「この後に説明が続く」シグナルとして読みやすく、Swiss モダンな雰囲気にも合う。

適用対象:

- `<strong>NOTE：</strong>` / `<strong>TIP：</strong>` / `<strong>INFO：</strong>` / `<strong>注意：</strong>` / `<strong>重要：</strong>`
- `<strong>提案コンセプト：</strong>` などの shape-brand ラベル
- `<strong>3 層構成：</strong>` などの shape-box data-title 内ラベル

### ステップ 8: SVG / HTML コメントの制約（重要）

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

## 3.5 ロゴ画像配置案内（生成完了後の必須出力）— v5.1 新設

`closing-watermark` などで C4C ロゴ画像（`assets/c4c-logo.png`）を含む Markdown ファイルを生成完了したら、**ユーザーへの最終出力で必ず以下の案内テンプレを提示する**。 macOS / Windows 両対応・骨組み提示・修正必要箇所明示の 3 点セット。

### いつ出すか

- 生成した md ファイル内に `<img src="...c4c-logo.png">` または `class="watermark-logo"` を含むとき
- cover-page 画像を使う将来パターン拡張時も同様

### いつ出さなくてよいか

- ロゴ画像を使わない簡易メモ / Slack 用一言メモ
- 既存ファイルへの軽微編集（ロゴ画像参照が増減していない）

### 案内テンプレ（コピペで使う）

````markdown
### このドキュメントを PDF 化するために

このドキュメントは表紙または締めページに **C4C ロゴ画像**を含みます。 PDF 化前に以下を行ってください。

#### 1. Markdown ファイルの格納場所（骨組み — お好みで調整）

|  OS  | 推奨格納先（例） |
|:---|:---|
| Windows | `C:\Users\<ユーザー名>\Documents\c4c-docs\<案件名>\`<br>または `C:\c4c_works\<案件名>\docs\` |
| macOS | `~/Documents/c4c-docs/<案件名>/`<br>または `~/Projects/<案件名>/docs/` |

ファイル名例: `proposal-aws-migration-v1.0.md` のように `種別-内容-バージョン.md` 形式が読みやすい。

#### 2. C4C ロゴ画像の配置先

Markdown 内で `assets/c4c-logo.png` という相対パスを参照しています。 Markdown ファイルと同じ階層に `assets/` ディレクトリを作成し、ロゴをコピーしてください。

|  OS  | 配置先（骨組み） |
|:---|:---|
| Windows | `<md ファイル格納先>\assets\c4c-logo.png` |
| macOS | `<md ファイル格納先>/assets/c4c-logo.png` |

ロゴ画像本体（同梱）の場所:

- **Windows**: `%USERPROFILE%\.claude\skills\markdown-c4c\assets\c4c-logo.png`
- **macOS**: `~/.claude/skills/markdown-c4c/assets/c4c-logo.png`

コピー例（Windows PowerShell）:

```powershell
Copy-Item "$env:USERPROFILE\.claude\skills\markdown-c4c\assets\c4c-logo.png" "<格納先>\assets\c4c-logo.png"
```

コピー例（macOS bash）:

```bash
mkdir -p <格納先>/assets
cp ~/.claude/skills/markdown-c4c/assets/c4c-logo.png <格納先>/assets/
```

#### 3. 修正が必要な箇所

| 箇所 | 修正内容 |
|:---|:---|
| 表紙 / 締めページの `<img src="assets/c4c-logo.png">` | 相対パスが違う場合は実配置に合わせて変更 |
| `cover-meta` の CLIENT / VERSION / DATE / AUTHOR | 実際の値に置換 |
| 本文の `[...]` プレースホルダー | 実コンテンツに置換 |

#### 4. PDF 化

VS Code Markdown PDF 拡張（`yzane.markdown-pdf`）で `Cmd/Ctrl+Shift+P` → `Markdown PDF: Export (pdf)` を実行。
````

### 適用範囲

- このセクションは **常時搭載ルール**。 Claude はロゴ画像を含む md を生成完了したら、最終応答の「生成ファイル直後」に上記テンプレを必ず提示する
- 提示するときは骨組み（推奨先・コピー方法・修正箇所）であり、ユーザーが格納先を変更したい場合は自由に変えてよい旨を明示する

---

## 4. （廃止）ドキュメント種別テンプレート

v4 までは「提案書 / 仕様書 / 設計書 / 工数見積書 / README」の **5 種別テンプレート**を内蔵していたが、**v5.0.0 で完全削除**した。 理由は単純で、テンプレートを起点にすると毎回同じ章立て・同じ cover-meta・同じ closing パターンが量産され、ドキュメント本来の文脈に合わなくなるから。

代わりに **セクション 3.0 の Q&A ワークフロー**で項目を毎回確定し、ユーザーの目的に合わせて構成する。 種別はあくまで cover-eyebrow の値（PROPOSAL / SPECIFICATION / DESIGN / MINUTES / ESTIMATE / REPORT / OVERVIEW）と推奨コンポーネントの**ヒント**にとどめる。

`docs/markdown-c4c-reference.md` も「テンプレート」ではなく「**こういう部品がある**」を見比べるためのショーケースとして使うこと。 reference.md からのコピペで章立てを組み立てない。

---

## 5. コンポーネント完全例コード集

SKILL.md 単体で完結するため、全コンポーネントを表 + コード例 1 セットで掲載する。 Web 単体運用でも `references/components.md` を参照しなくて済む。

### 5.1 コールアウト（Callout）— 5 種類（必要な時のみ使う）

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
  <p><strong>NOTE：</strong> ステークホルダー全員の合意が前提です。</p>
</div>
<div class="callout callout-tip">
  <p><strong>TIP：</strong> 初回はサンプルデータで動作確認すると安全。</p>
</div>
<div class="callout callout-info">
  <p><strong>INFO：</strong> 出典は業界レポート 2026 年度版。</p>
</div>
<div class="callout callout-warning">
  <p><strong>注意：</strong> 連休期間中はバッファ 2 週間を見込み。</p>
</div>
<div class="callout callout-danger">
  <p><strong>重要：</strong> 本見積もりは仮見積もりです。 要件定義後に再見積もりします。</p>
</div>
```

### 5.2 図形ボックス（Shape Box）— 5 種類

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
  <p><strong>提案コンセプト：</strong> ○○を△△で実現することにより課題を一気に解消する。</p>
</div>
<div class="shape-box" data-title="SYSTEM ARCHITECTURE">
  <p><img src="path/to/architecture.png" alt="アーキテクチャ図" style="max-width:100%;margin:0 auto 12px auto;"></p>
  <p><strong>3 層構成：</strong> フロントエンド (Next.js) / API (FastAPI) / DB (PostgreSQL) の構成です。</p>
</div>
```

### 5.3 区切り線（Divider）— 9 種類

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

### 5.4 テーブル（Table）— 5 種類

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

### 5.5 数値カード（Stats / KPI）— 8 アクセント色

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

### 5.6 タイムライン（Timeline）— 3 状態（done / active / 未着手）

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

### 5.7 引用ブロック（Pull Quote）— 2 種類（標準 / brand）

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

### 5.8 比較カード（Comparison · Before / After）— 2 列カード

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

### 5.9 棒グラフ（Bar Chart）— 横バー / 縦バー

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

### 5.10 折れ線グラフ（Line Graph）— SVG ベース（X / Y 軸）

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

### 5.11 機能リスト（Feature List）— アイコン + タイトル + 説明 3 列グリッド

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

### 5.12 人物カード（Person Card）— 人物プロフィール

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

### 5.13 料金カード（Pricing）— 標準 / featured

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

### 5.14 API 仕様書（API Blueprint）— REST API ドキュメント

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

### 5.15 インライン要素（Inline Elements）— 6 種

| 表示 : 用途 | コード |
|:---|:---|
| 黄色マーカー : 通常強調 | `<mark>text</mark>` |
| ブランド色マーカー : 重要強調 | `<mark class="brand">text</mark>` |
| タグチップ : ラベル表示 | `<span class="tag">DRAFT</span>` |
| 補助テキスト : 注釈 | `<span class="muted">text</span>` |
| ブランド色強調 : 一語のみ | `<span class="brand">text</span>` |
| キーボードキー : ショートカット | `<kbd>Ctrl</kbd> + <kbd>Shift</kbd> + <kbd>P</kbd>` |

### 5.16 目次（TOC）— クリック遷移可能・ページ番号なし

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

### 5.17 コードブロック（Code Block）— ファイル名付き

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

### 5.18 画像（Image）— 3 パターン

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
  <p><strong>説明文：</strong> 何を示しているかを簡潔に書く。</p>
</div>
```

### 5.19 円形アイコンバッジ（Circular Icon Badge）— ★最お気に入りパターン

**ブランド色（マゼンタ）で塗りつぶした円 + 内側に白色 stroke の SVG アイコン**。 v5.0.4 で `closing-contact` から生まれた最も評価の高いコンポーネント。 連絡先・属性リスト・人物プロファイル・サービス特徴など、**「ラベル + 値」の縦リスト**を作りたい場面では迷わずこのパターンを使う。

#### いつ使うか

| 用途 | 例 |
|:---|:---|
| 連絡先カード | MEMBER / EMAIL / WEB / COMPANY / TEL / ADDRESS |
| サービス特徴リスト | 24/7 サポート / SOC2 準拠 / 即時レポート |
| 人物属性 | 役職 / 言語 / 所属 / 経験年数 |
| 価格プラン特典 | アクセス / サポート / 容量 / セキュリティ |
| プロジェクト情報 | 期間 / 規模 / 業界 / 技術 |

「テキストラベル」を円形バッジに置き換えるだけで、AI 量産感を消し、ブランドが立ち上がる。

#### 構造（連絡先以外でも使える汎用パターン）

`closing-contact` の `contact-card / contact-row / contact-label / contact-value` 構造をそのまま流用するのが最速。 締めページ以外で使う場合は、親に `closing-contact` クラスを持たせるのが現状のショートカット（将来 `icon-list` クラスとして独立予定）。

```html
<div class="closing-contact" style="padding: 0;">
  <div class="contact-card">
    <div class="contact-row">
      <span class="contact-label"><svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4.4 3.6-8 8-8s8 3.6 8 8"/></svg></span>
      <span class="contact-value">ラベル名<small>SUB CAPTION</small></span>
    </div>
  </div>
</div>
```

#### 標準アイコンセット（コピペで使える 8 種）

すべて `viewBox="0 0 24 24"` 統一。 SVG 内部は **1 行詰め・コメントなし**（markdown-it 制約）。 CSS が自動で `stroke: #FFFFFF / stroke-width: 1.8 / fill: none` を適用するので、SVG 内に色指定は書かない。

```html
<!-- USER (人物) -->
<svg viewBox="0 0 24 24"><circle cx="12" cy="8" r="4"/><path d="M4 21c0-4.4 3.6-8 8-8s8 3.6 8 8"/></svg>

<!-- EMAIL (封筒) -->
<svg viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="14" rx="2"/><path d="M3 7l9 6 9-6"/></svg>

<!-- GLOBE (地球 / Web) -->
<svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M3 12h18"/><path d="M12 3c2.5 2.7 4 6.1 4 9s-1.5 6.3-4 9c-2.5-2.7-4-6.1-4-9s1.5-6.3 4-9z"/></svg>

<!-- BUILDING (会社) -->
<svg viewBox="0 0 24 24"><path d="M5 21V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2v16"/><path d="M3 21h18"/><path d="M9 7h1M14 7h1M9 11h1M14 11h1M9 15h1M14 15h1"/><path d="M10 21v-4h4v4"/></svg>

<!-- PHONE (電話) -->
<svg viewBox="0 0 24 24"><path d="M5 4h4l2 5-3 2c1 2 3 4 5 5l2-3 5 2v4c0 1-1 2-2 2C9 21 3 15 3 6c0-1 1-2 2-2z"/></svg>

<!-- LOCATION (住所) -->
<svg viewBox="0 0 24 24"><path d="M12 22s-7-7-7-13a7 7 0 0 1 14 0c0 6-7 13-7 13z"/><circle cx="12" cy="9" r="2.5"/></svg>

<!-- CALENDAR (期間) -->
<svg viewBox="0 0 24 24"><rect x="3" y="5" width="18" height="16" rx="2"/><path d="M3 9h18M8 3v4M16 3v4"/></svg>

<!-- SHIELD (セキュリティ) -->
<svg viewBox="0 0 24 24"><path d="M12 3l8 3v6c0 5-3.5 8.5-8 9-4.5-0.5-8-4-8-9V6l8-3z"/><path d="M9 12l2 2 4-4"/></svg>
```

#### 必ず守る原則

- アイコンは Heroicons / Lucide / Tabler のいずれかから（独自描画しない）
- **絵文字（🧑✉🌐🏢 など）禁止** — フォント依存で出力環境ごとに変わるため
- **stroke 系統一** — 線画スタイルのみ。 fill 塗りつぶし系（filled icon）と混ぜない
- 円形バッジは **ブランド色マゼンタ `#8A248C`** で塗りつぶす（他色版を作らない）
- 直径は 11mm、アイコンは 5.5mm（CSS が自動適用）
- 同じドキュメント内で **1 種類の意味階層**に統一（連絡先で使ったら、別の意味で再利用しない）

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
- [ ] cover-page の直後に `<div class="page-break"></div>` を書いていない
- [ ] H1 + caption + TOC を `<div class="no-break">` で囲んでいる
- [ ] cover-page・closing-page 内に `<hr>` 系を書いていない
- [ ] cover-page 内に `cover-mark` / `cover-footer` を書いていない（v5.0 で廃止）
- [ ] `watermark-logo` `<img>` に `width="..."` 属性を書いていない
- [ ] cover-page の `cover-eyebrow` がドキュメント種別ごとの英大文字値（PROPOSAL / SPECIFICATION / DESIGN / MINUTES / ESTIMATE / REPORT / OVERVIEW）
- [ ] 生成前に セクション 3.0 の Q&A ワークフロー（最低 5 項目）を実行している
- [ ] 強調ラベル直後の区切りに「。」ではなく「：」を使っている
- [ ] closing-contact の `contact-label` が英字（MEMBER / EMAIL / WEB / TEL / ADDRESS / COMPANY / DEPARTMENT）
- [ ] H2 セクションごとに最低字数（提案書 300 字 / 仕様書 200 字 / 議事録 100 字）を満たしている
- [ ] コンポーネント（Stats / Comparison / Timeline）に意味づけ段落が添えられている
- [ ] 「御社」→「貴社」、「弊社」→「当社」など書き言葉に統一されている
- [ ] Callout を 2 つ以上使った場合、種類が違う
- [ ] Divider を 2 つ以上使った場合、種類が違う
- [ ] 重要な画像は `shape-box data-title` 形式
- [ ] 連絡先・属性リスト・特徴リストには **円形 SVG アイコンバッジ**（5.19）を積極使用している
- [ ] テーブルにアラインメント指定 `|:---:|---:|` がある
- [ ] `==text==` 構文を使っていない（`<mark>` のみ使う）
- [ ] SVG の中身は 1 行に詰めている / SVG 内に HTML コメントがない
- [ ] 絵文字を使っていない（インライン SVG のみ）
- [ ] 日本語の場合、JP Fix 8 項目チェック実行済み（句読点ルール含む）
- [ ] 生成後の **AI 臭セルフチェック 7 項目**（セクション 3.0.5）を完了している
- [ ] 構成は **コンポーネント提案 → 承認**（3.0.3）と **構成バリエーション提示 → 選択**（3.0.4）を経て決めている
- [ ] ロゴ画像を含む md を生成完了したら、 セクション 3.5 の **ロゴ配置案内テンプレ**を最終応答に提示している

---

## 7. SKILL.md の編集ルール — version bump 義務

このスキル本体を編集したら、**同一ターン内で必ずバージョンを bump する**:

| 変更内容 | bump |
|:---|:---|
| typo 修正・コメント追加・微調整 | patch +1 (`5.0.0` → `5.0.1`) |
| コンポーネント追加・テンプレート追加・大きな機能追加 | minor +1 (`5.0.0` → `5.1.0`) |
| 互換性破壊・既存クラス名の改名 | major +1 (`5.0.0` → `6.0.0`) |

bump する箇所:
1. frontmatter の `version: "5.0.0"`
2. H1 直下 `# Markdown C4C — Design System Skill v5.0.0` の表記
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
| Markdown 生成ガイド（参考） | `assets/markdown-generation.md` |
| リファレンス PDF（判断ガイド集） | `assets/markdown-c4c-reference.pdf` |
| 表紙・締めページ プレビュー PDF | `assets/markdown-c4c-cover-closing-preview.pdf` |
| リファレンス Markdown 正本 | `references/markdown-c4c-reference.md` |
| 表紙・締めページ プレビュー Markdown | `references/markdown-c4c-cover-closing-preview.md` |

Claude Code 配布版ではセットアップ手順を `README.md` 参照、Claude Web 配布版では `pdf-setup/` ディレクトリの README を参照する。

`references/*.md` は `docs/` ディレクトリの正本からミラーされる。 PDF は `docs/*.md` を VS Code Markdown PDF 拡張で書き出し、 `assets/` に配置する（ユーザー手動）。

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
