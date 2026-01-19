:: Build ARM64 launcher executable
pushd conda_build\launcher_sources
curl -SLo launcher.c https://raw.githubusercontent.com/python/cpython/3.7/PC/launcher.c
patch -p0 < cpython-launcher-c-mods-for-setuptools.3.7.patch

echo #include "winuser.h" > resources.rc
echo 1 RT_MANIFEST manifest.xml >> resources.rc
rc /nologo resources.rc

cl.exe /nologo /O1 /Os /MT /DNDEBUG /DSCRIPT_WRAPPER /DUNICODE /D_UNICODE /DWIN32_LEAN_AND_MEAN /GL /GS- /Gy launcher.c resources.res /link /MACHINE:ARM64 /SUBSYSTEM:CONSOLE /OPT:REF /OPT:ICF /LTCG advapi32.lib shell32.lib /OUT:cli-arm64.exe
copy cli-arm64.exe ..\
popd

"%PYTHON%" -m pip install . -vv --no-deps --no-build-isolation
if errorlevel 1 exit /b 1