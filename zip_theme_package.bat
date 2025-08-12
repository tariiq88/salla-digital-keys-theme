@echo off
echo ===================================
echo    Creating ZIP Package for Salla
echo ===================================
echo.

REM Set the current directory
cd /d "%~dp0"

REM Create a timestamp for the zip file
for /f "tokens=2 delims==" %%I in ('wmic os get localdatetime /format:list') do set datetime=%%I
set datestamp=%datetime:~0,8%
set timestamp=%datetime:~8,6%
set zipname=digital-keys-theme-%datestamp%-%timestamp%.zip

REM Check if PowerShell is available for better ZIP creation
where powershell >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    echo Using PowerShell to create ZIP file...
    powershell -Command "Compress-Archive -Path 'fresh-theme-package\*' -DestinationPath '%zipname%' -Force"
) else (
    echo PowerShell not found, using legacy ZIP method...
    echo Set objShell = CreateObject("Shell.Application") > _zipscript.vbs
    echo Set objFSO = CreateObject("Scripting.FileSystemObject") >> _zipscript.vbs
    echo If Not objFSO.FileExists("%zipname%") Then >> _zipscript.vbs
    echo    objFSO.CreateTextFile("%zipname%", True).Write "PK" ^& Chr(5) ^& Chr(6) ^& String(18, vbNullChar) >> _zipscript.vbs
    echo End If >> _zipscript.vbs
    echo Set objZip = objShell.NameSpace("%CD%\%zipname%") >> _zipscript.vbs
    echo objZip.CopyHere "%CD%\fresh-theme-package" >> _zipscript.vbs
    echo WScript.Sleep 2000 >> _zipscript.vbs
    cscript //nologo _zipscript.vbs
    del _zipscript.vbs
)

echo.
echo ===================================
if exist "%zipname%" (
    echo Package created successfully: %zipname%
    echo.
    echo Next Steps:
    echo 1. Upload the ZIP file to Salla Partners
    echo 2. Submit your theme for review
    echo 3. Wait for approval from Salla team
) else (
    echo Failed to create ZIP package!
)
echo ===================================

pause
