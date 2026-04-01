#!/bin/bash
set -e

OWNER="GrabowskiM"
SOURCE_REPO="silver-palm-tree"
TARGET_REPO="sturdy-bassoon"
TARGET_DIR="$(cd "$(dirname "$0")" && pwd)"
CLONE_DIR="/tmp/${SOURCE_REPO}-$$"

SOURCE_URL="https://github.com/${OWNER}/${SOURCE_REPO}.git"

echo "Klonowanie ${SOURCE_REPO}..."
git clone "$SOURCE_URL" "$CLONE_DIR"

echo "Kopiowanie test.txt do $TARGET_DIR..."
cp "$CLONE_DIR/test.txt" "$TARGET_DIR/test.txt"

echo "Usuwanie sklonowanego repo..."
rm -rf "$CLONE_DIR"

echo "Commitowanie..."
cd "$TARGET_DIR"

if [ -n "$CI" ]; then
    git config user.email "github-actions[bot]@users.noreply.github.com"
    git config user.name "github-actions[bot]"
fi

git add test.txt
git commit -m "chore: sync test.txt from ${SOURCE_REPO} [skip ci]"

echo "Gotowe."
