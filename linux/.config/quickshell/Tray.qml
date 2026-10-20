import QtQuick
import QtQuick.Layouts
import Quickshell.Services.SystemTray
import Quickshell.Widgets

RowLayout {
	id: root

	required property var window

	spacing: 8

	Repeater {
		model: SystemTray.items

		IconImage {
			id: icon

			required property var modelData

			implicitSize: 16
			source: modelData.icon

			MouseArea {
				anchors.fill: parent
				acceptedButtons: Qt.LeftButton | Qt.RightButton
				onClicked: mouse => {
					const item = icon.modelData;
					if (mouse.button === Qt.LeftButton && !item.onlyMenu) {
						item.activate();
					} else if (item.hasMenu) {
						const pos = icon.mapToItem(root.window.contentItem, 0, icon.height);
						item.display(root.window, pos.x, pos.y);
					}
				}
			}
		}
	}
}
