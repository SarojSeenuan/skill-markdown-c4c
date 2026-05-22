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
<nav class="toc toc-no-page">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-1">セクション1</a></li>
    <li><a href="#sec-2">セクション2</a></li>
    <li><a href="#sec-3">セクション3</a></li>
  </ol>
</nav>

<!-- ⚠️ TOC にページ番号 (<span class="page">) を書くと実 PDF とズレるため記載禁止。
     toc-no-page クラスで dots / page を CSS で非表示にする。 -->
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

### 使用ルール（必須）

Callout は **本当に強調が必要な箇所だけ** に使う。

| やってよい | やらない |
|:---|:---|
| 読み手の判断・行動を左右する重要情報 | 普通の補足を Callout でラップ |
| 誤操作の警告、データ損失の注意 | 装飾目的の使用 |
| 推奨アクションの明示 | 連続して 2 個以上並べる |
| 読み飛ばしてはいけない前提条件 | 全セクションに 1 個ずつ機械的配置 |

判断軸: 「Callout を外しても文章として成立するか？」成立するなら **Callout 不要**。普通の段落 or `<strong>` で十分。

### 5 種類とラベル

| クラス | 表示ラベル | 用途 |
|:---|:---|:---|
| `callout-note` | NOTE | 通常の補足情報 |
| `callout-tip` | TIP | 推奨・ベストプラクティス |
| `callout-info` | INFO | 参考情報・出典 |
| `callout-warning` | **注意** | 注意喚起（誤操作・期日） |
| `callout-danger` | **重要** | データ損失・契約上の禁止事項 |

`warning` `danger` のラベルだけ日本語化されている（日本資料での違和感を避けるため）。クラス名は英語のまま。

### コード

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
  <p><strong>重要。</strong>データ損失・不可逆な変更。</p>
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

## 11. Stats / KPI カード（v3.2 — Modern Dashboard Card）

数値強調の見せ場（売上・成長率・実績など）に使う。 左側の縦カラーバー + 右上 chevron が特徴。 ダッシュボード風のモダンなカード。

```html
<div class="stats-grid">
  <div class="stat-card accent-red">
    <span class="stat-label">Total Sales</span>
    <span class="stat-value">¥245,980<span class="stat-trend up">↗</span></span>
    <span class="stat-delta up">+12.4% from last month</span>
  </div>
  <div class="stat-card accent-green">
    <span class="stat-label">Total Revenue</span>
    <span class="stat-value">¥1,280,450<span class="stat-trend up">↗</span></span>
    <span class="stat-delta up">+8.6% from last quarter</span>
  </div>
  <div class="stat-card accent-blue">
    <span class="stat-label">New Users</span>
    <span class="stat-value">3,465<span class="stat-trend up">↗</span></span>
    <span class="stat-delta up">+18.3% from last week</span>
  </div>
  <div class="stat-card accent-brand">
    <span class="stat-label">Conversion Rate</span>
    <span class="stat-value">6.8<span class="stat-unit">%</span><span class="stat-trend up">↗</span></span>
    <span class="stat-delta up">+0.7% from last week</span>
  </div>
</div>
```

### 縦バーのアクセント色（8 種類）

| クラス | 色 | 用途例 |
|:---|:---|:---|
| `accent-red` | 赤 #E53935 | 売上・トップライン |
| `accent-green` | 緑 #2E7D32 | 収益・成長 |
| `accent-blue` | 青 #0050B3 | ユーザー・規模 |
| `accent-brand` | ブランド色 #8A248C | コアKPI・主要指標 |
| `accent-amber` | 黄 #F59E0B | 完了率・進捗 |
| `accent-orange` | 橙 #EA580C | コスト・予算 |
| `accent-pink` | ピンク #EC4899 | エンゲージメント |
| `accent-gray` | グレー | 二次指標・参考値 |

### トレンドアイコン（数値の右に小さく表示）

