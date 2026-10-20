-- lackluster: luster #deeeed, gray4 #444444, background #0a0a0a
hl.config({
	general = {
		gaps_in = 15,
		gaps_out = { top = 50, right = 100, bottom = 50, left = 100 },
		border_size = 2,
		col = {
			active_border = "rgb(deeeed)",
			inactive_border = "rgb(444444)",
		},
		layout = "dwindle",
	},

	decoration = {
		rounding = 0,
		shadow = { enabled = false },
		blur = { enabled = false },
	},

	animations = { enabled = true },

	dwindle = { preserve_split = true },

	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = true,
		background_color = 0x0a0a0a,
	},
})

hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.animation({ leaf = "global", enabled = true, speed = 3, bezier = "quick" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "quick", style = "fade" })

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
