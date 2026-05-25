import QtQuick
import "../theme"

Item {
    id: root
    width: 300
    height: 72

    property bool leftIndicator: false
    property bool rightIndicator: false
    property bool headlights: false
    property string clockText: Qt.formatTime(new Date(), "hh:mm ap")
    property string weatherText: "16-18"

    Colors { id: colors }
    Fonts { id: fonts }

    Timer {
        interval: 1000
        running: true
        repeat: true
        onTriggered: root.clockText = Qt.formatTime(new Date(), "hh:mm ap")
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        spacing: 74

        Text {
            text: root.clockText
            color: colors.whiteSoft
            font.family: fonts.display
            font.pixelSize: fonts.caption
            font.bold: true
        }

        Row {
            spacing: 7
            Text { text: "☀"; color: colors.amber; font.pixelSize: 17 }
            Text {
                anchors.verticalCenter: parent.verticalCenter
                text: root.weatherText + "°"
                color: colors.whiteSoft
                font.family: fonts.display
                font.pixelSize: fonts.caption
                font.bold: true
            }
        }
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 34
        spacing: 20

        Text {
            text: "◀"
            color: root.leftIndicator ? colors.green : colors.textMuted
            opacity: root.leftIndicator ? 1.0 : 0.45
            font.pixelSize: 18
            Behavior on opacity { NumberAnimation { duration: 120 } }
        }
        Text {
            text: "▰D"
            color: root.headlights ? colors.textSecondary : colors.textMuted
            font.family: fonts.mono
            font.pixelSize: 17
            opacity: root.headlights ? 0.9 : 0.4
        }
        Text {
            text: "▰D"
            color: colors.textMuted
            font.family: fonts.mono
            font.pixelSize: 17
            opacity: 0.55
        }
        Text {
            text: "▶"
            color: root.rightIndicator ? colors.green : colors.textMuted
            opacity: root.rightIndicator ? 1.0 : 0.45
            font.pixelSize: 18
            Behavior on opacity { NumberAnimation { duration: 120 } }
        }
    }
}
