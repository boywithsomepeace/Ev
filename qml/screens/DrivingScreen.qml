import QtQuick
import QtQuick.Controls
import "../components"
import "../theme"

Item {
    id: root
    width: 800
    height: 480

    property var vehicle
    property var warnings
    signal debugRequested()
    signal settingsRequested()

    Colors { id: colors }
    Fonts { id: fonts }

    Rectangle {
        anchors.fill: parent
        color: colors.voidBlack
    }

    Text {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        anchors.topMargin: 22
        text: "Electric Car Dashboard"
        color: "#bdaaa5"
        font.family: fonts.display
        font.pixelSize: 42
        font.weight: Font.DemiBold
        opacity: 0.92
        visible: parent.height >= 470
    }

    Text {
        anchors.right: parent.right
        anchors.rightMargin: 78
        anchors.top: parent.top
        anchors.topMargin: 24
        text: "▰"
        color: "#bdaaa5"
        font.pixelSize: 48
        rotation: -45
        opacity: 0.8
        visible: parent.height >= 470
    }

    Rectangle {
        id: cockpit
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        anchors.leftMargin: 16
        anchors.rightMargin: 16
        anchors.topMargin: parent.height >= 470 ? 116 : 0
        anchors.bottomMargin: parent.height >= 470 ? 28 : 0
        color: colors.voidBlack
    }

    Canvas {
        id: shell
        anchors.fill: cockpit
        antialiasing: true
        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            ctx.lineJoin = "miter"

            function sx(v) { return v * width / 768 }
            function sy(v) { return v * height / 320 }

            var pts = [
                [8, 156], [112, 28], [238, 10], [298, 50],
                [470, 50], [530, 10], [656, 28], [760, 156],
                [672, 304], [96, 304]
            ]

            ctx.strokeStyle = colors.copper
            ctx.globalAlpha = 0.82
            ctx.lineWidth = 4
            ctx.beginPath()
            ctx.moveTo(sx(pts[0][0]), sy(pts[0][1]))
            for (var i = 1; i < pts.length; ++i)
                ctx.lineTo(sx(pts[i][0]), sy(pts[i][1]))
            ctx.closePath()
            ctx.stroke()

            ctx.globalAlpha = 0.18
            ctx.lineWidth = 1
            ctx.strokeStyle = colors.copperBright
            ctx.stroke()

            ctx.globalAlpha = 0.35
            ctx.strokeStyle = colors.lineDim
            ctx.lineWidth = 1
            ctx.beginPath()
            ctx.moveTo(sx(150), sy(244))
            ctx.lineTo(sx(250), sy(220))
            ctx.lineTo(sx(306), sy(220))
            ctx.lineTo(sx(334), sy(205))
            ctx.lineTo(sx(434), sy(205))
            ctx.lineTo(sx(462), sy(220))
            ctx.lineTo(sx(518), sy(220))
            ctx.lineTo(sx(618), sy(244))
            ctx.stroke()

            ctx.globalAlpha = 0.18
            ctx.beginPath()
            ctx.moveTo(sx(92), sy(304))
            ctx.lineTo(sx(676), sy(304))
            ctx.stroke()
        }
    }

    ChevronTunnel {
        anchors.left: cockpit.left
        anchors.leftMargin: 160
        anchors.verticalCenter: cockpit.verticalCenter
        anchors.verticalCenterOffset: 8
        width: 196
        height: 238
    }

    ChevronTunnel {
        anchors.right: cockpit.right
        anchors.rightMargin: 160
        anchors.verticalCenter: cockpit.verticalCenter
        anchors.verticalCenterOffset: 8
        width: 196
        height: 238
        mirrored: true
    }

    TopStatusBar {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: cockpit.top
        anchors.topMargin: 20
        leftIndicator: root.vehicle ? root.vehicle.leftIndicator : false
        rightIndicator: root.vehicle ? root.vehicle.rightIndicator : false
        headlights: root.vehicle ? root.vehicle.headlights : false
    }

    WarningPopup {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: cockpit.top
        anchors.topMargin: 2
        active: root.warnings ? root.warnings.active : false
        title: root.warnings ? root.warnings.title : ""
        message: root.warnings ? root.warnings.message : ""
        severity: root.warnings ? root.warnings.severity : "nominal"
    }

    Speedometer {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: cockpit.top
        anchors.topMargin: 82
        speed: root.vehicle ? root.vehicle.speed : 0
        rangeKm: root.vehicle ? root.vehicle.rangeKm : 0
        regenKw: root.vehicle ? root.vehicle.regenKw : 0
    }

    BottomTelemetryRail {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: cockpit.bottom
        anchors.bottomMargin: 12
        width: 520
        avgText: "Avg. 11.3 u/km"
        odoText: "ODO. 6666.6 km"
        rangeText: (root.vehicle ? root.vehicle.rangeKm : 465) + "km"
        gear: root.vehicle ? root.vehicle.gear : "N"
        batterySoc: root.vehicle ? root.vehicle.batterySoc : 100
    }

    MouseArea {
        anchors.left: parent.left
        anchors.top: parent.top
        width: 80
        height: 80
        onDoubleClicked: root.debugRequested()
    }

    MouseArea {
        anchors.right: parent.right
        anchors.top: parent.top
        width: 80
        height: 80
        onDoubleClicked: root.settingsRequested()
    }
}
