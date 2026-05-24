# Changelog

All notable changes to **skill-markdown-c4c** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [5.1.1] — 2026-05-25

### Added
- **`SETUP-WEB.md` / `SETUP-WEB.pdf` を新規同梱** — Claude Web 無料版での導入手順を画面キャプチャ 18 枚（`assets/setup-web/00-17`）付きで解説した非開発者向けセットアップガイド。 VS Code Markdown PDF 拡張のセットアップから ZIP アップロード、スキル発火確認、PDF 出力まで Windows / macOS / Linux 共通の手順
- **配布 ZIP `markdown-c4c-v5.1.1.zip` に `SETUP-WEB.md` / `SETUP-WEB.pdf` を同梱** — Claude Web 登録後に説明書をオフライン閲覧可能。 ZIP ルート直下に配置（`markdown-c4c/SETUP-WEB.md` / `markdown-c4c/SETUP-WEB.pdf`）
- **`docs/SETUP-WEB.md` / `docs/SETUP-WEB.pdf` 配置** — 既存の `docs/markdown-c4c-reference.md` などと同じ docs/ 直下に配置し、GitHub 閲覧時の発見性向上
- **`scripts/install.js` 新規作成** — Node.js 純正クロス OS インストーラ（`fs.cpSync` のみ使用、Bash / PowerShell 非依存）。 `npx -y .` または `npm link && markdown-c4c-skill` でスキル投入可能
- `package.json` に `bin: markdown-c4c-skill` + `engines.node: ">=16.7.0"` + `install:skill` script を追加
- SKILL.md tags に `setup-guide` / `claude-web` を追加

### Changed
- **`scripts/build-zip.sh` / `build-zip.ps1` の PDF 除外ルール変更** — `*.pdf` 一括除外から `template-document.pdf` のみ除外に変更。 SETUP-WEB.pdf など説明書 PDF は ZIP に同梱される
- **インストーラのバナー表記を v5.1.1 に更新** — `install.sh` / `install.ps1` / `install.js` の 3 種すべて
- **`scripts/validate-zip.py` のデフォルト ZIP 名を v5.1.1 に更新**
- **`README.md` 更新** — 旧 `markdown-c4c-web-v1.0.0/` 参照を `SETUP-WEB.md` に書き換え、 Repository Structure に SETUP-WEB ファイル群を明記、 npx 経由のインストール手順を C セクションに追加

### Removed
- **`markdown-c4c-web-v1.0.0/` フォルダ削除** — Claude Web 配布パッケージは ZIP に統合され、 旧フォルダ構造は不要になったため。 セットアップ手順は `SETUP-WEB.md` に集約
- **旧 ZIP `markdown-c4c-v3.5.0.zip` / `markdown-c4c-v4.0.0.zip` 削除** — バージョン履歴は CHANGELOG と RELEASE ノートで追跡可能
- `bash.exe.stackdump`（Git Bash クラッシュゴミ）を削除

## [5.1.0] — 2026-05-24

### Added
- **SKILL.md セクション 3.0 を 5 フェーズの Q&A ワークフローに拡張** — 3.0.1 基本 5 項目 / 3.0.2 種別ごとの追加質問テンプレ（提案書 5 問 / 仕様書 5 問 / 設計書 4 問 / 工数見積書 4 問 / 議事録 3 問 / 報告書 3 問 / README 3 問）/ 3.0.3 コンポーネント提案フェーズ / 3.0.4 構成バリエーション提示 / 3.0.5 生成後 AI 臭セルフチェック 7 項目 / 3.0.6 守るべき原則 + テンプレート廃止理由
- **SKILL.md セクション 3.5 ロゴ画像配置案内ルール新設** — ロゴ画像を含む md を生成完了したら、 macOS / Windows 両 OS の格納先と修正必要箇所を骨組みとして提示するテンプレを常時出力
- **`docs/markdown-c4c-reference.md` を判断ガイド集として全面再設計** — 「生成判断フロー」「Q&A の流れ図」「ドキュメント種別ごとの構成バリエーション（7 種別 × 2-3 パターン）」「コンポーネント組み合わせ NG 集」を新設。 各コンポーネントセクションに「いつ使う / いつ使わない」ミニ表を追加。 HTML / CSS の新規追加はせず、 Markdown 範囲内で完結
- **配布物ミラー `skill/references/` 新設** — `markdown-c4c-reference.md` と `markdown-c4c-cover-closing-preview.md` を `docs/` 正本から同梱
- **配布物ミラー `skill/assets/*.pdf`** — リファレンスと表紙・締めページ プレビューの PDF をユーザー手動で配置する運用に追加
- チェックリストに「生成後の AI 臭セルフチェック 7 項目を完了」「コンポーネント提案 → 承認 + 構成バリエーション提示 → 選択 を経て決めている」「ロゴ画像を含む md ではロゴ配置案内テンプレを提示している」を追加

