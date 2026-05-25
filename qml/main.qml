import QtQuick
import QtQuick.Controls
import "screens"
import "theme"

ApplicationWindow {
    id: window
    width: 800
    height: 480
    visible: true
    color: colors.voidBlack
    title: "EV HMI"

    Colors { id: colors }
    Fonts { id: fonts }

    QtObject { id: state; property string screen: "drive" }

    StackView {
        id: stack
        anchors.fill: parent
        initialItem: driveScreen
    }

    Component {
        id: driveScreen
        DrivingScreen {
            vehicle: vehicleData
            warnings: warningManager
            onDebugRequested: stack.replace(debugScreen)
            onSettingsRequested: stack.replace(settingsScreen)
        }
    }

    Component {
        id: debugScreen
        DebugScreen {
            vehicle: vehicleData
            onBackRequested: stack.replace(driveScreen)
        }
    }

    Component {
        id: settingsScreen
        SettingsScreen {
            onBackRequested: stack.replace(driveScreen)
        }
    }

    Rectangle {
        anchors.fill: parent
        color: "#000000"
        opacity: 0
        SequentialAnimation on opacity {
            running: true
            NumberAnimation { from: 0.8; to: 0.0; duration: 520; easing.type: Easing.OutCubic }
        }
    }
}
