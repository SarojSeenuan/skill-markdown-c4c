---
description: 株式会社C4C ブランドの Markdown ドキュメントを Swiss Modern v3.0 で生成する。引数にタイトルや要件を渡せる。
argument-hint: "[ドキュメントタイトル or 要件]"
---

# /markdown-c4c

`markdown-c4c` スキルを明示的に呼び出して、株式会社C4C ブランドの Markdown ドキュメントを生成する。

## 動作

1. **必ず最初に Skill ツールで `markdown-c4c` を呼び出す**
2. 呼出後、SKILL.md に記載された生成ルールに従ってドキュメントを作成
3. 引数 `$ARGUMENTS` がある場合はそれをドキュメントタイトル or 要件として解釈
4. 引数がない場合は、ユーザーに「何のドキュメントを作りますか？」と AskUserQuestion で確認

## 必須生成項目（SKILL.md 準拠）

- `<head><title>...</title></head>` 冒頭埋込
- `<nav class="toc">` 目次（H2 数 ≥ 3 の場合）
- `<h2 id="sec-xxx">` 形式の見出し（クリック遷移可能）
- Callout / Shape Box / Divider はバリエーション使い回し
- 画像は重要時 `<div class="shape-box" data-title="...">` 形式
- テーブルは `|:---:|---:|` でアラインメント明示
- 日本語は JP Fix 7 項目セルフチェック

## 引数

$ARGUMENTS

引数がドキュメントタイトル or 要件として渡された場合は、それを元に新規 Markdown を生成する。