```html
<span class="stat-trend up">↗</span>    <!-- 上向き・緑 -->
<span class="stat-trend down">↘</span>  <!-- 下向き・赤 -->
<span class="stat-trend flat">→</span>  <!-- 横這い・グレー -->
```

### バリエーション

| クラス | 用途 |
|:---|:---|
| `stat-card` | 標準（白背景・縦バー・chevron） |
| `stat-card.brand` | ブランド色背景（特に強調したい時） |
| `stat-card.minimal` | 罫線のみ・縦バーなし・最小限 |

## 12. Timeline / Process Step（横ステップ）

プロセス・スケジュール・フェーズ表現に。番号は CSS counter で自動採番。

```html
<div class="timeline">
  <div class="step done">
    <span class="step-meta">DONE · M1</span>
    <span class="step-title">要件定義</span>
    <p class="step-body">業務ヒアリング 10 社・要件定義書確定</p>
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
  <div class="step">
    <span class="step-meta">M7-8</span>
    <span class="step-title">テスト・リリース</span>
    <p class="step-body">UAT 完了後にカットオーバー</p>
  </div>
</div>
```

ステータス: `done` （完了・グレー） / `active` （進行中・ブランド色） / なし （未着手）

## 13. Pull Quote / 顧客の声

導入事例の声、印象的な引用に使う。装飾的な引用符が左上に大きく配置される。

```html
<div class="pullquote">
  <p class="pq-body">導入後 3 ヶ月で受注プロセスの作業時間が 40% 削減。営業がコア業務に集中できる環境が整いました。</p>
  <span class="pq-cite">田中 様 · 営業本部長 · 株式会社サンプル</span>
</div>

<div class="pullquote brand">
  <p class="pq-body">想定の倍速で機能拡張が進む。社内チームでも追従できないスピードで、本気で驚いています。</p>
  <span class="pq-cite">山田 様 · CTO · Acme Corp.</span>
</div>
```

バリエーション: 標準 （罫線なし・引用符のみ） / `brand` （左罫線 + ブランド色背景）

## 14. Comparison Card（Before / After）

「導入前 vs 導入後」「プラン A vs B」など 2 列比較。

```html
<div class="compare">
  <div class="cmp before">
    <span class="cmp-label">BEFORE</span>
    <span class="cmp-title">手作業ベースの集計</span>
    <ul>
      <li>月次レポート作成に 3 日</li>
      <li>転記ミスが月平均 4 件</li>
      <li>集計担当が属人化</li>
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

After 側は自動でブランド色のラベル + 強調枠線。

## 15. Bar Chart 横（水平バーチャート）

埋め込みの横棒グラフ。 色はブランド紫で統一、**値の大小は透明度で表現**（intensity-1 〜 4）。

```html
<div class="bar-chart">
  <div class="bar-row">
    <span class="bar-label">作業時間削減</span>
    <div class="bar-track"><div class="bar-fill intensity-4" style="width:78%"></div></div>
    <span class="bar-value">78%</span>
  </div>
  <div class="bar-row">
    <span class="bar-label">情報共有スピード</span>
    <div class="bar-track"><div class="bar-fill intensity-2" style="width:62%"></div></div>
    <span class="bar-value">62%</span>
  </div>
  <div class="bar-row">
    <span class="bar-label">コスト削減</span>
    <div class="bar-track"><div class="bar-fill intensity-1" style="width:34%"></div></div>
    <span class="bar-value">34%</span>
  </div>
</div>
```

| クラス | 透明度 | 用途 |
|:---|:---:|:---|
| `intensity-4` | 100% | 主要指標・最大値 |
| `intensity-3` | 75% | 上位 |
| `intensity-2` | 55% | 中位 |
| `intensity-1` | 35% | 下位・参考値 |

## 16. Bar Chart 縦（カラムチャート）

複数項目を縦に並べて比較したい時に使う。 `style="height:N%"` で高さ指定。

```html
<div class="bar-chart-v">
  <div class="col"><span class="col-value">312%</span><div class="col-bar intensity-4" style="height:90%"></div></div>
  <div class="col"><span class="col-value">258%</span><div class="col-bar intensity-3" style="height:78%"></div></div>
  <div class="col"><span class="col-value">184%</span><div class="col-bar intensity-3" style="height:60%"></div></div>
  <div class="col"><span class="col-value">142%</span><div class="col-bar intensity-2" style="height:48%"></div></div>
  <div class="col"><span class="col-value">96%</span><div class="col-bar intensity-2" style="height:32%"></div></div>
  <div class="col"><span class="col-value">52%</span><div class="col-bar intensity-1" style="height:18%"></div></div>
