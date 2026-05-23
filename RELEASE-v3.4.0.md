<head>
<title>Release Notes — markdown-c4c v3.4.0</title>
</head>

<div class="cover-page">
  <div class="cover-body">
    <span class="cover-eyebrow">RELEASE</span>
    <h1 class="cover-title">markdown-c4c<br>v3.4.0 Release Notes</h1>
    <p class="cover-subtitle">C4C ブランド統合・API Blueprint・Stat Card 刷新・
グラフコンポーネント拡充・JP Fix 句読点ルール</p>
  </div>
  <table class="cover-meta">
    <tr><th>VERSION</th><td>v3.4.0</td></tr>
    <tr><th>DATE</th><td>2026-04-21</td></tr>
    <tr><th>STATUS</th><td>RELEASED</td></tr>
    <tr><th>AUTHOR</th><td>株式会社C4C</td></tr>
  </table>
</div>

<div class="no-break">

# Release Notes — v3.4.0

<div class="caption">Version: v3.4.0 · RELEASED　·　Date: 2026-04-21　·　株式会社C4C</div>

<nav class="toc toc-no-page">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-highlights">ハイライト</a></li>
    <li><a href="#sec-components">追加コンポーネント</a></li>
    <li><a href="#sec-improvements">改善</a></li>
    <li><a href="#sec-jp-fix">JP Fix ルール拡張</a></li>
    <li><a href="#sec-distribution">配布パッケージ</a></li>
    <li><a href="#sec-install">インストール</a></li>
    <li><a href="#sec-postrelease">リリース後の修正</a></li>
  </ol>
</nav>

</div>

<h2 id="sec-highlights">1. ハイライト</h2>

v3.4.0 では C4C ブランドの統合を進めつつ、 REST API ドキュメント執筆に必要な「API Blueprint」コンポーネントと、 KPI 系の数値カード刷新、グラフ系コンポーネントの拡充を行いました。 ブランド表現を強化しながら、ドキュメントの表現力を一気に底上げするリリースです。

### C4C ブランド統合

- 公式ロゴ（`c4c-logo.png`）をリポジトリに同梱
- README のヒーローセクションをロゴ画像で刷新
- スキル本体 / Web 配布版 / `docs/brand/` の 3 か所に配置

<h2 id="sec-components">2. 追加コンポーネント</h2>

### 2.1 API Blueprint — REST API ドキュメント

REST API ドキュメントを Markdown で書けるコンポーネントを新設。

- HTTP method バッジ 7 種（`GET` `POST` `PUT` `PATCH` `DELETE` `HEAD` `OPTIONS`）— 色分け
- パス + 認証バッジ（Private / Public）
- パラメータ表（Name / Type / Required / Description）
- ステータスコードラベル（GitHub Primer 風 · AI 量産臭の排除）
- Request / Response Example ブロック

### 2.2 数値カード（Stats / KPI）刷新

モダンダッシュボード風カードに刷新:

- 左に縦カラーアクセントバー
- 右上に chevron `›`
- 8 accent 色（red / green / blue / brand / amber / orange / pink / gray）
- トレンドアイコン（↗ ↘ →）+ 変化率テキスト

### 2.3 グラフコンポーネント拡充

- **棒グラフ（横）** — `intensity-1〜4` で透明度ベースの値表現（色はブランド紫で統一）
- **棒グラフ（縦）** — 新規 `.bar-chart-v` を導入
- **折れ線グラフ（X / Y 軸）** — 新規 `.line-graph`（SVG ベース · 実線 + 破線 + 凡例）
- **ドーナツチャート削除** — PDF レンダリングが不安定だったため撤去

<h2 id="sec-improvements">3. 改善</h2>

