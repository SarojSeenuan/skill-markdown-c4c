# Case Study 01 — Markdown PDF を C4C ブランドで強化してみた

> 株式会社C4C 社内向けに作成した導入記事の公開版。
> Markdown のソースコードを **一行も変えずに**、PDF の見た目だけが全面的に変わる体験を紹介します。

---

## 背景

AI で資料を作る機会が一気に増えました。提案書、議事録、設計書、報告書、調査メモ — `.md` ファイルが増え続ける一方で、デフォルト設定の `Markdown PDF` 拡張で PDF 化すると、見た目が地味でクライアントに出しづらいという課題がありました。

> **困った点**：余白がスカスカ、テーブルは罫線だけ、見出しはただの太字。情報の階層が見えづらく、ブランドの一貫性もない。

---

## Before / After

| 【導入前】デフォルト出力 (1) | 【導入前】デフォルト出力 (2) | 【導入後】markdown-c4c 適用 |
|:---:|:---:|:---:|
| <img src="../screenshots/case-study/01-before-default.png" alt="Before 1" width="220" /> | <img src="../screenshots/case-study/02-before-default-alt.png" alt="Before 2" width="220" /> | <img src="../screenshots/case-study/03-after-c4c.png" alt="After" width="220" /> |

同じ Markdown ファイルを、CSS と settings.json を入れ替えるだけで右のような出力に変わります。
**原稿には一切手を加えていません。**

---

## 設計方針

- **Swiss Modern Minimal** — グリッドと余白で見せる、装飾は最小限
- **ブランドカラー 3 色** — `#8A248C` マゼンタ / `#888888` グレー / `#040104` インク
- **CSS の `:root` 3 行差し替え**で他ブランドにも転用可能
- 書く側は **何も覚え直さなくていい** — 普通の Markdown のままで OK

---

## ハイライト機能

| 機能 | 種類 | 概要 |
|:---|:---:|:---|
| Callout | 5 種 | NOTE / TIP / INFO / WARNING / DANGER |
| Shape Box | 5 種 | 標準 / filled / outline / brand / data-title |
| Divider | 9 種 | hairline / double / dot 系 6 種 / brand 菱形 |
| Table | 5 種 | 4辺枠線（既定）/ no-borders / compact / jp / wrap |
| TOC | — | ドットリーダー + クリック遷移可能目次 |
| Code Block | — | One Dark Pro 配色 + ファイル名ヘッダ |

全コンポーネントのギャラリーは [`docs/screenshots/gallery`](../screenshots/gallery/) を参照。

---

## 使い方（3 つの呼出方法）

1. **自動呼出** — Claude に「ドキュメント作って」と頼むだけで、スキルが自動参照される
2. **スラッシュコマンド** — `/markdown-c4c [タイトル]` で明示呼出
3. **テンプレートから手動開始** — `skill/assets/template-document.md` をコピー

---

## セットアップ（5 分）

1. **VS Code 拡張インストール**: `code --install-extension yzane.markdown-pdf`
2. **インストールスクリプト実行**: README の手順に従う（PowerShell or Bash ワンライナー）
3. **settings.json マージ**: `skill/assets/setup-vscode-settings.json` の内容を追加

詳細は [README.md](../../README.md) を参照。

---

## 今後の展開

- 社内全員への展開（提案書・議事録・設計書・報告書の統一）
- 他プロジェクトへの転用（ブランドカラー差替えで対応）
- 用途別テンプレート集の整備（提案書・週報など）

---

> Saroj Seenuan (Ken) · 株式会社C4C · 2026-05-21
