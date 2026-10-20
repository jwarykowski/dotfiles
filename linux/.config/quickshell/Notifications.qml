import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.Notifications

// notification daemon: popups top right; click dismisses, critical ones stay
Scope {
	NotificationServer {
		id: server
		keepOnReload: true
		actionsSupported: true
		bodySupported: true
		onNotification: n => n.tracked = true
	}

	PanelWindow {
		anchors {
			top: true
			right: true
		}
		margins {
			top: 8
			right: 8
		}
		exclusionMode: ExclusionMode.Normal
		implicitWidth: 380
		implicitHeight: column.implicitHeight
		color: "transparent"
		visible: server.trackedNotifications.values.length > 0

		ColumnLayout {
			id: column
			width: parent.width
			spacing: 8

			Repeater {
				model: server.trackedNotifications

				Rectangle {
					id: card

					required property var modelData
					readonly property bool critical: modelData.urgency === NotificationUrgency.Critical

					Layout.fillWidth: true
					implicitHeight: content.implicitHeight + 20
					color: Theme.surface
					border.width: 2
					border.color: critical ? Theme.red : Theme.border

					MouseArea {
						anchors.fill: parent
						onClicked: card.modelData.dismiss()
					}

					ColumnLayout {
						id: content
						anchors.fill: parent
						anchors.margins: 10
						spacing: 4

						Label {
							Layout.fillWidth: true
							text: card.modelData.summary
							font.bold: true
							elide: Text.ElideRight
						}

						Label {
							Layout.fillWidth: true
							visible: text !== ""
							text: card.modelData.body
							color: Theme.muted
							wrapMode: Text.Wrap
							maximumLineCount: 4
							textFormat: Text.PlainText
						}

						RowLayout {
							visible: card.modelData.actions.length > 0
							spacing: 12

							Repeater {
								model: card.modelData.actions

								Label {
									required property var modelData
									text: `[${modelData.text}]`
									color: Theme.lack

									MouseArea {
										anchors.fill: parent
										onClicked: parent.modelData.invoke()
									}
								}
							}
						}
					}

					Timer {
						running: !card.critical
						interval: card.modelData.expireTimeout > 0 ? card.modelData.expireTimeout * 1000 : 5000
						onTriggered: card.modelData.expire()
					}
				}
			}
		}
	}
}
