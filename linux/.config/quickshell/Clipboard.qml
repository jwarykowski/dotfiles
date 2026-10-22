import QtQuick
import Quickshell
import Quickshell.Io

// cliphist history: type to filter, up/down (ctrl+j/k) to pick, enter copies it back
Overlay {
	id: root

	property var entries: []
	readonly property var matches: {
		const query = input.text.toLowerCase();
		return entries.filter(line => line.toLowerCase().includes(query));
	}

	function pick(line) {
		if (!line)
			return;
		Quickshell.execDetached(["sh", "-c", "printf '%s' \"$1\" | cliphist decode | wl-copy", "sh", line]);
		open = false;
	}

	boxWidth: 720
	boxHeight: 460

	onOpenChanged: {
		if (!open)
			return;
		input.text = "";
		list.currentIndex = 0;
		history.running = true;
		input.forceActiveFocus();
	}

	Process {
		id: history
		command: ["cliphist", "list"]
		stdout: StdioCollector {
			onStreamFinished: root.entries = text.split("\n").filter(line => line !== "")
		}
	}

	TextInput {
		id: input
		x: 16
		y: 16
		width: root.boxWidth - 32
		color: Theme.fg
		font.family: Theme.font
		font.pixelSize: Theme.fontSize + 3
		onTextChanged: list.currentIndex = 0

		Keys.onPressed: event => {
			const ctrl = event.modifiers & Qt.ControlModifier;
			if (event.key === Qt.Key_Escape) {
				root.open = false;
			} else if (event.key === Qt.Key_Return || event.key === Qt.Key_Enter) {
				root.pick(root.matches[list.currentIndex]);
			} else if (event.key === Qt.Key_Down || (ctrl && event.key === Qt.Key_J)) {
				list.incrementCurrentIndex();
			} else if (event.key === Qt.Key_Up || (ctrl && event.key === Qt.Key_K)) {
				list.decrementCurrentIndex();
			} else {
				return;
			}
			event.accepted = true;
		}

		Label {
			visible: input.text === ""
			text: "clipboard…"
			color: Theme.muted
			font.pixelSize: input.font.pixelSize
		}
	}

	ListView {
		id: list
		x: 8
		y: 56
		width: root.boxWidth - 16
		height: root.boxHeight - 64
		clip: true
		model: root.matches
		highlightMoveDuration: 0

		highlight: Rectangle {
			color: Theme.surface
		}

		delegate: MouseArea {
			id: row

			required property string modelData
			required property int index

			width: list.width
			height: 32
			hoverEnabled: true
			onEntered: list.currentIndex = index
			onClicked: root.pick(modelData)

			Label {
				x: 8
				width: row.width - 16
				anchors.verticalCenter: parent.verticalCenter
				// drop cliphist's leading id column
				text: row.modelData.replace(/^\d+\t/, "")
				elide: Text.ElideRight
				color: row.ListView.isCurrentItem ? Theme.fg : Theme.muted
			}
		}
	}
}