### Changed
- **SKILL.md セクション 5 のコンポーネント見出しを日本語表記で統一** — クラス名・コード例は英字のまま、見出しテキストだけ日本語化（例: `5.1 Callout — 5 種類` → `5.1 コールアウト（Callout）— 5 種類`、`5.5 Stats / KPI` → `5.5 数値カード（Stats / KPI）`、`5.19 円形アイコンバッジ` を `円形アイコンバッジ（Circular Icon Badge）` に統一）
- **`README.md` を v5.1.0 に刷新** — 旧 v3.5.0 表記を全置換、「What's new in v5.1.0」セクション新設、ロゴ配置案内ルールの言及追加
- **`RELEASE-v3.4.0.md` / `RELEASE-v3.5.0.md` / `RELEASE-v4.0.0.md` を v5 形式で書き直し** — 当時の事実は CHANGELOG から 100% 保持しつつ、 cover-page + TOC + closing-message の 3 点セットを被せて統一フォーマット化
- **紹介記事と case-study を v5.1.0 形式に統一** — `docs/articles/markdown-c4c-introduction/README.md` と `docs/case-studies/01-introduction.md` に cover/TOC/closing を適用、既存ストーリーと screenshot パスは保持
- `docs/markdown-c4c-cover-closing-preview.md` の version を v5.1.0 に bump、 全パターンに「いつ使う / いつ使わない」追記、 「御社」「弊社」を「貴社」「当社」に修正

### Added (新規 RELEASE ファイル)
- **`RELEASE-v5.0.0.md` 新規作成** — v5.0.0〜v5.0.4 を統合した正式リリースノート（v5 系の途中バージョンには RELEASE ファイルがなかったため）
- **`RELEASE-v5.1.0.md` 新規作成** — 本リリースのノート

## [5.0.4] — 2026-05-24

### Added
- **SKILL.md セクション 5.19「円形アイコンバッジ — ★最お気に入りパターン」を新設** — ブランド色塗りつぶし円 + 白 stroke の SVG アイコンを、連絡先・属性リスト・特徴リスト・人物属性・価格特典などで積極使用するルール化。 8 種類の標準 SVG アイコン（user / envelope / globe / building / phone / location / calendar / shield）をコピペで使えるコードスニペット付きで掲載
- チェックリストに「連絡先・属性リスト・特徴リストには円形 SVG アイコンバッジを積極使用している」を追加

### Changed
- **closing-contact の contact-label を SVG アイコンに置換** — 英字テキスト (MEMBER/EMAIL/WEB/COMPANY) を Heroicons 系インライン SVG（user / envelope / globe / building-office）に置換。 円形バッジ内に 5.5mm の白色 stroke で描画
- **closing-contact / closing-cta の右下リング装飾を撤去** — `::after` のブランドアーク + グレーリングを display:none に。 右上ドットパターンは残置でバランスを取る
- closing-contact / closing-cta テンプレートを SVG アイコン版に書き換え（SKILL.md / docs/markdown-c4c-reference.md / docs/markdown-c4c-cover-closing-preview.md の 3 か所）

## [5.0.3] — 2026-05-24

