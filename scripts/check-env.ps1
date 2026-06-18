<#
.SYNOPSIS
    Check environment prerequisites for ProjectClipsAI.
.DESCRIPTION
    Verifies Windows version, GPU, VRAM, FFmpeg, Git, Python, and Node.
    Reports issues but does not fail hard -- all checks are advisory.
#>

$ErrorActionPreference = "Continue"
$results = @()

Write-Host "+----------------------------------------------+" -ForegroundColor Cyan
Write-Host "|   ProjectClipsAI -- Environment Check        |" -ForegroundColor Cyan
Write-Host "+----------------------------------------------+" -ForegroundColor Cyan
Write-Host ""

# 1. Windows Version
Write-Host "[*] Windows Version:" -ForegroundColor Yellow -NoNewline
try {
    $os = Get-CimInstance -ClassName Win32_OperatingSystem
    Write-Host " $($os.Caption) ($($os.Version))" -ForegroundColor Green
    $results += "PASS: Windows $($os.Version)"
} catch {
    Write-Host " Unable to detect" -ForegroundColor Red
    $results += "FAIL: Could not detect Windows version"
}

# 2. GPU / nvidia-smi
Write-Host "[*] NVIDIA GPU:" -ForegroundColor Yellow -NoNewline
try {
    $nvidia = nvidia-smi --query-gpu=name,memory.total --format=csv,noheader 2>$null
    if ($nvidia) {
        Write-Host " Found" -ForegroundColor Green
        $nvidia | ForEach-Object { Write-Host "   $_" }
        $results += "PASS: GPU detected"
    } else {
        Write-Host " Not found" -ForegroundColor Red
        $results += "WARN: No NVIDIA GPU detected (nvidia-smi returned nothing)"
    }
} catch {
    Write-Host " Not found" -ForegroundColor Red
    $results += "WARN: nvidia-smi not available. NVIDIA driver may not be installed."
}

# 3. VRAM
Write-Host "[*] VRAM Check:" -ForegroundColor Yellow -NoNewline
try {
    $vram = nvidia-smi --query-gpu=memory.total --format=csv,noheader 2>$null
    if ($vram) {
        Write-Host " $($vram.Trim())" -ForegroundColor Green
        $results += "PASS: VRAM $($vram.Trim())"
    } else {
        Write-Host " Unable to check" -ForegroundColor Red
        $results += "WARN: Could not determine VRAM"
    }
} catch {
    Write-Host " Unable to check" -ForegroundColor Red
    $results += "WARN: Could not determine VRAM"
}

# 4. FFmpeg
Write-Host "[*] FFmpeg:" -ForegroundColor Yellow -NoNewline
try {
    $ffver = ffmpeg -version 2>&1 | Select-Object -First 1
    if ($ffver) {
        Write-Host " $($ffver.Trim())" -ForegroundColor Green
        $results += "PASS: FFmpeg available"
    } else {
        Write-Host " Not found" -ForegroundColor Red
        $results += "WARN: FFmpeg not in PATH"
    }
} catch {
    Write-Host " Not found" -ForegroundColor Red
    $results += "WARN: FFmpeg not in PATH"
}

# 5. Git
Write-Host "[*] Git:" -ForegroundColor Yellow -NoNewline
try {
    $gitver = git --version 2>&1
    if ($gitver) {
        Write-Host " $($gitver.Trim())" -ForegroundColor Green
        $results += "PASS: Git available"
    } else {
        Write-Host " Not found" -ForegroundColor Red
        $results += "WARN: Git not in PATH"
    }
} catch {
    Write-Host " Not found" -ForegroundColor Red
    $results += "WARN: Git not in PATH"
}

# 6. Python
Write-Host "[*] Python:" -ForegroundColor Yellow -NoNewline
try {
    $pyver = python --version 2>&1
    if ($pyver) {
        Write-Host " $($pyver.Trim())" -ForegroundColor Green
        $results += "PASS: Python available"
    } else {
        Write-Host " Not found" -ForegroundColor Red
        $results += "WARN: Python not in PATH"
    }
} catch {
    Write-Host " Not found" -ForegroundColor Red
    $results += "WARN: Python not in PATH"
}

# 7. Node
Write-Host "[*] Node.js:" -ForegroundColor Yellow -NoNewline
try {
    $nodever = node --version 2>&1
    if ($nodever) {
        Write-Host " $($nodever.Trim())" -ForegroundColor Green
        $results += "PASS: Node.js available"
    } else {
        Write-Host " Not found" -ForegroundColor Yellow
        $results += "INFO: Node.js not in PATH (optional)"
    }
} catch {
    Write-Host " Not found" -ForegroundColor Yellow
    $results += "INFO: Node.js not in PATH (optional)"
}

Write-Host ""
Write-Host "+----------------------------------------------+" -ForegroundColor Cyan
Write-Host "|                 Results                      |" -ForegroundColor Cyan
Write-Host "+----------------------------------------------+" -ForegroundColor Cyan

$passCount = 0
$warnCount = 0
foreach ($r in $results) {
    if ($r -match "^PASS:") {
        $passCount++
        Write-Host "  [OK] $r" -ForegroundColor Green
    } elseif ($r -match "^WARN:") {
        $warnCount++
        Write-Host "  [!!] $r" -ForegroundColor Yellow
    } elseif ($r -match "^INFO:") {
        Write-Host "  [i] $r" -ForegroundColor Gray
    } else {
        Write-Host "  [XX] $r" -ForegroundColor Red
    }
}

Write-Host ""
Write-Host "Passed: $passCount | Warnings: $warnCount | Total: $($results.Count)" -ForegroundColor Cyan
Write-Host ""
Write-Host "Environment check completed. All checks are advisory." -ForegroundColor Gray
