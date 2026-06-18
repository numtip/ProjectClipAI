@echo off
setlocal enabledelayedexpansion

REM ============================================
REM assemble-batch.bat
REM Assemble 4-shot project into master exports.
REM
REM Usage:
REM   assemble-batch.bat <project-dir> [--dry-run]
REM
REM Examples:
REM   assemble-batch.bat F:\ProjectClipsAI\projects\project-001 --dry-run
REM   assemble-batch.bat F:\ProjectClipsAI\projects\project-001
REM ============================================

set PROJECT_DIR=%~1
set DRY_RUN=0

if "%PROJECT_DIR%"=="" (
    echo USAGE: assemble-batch.bat ^<project-dir^> [--dry-run]
    echo EXAMPLE: assemble-batch.bat F:\ProjectClipsAI\projects\project-001 --dry-run
    exit /b 1
)

if "%2"=="--dry-run" set DRY_RUN=1
if "%2"=="--dry-run" echo *** DRY RUN MODE — No actual assembly *** & echo.

set OUTPUTS_DIR=%PROJECT_DIR%\outputs
set EXPORTS_DIR=%PROJECT_DIR%\exports
set SHOTS=4

set ALL_PASSED=1

echo ========================================
echo BATCH ASSEMBLER
echo Project: %PROJECT_DIR%
echo Shots: %SHOTS%
echo Dry Run: %DRY_RUN%
echo ========================================
echo.

REM — Verify output dir
if not exist "%OUTPUTS_DIR%" (
    echo [ERROR] Outputs dir not found: %OUTPUTS_DIR%
    echo [INFO] Run render-batch-ltx.bat first
    exit /b 1
)

REM — Create exports dir
if not exist "%EXPORTS_DIR%" mkdir "%EXPORTS_DIR%"

REM — Verify all shot files exist
for /l %%N in (1,1,%SHOTS%) do (
    set SHOT_FILE=%OUTPUTS_DIR%\Shot0%%N.mp4
    if exist "!SHOT_FILE!" (
        echo [PASS] Shot0%%N.mp4 found
    ) else (
        echo [FAIL] Shot0%%N.mp4 NOT found in %OUTPUTS_DIR%
        set ALL_PASSED=0
    )
)

echo.
if !ALL_PASSED!==0 (
    echo [ERROR] Missing shot files. Render first.
    exit /b 1
)

REM — Check ffprobe
where ffprobe >nul 2>&1
if %ERRORLEVEL%==0 (
    echo [PASS] ffprobe available
) else (
    echo [WARN] ffprobe not in PATH — validation skipped
)

echo.

REM ======= VERSION A — Hard Cuts (concat) =======
echo ----------------------------------------
echo VERSION A: Hard Cuts
echo ----------------------------------------

if %DRY_RUN%==1 (
    echo [DRY RUN] Would create: %EXPORTS_DIR%\master-hardcuts.mp4
    echo [DRY RUN] Method: concat demuxer, stream copy (lossless)
) else (
    REM — Create concat list
    set CONCAT_FILE=%TEMP%\concat_%RANDOM%.txt
    (
        echo file '%OUTPUTS_DIR:\=/%/Shot01.mp4'
        echo file '%OUTPUTS_DIR:\=/%/Shot02.mp4'
        echo file '%OUTPUTS_DIR:\=/%/Shot03.mp4'
        echo file '%OUTPUTS_DIR:\=/%/Shot04.mp4'
    ) > "%CONCAT_FILE%"

    echo [ASSEMBLE] Concatenating...
    ffmpeg -y -f concat -safe 0 -i "%CONCAT_FILE%" -c copy -movflags +faststart "%EXPORTS_DIR%\master-hardcuts.mp4" 2>&1 | findstr /i "Output frame"
    if %ERRORLEVEL%==0 (
        echo [PASS] master-hardcuts.mp4 created
    ) else (
        echo [WARN] Check ffmpeg output above
    )
    del "%CONCAT_FILE%" 2>nul
)

echo.

REM ======= VERSION B — Fade Transitions (xfade) =======
echo ----------------------------------------
echo VERSION B: Fade Transitions (0.4s)
echo ----------------------------------------

if %DRY_RUN%==1 (
    echo [DRY RUN] Would create: %EXPORTS_DIR%\master-fades.mp4
    echo [DRY RUN] Method: xfade filter, libx264 CRF 18 re-encode
) else (
    echo [ASSEMBLE] Applying xfade transitions...
    ffmpeg -y -i "%OUTPUTS_DIR%\Shot01.mp4" -i "%OUTPUTS_DIR%\Shot02.mp4" -i "%OUTPUTS_DIR%\Shot03.mp4" -i "%OUTPUTS_DIR%\Shot04.mp4" ^
      -filter_complex "[0][1]xfade=transition=fade:duration=0.4:offset=4.642[x1];[x1][2]xfade=transition=fade:duration=0.4:offset=9.283[x2];[x2][3]xfade=transition=fade:duration=0.4:offset=13.925" ^
      -c:v libx264 -crf 18 -preset fast -pix_fmt yuv420p -movflags +faststart "%EXPORTS_DIR%\master-fades.mp4" 2>&1 | findstr /i "Output frame"
    if %ERRORLEVEL%==0 (
        echo [PASS] master-fades.mp4 created
    ) else (
        echo [WARN] Check ffmpeg output above
    )
)

echo.

REM ======= VALIDATION =======
echo ----------------------------------------
echo VALIDATION
echo ----------------------------------------

where ffprobe >nul 2>&1
if %ERRORLEVEL%==0 (
    for %%E in (master-hardcuts.mp4 master-fades.mp4) do (
        if exist "%EXPORTS_DIR%\%%E" (
            echo --- %%E ---
            for /f "tokens=*" %%a in ('ffprobe -v error -show_entries format^=duration^,size:stream^=codec_name^,width^,height^,r_frame_rate^,nb_frames -of default^=noprint_wrappers^=1 "%EXPORTS_DIR%\%%E" 2^>^&1') do (
                echo   %%a
            )
            echo.
        )
    )
) else (
    echo [INFO] ffprobe not available — manual validation required
)

echo ========================================
if %DRY_RUN%==1 (
    echo DRY RUN COMPLETE — No assembly performed
) else (
    echo ASSEMBLY COMPLETE
    echo Exports: %EXPORTS_DIR%
)
echo ========================================
exit /b 0
