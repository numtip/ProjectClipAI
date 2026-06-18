param(
    [Parameter(Mandatory=$true)]
    [string]$ProjectDir,
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

# Paths
$WORKFLOW = "F:\ProjectClipsAI\workflows\comfyui\first-video\first-video-002.json"
$COMFYUI_ROOT = "C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI"
$COMFYUI_INPUT = "$COMFYUI_ROOT\input"
$COMFYUI_OUTPUT = "$COMFYUI_ROOT\output"
$PYTHON = "C:\Users\prinya\AppData\Local\Programs\Python\Python312\python.exe"
$PROJECT_OUTPUTS = "$ProjectDir\outputs"
$PROJECT_REPORTS = "$ProjectDir\reports"
$LOG_FILE = "$PROJECT_REPORTS\render-log.md"

# Shot config
$SHOTS = 4
$SEEDS = @(101, 202, 303, 404)
$PROMPTS = @(
    "slow cinematic drone push forward over green agricultural fields, camera at low altitude revealing trees and landscape, tree canopy gently swaying in breeze, distant mountain ridgeline visible through morning haze, documentary aerial cinematography, photorealistic, natural daylight",
    "slow vertical descent of camera toward green terraced rice fields, rows of crops becoming larger as camera descends, morning light filtering through ground mist, documentary drone cinematography, natural muted green and gold tones, photorealistic",
    "close-up camera orbit around a metal monitoring post in a green rice field, scientific equipment surrounded by tall green plants, clear blue sky visible between plants, steady circular camera movement, documentary style, sharp clean lighting, photorealistic",
    "slow cinematic upward camera rise revealing wide landscape at golden hour, terraced green fields bathed in orange sunset light, mountain silhouette against warm sky, long shadows stretching across farmland, documentary final scene, photorealistic, rich golden warm tones"
)
$NEGATIVE = "blurry, low quality, distorted, ugly, deformed, fast motion, jittery, flickering, strobing, bad anatomy, character, person, human, face, hands, warping, morphing, geometric distortion, dissolving, artifacts, noise, grain, compression blocks, text, watermark, logo, subtitle, caption, overexposed, underexposed, flat lighting, camera shake, handheld wobble, unstable horizon, duplicate objects, extra limbs, double exposure"

# Stats
$script:TotalRenderSeconds = 0
$script:RenderTimes = @{}
$script:ErrorList = @()
$script:RetryCount = 0

# Create dirs
New-Item -ItemType Directory -Force -Path $PROJECT_OUTPUTS | Out-Null
New-Item -ItemType Directory -Force -Path $PROJECT_REPORTS | Out-Null

# Validate
if (-not (Test-Path $WORKFLOW)) { Write-Host "[ERROR] Workflow not found"; exit 1 }
if (-not (Test-Path "$COMFYUI_INPUT\first-render-001.png")) { Write-Host "[ERROR] Input image not found"; exit 1 }

Write-Host "========================================"
Write-Host "BATCH RENDER - LTX Video 2B"
Write-Host "Project: $ProjectDir"
Write-Host "Shots: $SHOTS"
Write-Host "Dry Run: $DryRun"
Write-Host "========================================"
Write-Host ""

# Check ComfyUI
Write-Host "[CHECK] Testing ComfyUI API..."
try {
    $null = Invoke-RestMethod -Uri 'http://127.0.0.1:8188/' -Method GET -TimeoutSec 5 -ErrorAction Stop
    Write-Host "[PASS] ComfyUI API reachable"
} catch {
    if ($DryRun) { Write-Host "[DRY RUN] ComfyUI would need start" }
    else {
        Write-Host "[WARN] Starting ComfyUI..."
        Start-Process -NoNewWindow -FilePath "cmd.exe" -ArgumentList "/c cd /d `"$COMFYUI_ROOT`" && `"$PYTHON`" main.py --listen 127.0.0.1 --port 8188"
        Write-Host "[INFO] Waiting 30s..."
        Start-Sleep -Seconds 30
    }
}

Write-Host "[PASS] Input image: first-render-001.png"
Write-Host ""

# Log header
$logHeader = @"
# Render Log

## Project: $ProjectDir

| Shot | Seed | Start | End | Duration | File | Size | Status |
|------|------|-------|-----|----------|------|------|--------|
"@
if (-not $DryRun) { Set-Content -Path $LOG_FILE -Value $logHeader }

# Render loop
for ($i = 0; $i -lt $SHOTS; $i++) {
    $n = $i + 1
    $shotId = "Shot0$n"
    $seed = $SEEDS[$i]
    $prompt = $PROMPTS[$i]

    Write-Host "----------------------------------------"
    Write-Host "[$n/$SHOTS] $shotId"
    Write-Host "Seed: $seed"
    Write-Host "----------------------------------------"

    if ($DryRun) {
        Write-Host "[DRY RUN] Would render: $shotId"
        Write-Host ""
        continue
    }

    $retries = 0
    $success = $false

    while (($retries -le 2) -and (-not $success)) {
        if ($retries -gt 0) {
            Write-Host "[RETRY $retries/2] Re-submitting $shotId..."
            $script:RetryCount++
        }

        $startTime = Get-Date

        try {
            $wf = Get-Content $WORKFLOW -Raw | ConvertFrom-Json
            $wf.'4'.inputs.text = $prompt
            $wf.'5'.inputs.text = $NEGATIVE
            $wf.'7'.inputs.seed = $seed
            $wf.'10'.inputs.filename_prefix = $shotId
            $body = @{prompt = $wf} | ConvertTo-Json -Depth 10

            Write-Host "[RENDER] Submitting..."
            $resp = Invoke-RestMethod -Uri 'http://127.0.0.1:8188/prompt' -Method POST -Body $body -ContentType 'application/json' -ErrorAction Stop
            $promptId = $resp.prompt_id
            Write-Host "[INFO] Prompt ID: $promptId"

            Write-Host "[WAIT] Rendering... (~120s)"
            $t0 = Get-Date

            do {
                Start-Sleep -Seconds 10
                try {
                    $h = Invoke-RestMethod -Uri "http://127.0.0.1:8188/history/$promptId" -Method GET -ErrorAction SilentlyContinue
                    if ($h.$promptId.status.completed) { $success = $true; break }
                    if ($h.$promptId.status.failed) { Write-Host "[ERROR] $shotId FAILED"; break }
                } catch { }
            } while ($true)

            $t1 = Get-Date
            $dur = ($t1 - $t0).TotalSeconds
            $script:TotalRenderSeconds += $dur
            $script:RenderTimes[$shotId] = $dur

            if ($success) {
                $outFile = Get-ChildItem "$COMFYUI_OUTPUT\${shotId}_*.mp4" | Sort-Object LastWriteTime -Descending | Select-Object -First 1
                if ($outFile) {
                    Copy-Item $outFile.FullName "$PROJECT_OUTPUTS\$shotId.mp4" -Force
                    $kb = [math]::Round($outFile.Length / 1KB)
                    Write-Host "[COPY] -> $PROJECT_OUTPUTS\$shotId.mp4 ($kb KB)"
                    $endStr = $t1.ToString('HH:mm:ss')
                    $entry = "| $shotId | $seed | $($t0.ToString('HH:mm:ss')) | $endStr | $('{0:N1}s' -f $dur) | $shotId.mp4 | ${kb}KB | OK |"
                    Add-Content -Path $LOG_FILE -Value $entry
                }
            }
        } catch {
            $msg = $_.Exception.Message
            Write-Host "[ERROR] $msg"
            $script:ErrorList += "$shotId : $msg"
        }

        if (-not $success) { $retries++ }
    }
}

Write-Host ""
Write-Host "========================================"
if ($DryRun) {
    Write-Host "DRY RUN COMPLETE"
} else {
    Write-Host "BATCH RENDER COMPLETE"
    Write-Host "Log: $LOG_FILE"
    Write-Host "Total render: $('{0:N1}s' -f $script:TotalRenderSeconds)"
    Write-Host "Retries: $script:RetryCount"
    if ($script:ErrorList.Count -gt 0) {
        Write-Host "Errors:"
        $script:ErrorList | ForEach-Object { Write-Host "  - $_" }
    }
}
Write-Host "========================================"

# Save stats
$stats = @{
    TotalRenderSeconds = $script:TotalRenderSeconds
    RenderTimes = $script:RenderTimes
    ErrorList = $script:ErrorList
    RetryCount = $script:RetryCount
}
$stats | ConvertTo-Json | Set-Content "$ProjectDir\reports\render-stats.json"
