-- SUPER is the moonlander's F/J hold; ctrl+alt combos belong to herdr
local mod = "SUPER"

local function bind(keys, dispatcher, opts)
	hl.bind(mod .. " + " .. keys, dispatcher, opts)
end

-- quickshell overlays (see ~/.config/quickshell)
local function qs(target)
	return hl.dsp.exec_cmd("qs ipc call " .. target .. " toggle")
end

bind("Return", hl.dsp.exec_cmd("ghostty"))
bind("D", qs("launcher"))
bind("V", qs("clipboard"))
bind("Escape", qs("power"))
bind("SHIFT + E", qs("power"))
bind("SHIFT + Q", hl.dsp.window.close())
bind("SHIFT + C", hl.dsp.reload_config())

-- moonlander lock key sends ctrl+alt+gui+l; hypridle runs hyprlock
hl.bind("CTRL + ALT + SUPER + L", hl.dsp.exec_cmd("loginctl lock-session"))

local directions = { H = "left", J = "down", K = "up", L = "right" }
for key, direction in pairs(directions) do
	bind(key, hl.dsp.focus({ direction = direction }))
	bind("SHIFT + " .. key, hl.dsp.window.move({ direction = direction }))
end

bind("F", hl.dsp.window.fullscreen({ mode = "fullscreen" }))
bind("SHIFT + space", hl.dsp.window.float({ action = "toggle" }))
bind("E", hl.dsp.layout("togglesplit"))

-- drop-down scratchpad
bind("S", hl.dsp.workspace.toggle_special("scratch"))
bind("SHIFT + S", hl.dsp.window.move({ workspace = "special:scratch" }))

-- night light
bind("N", hl.dsp.exec_cmd("pkill -x hyprsunset || hyprsunset -t 4000"))

for i = 1, 10 do
	local key = i % 10
	bind(key, hl.dsp.focus({ workspace = i }))
	bind("SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

bind("mouse:272", hl.dsp.window.drag(), { mouse = true })
bind("mouse:273", hl.dsp.window.resize(), { mouse = true })

bind("R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
	local step = 40
	local sizes = {
		H = { x = -step, y = 0 },
		L = { x = step, y = 0 },
		K = { x = 0, y = -step },
		J = { x = 0, y = step },
	}
	for key, size in pairs(sizes) do
		hl.bind(key, hl.dsp.window.resize({ x = size.x, y = size.y, relative = true }), { repeating = true })
	end
	hl.bind("Return", hl.dsp.submap("reset"))
	hl.bind("Escape", hl.dsp.submap("reset"))
end)

-- capture: region / screen to clipboard, annotate, record, colour pick, ocr
hl.bind("Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim - | wl-copy"))
hl.bind("CTRL + Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | satty --filename - --copy-command wl-copy'))
hl.bind("ALT + Print", hl.dsp.exec_cmd("$HOME/.local/bin/screenrecord"))
bind("Print", hl.dsp.exec_cmd("hyprpicker -a"))
bind("CTRL + Print", hl.dsp.exec_cmd('grim -g "$(slurp)" - | tesseract - - | wl-copy'))

local locked = { locked = true }
local repeating = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), repeating)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), repeating)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), locked)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), repeating)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), repeating)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), locked)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), locked)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), locked)
