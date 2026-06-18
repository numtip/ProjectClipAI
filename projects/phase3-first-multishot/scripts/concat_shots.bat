@echo off
REM ============================================================
REM concat_shots.bat
REM Concatenates Shot01.mp4 through Shot04.mp4 into one final clip
REM ============================================================

set INPUT_DIR=%~dp0..\inputs
set OUTPUT_DIR=%~dp0..\outputs
set FILELIST=%TEMP%\concat_shots.txt

REM Ensure output directory exists
if not exist "%OUTPUT_DIR%" mkdir "%OUTPUT_DIR%"

REM Build FFmpeg concat file list
echo file '%INPUT_DIR%\Shot01.mp4' > "%FILELIST%"
echo file '%INPUT_DIR%\Shot02.mp4' >> "%FILELIST%"
echo file '%INPUT_DIR%\Shot03.mp4' >> "%FILELIST%"
echo file '%INPUT_DIR%\Shot04.mp4' >> "%FILELIST%"

REM Run FFmpeg concatenation
ffmpeg -f concat -safe 0 -i "%FILELIST%" -c copy "%OUTPUT_DIR%\first_multishot_clip.mp4"

REM Clean up
del "%FILELIST%"

echo.
echo Done. Output: %OUTPUT_DIR%\first_multishot_clip.mp4
pause
