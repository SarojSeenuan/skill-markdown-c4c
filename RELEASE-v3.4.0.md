## ▍ Highlights

### C4C ブランド統合
- 公式ロゴ (`c4c-logo.png`) をリポジトリに同梱
- README のヒーローセクションをロゴ画像で刷新
- スキル本体 / Web 配布版 / `docs/brand/` の 3 箇所に配置

### 新コンポーネント — API Blueprint
REST API ドキュメントを Markdown で書けるコンポーネント。

- HTTP method バッジ 7 種 (`GET` `POST` `PUT` `PATCH` `DELETE` `HEAD` `OPTIONS`) — 色分け
- パス + 認証バッジ (Private / Public)
- パラメータ表 (Name / Type / Required / Description)
- ステータスコード Label (GitHub Primer 風 · AI 臭排除)
- Request / Response Example

### Stat Card / KPI 刷新
モダンダッシュボード風カードに刷新:

- 左に縦カラーアクセントバー
- 右上に chevron `›`
- 8 accent 色 (red / green / blue / brand / amber / orange / pink / gray)
- トレンドアイコン (↗ ↘ →) + 変化率テキスト

### グラフコンポーネント拡充
- **Bar Chart 横** — `intensity-1〜4` で透明度ベースの値表現 (色はブランド紫で統一)
- **Bar Chart 縦** — 新規 `.bar-chart-v`
- **Line Graph (X/Y)** — 新規 `.line-graph` (SVG ベース · 実線 + 破線 + 凡例)
- **Donut Chart 削除** — PDF レンダリングが不安定だったため

### その他の改善
- **Callout** — 「注意」「重要」を **「注意：」「重要：」** に変更（句読点ルール準拠）
- **Pricing Card** — padding / 幅拡大、角丸 + 軽い影
- **Timeline** — active/done の線の太さを 2pt に統一（ズレ修正）
- **Pull Quote** — 引用符サイズ 56pt → 28pt（テキストへの被り解消）
- **API params** — NAME 列の枠線密着を解消（左 padding 16pt 確保）

### JP Fix ルール拡張
日本語チェックを 7 項目 → **8 項目** に拡張:

- 英単語の直後に「。」を付けない（代わりに `—` か `:`）
- 文中の「。」のあとは半角スペース 1 つ

### Claude Web 無料版向け配布パッケージ
無料版を使うチームメンバー向けに、ZIP で配布可能な完全パッケージを同梱。

```
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

### フッタ表記の柔軟化
- フッタ左の `v1.0 · DRAFT` を **空** に
- バージョン表記はドキュメントタイトル直下の `caption` 行で動的指定可能に

---

## ▍ Components Lineup (v3.4)

| カテゴリ | バリエーション |
|:---|:---|
| Callout | 5 種 (NOTE · TIP · INFO · 注意 · 重要) |
| Shape Box | 5 種 |
| Divider | 9 種 |
| Table | 5 種 |
| **Stats / KPI** | 8 accent 色 |
| **Timeline** | 3 state |
| **Pull Quote** | 2 |
| **Comparison** | BEFORE / AFTER |
| **Bar Chart** | 横 + 縦 |
| **Line Graph** | X/Y 軸 + 実線/破線 |
| **Feature List** | SVG アイコン推奨 |
| **Person Card** | avatar + role + body |
| **Pricing Table** | 標準 + featured |
| **API Blueprint** | 7 method |
| TOC | クリック遷移可能 |
| Code Block | One Dark Pro |

---

## ▍ Install

### Claude Code 版

```bash
git clone https://github.com/SarojSeenuan/skill-markdown-c4c.git ~/c4c-skill
cd ~/c4c-skill
./scripts/install.sh         # macOS / Linux
.\scripts\install.ps1        # Windows
```

### Claude Web 無料版

このリリースの **Assets** から `markdown-c4c-web-v1.0.0.zip` をダウンロードして展開。 詳細は同梱の `README.md` と `pdf-setup/README-PDF-SETUP.md` を参照。

---

## ▍ Post-release fixes

このリリース後、以下の修正を別コミットで適用しています:

- ケーススタディ画像の追加 (`docs/case-studies/` + `docs/screenshots/case-study/`)
- ケーススタディ写真の分類修正 (BEFORE → AFTER にリネーム)

次のパッチリリース (`v3.4.1`) でまとめてタグ付け予定。

---

## ▍ Acknowledgements

Designed by Saroj Seenuan (Ken) · Built for 株式会社C4C
