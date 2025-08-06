@echo off
echo Creating theme package for Salla Partners...
echo.

REM Create a clean directory for theme files
if exist "salla-theme-package" rmdir /s /q "salla-theme-package"
mkdir "salla-theme-package"

REM Copy required files only
echo Copying theme files...
copy "twilight.json" "salla-theme-package\"
copy "package.json" "salla-theme-package\"
copy "README.md" "salla-theme-package\"

REM Copy directories
xcopy "src" "salla-theme-package\src\" /E /I /Q
xcopy "views" "salla-theme-package\views\" /E /I /Q
xcopy "locales" "salla-theme-package\locales\" /E /I /Q

echo.
echo ✅ Theme package created successfully in 'salla-theme-package' folder
echo.
echo Next steps:
echo 1. Add screenshots to the 'screenshots' folder
echo 2. Create a ZIP file from 'salla-theme-package' folder
echo 3. Upload directly to Salla Partners
echo.
pause
