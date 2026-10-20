import QtQuick
import Quickshell
import Quickshell.Widgets

// app launcher over the .desktop entries: type to filter, up/down (ctrl+j/k) to pick, enter to run
Overlay {
	id: root

	readonly property var apps: {
		const query = input.text.toLowerCase();
		return DesktopEntries.applications.values.filter(app => !app.noDisplay && [app.name, app.genericName, ...app.keywords].some(s => s?.toLowerCase().includes(query))).sort((a, b) => a.name.localeCompare(b.name));
	}

	function run(app) {
		if (!app)
			return;
		app.execute();
		open = false;
	}

	boxWidth: 560
	boxHeight: 420

	onOpenChanged: {
		if (!open)
			return;
		input.text = "";
		list.currentIndex = 0;
		input.forceActiveFocus();
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
				root.run(root.apps[list.currentIndex]);
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
			text: "run…"
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
		model: root.apps
		highlightMoveDuration: 0

		highlight: Rectangle {
			color: Theme.surface
		}

		delegate: MouseArea {
			id: row

			required property var modelData
			required property int index

			width: list.width
			height: 32
			hoverEnabled: true
			onEntered: list.currentIndex = index
			onClicked: root.run(modelData)

			IconImage {
				x: 8
				anchors.verticalCenter: parent.verticalCenter
				implicitSize: 18
				source: Quickshell.iconPath(row.modelData.icon, true)
			}

			Label {
				x: 36
				anchors.verticalCenter: parent.verticalCenter
				text: row.modelData.name
				color: row.ListView.isCurrentItem ? Theme.fg : Theme.muted
			}
		}
	}
}
