# Changelog

All notable changes to **skill-markdown-c4c** will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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
