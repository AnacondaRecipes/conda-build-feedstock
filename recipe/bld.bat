python setup.py install --single-version-externally-managed --record=record.txt
if errorlevel 1 exit 1

del /f /q "%PREFIX%\Scripts\conda"
if errorlevel 1 exit 1