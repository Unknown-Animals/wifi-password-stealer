@echo off

setlocal
call :setESC

: compile py script file
echo.
echo %ESC%[34mcompiling py script...%ESC%[0m
echo.
pyinstaller -F scripts/wifi-passwords.py -n wifi-passwords --clean --distpath ./bin
echo.
echo %ESC%[32mCompilation Complete!%ESC%[0m
echo.

echo.
echo %ESC%[34mcleaning build...%ESC%[0m

: remove build dir
rmdir /s /q build

: remove spec file if exist
set fn="wifi-passwords.spec"
if exist %fn% del %fn%

echo.
echo %ESC%[32mCleaning Complete!%ESC%[0m

echo.

pause

:setESC
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do (
  set ESC=%%b
  exit /B 0
)
exit /B 0