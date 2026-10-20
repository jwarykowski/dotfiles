import QtQuick
import Quickshell

Label {
	text: Qt.formatDateTime(clock.date, "ddd d MMM  HH:mm")

	SystemClock {
		id: clock
		precision: SystemClock.Minutes
	}
}