</div>
<div class="bar-chart-v-labels">
  <span class="x-label">営業</span>
  <span class="x-label">CS</span>
  <span class="x-label">経理</span>
  <span class="x-label">人事</span>
  <span class="x-label">情シス</span>
  <span class="x-label">広報</span>
</div>
```

## 17. Line Graph（X / Y ライングラフ）

時系列の推移や折れ線グラフに使う。 SVG ベース、`polyline` の `points` を編集して値を変える。

⚠️ **重要な制約: `<svg>` の中身は 1 行に詰めて書くこと**
markdown-it は SVG 内の改行や HTML コメント `<!-- ... -->` を見ると、SVG が壊れてコードブロックとして出力されてしまう。 改行・コメントを入れずに `<svg>...</svg>` を 1 行にまとめる。

```html
<div class="line-graph">
<span class="lg-title">MONTHLY REVENUE · 2025-2026</span>
<svg viewBox="0 0 400 160" preserveAspectRatio="xMidYMid meet"><line class="lg-grid" x1="40" y1="20" x2="390" y2="20"/><line class="lg-grid" x1="40" y1="55" x2="390" y2="55"/><line class="lg-grid" x1="40" y1="90" x2="390" y2="90"/><line class="lg-grid" x1="40" y1="125" x2="390" y2="125"/><text class="lg-axis-label" x="35" y="23" text-anchor="end">¥100M</text><text class="lg-axis-label" x="35" y="58" text-anchor="end">¥75M</text><text class="lg-axis-label" x="35" y="93" text-anchor="end">¥50M</text><text class="lg-axis-label" x="35" y="128" text-anchor="end">¥25M</text><line class="lg-axis" x1="40" y1="20" x2="40" y2="140"/><line class="lg-axis" x1="40" y1="140" x2="390" y2="140"/><polyline class="lg-line" points="55,118 90,108 125,92 160,84 195,70 230,58 265,52 300,40 335,38 370,28"/><polyline class="lg-line secondary" points="55,120 90,112 125,100 160,92 195,82 230,72 265,62 300,52 335,42 370,32"/><circle class="lg-dot" cx="55" cy="118" r="2.2"/><circle class="lg-dot" cx="370" cy="28" r="2.2"/><text class="lg-axis-label" x="55" y="152" text-anchor="middle">7月</text><text class="lg-axis-label" x="370" y="152" text-anchor="middle">4月</text></svg>
<div class="lg-legend">
<span class="lg-legend-item"><span class="lg-swatch"></span>実績</span>
<span class="lg-legend-item"><span class="lg-swatch secondary"></span>計画</span>
</div>
</div>
```

**SVG 構造の説明（コードに書かないでください、ここを読んで構造を理解する用）:**
- `<line class="lg-grid">` × 4 — 横グリッド線（y=20, 55, 90, 125）
- `<text class="lg-axis-label">` Y 軸 — 数値ラベル（¥100M, ¥75M, ...）
- `<line class="lg-axis">` × 2 — X / Y 軸の線
- `<polyline class="lg-line">` — メインライン（実線・紫）
- `<polyline class="lg-line secondary">` — サブライン（破線・グレー）
- `<circle class="lg-dot">` — データポイント
- `<text class="lg-axis-label">` X 軸 — 月ラベル

| クラス | 用途 |
|:---|:---|
| `lg-line` | メインライン（ブランド紫・実線） |
| `lg-line.secondary` | サブライン（グレー・破線） |
| `lg-dot` | データポイントの円 |
| `lg-grid` | 横グリッド線 |
| `lg-axis` | X / Y 軸 |
| `lg-axis-label` | 軸ラベル数値 |
| `lg-legend` + `lg-swatch` | 凡例 |

| クラス | 用途 |
|:---|:---|
| `lg-line` | メインライン（ブランド紫・実線） |
| `lg-line.secondary` | サブライン（グレー・破線） |
| `lg-dot` | データポイントの円 |
| `lg-grid` | 横グリッド線 |
| `lg-axis` | X / Y 軸 |
| `lg-axis-label` | 軸ラベル数値 |
| `lg-legend` + `lg-swatch` | 凡例 |

## 17. Feature List（3 列アイコングリッド）

機能一覧・提供価値・サービス紹介に使う。アイコンは **インライン SVG** のみ（絵文字禁止）。

```html
<div class="features">
  <div class="feature">
    <span class="feature-icon">
      <svg viewBox="0 0 24 24"><path d="M12 2 L20 8 V20 H4 V8 Z"/><path d="M9 13 H15 M9 17 H15"/></svg>
    </span>
    <span class="feature-title">即時レポート</span>
    <p class="feature-body">月次レポートをリアルタイムに自動生成。手作業ゼロ。</p>
  </div>
  <div class="feature brand">
    <span class="feature-icon">
      <svg viewBox="0 0 24 24"><circle cx="12" cy="12" r="9"/><path d="M12 7 V12 L15 14"/></svg>
    </span>
    <span class="feature-title">24/7 監視</span>
    <p class="feature-body">障害検知から復旧支援までを自動化。</p>
  </div>
  <div class="feature">
    <span class="feature-icon">
      <svg viewBox="0 0 24 24"><path d="M3 12 L9 18 L21 6"/></svg>
    </span>
    <span class="feature-title">SOC2 準拠</span>
    <p class="feature-body">エンタープライズ水準のセキュリティ。</p>
  </div>
