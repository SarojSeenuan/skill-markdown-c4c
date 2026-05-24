<head>
<title>Release Notes — markdown-c4c v5.1.1</title>
</head>

<div class="cover-page">
  <div class="cover-body">
    <span class="cover-eyebrow">RELEASE</span>
    <h1 class="cover-title">markdown-c4c<br>v5.1.1 Release Notes</h1>
    <p class="cover-subtitle">Claude Web セットアップガイド `SETUP-WEB.md/pdf` を ZIP と docs に同梱・
npx 経由のクロス OS インストーラ `install.js` 追加・
配布物の整理と最適化</p>
  </div>
  <table class="cover-meta">
    <tr><th>VERSION</th><td>v5.1.1</td></tr>
    <tr><th>DATE</th><td>2026-05-25</td></tr>
    <tr><th>STATUS</th><td>RELEASED</td></tr>
    <tr><th>AUTHOR</th><td>株式会社C4C</td></tr>
  </table>
</div>

<div class="no-break">

# Release Notes — v5.1.1

<div class="caption">Version: v5.1.1 · RELEASED　·　Date: 2026-05-25　·　株式会社C4C</div>

<nav class="toc toc-no-page">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-highlights">ハイライト</a></li>
    <li><a href="#sec-setup-web">SETUP-WEB.md / pdf を ZIP と docs に同梱</a></li>
    <li><a href="#sec-installer">scripts/install.js — クロス OS インストーラ追加</a></li>
    <li><a href="#sec-build-zip">build-zip スクリプトの PDF 除外ルール変更</a></li>
    <li><a href="#sec-cleanup">配布物の整理</a></li>
    <li><a href="#sec-tags">SKILL.md tags 拡張</a></li>
    <li><a href="#sec-upgrade">アップグレード手順</a></li>
  </ol>
</nav>

</div>

<h2 id="sec-highlights">1. ハイライト</h2>

v5.1.1 は v5.1.0 で完成した「判断ガイド集」インフラの上に、 **Claude Web ユーザー向けの導入体験を最大化する**ためのリリースです。 開発者でない人でも ZIP を 1 つ受け取れば、画面キャプチャ付きの説明書 PDF がその中に入っていて、迷わず Claude Web に登録できる状態を目指しました。

主な変化:

- **`SETUP-WEB.md` / `SETUP-WEB.pdf` を ZIP に同梱** — 配布物が説明書ごとオフライン完結
- **`scripts/install.js` 新規追加** — Node.js だけで Windows / macOS / Linux すべてに対応する純正インストーラ。 `npx` 一発で導入可能
- **`build-zip` の PDF 除外ルール緩和** — `template-document.pdf` のみ除外、 SETUP-WEB.pdf のような説明書 PDF は ZIP に同梱される
- **旧 `markdown-c4c-web-v1.0.0/` フォルダ廃止** — Claude Web 配布資産は ZIP に統合

<h2 id="sec-setup-web">2. SETUP-WEB.md / pdf を ZIP と docs に同梱</h2>

Claude Web 無料版ユーザー向けの **18 ステップ画面キャプチャ付き** セットアップガイド `SETUP-WEB.md` と、 そのまま印刷・閲覧できる PDF 版 `SETUP-WEB.pdf` を新規同梱しました。

### 同梱箇所

| 場所 | パス | 用途 |
|:---|:---|:---|
| **ZIP ルート直下** | `markdown-c4c/SETUP-WEB.md` / `SETUP-WEB.pdf` | Claude Web に登録した後でも、 ZIP を解凍すれば説明書をオフライン閲覧可能 |
| **リポジトリトップ** | `SETUP-WEB.md` / `SETUP-WEB.pdf` | GitHub 閲覧時に README から直接リンク |
| **docs/ 配下** | `docs/SETUP-WEB.md` / `SETUP-WEB.pdf` | 既存の reference.md などと同じ並びで発見しやすく |
| **skill/ 配下** | `skill/SETUP-WEB.md` / `SETUP-WEB.pdf` | ZIP ビルド時のソース。 install スクリプトで `~/.claude/skills/markdown-c4c/` にも配置される |

### 解説範囲

VS Code Markdown PDF 拡張のセットアップ → settings.json 編集 → ZIP ダウンロード → Claude Web 登録 → スキル発火確認 → 実際の MD/PDF 出力 まで、 **18 枚の画面キャプチャ**（`assets/setup-web/00-17.png`）で説明。 Windows / macOS / Linux 共通の手順で記述。

<h2 id="sec-installer">3. scripts/install.js — クロス OS インストーラ追加</h2>

