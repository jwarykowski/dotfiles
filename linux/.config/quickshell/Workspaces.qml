import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland

RowLayout {
	id: root

	required property var screen
	readonly property var monitor: Hyprland.monitorFor(screen)

	spacing: 4

	Repeater {
		model: Hyprland.workspaces

		Label {
			required property var modelData

			// negative ids are special workspaces
			visible: modelData.id > 0 && modelData.monitor === root.monitor
			text: modelData.name
			leftPadding: 6
			rightPadding: 6
			color: modelData.urgent ? Theme.orange : modelData.active ? Theme.fg : Theme.muted
			font.bold: modelData.focused

			MouseArea {
				anchors.fill: parent
				// hyprland 0.56 dispatch takes lua, so not workspace.activate()
				onClicked: Hyprland.dispatch(`hl.dsp.focus({ workspace = ${parent.modelData.id} })`)
			}
		}
	}
}
