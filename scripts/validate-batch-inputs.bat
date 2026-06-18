@echo off
setlocal enabledelayedexpansion

REM ============================================
REM validate-batch-inputs.bat
REM Validate project folder before batch render.
REM Usage: validate-batch-inputs.bat <project-dir>
REM ============================================

set PROJECT_DIR=%~1
if "%PROJECT_DIR%"=="" (
    echo USAGE: validate-batch-inputs.bat ^<project-dir^>
    echo EXAMPLE: validate-batch-inputs.bat F:\ProjectClipsAI\projects\phase3-first-multishot
    exit /b 1
)

echo ========================================
echo BATCH INPUT VALIDATOR
echo Project: %PROJECT_DIR%
echo ========================================
echo.

set ALL_PASS=1

REM 1 — Check project folder exists
if exist "%PROJECT_DIR%" (
    echo [PASS] Project folder: %PROJECT_DIR%
) else (
    echo [FAIL] Project folder NOT found: %PROJECT_DIR%
    set ALL_PASS=0
)

REM 2 — Check input image (check assets or output source)
if exist "%PROJECT_DIR%\assets\key-image.png" (
    echo [PASS] Source image: %PROJECT_DIR%\assets\key-image.png
) else if exist "%PROJECT_DIR%\..\..\..\ComfyUI\input\first-render-001.png" (
    echo [PASS] Source image: ComfyUI\input\first-render-001.png (global)
) else if exist "C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\input\first-render-001.png" (
    echo [PASS] Source image: ComfyUI\input\first-render-001.png (absolute)
) else (
    echo [WARN] Source image not found in project or global ComfyUI input
)

REM 3 — Check workflow JSON exists
if exist "F:\ProjectClipsAI\workflows\comfyui\first-video\first-video-002.json" (
    echo [PASS] Workflow JSON: first-video-002.json
) else (
    echo [FAIL] Workflow JSON NOT found
    set ALL_PASS=0
)

REM 4 — Check ComfyUI path exists
if exist "C:\Users\prinya\AppData\Local\StabilityMatrix\Data\Packages\ComfyUI\main.py" (
    echo [PASS] ComfyUI: main.py found
) else (
    echo [FAIL] ComfyUI main.py NOT found
    set ALL_PASS=0
)

REM 5 — Check FFmpeg exists
where ffmpeg >nul 2>&1
if %ERRORLEVEL%==0 (
    echo [PASS] FFmpeg: found in PATH
) else (
    echo [FAIL] FFmpeg NOT found in PATH
    set ALL_PASS=0
)

REM 6 — Check project output folders
if exist "%PROJECT_DIR%\outputs" (
    echo [PASS] Outputs folder: %PROJECT_DIR%\outputs
) else (
    echo [WARN] Outputs folder missing — will be created
)
if exist "%PROJECT_DIR%\exports" (
    echo [PASS] Exports folder: %PROJECT_DIR%\exports
) else (
    echo [WARN] Exports folder missing — will be created
)

REM 7 — Check shot manifest
if exist "%PROJECT_DIR%\shot-manifest.json" (
    echo [PASS] Shot manifest: shot-manifest.json found
) else (
    echo [WARN] Shot manifest not found. Using default 4-shot layout.
)

REM 8 — Check existing shots if present
set SHOT_COUNT=0
for %%f in ("%PROJECT_DIR%\outputs\Shot*.mp4") do set /a SHOT_COUNT+=1
if %SHOT_COUNT% GTR 0 (
    echo [PASS] %SHOT_COUNT% existing shot(s) found in outputs
) else (
    echo [INFO] No existing shots in outputs (fresh project)
)

echo.
if %ALL_PASS%==1 (
    echo ========================================
    echo RESULT: READY
    echo ========================================
    exit /b 0
) else (
    echo ========================================
    echo RESULT: BLOCKED — Fix failures above
    echo ========================================
    exit /b 1
)
