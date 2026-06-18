@echo off
setlocal enabledelayedexpansion

REM ============================================
REM render-batch-ltx.bat
REM Batch render 4-shot LTX video via ComfyUI API.
REM
REM Usage:
REM   render-batch-ltx.bat <project-dir> [--dry-run]
REM
REM Examples:
REM   render-batch-ltx.bat F:\ProjectClipsAI\projects\project-001 --dry-run
REM   render-batch-ltx.bat F:\ProjectClipsAI\projects\project-001
REM ============================================

set PROJECT_DIR=%~1
set DRY_RUN=0

if "%PROJECT_DIR%"=="" (
    echo USAGE: render-batch-ltx.bat ^<project-dir^> [--dry-run]
    echo EXAMPLE: render-batch-ltx.bat F:\ProjectClipsAI\projects\project-001 --dry-run
    exit /b 1
)

if "%2"=="--dry-run" set DRY_RUN=1
if "%2"=="--dry-run" echo *** DRY RUN MODE — No actual rendering *** & echo.

REM — Paths
set WORKFLOW=F:\ProjectClipsAI\workflows\comfyui\first-video\first-video-002.json
set COMFYUI_ROOT=C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI
set COMFYUI_OUTPUT=%COMFYUI_ROOT%\output
set COMFYUI_INPUT=%COMFYUI_ROOT%\input
set PYTHON=C:\Users\prinya\AppData\Local\Programs\Python\Python312\python.exe

set PROJECT_OUTPUTS=%PROJECT_DIR%\outputs
set PROJECT_REPORTS=%PROJECT_DIR%\reports

REM — Create output dirs
if not exist "%PROJECT_OUTPUTS%" mkdir "%PROJECT_OUTPUTS%"
if not exist "%PROJECT_REPORTS%" mkdir "%PROJECT_REPORTS%"

REM — Validate workflow
if not exist "%WORKFLOW%" (
    echo [ERROR] Workflow not found: %WORKFLOW%
    exit /b 1
)

REM — Shot definitions (default 4-shot layout)
REM Edit or provide shot-manifest.json for custom shots
set SHOTS=4
set SEED_1=101
set SEED_2=202
set SEED_3=303
set SEED_4=404

set PROMPT_1=cinematic drone flight above agricultural campus, gentle forward movement, trees swaying naturally, subtle fog, mountains in background, realistic aerial documentary footage, photorealistic, natural lighting
set PROMPT_2=smooth drone descent toward lush green rice terraces, agricultural research plots, rows of crops gently swaying, morning sunlight breaking through mist, documentary cinematography style, natural colors, gentle downward camera movement
set PROMPT_3=close-up shot of smart agriculture monitoring station in rice field, sensor equipment among green plants, IoT antennas, educational documentary aesthetic, clean crisp lighting, slight camera orbit
set PROMPT_4=golden hour wide shot of agricultural campus, warm sunset light over terraced fields, mountains in background with soft haze, peaceful countryside atmosphere, slow cinematic crane rise, photorealistic, warm color grading

set NEGATIVE=blurry, low quality, distorted, ugly, deformed, fast motion, jittery, flickering, bad anatomy, character, person, human, face, warping, morphing, artifacts, noise

REM — Log file
set LOG_FILE=%PROJECT_REPORTS%\render-log.md

echo ========================================
echo BATCH RENDER — LTX Video 2B
echo Project: %PROJECT_DIR%
echo Shots: %SHOTS%
echo Dry Run: %DRY_RUN%
echo ========================================
echo.

REM — Write log header
if %DRY_RUN%==0 (
    echo # Render Log > "%LOG_FILE%"
    echo. >> "%LOG_FILE%"
    echo ## Project: %PROJECT_DIR% >> "%LOG_FILE%"
    echo. >> "%LOG_FILE%"
    echo ^| Shot ^| Seed ^| Start ^| End ^| Duration ^| File ^| Size ^| Status ^| >> "%LOG_FILE%"
    echo ^|------^|------^|-------^|-----^|----------^|------^|------^|--------^| >> "%LOG_FILE%"
)

REM — Check if ComfyUI is running
echo [CHECK] Testing ComfyUI API connectivity...
powershell -Command "try { $r=Invoke-RestMethod -Uri 'http://127.0.0.1:8188/' -Method GET -TimeoutSec 5 -ErrorAction Stop; Write-Output 'OK' } catch { Write-Output 'DOWN' }" > "%TEMP%\comfyui_status.txt"
set /p COMFYUI_STATUS=<%TEMP%\comfyui_status.txt

