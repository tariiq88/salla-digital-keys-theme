@echo off
echo ===================================
echo    إعداد مستودع GitHub جديد
echo ===================================
echo.

REM تعيين المسار الحالي
cd /d "%~dp0salla-minimal-theme"

echo جاري تهيئة مستودع Git جديد...
git init

echo إضافة الملفات إلى المستودع...
git add .

echo تثبيت التغييرات...
git commit -m "Initial commit - Basic Salla theme structure"

echo.
echo ===================================
echo تم إعداد المستودع المحلي بنجاح
echo.
echo الخطوات التالية:
echo 1. قم بإنشاء مستودع جديد في GitHub
echo    (بدون README.md و .gitignore)
echo 2. ربط المستودع المحلي بالمستودع البعيد:
echo    git remote add origin https://github.com/[username]/[repo-name].git
echo 3. دفع المستودع إلى GitHub:
echo    git push -u origin main
echo 4. استخدم المستودع الجديد في Salla Partners
echo ===================================

pause