| 対象 | 改善内容 |
|:---|:---|
| コールアウト | 「注意」「重要」を **「注意：」「重要：」** に変更（句読点ルール準拠） |
| 料金カード（Pricing） | padding / 幅拡大、角丸 + 軽い影 |
| タイムライン | active / done の線の太さを 2pt に統一（ズレ修正） |
| 引用ブロック（Pull Quote） | 引用符サイズ 56pt → 28pt（テキストへの被り解消） |
| API params | NAME 列の枠線密着を解消（左 padding 16pt 確保） |

### フッタ表記の柔軟化

- フッタ左の `v1.0 · DRAFT` を **空**に
- バージョン表記はドキュメントタイトル直下の `caption` 行で動的指定可能に

<h2 id="sec-jp-fix">4. JP Fix ルール拡張</h2>

日本語チェックを 7 項目 → **8 項目**に拡張しました。 句読点ルールを追加し、英単語と日本語が混在するときの読みづらさを解消しています。

- 英単語の直後に「。」を付けない（代わりに `—` か `:` を使う）
- 文中の「。」のあとは半角スペースを 1 つ入れる

<h2 id="sec-distribution">5. 配布パッケージ</h2>

Claude Web 無料版を使うチームメンバー向けに、ZIP で配布可能な完全パッケージを同梱しました。

```text
markdown-c4c-web-v1.0.0/
├── README.md
├── SKILL.md                ← Claude Web に登録するスキル
├── assets/                 ← テンプレ + ギャラリー + JP Fix
└── pdf-setup/
    ├── README-PDF-SETUP.md ← 画像付き手順書
    ├── markdown-pdf.css
    ├── settings.json.sample
    └── images/             ← スクリーンショット 6 枚
```

このリリースの **Assets** から `markdown-c4c-web-v1.0.0.zip` を直接ダウンロード可能。

### コンポーネントラインナップ（v3.4 時点）

| カテゴリ | バリエーション |
|:---|:---|
| コールアウト（Callout） | 5 種（NOTE · TIP · INFO · 注意 · 重要） |
| 図形ボックス（Shape Box） | 5 種 |
| 区切り線（Divider） | 9 種 |
| テーブル（Table） | 5 種 |
| 数値カード（Stats / KPI） | 8 accent 色 |
| タイムライン（Timeline） | 3 state |
| 引用ブロック（Pull Quote） | 2 |
| 比較カード（Comparison） | Before / After |
| 棒グラフ（Bar Chart） | 横 + 縦 |
| 折れ線グラフ（Line Graph） | X / Y 軸 + 実線 / 破線 |
| 機能リスト（Feature List） | SVG アイコン推奨 |
| 人物カード（Person Card） | avatar + role + body |
| 料金カード（Pricing） | 標準 + featured |
| API 仕様書（API Blueprint） | 7 method |
| TOC | クリック遷移可能 |
| コードブロック | One Dark Pro |

<h2 id="sec-install">6. インストール</h2>

### Claude Code 版

```bash
git clone https://github.com/SarojSeenuan/skill-markdown-c4c.git ~/c4c-skill
cd ~/c4c-skill
./scripts/install.sh         # macOS / Linux
.\scripts\install.ps1        # Windows
```

### Claude Web 無料版

このリリースの **Assets** から `markdown-c4c-web-v1.0.0.zip` をダウンロードして展開。 詳細は同梱の `README.md` と `pdf-setup/README-PDF-SETUP.md` を参照。

<h2 id="sec-postrelease">7. リリース後の修正</h2>

このリリース後、以下の修正を別コミットで適用しています。

- ケーススタディ画像の追加（`docs/case-studies/` + `docs/screenshots/case-study/`）
- ケーススタディ写真の分類修正（BEFORE → AFTER にリネーム）

次のパッチリリース（`v3.4.1`）でまとめてタグ付け予定でした（実際は v3.5.0 で取り込み）。

<div class="closing-page closing-message">
  <p class="closing-thanks">最後までご覧いただき、誠にありがとうございました。</p>
  <p class="closing-credo">「カタチ」に残すだけじゃない、<br>「ココロ」に残る仕事を。</p>
  <p class="closing-org">株式会社C4C</p>
</div>
