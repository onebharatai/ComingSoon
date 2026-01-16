#!/bin/bash
# Deploy script for RegRev Coming Soon

# Stop on error
set -e

echo "--> Initializing Git repository..."
git init

# Check if user identity is set, otherwise set a temporary one for this repo
cf_email=$(git config user.email || true)
if [ -z "$cf_email" ]; then
    echo "--> Configuring git user identity..."
    git config user.email "deploy@regrev.com"
    git config user.name "RegRev Deployer"
fi

echo "--> Staging files..."
git add .

echo "--> Committing changes..."
# Commit only if there are changes
if ! git diff-index --quiet HEAD --; then
    git commit -m "Initial commit"
else
    echo "   (Nothing to commit)"
fi

echo "--> Setting branch to main..."
git branch -M main

echo "--> Configuring remote 'origin'..."
if git remote | grep -q "^origin$"; then
    git remote set-url origin https://github.com/onebharatai/ComingSoon
else
    git remote add origin https://github.com/onebharatai/ComingSoon
fi

echo "--> Pushing to GitHub..."
echo "    (You may be asked for your username & password/token)"
git push -u origin main
