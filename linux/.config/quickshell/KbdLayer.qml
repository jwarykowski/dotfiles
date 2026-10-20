import QtQuick
import Quickshell.Io

// moonlander layer via kbd-layer (keymapp api); empty on the base layer
Label {
	id: root

	property string layer: ""

	visible: layer !== ""
	text: `⌨ ${layer}`
	color: Theme.orange

	Process {
		id: proc
		command: [`${Theme.home}/.local/bin/kbd-layer`]
		stdout: StdioCollector {
			onStreamFinished: root.layer = text.trim()
		}
	}

	Timer {
		interval: 1000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: proc.running = true
	}
}
