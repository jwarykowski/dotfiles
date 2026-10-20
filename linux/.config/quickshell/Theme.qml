pragma Singleton

import QtQuick
import Quickshell

// lackluster, matching ghostty/nvim/tmux
Singleton {
	readonly property color bg: "#0a0a0a"
	readonly property color surface: "#191919"
	readonly property color border: "#444444"
	readonly property color muted: "#7a7a7a"
	readonly property color fg: "#deeeed"
	readonly property color lack: "#708090"
	readonly property color green: "#789978"
	readonly property color orange: "#ffaa88"
	readonly property color red: "#d70000"
	readonly property color dim: "#b30a0a0a"

	readonly property string font: "Berkeley Mono"
	readonly property int fontSize: 13
	readonly property int barHeight: 30

	readonly property string home: Quickshell.env("HOME")
}
