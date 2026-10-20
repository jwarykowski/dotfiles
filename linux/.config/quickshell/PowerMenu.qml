import QtQuick
import Quickshell

// lock / log out / suspend / reboot / shut down: press the letter, or j/k and enter
Overlay {
	id: root

	readonly property var actions: [
		{
			key: "l",
			label: "lock",
			command: ["loginctl", "lock-session"]
		},
		{
			key: "e",
			label: "log out",
			command: ["hyprshutdown"]
		},
		{
			key: "s",
			label: "suspend",
			command: ["systemctl", "suspend"]
		},
		{
			key: "r",
			label: "reboot",
			command: ["systemctl", "reboot"]
		},
		{
			key: "p",
			label: "shut down",
			command: ["systemctl", "poweroff"]
		}
	]
	property int current: 0

	function run(action) {
		open = false;
		Quickshell.execDetached(action.command);
	}

	boxWidth: 260
	boxHeight: actions.length * 36 + 24

	onOpenChanged: {
		if (!open)
			return;
		current = 0;
		keys.forceActiveFocus();
	}

	Item {
		id: keys
		anchors.fill: parent

		Keys.onPressed: event => {
			const match = root.actions.find(a => a.key === event.text);
			if (match) {
				root.run(match);
			} else if (event.key === Qt.Key_Escape) {
				root.open = false;
			} else if (event.key === Qt.Key_J || event.key === Qt.Key_Down) {
				root.current = (root.current + 1) % root.actions.length;
			} else if (event.key === Qt.Key_K || event.key === Qt.Key_Up) {
				root.current = (root.current + root.actions.length - 1) % root.actions.length;
			} else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
				root.run(root.actions[root.current]);
			} else {
				return;
			}
			event.accepted = true;
		}
	}

	Column {
		x: 8
		y: 12
		width: root.boxWidth - 16

		Repeater {
			model: root.actions

			MouseArea {
				id: action

				required property var modelData
				required property int index

				width: parent.width
				height: 36
				hoverEnabled: true
				onEntered: root.current = index
				onClicked: root.run(modelData)

				Rectangle {
					anchors.fill: parent
					color: action.index === root.current ? Theme.surface : "transparent"
				}

				Label {
					x: 12
					anchors.verticalCenter: parent.verticalCenter
					text: `${action.modelData.key}  ${action.modelData.label}`
					color: action.index === root.current ? Theme.fg : Theme.muted
				}
			}
		}
	}
}