`bash` も `pwsh` も使わない **Node.js 純正のインストーラ**を新規追加しました。 `fs.cpSync` だけで動くため、 Windows / macOS / Linux で同じ挙動。

### 4 つのインストールルートが揃った

| 方法 | コマンド | 対象 OS |
|:---|:---|:---|
| **Claude Web** | スキル管理画面に `markdown-c4c-v5.1.1.zip` を D&D | 全 OS |
| **npx (Node.js)** | `npx -y . markdown-c4c-skill`（リポ内）または `npm link && markdown-c4c-skill` | 全 OS (Node 16.7+) |
| **シェルスクリプト** | `bash scripts/install.sh`（mac/linux）/ `pwsh scripts/install.ps1`（win） | 全 OS |
| **手動コピー** | `skill/` を `~/.claude/skills/markdown-c4c/` へ | 全 OS |

### package.json の変更

```json
{
  "engines": { "node": ">=16.7.0" },
  "bin": { "markdown-c4c-skill": "./scripts/install.js" },
  "scripts": {
    "install:skill": "node ./scripts/install.js"
  }
}
```

<h2 id="sec-build-zip">4. build-zip スクリプトの PDF 除外ルール変更</h2>

従来の `*.pdf` 一括除外を、 `template-document.pdf` のみ除外に変更しました。 これにより `SETUP-WEB.pdf` のような **説明書 PDF が ZIP に同梱可能**になっています。

### 除外ルール

**変更前（v5.1.0）:**
```bash
--exclude '*.pdf'
```

**変更後（v5.1.1）:**
```bash
--exclude 'template-document.pdf'
```

`scripts/build-zip.sh` / `build-zip.ps1` の両方を更新。 ZIP サイズは 120KB → 4.4MB（SETUP-WEB.pdf 5.3MB 圧縮込）。

<h2 id="sec-cleanup">5. 配布物の整理</h2>

### 削除したもの

- **`markdown-c4c-web-v1.0.0/`** — 旧 Claude Web 配布パッケージ。 v5.1.1 ZIP に統合され役目を終えたため
- **`markdown-c4c-v3.5.0.zip` / `markdown-c4c-v4.0.0.zip`** — 旧バージョン ZIP。 履歴は CHANGELOG.md と RELEASE-vX.X.X.md で追跡可能
- **`bash.exe.stackdump`** — Git Bash クラッシュゴミ

### README.md の参照更新

5 箇所の `markdown-c4c-web-v1.0.0/` 参照を以下に書き換え:

- バッジリンク → `./SETUP-WEB.md`
- ステップ 1 説明 → `markdown-c4c-v5.1.1.zip` を同梱と明記
- PDF セットアップ手順 → `./SETUP-WEB.md` を直接参照
- Repository Structure → `markdown-c4c-v5.1.1.zip` / `SETUP-WEB.md` / `SETUP-WEB.pdf` を明記

<h2 id="sec-tags">6. SKILL.md tags 拡張</h2>

スキル発見性向上のため、 frontmatter tags に 2 つ追加しました:

```yaml
tags:
  - markdown
  - pdf
  - documentation
  - design-system
  - swiss-modern
  - c4c
  - branding
  - vscode
  - markdown-pdf
  - japanese
  - setup-guide         # 追加
  - claude-web          # 追加
```

package.json の keywords も同様に拡張。

<h2 id="sec-upgrade">7. アップグレード手順</h2>

### Claude Code 既存ユーザー

```bash
cd ~/c4c-skill   # または git clone 先
git pull
node ./scripts/install.js
# または: bash scripts/install.sh (mac/linux) / pwsh scripts/install.ps1 (win)
```

新規 `SETUP-WEB.md/pdf` が `~/.claude/skills/markdown-c4c/` にも配置されます。

### Claude Web ユーザー

1. 既存の `markdown-c4c` スキルを Claude Web のサイドバー → カスタマイズ → スキルから削除
2. `markdown-c4c-v5.1.1.zip` をダウンロード
3. 同じ画面に D&D で再登録

旧 v5.1.0 と互換性 100%、 既存 Markdown ドキュメントの再生成は不要です。

---

<div class="closing-message">
  <div class="closing-eyebrow">END OF RELEASE NOTES</div>
  <p class="closing-title">v5.1.1 で「ZIP 一つあれば、説明書も入っている」状態に到達。</p>
  <p class="closing-body">非開発者向けの導入体験が完成しました。 次は v5.2 で複数言語対応とテンプレートエコシステムの再構築に進みます。</p>
  <div class="caption">株式会社C4C　·　markdown-c4c　·　v5.1.1　·　2026-05-25</div>
</div>
