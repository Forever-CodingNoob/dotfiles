#!/usr/bin/env bash

for d in */; do
    stow -vt "$HOME" "${d%/}";
done

systemctl --user daemon-reload && systemctl --user enable --now greenclip.service nvidia-settings.service
