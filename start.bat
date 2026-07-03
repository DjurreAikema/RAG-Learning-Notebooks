@echo off
REM ============================================================
REM  Double-click this file to launch the RAG Q&A notebook.
REM  It activates the project's virtual environment and starts
REM  Jupyter automatically - no typing needed.
REM ============================================================

REM Move into the folder this file lives in (works from anywhere)
cd /d "%~dp0"

REM Activate the virtual environment
call .venv\Scripts\activate.bat

REM Launch Jupyter (your browser will open automatically)
jupyter notebook

REM Keep the window open if something goes wrong, so you can read the error
pause
