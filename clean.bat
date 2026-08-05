@echo off
:: ============================================================
::  Clean LaTeX auxiliary files (keeps main.pdf and sources)
::  Usage:  clean.bat
:: ============================================================

del /q *.aux 2>nul
del /q *.log 2>nul
del /q *.out 2>nul
del /q *.toc 2>nul
del /q *.lof 2>nul
del /q *.lot 2>nul
del /q *.fls 2>nul
del /q *.synctex.gz 2>nul
del /q *.xdv 2>nul
del /q *.bbl 2>nul
del /q *.blg 2>nul
del /q *.bcf 2>nul
del /q *.run.xml 2>nul
del /q *.thm 2>nul
del /q *.nav 2>nul
del /q *.snm 2>nul
del /q *.vrb 2>nul
del /q *.bak 2>nul

echo Cleanup done. main.pdf and sources kept.
pause
