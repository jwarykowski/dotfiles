import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import Quickshell.Io

// herdr agents: working / blocked / done counts; click jumps to the next one waiting
MouseArea {
	id: root

	property var agents: []
	readonly property var blocked: agents.filter(a => a.agent_status === "blocked")
	readonly property var done: agents.filter(a => a.agent_status === "done")
	readonly property int working: agents.filter(a => a.agent_status === "working").length
	readonly property string herdr: `${Theme.home}/.local/bin/herdr`

	visible: agents.length > 0
	implicitWidth: row.implicitWidth
	implicitHeight: row.implicitHeight

	onClicked: {
		const next = blocked[0] ?? done[0];
		if (!next)
			return;
		focuser.command = [herdr, "agent", "focus", next.pane_id];
		focuser.running = true;
		Hyprland.dispatch('hl.dsp.focus({ window = "class:com.mitchellh.ghostty" })');
	}

	RowLayout {
		id: row
		anchors.fill: parent
		spacing: 8

		Label {
			visible: root.working > 0
			text: `◑ ${root.working}`
			color: Theme.lack
		}

		Label {
			visible: root.blocked.length > 0
			text: `◆ ${root.blocked.length}`
			color: Theme.orange
		}

		Label {
			visible: root.done.length > 0
			text: `✓ ${root.done.length}`
			color: Theme.green
		}
	}

	Process {
		id: list
		command: [root.herdr, "agent", "list"]
		stdout: StdioCollector {
			onStreamFinished: {
				try {
					root.agents = JSON.parse(text).result.agents ?? [];
				} catch (e) {
					root.agents = [];
				}
			}
		}
	}

	Process {
		id: focuser
	}

	Timer {
		interval: 2000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: list.running = true
	}
}