### Changed
- **closing-contact を Editorial スタイルに全面再設計** — 参考デザイン準拠で、box 囲み + left-border カードの「AI 量産デザイン」を完全撤廃。 大型 "Contact" タイポ + 左短縦バー + 短ヘアライン + ミッション文 + `Country for Country` タグライン + 円形ブランドカラーアイコン付き連絡先リスト + 下端 `CHALLENGE FOR CHANGE` ブランド署名で構成。 右上ドットパターン + 右下ブランドカラーアーク装飾
- **closing-cta も同 Editorial 語彙に再設計** — center-stack を脱却し左寄せ。 大型 "Contact" タイポ + 左短縦バー + 右上ドット + 右下アーク。 CTA ボタンは uppercase + letter-spacing 0.18em で印象を強化。 closing-cta-meta に `Country for Country` ブランド署名を配置
- HTML 構造変更: `closing-cta-eyebrow` / `closing-contact-eyebrow` を廃止（CSS は display:none で防御）。 `closing-cta-title` / `closing-contact h2` 内に `<small>` で日本語サブタイトルを埋める構造に変更
- closing-contact に `contact-mission` / `contact-tagline` / `contact-rule` / `contact-footer-tagline` の 4 要素を新設

## [5.0.2] — 2026-05-24

### Changed
- **closing-contact を Block-based + Motion-Driven デザインに刷新** — contact-card を 2 列グリッドに変更、各 contact-row を独立ブロック化（左端ブランド色アクセントバー / 上下 2 段の階層 / 右上に動きを示す `↗` アイコン / 偶数行は影とアクセント色を変えてリズム化）
- **closing-watermark のロゴサイズ拡大** — width 110mm → 170mm。 紙面のほぼ全幅を覆う「背景全体がロゴ」の存在感
- **closing-thanks のサイズ調整** — 17pt → 12.5pt、Inter Tight 800 → Noto Sans JP 700 に変更、`white-space: nowrap` 追加で「最後までご覧いただき、誠にありがとうございました。」が確実に 1 行に収まる
- closing-contact の `contact-card` を子要素数で自動分岐（1 個=中央 1 列 / 3 個=1 行 3 列 / それ以外=2 列）

## [5.0.1] — 2026-05-24

### Fixed
- **TOC が caption と同じページに収まらず別ページに送られる問題** — `.toc h2`（Index 見出し）に `page-break-before: auto` を明示し、グローバル `h2 { page-break-before: always }` の上書きが効くようにした
- 保険として `.no-break h2` 全般に対しても改ページ抑止を追加（no-break ラッパ内の h2 で同じ事故が起きないようにする）

## [5.0.0] — 2026-05-24

### Breaking
- **SKILL.md セクション 4「ドキュメント種別テンプレート（5 種）」を完全削除** — 種別別の章立てテンプレが量産する「同じ顔のドキュメント」を根絶
- **Markdown 生成前に Q&A 確認（最低 5 項目）を必須化** — SKILL.md セクション 3.0 新設、AskUserQuestion 経由で種別 / 読者 / 主要メッセージ / コンポーネント / トーンを毎回確定
- **`cover-mark` / `cover-footer` を cover-page から撤去** — CSS 側は `display: none !important` で防御、テンプレ側からも完全削除
- **`docs/markdown-c4c-reference.md` をテンプレート集 → 参考スニペット集に格下げ** — 冒頭に「コピペ元ではない」と明示

### Added
- CSS: `.pricing` を `grid-template-columns: repeat(3, 1fr)` 固定 + `:has()` ベースの子要素数自動分岐（2 プラン → 2 列、1 プラン → 中央配置）
- CSS: `.stats-grid` を `repeat(4, 1fr)` 固定 + `:has()` ベース自動分岐（3 → 3 列、2 → 2 列、1 → 中央）
- CSS: 手動上書きクラス `.pricing.cols-N` / `.stats-grid.cols-N`（`:has()` 非対応環境の fallback）
- ルール: 強調ラベル直後の区切りに「。」ではなくコロン「：」を使う（SKILL.md ステップ 7 配下に追加）

