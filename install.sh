#!/usr/bin/env bash

DIR="$(dirname $(realpath notes.md))"

for d in $DIR/*/; do
    stow -vt "$HOME" "${d%/}";
done

chmod +x $DIR/scripts/bin/*

systemctl --user daemon-reload && systemctl --user enable --now greenclip.service nvidia-settings.service
