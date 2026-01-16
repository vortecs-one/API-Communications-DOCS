#!/usr/bin/env bash

set -e  # Exit immediately if any command fails

DOC_ROOT="/var/www/html"
DOCS_DIR="$DOC_ROOT/docs"
BACKUP_DIR="$DOC_ROOT/docs.bk"
BUILD_DIR="build"

echo "▶ Building documentation..."
bundle exec middleman build

echo "▶ Creating backup..."
if [ -d "$DOCS_DIR" ]; then
    sudo rm -rf "$BACKUP_DIR"
    sudo cp -r "$DOCS_DIR" "$BACKUP_DIR"
fi

echo "▶ Deploying new docs..."
sudo rsync -av --delete "$BUILD_DIR/" "$DOCS_DIR/"

echo "▶ Testing nginx configuration..."
sudo nginx -t

echo "▶ Restarting nginx..."
sudo systemctl restart nginx

echo "✅ Documentation deployed successfully"
