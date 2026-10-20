import QtQuick
import Quickshell.Services.Pipewire

Label {
	id: root

	readonly property var audio: Pipewire.defaultAudioSink?.audio ?? null

	visible: audio !== null
	text: !audio ? "" : audio.muted ? "vol muted" : `vol ${Math.round(audio.volume * 100)}%`
	color: audio?.muted ? Theme.muted : Theme.fg

	// binds the sink so volume/mute stay live
	PwObjectTracker {
		objects: [Pipewire.defaultAudioSink]
	}

	MouseArea {
		anchors.fill: parent
		onClicked: root.audio.muted = !root.audio.muted
		onWheel: wheel => {
			const step = wheel.angleDelta.y > 0 ? 0.05 : -0.05;
			root.audio.volume = Math.max(0, Math.min(1, root.audio.volume + step));
		}
	}
}
