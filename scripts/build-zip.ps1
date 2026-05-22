<#
.SYNOPSIS
  markdown-c4c skill パッケージを Claude Web 互換 ZIP として生成する。

.DESCRIPTION
  - skill/ ディレクトリの内容を ZIP のルート直下フォルダ markdown-c4c/ に格納
  - Anthropic の skill validator が必須とする forward slash `/` セパレータで
    エントリパスを明示構築（Compress-Archive はバックスラッシュを出すため使用禁止）
  - skill name と一致するルートフォルダ名 (markdown-c4c) を強制
  - SKILL.md frontmatter から version を読み取り、出力ファイル名を
    markdown-c4c-v<VERSION>.zip に自動設定
  - __MACOSX / .DS_Store / Thumbs.db / *.pdf / .git は除外
  - 生成後にエントリ名にバックスラッシュが含まれていないか自己検証

.NOTES
  Requires PowerShell 5.1+ / pwsh 7+. Uses .NET System.IO.Compression.
#>

[CmdletBinding()]
param(
    [string]$SourceDir,
    [string]$OutputDir,
    [string]$SkillName = 'markdown-c4c'
)

$ErrorActionPreference = 'Stop'

# Resolve script-relative defaults. $PSScriptRoot may be empty if invoked
# via certain harnesses (e.g. `-File` under PowerShell 5.1), so fall back
# to $MyInvocation, then the current working directory.
if (-not $PSScriptRoot) {
    $scriptRoot = if ($MyInvocation.MyCommand.Path) {
        Split-Path -Parent $MyInvocation.MyCommand.Path
    } else {
        (Get-Location).Path
    }
} else {
    $scriptRoot = $PSScriptRoot
}

if (-not $SourceDir) { $SourceDir = Join-Path $scriptRoot '..\skill' }
if (-not $OutputDir) { $OutputDir = Join-Path $scriptRoot '..' }

function Read-VersionFromSkillMd {
    param([string]$SkillMdPath)
    $content = Get-Content -Path $SkillMdPath -Raw -Encoding UTF8
    if ($content -match '(?m)^version:\s*"?([^"\r\n]+)"?\s*$') {
        return $Matches[1].Trim()
    }
    throw "Could not read version from $SkillMdPath"
}

function Should-Exclude {
    param([string]$RelativePath)
    $excludePatterns = @(
        '__MACOSX',
        '\.DS_Store$',
        'Thumbs\.db$',
        '\.git[\\/]',
        '\.gitignore$',
        '\.pdf$'
    )
    foreach ($pattern in $excludePatterns) {
        if ($RelativePath -match $pattern) { return $true }
    }
    return $false
}

# ─── Resolve paths ────────────────────────────────────────────────────────
$SourceDir = (Resolve-Path $SourceDir).Path
$OutputDir = (Resolve-Path $OutputDir).Path

$skillMdPath = Join-Path $SourceDir 'SKILL.md'
if (-not (Test-Path $skillMdPath)) {
    throw "SKILL.md not found at $skillMdPath"
}

$version = Read-VersionFromSkillMd -SkillMdPath $skillMdPath
Write-Host "[build-zip] Detected version: $version" -ForegroundColor Cyan

$zipFileName = "$SkillName-v$version.zip"
$zipPath = Join-Path $OutputDir $zipFileName

if (Test-Path $zipPath) {
    Write-Host "[build-zip] Removing existing $zipFileName" -ForegroundColor Yellow
    Remove-Item $zipPath -Force
}

# ─── Build ZIP entries manually with forward slashes ──────────────────────
Add-Type -AssemblyName System.IO.Compression
Add-Type -AssemblyName System.IO.Compression.FileSystem

$utf8NoBom = New-Object System.Text.UTF8Encoding($false)
$zipStream = [System.IO.File]::Open($zipPath, [System.IO.FileMode]::CreateNew)
$archive = New-Object System.IO.Compression.ZipArchive($zipStream, [System.IO.Compression.ZipArchiveMode]::Create, $false, $utf8NoBom)

$entryCount = 0
try {
    $files = Get-ChildItem -Path $SourceDir -Recurse -File
    foreach ($file in $files) {
        $rel = $file.FullName.Substring($SourceDir.Length).TrimStart('\','/')
        if (Should-Exclude -RelativePath $rel) {
            Write-Host "[build-zip] Skip: $rel" -ForegroundColor DarkGray
            continue
        }
        # Force forward slashes + force skill-name root
        $entryName = "$SkillName/" + ($rel -replace '\\','/')

        $entry = $archive.CreateEntry($entryName, [System.IO.Compression.CompressionLevel]::Optimal)
        $entryStream = $entry.Open()
        try {
            $sourceStream = [System.IO.File]::OpenRead($file.FullName)
            try {
                $sourceStream.CopyTo($entryStream)
            } finally {
                $sourceStream.Dispose()
            }
        } finally {
            $entryStream.Dispose()
        }
        $entryCount++
    }
} finally {
    $archive.Dispose()
    $zipStream.Dispose()
}

Write-Host "[build-zip] Wrote $entryCount entries to $zipPath" -ForegroundColor Green

# ─── Self-verify ──────────────────────────────────────────────────────────
$verifyArchive = [System.IO.Compression.ZipFile]::OpenRead($zipPath)
try {
    $bad = @($verifyArchive.Entries | Where-Object { $_.FullName -match '\\' })
    if ($bad.Count -gt 0) {
        Write-Host "[build-zip] ERROR: $($bad.Count) entries contain backslashes" -ForegroundColor Red
        $bad | ForEach-Object { Write-Host "  - $($_.FullName)" -ForegroundColor Red }
        throw "ZIP contains backslash entries — Anthropic validator will reject."
    }

    $nonRoot = @($verifyArchive.Entries | Where-Object { -not ($_.FullName.StartsWith("$SkillName/") -or $_.FullName -eq "$SkillName/") })
    if ($nonRoot.Count -gt 0) {
        Write-Host "[build-zip] ERROR: $($nonRoot.Count) entries are not under $SkillName/" -ForegroundColor Red
        $nonRoot | Select-Object -First 5 | ForEach-Object { Write-Host "  - $($_.FullName)" -ForegroundColor Red }
        throw "Entries must all be under $SkillName/ root."
    }

    Write-Host "[build-zip] Verified: all $($verifyArchive.Entries.Count) entries use '/' under $SkillName/" -ForegroundColor Green
    Write-Host ""
    Write-Host "Output: $zipPath" -ForegroundColor Cyan
    Write-Host "Size:   $([Math]::Round((Get-Item $zipPath).Length / 1KB, 1)) KB" -ForegroundColor Cyan
} finally {
    $verifyArchive.Dispose()
}
