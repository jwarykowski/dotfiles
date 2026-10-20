hl.on("hyprland.start", function()
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("hyprpaper")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("qs")
	-- kbd-layer needs keymapp's api; gnome starts it from ~/.config/autostart
	hl.exec_cmd("$HOME/.local/bin/keymapp")
end)