if "%COMFYUI_STATUS%"=="DOWN" (
    if %DRY_RUN%==1 (
        echo [DRY RUN] ComfyUI is DOWN — would need to start it:
        echo   cmd /c "cd /d %COMFYUI_ROOT% && %PYTHON% main.py --listen 127.0.0.1 --port 8188"
        echo.
    ) else (
        echo [WARN] ComfyUI is not running. Attempting to start...
        start "" cmd /c "cd /d %COMFYUI_ROOT% && %PYTHON% main.py --listen 127.0.0.1 --port 8188"
        echo [INFO] Waiting 30s for startup...
        timeout /t 30 /nobreak >nul
    )
) else (
    echo [PASS] ComfyUI API is reachable at http://127.0.0.1:8188
)

echo.

REM — Validate input image
if not exist "%COMFYUI_INPUT%\first-render-001.png" (
    echo [ERROR] Input image not found: %COMFYUI_INPUT%\first-render-001.png
    echo [INFO] Copy your source image to ComfyUI input:
    echo   copy ^<your-image^> %COMFYUI_INPUT%\first-render-001.png
    exit /b 1
) else (
    echo [PASS] Input image: %COMFYUI_INPUT%\first-render-001.png
)

echo.

REM — Render loop
for /l %%N in (1,1,%SHOTS%) do (
    setlocal
    set SHOT_ID=Shot0%%N
    set SEED_VAL=!SEED_%%N!
    set PROMPT_VAL=!PROMPT_%%N!

    echo ----------------------------------------
    echo [%%N/%SHOTS%] !SHOT_ID!
    echo Seed: !SEED_VAL!
    echo Prompt: !PROMPT_VAL!
    echo ----------------------------------------

    if !DRY_RUN!==1 (
        echo [DRY RUN] Would submit API request:
        echo   POST http://127.0.0.1:8188/prompt
        echo   Workflow: %WORKFLOW%
        echo   Filename prefix: !SHOT_ID!
        echo.
    ) else (
        echo [RENDER] Submitting shot...

        REM — Build and submit via PowerShell
        powershell -Command "& {
            $wf = Get-Content '%WORKFLOW%' -Raw | ConvertFrom-Json
            $wf.'4'.inputs.text = '!PROMPT_VAL!'
            $wf.'5'.inputs.text = '%NEGATIVE%'
            $wf.'7'.inputs.seed = !SEED_VAL!
            $wf.'10'.inputs.filename_prefix = '!SHOT_ID!'
            $body = @{prompt = $wf} | ConvertTo-Json -Depth 10
            $response = Invoke-RestMethod -Uri 'http://127.0.0.1:8188/prompt' -Method POST -Body $body -ContentType 'application/json' -ErrorAction Stop
            Write-Output $response.prompt_id
        }" > %TEMP%\shot_prompt_id.txt
        set /p PROMPT_ID=<%TEMP%\shot_prompt_id.txt
        echo [INFO] Prompt ID: !PROMPT_ID!

        REM — Wait for completion
        echo [WAIT] Rendering... (estimated ~120s)
        set START_TIME=%TIME%
        :waitloop
        timeout /t 10 /nobreak >nul
        powershell -Command "& {
            $h = Invoke-RestMethod -Uri 'http://127.0.0.1:8188/history/!PROMPT_ID!' -Method GET -ErrorAction SilentlyContinue
            if ($h.'!PROMPT_ID!'.status.completed) { Write-Output 'COMPLETE'; exit }
            if ($h.'!PROMPT_ID!'.status.failed) { Write-Output 'FAILED'; exit }
            Write-Output 'WAITING'
        }" > %TEMP%\shot_status.txt
        set /p STATUS=<%TEMP%\shot_status.txt
        if "!STATUS!"=="COMPLETE" goto shotdone
        if "!STATUS!"=="FAILED" (
            echo [ERROR] Shot !SHOT_ID! FAILED
            goto shotdone
        )
        goto waitloop
        :shotdone

        set END_TIME=%TIME%
        echo [DONE] !SHOT_ID! finished

        REM — Copy output to project
        for %%f in ("%COMFYUI_OUTPUT%\!SHOT_ID!_*.mp4") do (
            set OUTPUT_FILE=%%f
            set OUTPUT_SIZE=%%~zf
        )
        copy "!OUTPUT_FILE!" "%PROJECT_OUTPUTS%\!SHOT_ID!.mp4" >nul
        echo [COPY] !OUTPUT_FILE! -^> %PROJECT_OUTPUTS%\!SHOT_ID!.mp4

        REM — Log entry
        echo ^| !SHOT_ID! ^| !SEED_VAL! ^| !START_TIME! ^| !END_TIME! ^| ... ^| !SHOT_ID!.mp4 ^| !OUTPUT_SIZE! ^| OK ^| >> "%LOG_FILE%"
    )
    endlocal
)

echo.
echo ========================================
if %DRY_RUN%==1 (
    echo DRY RUN COMPLETE — No rendering performed
) else (
    echo BATCH RENDER COMPLETE
    echo Log: %LOG_FILE%
)
echo ========================================
exit /b 0