### Changed
- CSS: `closing-credo` 32pt → 22pt（1.5 段ダウン）、`line-height: 1.9 → 1.8`、`letter-spacing: 0.1em → 0.08em`
- CSS: `closing-thanks` を Inter Tight 17pt 800 / `var(--brand-ink)` に強調（旧: Noto Sans JP 14pt 500 gray-60）
- CSS: `watermark-logo` `opacity: 0.06 → 0.12` / `width: 130mm → 110mm`
- CSS: `closing-cta-body` を中央寄せ明示 + `white-space: pre-line` で改行尊重 / `font-size 12pt → 11.5pt` / `max-width 120mm → 110mm`
- CSS: `cover-subtitle` を中央寄せ明示 + `white-space: pre-line` で改行尊重 + `margin: 0 auto`
- CSS: `stat-card` の padding を圧縮（sp-4 → sp-3）、`stat-value` 22pt → 18pt（4 列で破綻しないため）
- CSS: `price-card` padding を `8mm 6mm 7mm 6mm` に圧縮、`price-amount` 28pt → 24pt（3 列固定対応）
- SKILL.md: `closing-thanks` の文言を「最後までご覧いただき、誠にありがとうございました。」に統一
- SKILL.md: `closing-cta-body` のサンプルを 3 行構成に変更（中央寄せで見栄え良く）
- `docs/markdown-c4c-reference.md`: shape-box / shape-brand / Callout / shape-box data-title のラベル `<strong>X。</strong>` を `<strong>X：</strong>` に統一
- `docs/markdown-c4c-reference.md`: Stats / Pricing サンプルを 3 列固定前提に書き直し
- `docs/markdown-c4c-reference.md`: 8.2-8.4 を「GFM 標準で十分」セクションに統合、HTML テーブル実例を削除
- CSS / SKILL.md / package.json 全箇所のバージョンを 5.0.0 に bump

### Removed
- `docs/markdown-c4c-reference.md`: 8.5 横スクロール対応セクション全削除（markdown-pdf 非対応）
- SKILL.md: セクション 4「ドキュメント種別テンプレート（5 種）」全削除
- SKILL.md: cover-page テンプレートから `cover-mark` / `cover-footer` を撤去
- `markdown-c4c-reference.md`: cover-page セクションから `cover-mark` / `cover-footer` を撤去

### Fixed
- Pricing 3 プランが A4 幅で 2+1 に改行する問題 — `auto-fit minmax(210px, 1fr)` → `repeat(3, 1fr)` 固定で確実に 3 列横並び
- Stats が A4 幅で意図しない列数になる問題 — `auto-fit minmax(170px, 1fr)` → `repeat(4, 1fr)` 固定 + `:has()` で子要素数に合わせて自動調整
- closing-watermark のロゴが薄すぎて見えない問題 — opacity 0.06 → 0.12
- closing-credo が 32pt で巨大すぎ + 余白が不十分な問題 — 22pt 化 + line-height / letter-spacing 調整
- closing-thanks が弱すぎて締めページの主役にならない問題 — Inter Tight 800 17pt に強調
- cover-page の上下に飾り（cover-mark + cover-footer）が乗って情報過多になる問題 — 両方撤去し非対称構成に

## [4.0.0] — 2026-05-23

### Added
- **Google Fonts `@import`** — Noto Sans JP / Inter Tight / Manrope / Zen Kaku Gothic New / JetBrains Mono の 5 ファミリ
- **CSS フォント変数** — `--font-sans-en` / `--font-sans-jp` / `--font-display` / `--font-mono` を `:root` に追加
- **`closing-watermark` パターン（新規）** — C4C ロゴを `opacity: 0.06` で背景透かしし、上にクレドを重ねる提案書最終ページ用デザイン
- **`cover-eyebrow` 要素** — ドキュメント種別を示す英大文字 1 ワードのタグ (`PROPOSAL` / `SPECIFICATION` / `DESIGN` / `MINUTES` / `ESTIMATE` / `REPORT` / `OVERVIEW`)
- **`cover-mark` 要素** — 小さな C4C ロゴ + 組織名ラベルを上端に配置（width: auto, height: 6mm 強制）
- **`closing-cta-eyebrow` / `closing-cta-meta`** — CTA ページの上下にブランドラベルを追加
- **`closing-contact-eyebrow`** — Contact ページにブランドラベルを追加
- **`contact-card` / `contact-row` / `contact-label` / `contact-value`** — `<dl>` を捨てた新構造（日本語 dt の letter-spacing で字間崩れする問題を根絶）
- **コンテンツ密度ルール** — H2 セクション 1 つあたり最低 200-300 字、コンポーネントには意味づけ段落必須
- **文言ルール** — 「御社 → 貴社」「弊社 → 当社」など書き言葉統一規約
- **`no-break` ラッパ運用** — H1 + caption + TOC を 1 ページに収める運用ルール