</div>
```

バリエーション: 標準（線アイコン）/ `feature.brand`（ブランド色塗り）

**SVG アイコン推奨ライブラリ** (アウトラインスタイル):
- Heroicons (`heroicons.com`) — シンプル・線細め
- Lucide (`lucide.dev`) — Feather 由来・現代的
- Tabler Icons (`tabler-icons.io`) — 大量バリエーション

すべて MIT で商用利用可。`stroke="currentColor" fill="none"` の SVG を貼ればそのまま使える。

## 18. Person Card（人物プロフィール）

チーム紹介・講師紹介・推薦者一覧に使う。

```html
<div class="person-grid">
  <div class="person">
    <img class="person-avatar" src="path/to/avatar.jpg" alt="Saroj Seenuan">
    <span class="person-name">Saroj Seenuan</span>
    <span class="person-role">Founder · CEO</span>
    <p class="person-body">Node.js / Python / Cloud アーキテクト。10 年の開発リード経験。</p>
    <span class="person-meta">JP · EN · TH</span>
  </div>
  <div class="person">
    <img class="person-avatar" src="path/to/avatar2.jpg" alt="...">
    <span class="person-name">下重 香奈子</span>
    <span class="person-role">人事部 · 採用責任者</span>
    <p class="person-body">スタートアップ採用・組織開発のスペシャリスト。</p>
  </div>
