//@ pragma IconTheme Adwaita
import QtQuick
import Quickshell
import Quickshell.Io

ShellRoot {
	Variants {
		model: Quickshell.screens

		Bar {}
	}

	Notifications {}
	VolumeOsd {}

	Launcher {
		id: launcher
	}

	PowerMenu {
		id: power
	}

	Clipboard {
		id: clipboard
	}

	// hyprland binds: qs ipc call <target> toggle
	IpcHandler {
		target: "launcher"

		function toggle(): void {
			launcher.toggle();
		}
	}

	IpcHandler {
		target: "power"

		function toggle(): void {
			power.toggle();
		}
	}

	IpcHandler {
		target: "clipboard"

		function toggle(): void {
			clipboard.toggle();
		}
	}
}