### Changed
- **cover-page を全面書き直し** — flex space-between の 3 ゾーン構造（上端 mark / 中央 body / 下端 meta + footer）
- **cover-title** を Noto Sans JP Black 38pt に強化（旧: Inter Tight 32pt）
- **cover-subtitle** を Noto Sans JP Medium 13pt / line-height 1.8 / letter-spacing 0.04em に変更
- **cover ロゴサイズ強制** — `height: 6mm !important; width: auto !important;` で HTML inline width 属性に勝つ
- **closing-message のクレド** を 32pt Black / line-height 1.9 / letter-spacing 0.1em に大幅強化
- **closing-cta button を `<a>` 直書き** — 旧 `<p class="center"><a>` の位置不安定問題を解消、padding 5mm 14mm / border-radius 2mm
- **closing-contact** を `<dl>` から `contact-card + contact-row` 構造に置換
- **H2 weight** を 700 → 800（Black 切替）
- **body font stack** を Noto Sans JP 優先に変更
- **CHANGELOG / package.json / SKILL.md** 全箇所のバージョンを 4.0.0 に bump

### Removed
- **cover-divider の 2 本目使用** を廃止（eyebrow + 余白で分節）
- **closing-page 内の `<hr class="divider-brand">`** を全パターンから削除（紫菱形だけのページ事故を根絶）
- **`<dl>` ベースの closing-contact** は新構造に置き換え（後方互換は legacy CSS で残置）

### Fixed
- **cover-page 直後の 2 重改ページ事故** — テンプレ側の `<div class="page-break">` を削除（CSS 側で防御）
- **caption + TOC の改ページ分裂** — `<div class="no-break">` ラッパで強制 1 ページ化
- **closing-page 内の余白ページ事故** — `.closing-page > hr` / `.divider-brand` を `display: none !important` で防御
- **cover ロゴ巨大化問題** — HTML `<img width="100">` 属性を CSS `!important` で打ち消し
- **closing-contact dl 字間崩れ** — 日本語 dt + letter-spacing で「担　当」になる問題を構造変更で根絶

### Breaking
- **closing-page 内に `<hr>` を書いてはいけない** — CSS で `display: none` 防御だが、テンプレ側でも書かない
- **cover-page 内に手動 `<div class="page-break">` を書いてはいけない** — CSS の `page-break-after: always` と重複する
- **cover-page のロゴ `<img>` に `width="..."` 属性を書いてはいけない** — CSS が `!important` で強制サイズ化
- **closing-contact のラベルは英字固定** — `MEMBER` / `EMAIL` / `WEB` / `TEL` / `ADDRESS` / `COMPANY` / `DEPARTMENT`、日本語ラベル不可

## [3.5.0] — 2026-05-23

### Added
- **ZIP ビルドスクリプト**（`scripts/build-zip.ps1` / `scripts/build-zip.sh`）
  - Anthropic skill validator が必須とする forward slash `/` セパレータで ZIP を生成
  - skill name と一致するルートフォルダ `markdown-c4c/` を強制
  - SKILL.md frontmatter から version を読み取り、出力名を自動設定
  - 生成後にエントリ名のバックスラッシュ / ASCII 違反を自己検証
- **表紙テンプレート（cover-page）** — ロゴ + ヘアライン + タイトル + サブタイトル + メタ表 + フッタ
- **締めページ 4 パターン（closing-page）**
  - パターン①: C4C クレド + お礼
  - パターン②: CTA（行動喚起）
  - パターン③: 連絡先骨組み
  - パターン④: ビジュアル + 名言
- **CSS 新規クラス**（`assets/markdown-pdf.css` 末尾に追加）
  - `.cover-page` / `.cover-logo` / `.cover-divider` / `.cover-title` / `.cover-subtitle` / `.cover-meta` / `.cover-footer`
  - `.closing-page` / `.closing-message` / `.closing-cta` / `.closing-contact` / `.closing-visual`
- **SKILL.md 自己充足型リライト**（v3.0 → v3.5.0）
  - コンポーネント完全例コード集（14 種類すべて表 + コード例）
  - ドキュメント種別テンプレート 5 種（提案書 / 仕様書 / 設計書 / 工数見積書 / README）
  - 表紙テンプレート + 締めページ 4 パターンを内蔵
  - version bump 義務ルール（SKILL.md 編集時の自動バージョン更新）
