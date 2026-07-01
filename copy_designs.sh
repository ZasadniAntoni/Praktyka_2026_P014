#!/bin/bash

# ==========================================
# CONFIG
# ==========================================
SOURCE_DIR="$HOME/eda/designs"
BACKUP_DIR="$HOME/Documents/Praktyka_2026_P014/designs_backup"
# ==========================================

sudo chown -R $USER:$USER "$SOURCE_DIR"

if [ ! -d "$BACKUP_DIR" ]; then
    echo "Created new folder: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
fi

if cp -r "$SOURCE_DIR" "$BACKUP_DIR"/; then
    echo "Done! Backed up to: $BACKUP_DIR"
else
    echo "Backup unsuccessful."
fi