</div>
```

avatar は画像が無くてもグレー円が表示される。`person-meta` は任意（言語スキル・所在地など）。

## 19. Pricing Table（料金プラン）

提案書・サービス紹介の料金提示に。

```html
<div class="pricing">
  <div class="price-card">
    <span class="price-name">STARTER</span>
    <span class="price-amount">¥48,000<span class="price-unit">/月</span></span>
    <span class="price-tagline">スモールチーム向け。導入は最短 1 週間。</span>
    <ul>
      <li>ユーザー 10 名まで</li>
      <li>標準サポート（営業時間内）</li>
      <li>月次レポート</li>
      <li class="dim">SSO 連携</li>
      <li class="dim">専任 CSM</li>
    </ul>
  </div>
  <div class="price-card featured">
    <span class="price-name">BUSINESS</span>
    <span class="price-amount">¥148,000<span class="price-unit">/月</span></span>
    <span class="price-tagline">中規模組織の標準プラン。ROI 最大化。</span>
    <ul>
      <li>ユーザー 50 名まで</li>
      <li>24/7 サポート</li>
      <li>カスタムダッシュボード</li>
      <li>SSO・SCIM 連携</li>
      <li class="dim">専任 CSM</li>
    </ul>
  </div>
  <div class="price-card">
    <span class="price-name">ENTERPRISE</span>
    <span class="price-amount">要相談</span>
    <span class="price-tagline">大規模・カスタム要件。専任 CSM 付帯。</span>
    <ul>
      <li>ユーザー無制限</li>
      <li>SLA 99.95%</li>
      <li>カスタム機能開発</li>
      <li>SSO・SCIM・監査ログ</li>
      <li>専任 CSM</li>
    </ul>
  </div>
</div>
```

バリエーション: 標準 / `featured`（ブランド色枠 + `RECOMMENDED` バッジ）。
`<li class="dim">` で「このプランには含まれない」項目を打ち消し線表示。

## 20. API Blueprint（REST API ドキュメント）

REST API の設計書・仕様書・公開ドキュメントに使う。 HTTP メソッドの色分けバッジ、エンドポイントパス、パラメータ表、ステータスコード一覧、リクエスト / レスポンス例を一体化したコンポーネント。

### 20.1 標準形（メソッド + パス + 説明 + パラメータ + レスポンス）

```html
<div class="api-endpoint">
<div class="api-head">
<span class="api-method get">GET</span>
<span class="api-path">/api/v1/users/<span class="param">:id</span></span>
<span class="api-auth">Private</span>
</div>
<div class="api-body">
<p class="api-desc">指定された ID のユーザー情報を取得します。 認証済みユーザーのみアクセス可能。</p>

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
<span class="api-status success"><span class="api-status-code">200</span><span class="api-status-text">OK — ユーザー取得成功</span></span>
<span class="api-status client-err"><span class="api-status-code">401</span><span class="api-status-text">Unauthorized</span></span>
<span class="api-status client-err"><span class="api-status-code">404</span><span class="api-status-text">User not found</span></span>
<span class="api-status server-err"><span class="api-status-code">500</span><span class="api-status-text">Internal Server Error</span></span>
</div>
</div>

<div class="api-section">
<span class="api-section-title">Response Example</span>
<div class="api-example">
<span class="api-example-label">200 OK<span class="api-example-tag">application/json</span></span>

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "name": "Saroj Seenuan",
  "email": "ken@c4c.co.jp",
  "role": "admin",
  "created_at": "2026-01-15T09:30:00Z"
}
```

</div>
</div>
</div>
</div>
```

### 20.2 HTTP メソッドの色マッピング

| メソッド | クラス | 色 | 用途 |
|:---|:---|:---|:---|
| GET | `api-method get` | 緑 #2E7D32 | データ取得・参照 |
| POST | `api-method post` | 青 #0050B3 | 新規作成 |
| PUT | `api-method put` | 橙 #C77700 | 全体更新（冪等） |
| PATCH | `api-method patch` | ブランド紫 #8A248C | 部分更新 |
| DELETE | `api-method delete` | 赤 #B00020 | 削除 |
| HEAD | `api-method head` | グレー | ヘッダ情報のみ |
| OPTIONS | `api-method options` | グレー | サポートメソッド確認 |

### 20.3 認証バッジ

```html
<span class="api-auth">Private</span>           <!-- 認証必須（黒背景） -->
<span class="api-auth public">Public</span>     <!-- 公開（罫線のみ） -->
```

### 20.4 パスパラメータのハイライト

