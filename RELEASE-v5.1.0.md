<head>
<title>Release Notes — markdown-c4c v5.1.0</title>
</head>

<div class="cover-page">
  <div class="cover-body">
    <span class="cover-eyebrow">RELEASE</span>
    <h1 class="cover-title">markdown-c4c<br>v5.1.0 Release Notes</h1>
    <p class="cover-subtitle">判断ガイド集として reference.md 全面再設計・
SKILL.md セクション 3.0 を 5 フェーズ Q&A ワークフローに拡張・
ロゴ画像配置案内ルール新設・全ドキュメント刷新</p>
  </div>
  <table class="cover-meta">
    <tr><th>VERSION</th><td>v5.1.0</td></tr>
    <tr><th>DATE</th><td>2026-05-24</td></tr>
    <tr><th>STATUS</th><td>RELEASED</td></tr>
    <tr><th>AUTHOR</th><td>株式会社C4C</td></tr>
  </table>
</div>

<div class="no-break">

# Release Notes — v5.1.0

<div class="caption">Version: v5.1.0 · RELEASED　·　Date: 2026-05-24　·　株式会社C4C</div>

<nav class="toc toc-no-page">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-highlights">ハイライト</a></li>
    <li><a href="#sec-qa">SKILL.md セクション 3.0 — 5 フェーズ Q&A ワークフロー</a></li>
    <li><a href="#sec-logo">SKILL.md セクション 3.5 — ロゴ画像配置案内ルール</a></li>
    <li><a href="#sec-reference">reference.md — 判断ガイド集として再設計</a></li>
    <li><a href="#sec-jp-headings">コンポーネント見出し日本語化</a></li>
    <li><a href="#sec-docs-refresh">全ドキュメントの v5.1.0 統一</a></li>
    <li><a href="#sec-mirror">配布構造 — skill/references 新設</a></li>
    <li><a href="#sec-checklist-additions">チェックリスト強化</a></li>
    <li><a href="#sec-upgrade">アップグレード手順</a></li>
  </ol>
</nav>

</div>

<h2 id="sec-highlights">1. ハイライト</h2>

v5.1.0 は v5.0.4 までで積み上げた基盤の上に、 **「同じ顔のドキュメントを量産しない」ための判断インフラ**を整備するリリースです。 Claude が毎回 reference.md を見ながら判断し、ユーザーと対話しながら構成を決められるように、SKILL.md と reference.md を全面強化しました。

主な変化:

- **判断ガイド集**としての `docs/markdown-c4c-reference.md` 再設計
- **5 フェーズ Q&A ワークフロー**（基本 5 項目 → 種別追加 → コンポーネント提案 → 構成バリエーション提示 → 生成後 AI 臭セルフチェック）
- **ロゴ画像配置案内ルール**で macOS / Windows 両 OS のユーザーに優しい出力

<h2 id="sec-qa">2. SKILL.md セクション 3.0 — 5 フェーズ Q&A ワークフロー</h2>

セクション 3.0 を従来の「最低 5 項目を聞いて終わり」から、 **5 つのフェーズを順番に踏む 1 セット**に拡張しました。

### フェーズ構成

```text
3.0.1 基本 5 項目
  ↓
3.0.2 種別ごとの追加質問テンプレ（7 種別 × 3-5 問）
  ↓
3.0.3 コンポーネント提案フェーズ
  ↓
3.0.4 構成バリエーション提示
  ↓
（生成）
  ↓
3.0.5 生成後 AI 臭セルフチェック 7 項目
```

各フェーズは独立して機能しつつ、全部を通すことで「ユーザーの目的に寄り添った 1 本の構成」が完成します。

### 種別ごとの追加質問テンプレ（一例）

提案書を選ばれたら:

- 料金プランは何種類？（1 / 2 / 3 / 提示しない）
- 比較対象の現行システムは？
- 想定する意思決定者は？（経営層 / 部門長 / 現場）
- 期待される ROI / 削減効果の数値は？
- 契約形態は？（一括 / SaaS / SES / 段階契約）

仕様書・設計書・工数見積書・議事録・報告書・README にも、それぞれ 3-5 問の追加質問テンプレを定義しています。 詳細は SKILL.md セクション 3.0.2 を参照。

### 生成後 AI 臭セルフチェック 7 項目

生成完了した瞬間、 **送信前に必ず**以下 7 項目を確認します。

1. 抽象動詞が 3 つ以上連続していないか
2. 同じ種類のコールアウトを 2 個以上連続させていないか
3. コンポーネントの前後に意味づけ段落（200 字以上）があるか
4. 「貴社・当社」「いたします・ください・できます」など書き言葉統一されているか
5. 数値カード・比較カードのセクションに根拠説明があるか
6. cover-eyebrow が英大文字 1 ワードの規定値か
7. 強調ラベル直後が「：」（コロン）になっているか

<h2 id="sec-logo">3. SKILL.md セクション 3.5 — ロゴ画像配置案内ルール（新設）</h2>

`closing-watermark` などで C4C ロゴ画像を含む Markdown を生成完了したら、 **ユーザーへの最終出力で必ず以下を案内**します。

- Markdown ファイルの推奨格納場所（Windows / macOS 両対応の骨組み）
- C4C ロゴ画像の配置先（`assets/c4c-logo.png` 相対パス）
- ロゴ画像本体のコピー手順（PowerShell / bash 両方）
- 修正が必要な箇所（相対パス / cover-meta / プレースホルダ）
- PDF 化手順（VS Code Markdown PDF 拡張）

ユーザーが格納先をカスタマイズしたい場合に備えて、 **骨組みとして提示**する方針です。

<h2 id="sec-reference">4. reference.md — 判断ガイド集として再設計</h2>

