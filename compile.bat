@echo off
setlocal
:: ============================================================
::  LaTeX one-click compile & cleanup (Windows)
::  Usage:  compile.bat         (compile + clean)
::          compile.bat keep    (compile, keep aux files)
::
::  Compile flow:
::    xelatex -> biber/bibtex (bibliography) -> xelatex -> xelatex
::  If ANY step fails, the script pauses with an error and KEEPS
::  all log files (never runs the cleanup), so you can inspect
::  main.log to find the problem.
::  Requires: xelatex + biber (or bibtex) from TeX Live / MiKTeX
::
::  NOTE: keep this file ASCII-only (no Chinese). cmd.exe parses
::  batch files with the system codepage, and UTF-8 Chinese bytes
::  would corrupt the commands.
:: ============================================================

set "TEXFILE=main.tex"
set "BASENAME=main"

echo.
echo ========================================
echo   LaTeX Build Script
echo ========================================
echo.

:: ---------- check xelatex ----------
where xelatex >nul 2>nul
if errorlevel 1 (
    echo [ERROR] xelatex not found. Install TeX Live or MiKTeX and add to PATH.
    pause
    exit /b 1
)

:: ---------- check main file ----------
if not exist "%TEXFILE%" (
    echo [ERROR] %TEXFILE% not found.
    pause
    exit /b 1
)

:: ---------- pass 1 ----------
echo [1/5] First pass (generating aux/toc/bcf) ...
echo ----------------------------------------
xelatex -interaction=nonstopmode -halt-on-error "%TEXFILE%"
if errorlevel 1 goto :fail

:: ---------- bibliography ----------
:: Plan A (biblatex):   aux has no \bibdata, run biber if .bcf exists
:: Plan B (bibtex):     run bibtex if the .aux contains \bibdata
:: Order matters: check \bibdata (Plan B) FIRST so a stale .bcf from a
:: previous Plan-A build cannot hijack a Plan-B build without cleaning.
findstr /c:"\bibdata" "%BASENAME%.aux" >nul 2>nul
if not errorlevel 1 goto :run_bibtex
if exist "%BASENAME%.bcf" goto :run_biber
goto :pass2

:run_biber
echo.
echo [2/5] Running biber (biblatex backend) ...
echo ----------------------------------------
where biber >nul 2>nul
if errorlevel 1 (
    echo [ERROR] biber not found. Install TeX Live full or add biber to PATH.
    pause
    exit /b 1
)
biber "%BASENAME%"
if errorlevel 1 goto :fail
goto :pass2

:run_bibtex
echo.
echo [2/5] Running bibtex ...
echo ----------------------------------------
where bibtex >nul 2>nul
if errorlevel 1 (
    echo [ERROR] bibtex not found.
    pause
    exit /b 1
)
bibtex "%BASENAME%"
if errorlevel 1 goto :fail
goto :pass2

:pass2
echo.
echo [3/5] Second pass (cross-refs and TOC) ...
echo ----------------------------------------
xelatex -interaction=nonstopmode -halt-on-error "%TEXFILE%"
if errorlevel 1 goto :fail

echo.
echo [4/5] Third pass (final) ...
echo ----------------------------------------
xelatex -interaction=nonstopmode -halt-on-error "%TEXFILE%"
if errorlevel 1 goto :fail

:: ---------- verify output ----------
if not exist "%BASENAME%.pdf" (
    echo [ERROR] %BASENAME%.pdf was not generated.
    goto :fail
)

:: ---------- cleanup ----------
if /i "%1"=="keep" (
    echo.
    echo [SKIP] keep mode - aux files retained.
) else (
    echo.
    echo [5/5] Cleaning auxiliary files ...
    del /q "%BASENAME%.aux"           2>nul
    del /q "%BASENAME%.log"           2>nul
    del /q "%BASENAME%.out"           2>nul
    del /q "%BASENAME%.toc"           2>nul
    del /q "%BASENAME%.lof"           2>nul
    del /q "%BASENAME%.lot"           2>nul
    del /q "%BASENAME%.fls"           2>nul
    del /q "%BASENAME%.fdb_latexmk"   2>nul
    del /q "%BASENAME%.synctex.gz"    2>nul
    del /q "%BASENAME%.thm"           2>nul
    del /q "%BASENAME%.nav"           2>nul
    del /q "%BASENAME%.snm"           2>nul
    del /q "%BASENAME%.vrb"           2>nul
    del /q "%BASENAME%.bbl"           2>nul
    del /q "%BASENAME%.blg"           2>nul
    del /q "%BASENAME%.bcf"           2>nul
    del /q "%BASENAME%.run.xml"       2>nul
    del /q "%BASENAME%.xdv"           2>nul
    :: per-chapter aux files produced by \include (under texfile/)
    del /q "texfile\*.aux"            2>nul
    echo        Done.
)

echo.
echo ========================================
echo   Build OK: %BASENAME%.pdf
echo ========================================
echo.
pause
exit /b 0

:: ---------- failure handler ----------
:fail
echo.
echo ========================================
echo   [ERROR] Compilation FAILED!
echo   Please check the output above or %BASENAME%.log
echo   All log files are KEPT for troubleshooting (not cleaned).
echo ========================================
pause
exit /b 1
