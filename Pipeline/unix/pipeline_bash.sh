#!/bin/bash

if [ "$1" == "--help" ]; then
  echo ""
  echo "============================"
  echo "Build and Deploy Script for Unity and Itch.io"
  echo "============================"
  echo "This script automates the build and deployment of Unity projects."
  echo "Make sure to fill in the environment variables below:"
  echo ""
  echo "- UNITY_PATH: Path to your Unity Editor executable."
  echo "- PROJECT_PATH: Path to the Unity project (use current directory with \`pwd\`)."
  echo "- BUILD_PATH: Path to the generated build file."
  echo "- ITCHIO_USER: Your Itch.io username."
  echo "- ITCHIO_GAME: Itch.io game project name."
  echo ""
  echo "Script Arguments:"
  echo "  --build   : Executes only the build process."
  echo "  --deploy  : Executes only the deploy process."
  echo "No arguments: Runs both build and deploy sequentially."
  exit 0
fi

export UNITY_PATH="/path/to/Unity/Editor/Unity"
export PROJECT_PATH=$(pwd)
export BUILD_PATH="Builds/WebGLBuild.zip"
export ITCHIO_USER="brailog"
export ITCHIO_GAME="agrlab-grro-demo1"

export EXECUTE_BUILD=false
export EXECUTE_DEPLOY=false

if [ -z "$1" ]; then
  EXECUTE_BUILD=true
  EXECUTE_DEPLOY=true
elif [ "$1" == "--build" ]; then
  EXECUTE_BUILD=true
elif [ "$1" == "--deploy" ]; then
  EXECUTE_DEPLOY=true
else
  echo "Invalid argument! Use --build, --deploy, or no arguments to run both."
  echo "Usage: $0 [--build | --deploy | --help]"
  exit 1
fi

if [ "$EXECUTE_BUILD" == "true" ]; then
  echo "Starting Unity Build Process..."
  UNITY_CMD="$UNITY_PATH -quit -batchmode -projectPath $PROJECT_PATH -executeMethod Builder.Build"
  echo $UNITY_CMD
  eval $UNITY_CMD
  echo "Unity Build Completed!"
fi

if [ "$EXECUTE_DEPLOY" == "true" ]; then
  echo "Starting Itch.io Deploy Process..."
  DEPLOY_CMD="butler push $BUILD_PATH $ITCHIO_USER/$ITCHIO_GAME:webgl"
  echo $DEPLOY_CMD
  eval $DEPLOY_CMD
  echo "Itch.io Deploy Completed!"
fi

echo "Script execution completed successfully!"
