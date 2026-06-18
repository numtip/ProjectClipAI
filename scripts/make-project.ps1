<#
.SYNOPSIS
    Create a new numbered project folder with standard structure.
.DESCRIPTION
    Creates a sequential project folder under projects/ with brief.md,
    storyboard.md, prompts.md, render-notes.md, and subfolders.
.PARAMETER Name
    Short name for the project (e.g. "my-cool-clip").
.PARAMETER Description
    Optional one-line description for brief.md.
.EXAMPLE
    .\scripts\make-project.ps1 -Name "my-cool-clip" -Description "A clip about space"
#>

param(
    [Parameter(Mandatory=$true)]
    [string]$Name,

    [Parameter(Mandatory=$false)]
    [string]$Description = ""
)

$ErrorActionPreference = "Stop"
$projectRoot = "F:\ProjectClipsAI\projects"

$existing = Get-ChildItem $projectRoot -Directory | Where-Object { $_.Name -match '^[0-9]+-' }
$nextNum = 1
if ($existing) {
    $maxNum = 0
    foreach ($d in $existing) {
        $parts = $d.Name -split '-'
        $num = [int]$parts[0]
        if ($num -gt $maxNum) { $maxNum = $num }
    }
    $nextNum = $maxNum + 1
}

$padded = $nextNum.ToString()
while ($padded.Length -lt 3) { $padded = "0" + $padded }
$folderName = $padded + "-" + $Name
$folderPath = Join-Path $projectRoot $folderName

Write-Host "Creating project: $folderName" -ForegroundColor Cyan
Write-Host ""

New-Item -ItemType Directory -Path (Join-Path $folderPath "assets") -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $folderPath "outputs") -Force | Out-Null
New-Item -ItemType Directory -Path (Join-Path $folderPath "exports") -Force | Out-Null

$brief = @"
# Project $folderName

**Status:** planned
**Duration:** TBD
**Shots:** TBD
**Resolution:** 720p
**Final Format:** MP4

## Concept

$Description

## Constraints

- Image-to-video pipeline
- Per FIRST_CLIP_SPRINT.md guidelines
"@

$storyboard = @"
# Storyboard: $folderName

**Project:** $folderName
**Total Duration:** TBD

---

### Shot 1

| Field | Value |
|-------|-------|
| Duration | 5s |
| Scene | |
| Subject | |
| Style | |
| Camera | |
| Lighting | |
| Motion | |
"@

$prompts = @"
# Prompts: $folderName

**Project:** $folderName

## Shot 1 - Image Prompt

```
Scene:
Subject:
Style:
Camera:
Lighting:
Negative:
Aspect Ratio: 16:9
```

## Shot 1 - Video Motion Prompt

```
Scene:
Subject:
Style:
Camera:
Lighting:
Motion:
Negative:
Duration: 5
Aspect Ratio: 16:9
```
"@

$renderNotes = @"
# Render Notes: $folderName

**Project:** $folderName

## Overview

| Field | Value |
|-------|-------|
| Pipeline | Image-to-Video |
| Model | |
| Resolution | 720p |

## Render Log

| Attempt | Date | Settings | Output | Issues |
|---------|------|----------|--------|--------|
| - | - | - | - | - |
"@

$brief | Out-File -FilePath (Join-Path $folderPath "brief.md") -Encoding default
$storyboard | Out-File -FilePath (Join-Path $folderPath "storyboard.md") -Encoding default
$prompts | Out-File -FilePath (Join-Path $folderPath "prompts.md") -Encoding default
$renderNotes | Out-File -FilePath (Join-Path $folderPath "render-notes.md") -Encoding default

" " | Out-File -FilePath (Join-Path (Join-Path $folderPath "assets") ".gitkeep") -Encoding default
" " | Out-File -FilePath (Join-Path (Join-Path $folderPath "outputs") ".gitkeep") -Encoding default
" " | Out-File -FilePath (Join-Path (Join-Path $folderPath "exports") ".gitkeep") -Encoding default

Write-Host "[OK] Project $folderName created" -ForegroundColor Green
Write-Host "     $folderPath" -ForegroundColor Gray
Write-Host ""
Write-Host "Update registry/PROJECT_REGISTRY.md with this project." -ForegroundColor Gray
