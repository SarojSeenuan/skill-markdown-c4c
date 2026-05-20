<head>
<title>ドキュメントタイトル</title>
</head>

# ドキュメントタイトル

<div class="caption">Author: 担当者名　·　Version: v1.0　·　Date: 2026-05-21</div>

<nav class="toc">
  <h2>Index</h2>
  <ol>
    <li><a href="#sec-overview">概要</a><span class="dots"></span><span class="page">2</span></li>
    <li><a href="#sec-background">背景</a><span class="dots"></span><span class="page">3</span></li>
    <li><a href="#sec-proposal">ご提案内容</a><span class="dots"></span><span class="page">5</span></li>
    <li><a href="#sec-plan">スケジュール</a><span class="dots"></span><span class="page">8</span></li>
    <li><a href="#sec-cost">見積もり</a><span class="dots"></span><span class="page">10</span></li>
    <li><a href="#sec-appendix">付録</a><span class="dots"></span><span class="page">12</span></li>
  </ol>
</nav>

<h2 id="sec-overview">1. 概要</h2>

##### EXECUTIVE SUMMARY

本書は <span class="brand">株式会社C4C</span> がご提案する <mark>○○プロジェクト</mark>の全体像をまとめたものです。

<div class="callout callout-tip">
<p><strong>本書の目的。</strong>意思決定に必要な情報を 1 ドキュメントで提供します。詳細仕様は付録を参照してください。</p>
</div>

### 1.1 主要ポイント

- ポイント A
- ポイント B
- ポイント C

<h2 id="sec-background">2. 背景</h2>

現状の課題を整理します。

| 項目 | 現状 | 課題 |
|:---:|:---|:---|
| 業務効率 | 手作業中心 | 工数増加・属人化 |
| 情報共有 | メール・口頭 | 履歴が残らない |
| 品質管理 | チェックリストのみ | 抜け漏れ発生 |

<hr class="divider-dot-line">

### 2.1 ステークホルダー

<dl>
  <dt>事業責任者</dt>
  <dd>意思決定・予算承認・KPI 設定</dd>
  <dt>現場担当者</dt>
  <dd>業務遂行・要件整理・テスト</dd>
  <dt>システム部門</dt>
  <dd>導入支援・運用保守</dd>
</dl>

<h2 id="sec-proposal">3. ご提案内容</h2>

##### CORE SOLUTION

<div class="shape-box shape-brand">
<p><strong>提案コンセプト。</strong>○○を△△で実現することにより、現状の課題を一気に解消します。</p>
</div>

### 3.1 機能一覧

<table class="with-v-lines">
<thead>
<tr><th>機能カテゴリ</th><th align="left">機能名</th><th align="center">優先度</th><th align="right">開発工数</th></tr>
</thead>
<tbody>
<tr><td>認証</td><td>SSO 連携</td><td align="center">A</td><td align="right">5d</td></tr>
<tr><td>ダッシュボード</td><td>KPI 可視化</td><td align="center">A</td><td align="right">8d</td></tr>
<tr><td>レポート</td><td>PDF 出力</td><td align="center">B</td><td align="right">3d</td></tr>
<tr><td>通知</td><td>Slack 連携</td><td align="center">B</td><td align="right">2d</td></tr>
</tbody>
</table>

<hr class="divider-dot-brand">

### 3.2 アーキテクチャ

<div class="shape-box" data-title="SYSTEM ARCHITECTURE">
<p><img src="file:///path/to/architecture.png" alt="アーキテクチャ図" style="max-width:100%;margin:0 auto 12px auto;"></p>
<p><strong>3 層構成</strong>　·　フロントエンド (Next.js) ／ API (FastAPI) ／ DB (PostgreSQL) のマイクロサービス。<mark class="brand">スケーラビリティ</mark>を最優先にした構成です。</p>
</div>

<div class="callout callout-info">
<p><strong>採用理由。</strong>Next.js + FastAPI は社内で運用実績があり、エンジニア確保も容易です。</p>
</div>

<h2 id="sec-plan">4. スケジュール</h2>

| Phase | 期間 | 主要マイルストーン |
|:---:|:---:|:---|
| 要件定義 | M1 | 要件定義書・画面遷移図完成 |
| 設計 | M2-M3 | API 設計書・DB 設計書完成 |
| 実装 | M4-M6 | α 版完成 |
| テスト | M7 | UAT 完了 |
| 本番リリース | M8 | カットオーバー |

<div class="callout callout-warning">
<p><strong>留意点。</strong>連休期間中は開発進捗が想定より遅れる可能性があります。バッファとして 2 週間を見込んでいます。</p>
</div>

<h2 id="sec-cost">5. 見積もり</h2>

<table class="compact">
<thead>
<tr><th align="left">項目</th><th align="right">人月</th><th align="right">単価</th><th align="right">小計</th></tr>
</thead>
<tbody>
<tr><td>要件定義</td><td align="right">1.0</td><td align="right">¥1,000,000</td><td align="right">¥1,000,000</td></tr>
<tr><td>設計</td><td align="right">2.0</td><td align="right">¥1,000,000</td><td align="right">¥2,000,000</td></tr>
<tr><td>実装</td><td align="right">4.0</td><td align="right">¥900,000</td><td align="right">¥3,600,000</td></tr>
<tr><td>テスト</td><td align="right">1.5</td><td align="right">¥800,000</td><td align="right">¥1,200,000</td></tr>
<tr><td><strong>合計</strong></td><td align="right"><strong>8.5</strong></td><td align="right">—</td><td align="right"><strong>¥7,800,000</strong></td></tr>
</tbody>
</table>

<p class="caption">税抜・諸経費別</p>

<div class="callout callout-danger">
<p><strong>注意。</strong>本見積もりは仮見積もりです。要件定義完了後に再見積もりを実施します。</p>
</div>

<h2 id="sec-appendix">6. 付録</h2>

### 6.1 用語集

| 用語 | 説明 |
|:---|:---|
| SSO | Single Sign-On。1 度の認証で複数システムにログインできる仕組み |
| KPI | Key Performance Indicator。重要業績評価指標 |
| UAT | User Acceptance Test。ユーザー受入テスト |

### 6.2 参考リンク

- [株式会社C4C 公式サイト](https://example.com)
- [前回のプロジェクト報告書](https://example.com/report)

<hr class="divider-brand">

<p class="center muted">— END OF DOCUMENT —</p>
