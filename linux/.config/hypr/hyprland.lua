hl.monitor({ output = "", mode = "preferred", position = "auto", scale = "auto" })

require("look")
require("input")
require("binds")
require("rules")
require("autostart")

-- untracked per-machine overrides (monitors, scale); optional
pcall(require, "local")
