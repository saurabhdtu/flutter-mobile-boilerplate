#!/bin/bash

# Define the source and destination paths
ANDROID_STUDIO_DIR=~/Library/Application\ Support/Google
ANDROID_STUDIO_VERSION=$(ls "$ANDROID_STUDIO_DIR" | grep -i 'AndroidStudio')


REPO_ROOT=$(git rev-parse --show-toplevel)
TEMPLATES_SOURCE="$REPO_ROOT/android_studio_templates/fileTemplates"
ANDROID_STUDIO_TEMPLATES_DIR="$ANDROID_STUDIO_DIR/$ANDROID_STUDIO_VERSION/fileTemplates"

# Create the Android Studio templates directory if it doesn't exist
mkdir -p "$ANDROID_STUDIO_TEMPLATES_DIR"

# Copy the templates from the repo to the Android Studio folder
cp -R "$TEMPLATES_SOURCE"/* "$ANDROID_STUDIO_TEMPLATES_DIR"

echo "Templates copied successfully to Android Studio."