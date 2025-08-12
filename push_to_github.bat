@echo off
echo ===================================
echo    ربط وتحميل المشروع إلى GitHub
echo ===================================
echo.

set /p repo_url=أدخل رابط المستودع الجديد (مثال: https://github.com/tariiq88/salla-digital-keys-minimal.git): 

REM تعيين المسار الحالي
cd /d "%~dp0salla-minimal-theme"

echo جاري ربط المستودع المحلي بالمستودع البعيد...
git remote add origin %repo_url%

echo جاري تحميل المشروع إلى GitHub...
git push -u origin main

echo.
echo ===================================
echo تم الانتهاء من رفع المشروع إلى GitHub
echo.
echo الخطوات التالية:
echo 1. انتقل إلى منصة Salla Partners
echo 2. اختر "استيراد من GitHub"
echo 3. أدخل عنوان المستودع الجديد
echo ===================================

pause
