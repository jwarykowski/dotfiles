import QtQuick
import Quickshell
import Quickshell.Hyprland
import Quickshell.Wayland

// full-screen dimmed layer on the focused monitor with a centred box; base of launcher and power menu
PanelWindow {
	id: root

	property bool open: false
	property real boxWidth: 400
	property real boxHeight: 300
	default property alias content: box.data

	function toggle() {
		if (!open)
			screen = focusedScreen();
		open = !open;
	}

	function focusedScreen() {
		const name = Hyprland.focusedMonitor?.name;
		const screens = Quickshell.screens;
		for (let i = 0; i < screens.length; i++) {
			if (screens[i].name === name)
				return screens[i];
		}
		return screens[0];
	}

	visible: open
	anchors {
		top: true
		bottom: true
		left: true
		right: true
	}
	exclusionMode: ExclusionMode.Ignore
	color: Theme.dim
	WlrLayershell.layer: WlrLayer.Overlay
	WlrLayershell.keyboardFocus: open ? WlrKeyboardFocus.Exclusive : WlrKeyboardFocus.None
	WlrLayershell.namespace: "quickshell-overlay"

	MouseArea {
		anchors.fill: parent
		onClicked: mouse => {
			if (!box.contains(mapToItem(box, mouse.x, mouse.y)))
				root.open = false;
		}
	}

	Rectangle {
		id: box
		anchors.centerIn: parent
		width: root.boxWidth
		height: root.boxHeight
		color: Theme.bg
		border.width: 2
		border.color: Theme.border
	}
}
