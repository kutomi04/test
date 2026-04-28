@echo off
setlocal

set "PHP=%~dp0..\.tools\php-8.3.30\php.exe"

if not exist "%PHP%" (
    echo PHP 8.3 was not found at "%PHP%"
    exit /b 1
)

"%PHP%" %*
exit /b %ERRORLEVEL%
