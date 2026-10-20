import QtQuick
import QtQuick.Layouts
import Quickshell

PanelWindow {
	id: bar

	required property var modelData

	screen: modelData
	anchors {
		top: true
		left: true
		right: true
	}
	implicitHeight: Theme.barHeight
	color: Theme.bg

	RowLayout {
		anchors.fill: parent
		anchors.leftMargin: 12
		anchors.rightMargin: 12
		spacing: 16

		Workspaces {
			screen: bar.screen
		}

		Item {
			Layout.fillWidth: true
		}

		Agents {}
		KbdLayer {}
		Volume {}

		Tray {
			window: bar
		}

		Clock {}
	}
}
