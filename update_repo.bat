@echo off
echo ===================================
echo    تحديث المستودع للرفع عبر GitHub
echo ===================================
echo.

REM تعيين المسار الحالي
cd /d "%~dp0"

REM نسخ محتويات الحزمة الجديدة إلى المستودع الرئيسي
echo نسخ الملفات من الحزمة الجديدة...
xcopy /E /Y "fresh-theme-package\*" "." /EXCLUDE:exclude_list.txt

echo.
echo ===================================
echo تم تحديث الملفات بنجاح
echo.
echo الخطوات التالية:
echo 1. عمل git add لإضافة التغييرات
echo 2. عمل git commit لحفظ التغييرات
echo 3. عمل git push لدفع التغييرات إلى GitHub
echo 4. استخدام خيار "استيراد من GitHub" في منصة Salla Partners
echo ===================================

pause