`:id` `{id}` などのプレースホルダは `<span class="param">` で囲むとブランド色強調される。

```html
<span class="api-path">/api/v1/orders/<span class="param">{order_id}</span>/items/<span class="param">{item_id}</span></span>
```

### 20.5 ステータスコードのカテゴリ

GitHub Primer Label 風の **背景 tint + 文字色** デザイン。 左バーは使わない（AI 臭いデザインを避けるため）。

| クラス | 範囲 | 配色 |
|:---|:---|:---|
| `api-status.success` | 2xx | 緑系（薄い緑背景 + 濃緑文字） |
| `api-status.redirect` | 3xx | 青系（薄い青背景 + 濃青文字） |
| `api-status.client-err` | 4xx | 橙系（薄い橙背景 + 濃橙文字） |
| `api-status.server-err` | 5xx | 赤系（薄い赤背景 + 濃赤文字） |

### 20.6 POST の例（リクエスト + レスポンス）

```html
<div class="api-endpoint">
<div class="api-head">
<span class="api-method post">POST</span>
<span class="api-path">/api/v1/orders</span>
<span class="api-auth">Private</span>
</div>
<div class="api-body">
<p class="api-desc">新規注文を作成します。</p>

<div class="api-section">
<span class="api-section-title">Request Body</span>
<table class="api-params">
<thead><tr><th>Name</th><th>Type</th><th>Required</th><th>Description</th></tr></thead>
<tbody>
<tr><td class="name">customer_id</td><td class="type">string</td><td class="req"><span class="required">Required</span></td><td class="desc">注文する顧客の ID</td></tr>
<tr><td class="name">items</td><td class="type">array&lt;object&gt;</td><td class="req"><span class="required">Required</span></td><td class="desc">注文アイテムの配列</td></tr>
<tr><td class="name">note</td><td class="type">string</td><td class="req"><span class="optional">Optional</span></td><td class="desc">備考メモ（最大 500 文字）</td></tr>
</tbody>
</table>
</div>

<div class="api-section">
<span class="api-section-title">Request Example</span>
<div class="api-example">
<span class="api-example-label">POST Body<span class="api-example-tag">application/json</span></span>

```json
{
  "customer_id": "cus_abc123",
  "items": [
    { "sku": "SKU-001", "qty": 2 }
  ],
  "note": "急ぎ便希望"
}
```

</div>
</div>

<div class="api-section">
<span class="api-section-title">Response Status</span>
<div class="api-status-list">
<span class="api-status success"><span class="api-status-code">201</span><span class="api-status-text">Created</span></span>
<span class="api-status client-err"><span class="api-status-code">400</span><span class="api-status-text">Bad Request — バリデーション失敗</span></span>
<span class="api-status client-err"><span class="api-status-code">422</span><span class="api-status-text">Unprocessable Entity</span></span>
</div>
</div>
</div>
</div>
```

### 20.7 一覧用コンパクトモード（見出しのみ）

API 一覧表で「メソッド + パス」だけ並べたい時は `compact` を付ける:

```html
<div class="api-endpoint compact">
<div class="api-head">
<span class="api-method get">GET</span>
<span class="api-path">/api/v1/users</span>
</div>
</div>
<div class="api-endpoint compact">
<div class="api-head">
<span class="api-method post">POST</span>
<span class="api-path">/api/v1/users</span>
</div>
</div>
<div class="api-endpoint compact">
<div class="api-head">
<span class="api-method delete">DELETE</span>
<span class="api-path">/api/v1/users/<span class="param">:id</span></span>
</div>
</div>
```

## 21. ユーティリティ

| クラス | 用途 |
|:---|:---|
| `<div class="page-break"></div>` | 強制改ページ |
| `<div class="no-break">...</div>` | 改ページさせない |
| `<p class="center">...</p>` | 中央寄せ |
| `<p class="right">...</p>` | 右寄せ |
| `<p class="caption">...</p>` | キャプション体 |
| `<p class="muted">...</p>` | 薄色テキスト |
