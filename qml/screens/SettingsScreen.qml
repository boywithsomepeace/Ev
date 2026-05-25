import QtQuick
import QtQuick.Controls
import "../theme"

Item {
    id: root
    width: 800
    height: 480

    signal backRequested()

    Colors { id: colors }
    Fonts { id: fonts }

    Rectangle { anchors.fill: parent; color: colors.voidBlack }

    Text {
        anchors.left: parent.left
        anchors.leftMargin: 36
        anchors.top: parent.top
        anchors.topMargin: 26
        text: "SYSTEM SETTINGS"
        color: colors.textPrimary
        font.family: fonts.mono
        font.pixelSize: 18
        font.bold: true
    }

    Column {
        anchors.left: parent.left
        anchors.leftMargin: 70
        anchors.top: parent.top
        anchors.topMargin: 104
        spacing: 18

        CheckBox { text: "Telemetry simulator"; checked: true }
        CheckBox { text: "Night luminance lock"; checked: true }
        CheckBox { text: "Warning audio"; checked: false }
        Slider { width: 300; from: 0.35; to: 1.0; value: 0.82 }
    }

    Button {
        anchors.left: parent.left
        anchors.leftMargin: 34
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 28
        text: "BACK"
        onClicked: root.backRequested()
    }
}
