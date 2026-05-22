# Changelog

All notable changes to **skill-markdown-c4c** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
