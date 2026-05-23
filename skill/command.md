---
description: 株式会社C4C ブランドの Markdown ドキュメントを Swiss Modern Minimal v5.1 で生成する。引数にタイトルや要件を渡せる。
argument-hint: "[ドキュメントタイトル or 要件]"
---

# /markdown-c4c

`markdown-c4c` スキルを明示的に呼び出して、株式会社C4C ブランドの Markdown ドキュメントを生成する。

## 動作

1. **必ず最初に Skill ツールで `markdown-c4c` を呼び出す**
2. 呼出後、SKILL.md セクション 3.0 の **5 フェーズ Q&A ワークフロー**を踏む（基本 5 項目 → 種別ごとの追加質問 → コンポーネント提案 → 構成バリエーション提示 → 生成 → AI 臭セルフチェック 7 項目）
3. 引数 `$ARGUMENTS` がある場合はそれをドキュメントタイトル or 要件として解釈
4. 引数がない場合は、ユーザーに `AskUserQuestion` で 5 項目以上を確認

## 必須生成項目（SKILL.md v5.1 準拠）

- `<head><title>...</title></head>` 冒頭埋込
- `<nav class="toc toc-no-page">` 目次（H2 数 ≥ 3 の場合、**ページ番号なし**）
- `<h2 id="sec-xxx">` 形式の見出し（クリック遷移可能）
- コールアウト / 図形ボックス / 区切り線はバリエーション使い回し
- 画像は重要時 `<div class="shape-box" data-title="...">` 形式
- テーブルは `|:---:|---:|` でアラインメント明示
- 日本語は JP Fix 8 項目セルフチェック
- ロゴ画像を含むドキュメントを生成完了したら、 SKILL.md セクション 3.5 のロゴ配置案内テンプレを最終応答に提示

## 引数

$ARGUMENTS

引数がドキュメントタイトル or 要件として渡された場合は、それを元に新規 Markdown を生成する。
