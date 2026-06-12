@echo off
setlocal

:: ============================================================
::  LaTeX one-click compile & cleanup
::  Usage:  compile.bat         (compile + clean)
::          compile.bat keep    (compile, keep aux files)
:: ============================================================

set "TEXFILE=main.tex"
set "BASENAME=main"

echo.
echo ========================================
echo   LaTeX Build Script
echo ========================================
echo.

:: check xelatex
where xelatex >nul 2>nul
if %ERRORLEVEL% neq 0 (
    echo [ERROR] xelatex not found. Install TeX Live or MiKTeX and add to PATH.
    pause
    exit /b 1
)

:: check main file
if not exist "%TEXFILE%" (
    echo [ERROR] %TEXFILE% not found.
    pause
    exit /b 1
)

:: ---------- pass 1 ----------
echo [1/3] First pass (generating aux/toc/lof/lot) ...
echo ----------------------------------------
xelatex -interaction=nonstopmode -halt-on-error "%TEXFILE%"
if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Pass 1 failed. See output above or %BASENAME%.log .
    pause
    exit /b 1
)
echo.

:: ---------- pass 2 ----------
echo [2/3] Second pass (cross-refs and TOC) ...
echo ----------------------------------------
xelatex -interaction=nonstopmode -halt-on-error "%TEXFILE%"
if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Pass 2 failed. See output above or %BASENAME%.log .
    pause
    exit /b 1
)
echo.

:: ---------- pass 3 ----------
echo [3/3] Third pass (final) ...
echo ----------------------------------------
xelatex -interaction=nonstopmode -halt-on-error "%TEXFILE%"
if %ERRORLEVEL% neq 0 (
    echo.
    echo [ERROR] Pass 3 failed. See output above or %BASENAME%.log .
    pause
    exit /b 1
)
echo.

:: ---------- cleanup ----------
if /i "%1"=="keep" (
    echo [SKIP] keep mode - aux files retained.
) else (
    echo [CLEAN] Removing auxiliary files ...
    del /q "%BASENAME%.aux"           2>nul
    del /q "%BASENAME%.log"           2>nul
    del /q "%BASENAME%.out"           2>nul
    del /q "%BASENAME%.toc"           2>nul
    del /q "%BASENAME%.lof"           2>nul
    del /q "%BASENAME%.lot"           2>nul
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
    echo        Done.
)

echo.
echo ========================================
echo   Build OK: %BASENAME%.pdf
echo ========================================
echo.
pause
