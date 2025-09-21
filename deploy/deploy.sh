#!/bin/bash

LOCAL_PATH="/mnt/c/Users/91704/Desktop/Devops/HeroVired/coding-assignment-prt"
REMOTE_USER="ubuntu"
REMOTE_HOST="192.168.31.100"
REMOTE_PATH="/home/ubuntu/herovired/coding-assignment-prt"
EXCLUDES="$(dirname "$0")/.rsync-exclude"
SSH_KEY="$HOME/.ssh/id_ed25519"

echo "🚀 Deploying from $LOCAL_PATH to $REMOTE_USER@$REMOTE_HOST..."

sshpass -p '123' rsync -avz --delete -e "ssh -i $SSH_KEY" \
  --checksum \
  --exclude-from="$EXCLUDES" \
  "$LOCAL_PATH"/ \
  "$REMOTE_USER@$REMOTE_HOST:$REMOTE_PATH"

echo "✅ Deployed successfully to $REMOTE_HOST"
