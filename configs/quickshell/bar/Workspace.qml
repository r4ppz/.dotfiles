import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../theme/"

Item {
    id: root

    required property int workspaceId

    property bool hovered: mouseArea.containsMouse
    property bool active: Hyprland.focusedWorkspace?.id === workspaceId
    property bool activeOrHovered: root.active || mouseArea.containsMouse

    property string icon: {
        switch (workspaceId) {
        case 1:
            return "1";
        case 2:
            return "2";
        case 3:
            return "3";
        case 4:
            return "4";
        case 5:
            return "5";
        case 6:
            return "6";
        case 7:
            return "7";
        case 8:
            return "8";
        case 9:
            return "9";
        case 10:
            return "10";
        default:
            return "?";
        }
    }

    implicitWidth: 28

    Layout.fillHeight: true
    Layout.topMargin: Theme.spacingXs
    Layout.bottomMargin: Theme.spacingXs

    Rectangle {
        anchors.fill: parent

        color: root.activeOrHovered ? Theme.blue2 : "transparent"

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                Hyprland.dispatch(`hl.dsp.focus({ workspace = "${root.workspaceId}" })`);
            }
        }

        Text {
            text: root.icon
            anchors.centerIn: parent
            color: root.activeOrHovered ? Theme.bg : Theme.fg
            font {
                family: Theme.fontMono
                pixelSize: Theme.iconSizeSm
                weight: root.activeOrHovered ? Font.FontWeight.Bold : Font.FontWeight.DemiBold
            }
        }
    }
}
