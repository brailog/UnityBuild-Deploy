@echo off
REM ============================================================
REM This is a unified Build and Deploy script for Unity projects and Itch.io.
REM ============================================================

if "%1"=="--help" (
    echo.
    echo ============================
    echo Build and Deploy Script for Unity and Itch.io
    echo ============================
    echo This script automates the build and deployment of Unity projects.
    echo Make sure to fill in the environment variables below:
    echo.
    echo - UNITY_PATH: Path to your Unity Editor executable.
    echo - PROJECT_PATH: Path to the Unity project.
    echo - BUILD_PATH: Path to the generated build file.
    echo - ITCHIO_USER: Your Itch.io username.
    echo - ITCHIO_GAME: Itch.io game project name.
    echo.
    echo Script Arguments:
    echo   --build   : Executes only the build process.
    echo   --deploy  : Executes only the deploy process.
    echo No arguments: Runs both build and deploy sequentially.
    echo.
    exit /b 0
)

set UNITY_PATH="C:\Program Files\Unity\Hub\Editor\2022.3.48f1\Editor\Unity.exe"
set PROJECT_PATH=%cd%
set BUILD_PATH="Builds\WebGLBuild.zip"
set ITCHIO_USER="brailog"
set ITCHIO_GAME="agrlab-grro-demo1"

set EXECUTE_BUILD=false
set EXECUTE_DEPLOY=false

if "%1"=="" (
    set EXECUTE_BUILD=true
    set EXECUTE_DEPLOY=true
) else if "%1"=="--build" (
    set EXECUTE_BUILD=true
) else if "%1"=="--deploy" (
    set EXECUTE_DEPLOY=true
) else (
    echo Invalid argument! Use --build, --deploy, or no arguments to run both.
    echo Usage: %0 [--build | --deploy | --help]
    exit /b 1
)

if "%EXECUTE_BUILD%"=="true" (
    echo Starting Unity Build Process. Can take some minutes to complete...
    %UNITY_PATH% -quit -batchmode -projectPath %PROJECT_PATH% -executeMethod Builder.Build
    echo Unity Build Completed!
)

if "%EXECUTE_DEPLOY%"=="true" (
    echo Starting Itch.io Deploy Process...
    timeout /t 3 /nobreak
    .\Resource\butler_exe\butler push %BUILD_PATH% %ITCHIO_USER%/%ITCHIO_GAME%:webgl
    echo Itch.io Deploy Completed!
)

echo Script execution completed successfully!
exit /b 0