- `package.json` に `build:zip` script を追加（OS 判定で PowerShell / Bash を切替）
- `pdf-setup/README-PDF-SETUP.md` を Windows / macOS / Linux 3 OS 対応に書き直し
- `pdf-setup/how-to-export.md` を 3 OS ショートカット併記に書き直し
- `pdf-setup/settings.json.sample` に OS 別パスのコメントを追記

### Changed
- **フッタ運用を統一** — フッタ左は空のまま、バージョンは Markdown 本文の caption 行で動的指定
- **OSS 化対応** — 個人情報を完全除去
  - `author` を `"株式会社C4C"` に統一（個人名併記を削除）
  - LICENSE の著作権者を `株式会社C4C` に統一
  - 個人 GitHub URL / git clone URL を `<YOUR-REPO>` プレースホルダに変更
  - `~/.claude/...` などの個人パス参照を相対パス（`assets/...` 等）に変更
  - サンプル人物名（Saroj Seenuan / 田中 / 山田 / 佐藤 / 鈴木）を `○○ ○○` プレースホルダに変更
- `jp-fix-checklist.md` を 7 項目 → 8 項目に拡張（句読点ルール統合）+ 個人参照削除
- CSS 内部バージョンを v3.0.1 → v3.5.0 に bump

### Fixed
- 旧 Web ZIP がアップロード時に「invalid characters」エラーになる問題を解消
  - 原因: `Compress-Archive` がエントリパスにバックスラッシュ `\` を出力していた
  - 対策: `System.IO.Compression.ZipFile` で `/` を明示構築するスクリプトに置き換え

## [3.0.1] — 2026-05-21

### Fixed
- **TOC 直後の H2 セクションが改ページされないバグを修正**
  - `.toc + h2` と `h2:first-of-type` の例外ルールを削除
  - INDEX ページとセクション 1 が正しく別ページに分かれるようになった
  - H1 直後の H2（表紙直後）と `h2.no-page-break` クラス指定時は引き続き改ページしない

## [3.0.0] — 2026-05-21

### Added
- Swiss Modern Minimal v3.0 デザインシステム全面リライト
- ブランドコア 3 色（`#8A248C` / `#888888` / `#040104`）
- 5 種類の Callout（note / tip / info / warning / danger）
- 5 種類の Shape Box（標準 / filled / outline / brand / data-title）
- 9 種類の Divider（hairline / double / dot 系 6種 / brand 菱形）
- 5 種類の Table バリエーション（4辺枠線デフォルト / no-borders / compact / jp / wrap）
- ドットリーダー付きクリック遷移可能 TOC
- H2 セクション自動改ページ（`page-break-before: always`）
- ヘッダ自動装飾（ブランド色縦バー + 株式会社C4C + ドキュメントタイトル + 下罫）
- フッタ自動装飾（資料バージョン + ページ番号 `現在/総数`）
- スラッシュコマンド `/markdown-c4c [タイトル]` 対応
- 自動呼出トリガー強化（description にキーワード豊富）
- JP Fix 7 項目セルフチェック内蔵
- インストールスクリプト（PowerShell / Bash）
- VS Code Markdown PDF 拡張 (`yzane.markdown-pdf`) 対応

### Changed
- 紫マゼンタ単独運用から 3 色ブランドコアシステムに移行
- テーブルデフォルトを「横罫のみ」から「4 辺全枠線 + ブランド色ヘッダ」に変更
- マーカー強調を `linear-gradient` から `<mark>` + 全面塗りに変更（菱形バグ修正）
- TOC ドット幅を `flex-grow: 99` + `min-width: 120pt` で伸ばす
- フッタのページ番号区切りを `·` から `/` に変更
- 第1列の zebra 色を交互から固定（少データ時の違和感解消）

### Removed
- `==text==` マーカー構文（markdown-it 非対応のため `<mark>` のみに統一）
- `{#id}` 構文（markdown-it 非対応のため `<h2 id="...">` 直書きに統一）

## [2.1.0] — 2026-04-XX

### Added
- High-specificity override edition（全宣言に `!important` 付与）
- Editorial Tech Document スタイル

## [1.0.0] — 2026-03-XX

### Added
- 初期版
- 紫マゼンタ単独運用
