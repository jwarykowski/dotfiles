import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Pipewire

// shows for a moment whenever the default sink's volume or mute changes
Scope {
	id: root

	readonly property var audio: Pipewire.defaultAudioSink?.audio ?? null
	property bool shown: false

	PwObjectTracker {
		objects: [Pipewire.defaultAudioSink]
	}

	Connections {
		target: root.audio

		function onVolumesChanged() {
			root.shown = true;
			hide.restart();
		}

		function onMutedChanged() {
			root.shown = true;
			hide.restart();
		}
	}

	Timer {
		id: hide
		interval: 1500
		onTriggered: root.shown = false
	}

	PanelWindow {
		visible: root.shown && root.audio !== null
		anchors.bottom: true
		margins.bottom: 80
		exclusionMode: ExclusionMode.Ignore
		implicitWidth: 300
		implicitHeight: 44
		color: Theme.bg
		// clicks pass through
		mask: Region {}

		Rectangle {
			anchors.fill: parent
			color: "transparent"
			border.width: 2
			border.color: Theme.border

			RowLayout {
				anchors.fill: parent
				anchors.margins: 14
				spacing: 12

				Label {
					text: root.audio?.muted ? "muted" : "vol"
				}

				Rectangle {
					Layout.fillWidth: true
					implicitHeight: 6
					color: Theme.surface

					Rectangle {
						width: parent.width * Math.min(1, root.audio?.volume ?? 0)
						height: parent.height
						color: root.audio?.muted ? Theme.muted : Theme.fg
					}
				}
			}
		}
	}
}
