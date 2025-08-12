@echo off
echo ===================================
echo    إنشاء مشروع مبسط لـ Salla
echo ===================================
echo.

REM تعيين المسار الحالي
cd /d "%~dp0"

REM إنشاء مجلد للنسخة المبسطة
mkdir salla-minimal-theme
cd salla-minimal-theme

REM إنشاء الهيكل الأساسي للمجلدات
mkdir locales
mkdir src\assets\images
mkdir src\assets\js
mkdir src\assets\styles
mkdir views\components
mkdir views\layouts
mkdir views\pages

REM نسخ الملفات الأساسية
echo جاري نسخ الملفات الأساسية...
copy ..\twilight.json .
copy ..\package.json .
copy ..\twig-variables.json .
copy ..\locales\ar.json locales\
copy ..\locales\en.json locales\
copy ..\src\assets\js\main.js src\assets\js\
copy ..\src\assets\styles\main.css src\assets\styles\
copy ..\views\layouts\master.twig views\layouts\
copy ..\views\pages\index.twig views\pages\
copy ..\views\components\header.twig views\components\

echo.
echo ===================================
echo تم إنشاء المشروع المبسط بنجاح
echo.
echo الخطوات التالية:
echo 1. قم بإنشاء مستودع GitHub جديد
echo 2. ادفع هذا المشروع إلى المستودع الجديد
echo 3. استخدم المستودع الجديد في Salla Partners
echo ===================================

pause