`docs/markdown-c4c-reference.md` を「コンポーネントカタログ」から「**判断ガイド付きカタログ**」へ全面再設計しました。

### 新しい目次（H2 抜粋）

```text
1. このドキュメントについて — 判断ガイド集
2. 生成判断フロー
3. Q&A の流れ図 — 4 ステップ
4. ドキュメント種別ごとの構成バリエーション（7 種別 × 2-3 パターン）
5. コンポーネント組み合わせ NG 集
6. 自動適用ルール一覧
7-19. コンポーネント別ショーケース + 「いつ使う / いつ使わない」
```

### 主な追加要素

- **生成判断フロー**: ドキュメント種別から構成を決めるまでのフロー図（ASCII 図）
- **Q&A の流れ図**: 質問 → ヒアリング → 提案 → 承認の 4 ステップ
- **構成バリエーション 7 種別 × 2-3 パターン**: 同じ「提案書」でも 3 パターンの章立て案
- **組み合わせ NG 集**: コールアウト連続使用 / 数値カードだけのセクション / 図形ボックス濫用 / 区切り線同種連発 / 円形バッジ越境再利用 / 表紙・締めページ内 hr の 6 サブセクション
- **「いつ使う / いつ使わない」ミニ表**: コールアウト / 図形ボックス / 区切り線 / 画像の各セクションに追加

<h2 id="sec-jp-headings">5. コンポーネント見出し日本語化</h2>

SKILL.md セクション 5 と reference.md の 18 章すべてで、コンポーネント見出しを日本語表記に統一しました。 クラス名・コード例は英字のまま、見出しテキストだけ日本語化しています。

| 旧 | 新 |
|:---|:---|
| `5.1 Callout — 5 種類` | `5.1 コールアウト（Callout）— 5 種類` |
| `5.5 Stats / KPI` | `5.5 数値カード（Stats / KPI）— 8 アクセント色` |
| `5.6 Timeline` | `5.6 タイムライン（Timeline）— 3 状態` |
| `5.8 Comparison` | `5.8 比較カード（Comparison · Before / After）` |
| `5.19 円形アイコンバッジ` | `5.19 円形アイコンバッジ（Circular Icon Badge）— ★最お気に入りパターン` |

ほか全 19 項目。

<h2 id="sec-docs-refresh">6. 全ドキュメントの v5.1.0 統一</h2>

以下のドキュメント類を v5.1.0 形式（cover-page + TOC + closing-page）に統一しました。

- `README.md` — v3.5.0 表記を全置換、「What's new in v5.1.0」セクション新設、ロゴ配置案内の言及追加
- `RELEASE-v3.4.0.md` / `RELEASE-v3.5.0.md` / `RELEASE-v4.0.0.md` — 当時の事実は CHANGELOG から 100% 保持しつつ、 v5 形式の体裁を適用
- `RELEASE-v5.0.0.md` 新規 — v5.0.0〜v5.0.4 を統合した正式リリースノート
- `docs/articles/markdown-c4c-introduction/README.md` — v5.1.0 caption + cover/closing 適用
- `docs/case-studies/01-introduction.md` — cover-page / TOC / closing-page を追加
- `docs/markdown-c4c-cover-closing-preview.md` — v5.1.0 形式、「いつ使う / いつ使わない」を各パターンに追加、書き言葉統一

<h2 id="sec-mirror">7. 配布構造 — skill/references 新設</h2>

`skill/references/` ディレクトリを新設し、 docs/ の正本から判断ガイドと表紙・締めページプレビューの Markdown をミラーします。

```text
skill/
├── assets/
│   ├── markdown-c4c-reference.pdf                  ← ユーザー手動配置
│   └── markdown-c4c-cover-closing-preview.pdf      ← ユーザー手動配置
└── references/
    ├── markdown-c4c-reference.md                   ← docs/ からミラー
    └── markdown-c4c-cover-closing-preview.md       ← docs/ からミラー
```

PDF は Markdown PDF 拡張で `docs/*.md` から生成し、 `skill/assets/` に配置する手動運用です。

<h2 id="sec-checklist-additions">8. チェックリスト強化</h2>

SKILL.md セクション 6（必須チェックリスト）に以下 3 項目を追加しました。

- 生成後の AI 臭セルフチェック 7 項目（セクション 3.0.5）を完了している
- 構成は コンポーネント提案 → 承認（3.0.3）と 構成バリエーション提示 → 選択（3.0.4）を経て決めている
- ロゴ画像を含む md を生成完了したら、 セクション 3.5 のロゴ配置案内テンプレを最終応答に提示している

<h2 id="sec-upgrade">9. アップグレード手順</h2>

```bash
# 1. リポジトリを pull
git pull

# 2. ZIP を再生成（OS に応じて）
pwsh ./scripts/build-zip.ps1     # Windows
./scripts/build-zip.sh           # macOS / Linux

# 3. 生成された markdown-c4c-v5.1.0.zip を Claude Web の Skills に手動アップロード
```

v5.0.4 から v5.1.0 への移行で、互換性破壊はありません。 CSS の構造変更も行っていないため、既存ドキュメントはそのまま使えます。 ただし以下を推奨します。

- 新規ドキュメントは SKILL.md セクション 3.0 の 5 フェーズ Q&A を必ず通す
- ロゴ画像を使う場合はセクション 3.5 の配置案内テンプレを必ず最終応答に含める

<div class="closing-page closing-message">
  <p class="closing-thanks">最後までご覧いただき、誠にありがとうございました。</p>
  <p class="closing-credo">「カタチ」に残すだけじゃない、<br>「ココロ」に残る仕事を。</p>
  <p class="closing-org">株式会社C4C</p>
</div>
