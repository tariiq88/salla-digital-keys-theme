@echo off
echo Creating a fresh theme package for Salla Partners...
echo.

REM Create a fresh directory for theme files
if exist "fresh-theme-package" rmdir /s /q "fresh-theme-package"
mkdir "fresh-theme-package"

REM Copy required files only (from direct structure)
echo Copying core files...
copy "twilight.json" "fresh-theme-package\"
copy "package.json" "fresh-theme-package\"
copy "twig-variables.json" "fresh-theme-package\"

REM Create and copy directories
echo Creating directory structure...
mkdir "fresh-theme-package\src"
mkdir "fresh-theme-package\src\assets"
mkdir "fresh-theme-package\src\assets\styles"
mkdir "fresh-theme-package\src\assets\js"
mkdir "fresh-theme-package\views"
mkdir "fresh-theme-package\views\layouts"
mkdir "fresh-theme-package\views\pages"
mkdir "fresh-theme-package\views\components"
mkdir "fresh-theme-package\locales"

REM Copy directory contents
echo Copying files...
copy "src\assets\styles\*.css" "fresh-theme-package\src\assets\styles\"
copy "src\assets\js\*.js" "fresh-theme-package\src\assets\js\"
copy "views\layouts\*.twig" "fresh-theme-package\views\layouts\"
copy "views\pages\*.twig" "fresh-theme-package\views\pages\"
copy "views\components\*.twig" "fresh-theme-package\views\components\"
copy "locales\*.json" "fresh-theme-package\locales\"

REM Create screenshots directory
mkdir "fresh-theme-package\screenshots"
echo Place screenshots in 'screenshots' folder > "fresh-theme-package\screenshots\README.txt"

echo.
echo ✅ Fresh theme package created in 'fresh-theme-package' folder
echo.
echo Next steps:
echo 1. ZIP the 'fresh-theme-package' folder
echo 2. Upload the ZIP directly to Salla Partners
echo.

pause
