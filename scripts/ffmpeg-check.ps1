<#
.SYNOPSIS
    Check FFmpeg availability and key capabilities.
.DESCRIPTION
    Verifies FFmpeg is installed, checks version, and tests basic functionality.
#>

$ErrorActionPreference = "Continue"

Write-Host "+----------------------------------------------+" -ForegroundColor Cyan
Write-Host "|       ProjectClipsAI -- FFmpeg Check         |" -ForegroundColor Cyan
Write-Host "+----------------------------------------------+" -ForegroundColor Cyan
Write-Host ""

# Check FFmpeg
try {
    $ffver = ffmpeg -version 2>&1 | Select-Object -First 1
    if ($ffver) {
        Write-Host "[OK] FFmpeg found:" -ForegroundColor Green
        Write-Host "      $($ffver.Trim())" -ForegroundColor Gray
    } else {
        Write-Host "[FAIL] FFmpeg not found in PATH" -ForegroundColor Red
        Write-Host ""
        Write-Host "Install FFmpeg:" -ForegroundColor Yellow
        Write-Host "  1. Download from https://ffmpeg.org/download.html" -ForegroundColor Gray
        Write-Host "  2. Extract to a folder (e.g., C:\ffmpeg)" -ForegroundColor Gray
        Write-Host "  3. Add to system PATH" -ForegroundColor Gray
        Write-Host "  4. Restart terminal and run this script again" -ForegroundColor Gray
        exit 1
    }
} catch {
    Write-Host "[FAIL] FFmpeg not found in PATH" -ForegroundColor Red
    exit 1
}

# Check encoders
Write-Host ""
Write-Host "[*] Checking encoders..." -ForegroundColor Yellow
$encoders = ffmpeg -encoders 2>&1

$checks = @{
    "libx264"   = "H.264 video encoder"
    "libx265"   = "H.265/HEVC video encoder"
    "aac"       = "AAC audio encoder"
}

foreach ($enc in $checks.Keys) {
    $found = $encoders -match "^.*\s$enc\s"
    if ($found) {
        Write-Host "  [OK] $($checks[$enc])" -ForegroundColor Green
    } else {
        Write-Host "  [!!] $($checks[$enc]) -- NOT FOUND" -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "[OK] FFmpeg check complete" -ForegroundColor Cyan
