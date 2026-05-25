import QtQuick
import QtQuick.Controls
import "../components"
import "../theme"

Item {
    id: root
    width: 800
    height: 480

    property var vehicle
    signal backRequested()

    Colors { id: colors }
    Fonts { id: fonts }

    Rectangle { anchors.fill: parent; color: colors.voidBlack }

    Text {
        anchors.left: parent.left
        anchors.leftMargin: 36
        anchors.top: parent.top
        anchors.topMargin: 26
        text: "DIAGNOSTICS"
        color: colors.textPrimary
        font.family: fonts.mono
        font.pixelSize: 18
        font.bold: true
    }

    Grid {
        anchors.centerIn: parent
        columns: 3
        spacing: 14

        TelemetryCard { label: "SPEED"; value: root.vehicle ? root.vehicle.speed : "--"; unit: "km/h"; accent: colors.copperBright }
        TelemetryCard { label: "CURRENT"; value: root.vehicle ? root.vehicle.packCurrent.toFixed(1) : "--"; unit: "A"; accent: colors.cyan }
        TelemetryCard { label: "SOC"; value: root.vehicle ? root.vehicle.batterySoc : "--"; unit: "%"; accent: colors.green }
        TelemetryCard { label: "INV TEMP"; value: root.vehicle ? root.vehicle.inverterTemp.toFixed(0) : "--"; unit: "C"; accent: colors.amber }
        TelemetryCard { label: "BAT TEMP"; value: root.vehicle ? root.vehicle.batteryTemp.toFixed(0) : "--"; unit: "C"; accent: colors.copperBright }
        TelemetryCard { label: "REGEN"; value: root.vehicle ? root.vehicle.regenKw.toFixed(1) : "--"; unit: "kW"; accent: colors.green }
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
