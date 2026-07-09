#!/usr/bin/env bash

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

home_packages=(alacritty fcitx5 gtk i3 neofetch nvidia qt screen scripts shell systemd vesktop vim x11 xdg)
system_packages=(pacman-hooks)

for pkg in "${home_packages[@]}"; do
	stow -v -t "$HOME" -d "$DIR" "$pkg"
done

for pkg in "${system_packages[@]}"; do
	sudo stow -v -t / -d "$DIR" "$pkg"
done

chmod +x "$DIR"/scripts/bin/*

systemctl --user daemon-reload && systemctl --user enable --now greenclip.service nvidia-settings.service
