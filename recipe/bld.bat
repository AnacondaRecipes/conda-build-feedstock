"%PYTHON%" -m pip install . -vv --no-deps --no-build-isolation
if errorlevel 1 exit /b 1

REM Copy launchers from the conda-launchers host dependency into the package.
REM Always ship both 64-bit and ARM64 launchers (cli and gui) on every Windows
REM build so any environment can cross-target win-64 and win-arm64.
set "LAUNCHER_SRC=%PREFIX%\share\conda-launchers"
set "LAUNCHER_DST=%SP_DIR%\conda_build"

for %%A in (64 arm64) do (
    if not exist "%LAUNCHER_SRC%\cli-%%A.exe" (
        echo ERROR: missing %LAUNCHER_SRC%\cli-%%A.exe from conda-launchers
        exit /b 1
    )
    if not exist "%LAUNCHER_SRC%\gui-%%A.exe" (
        echo ERROR: missing %LAUNCHER_SRC%\gui-%%A.exe from conda-launchers
        exit /b 1
    )
    copy /Y "%LAUNCHER_SRC%\cli-%%A.exe" "%LAUNCHER_DST%\"
    if errorlevel 1 exit /b 1
    copy /Y "%LAUNCHER_SRC%\gui-%%A.exe" "%LAUNCHER_DST%\"
    if errorlevel 1 exit /b 1
)
