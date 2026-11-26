import QtQuick
import Quickshell.Hyprland
import "../theme"

Item {
    id: root

    property string currentSubmap: ""

    visible: currentSubmap !== ""
    implicitWidth: badge.implicitWidth
    implicitHeight: badge.implicitHeight

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name === "submap") {
                root.currentSubmap = event.data;
            }
        }
    }

    Rectangle {
        id: badge
        implicitWidth: label.implicitWidth + 10
        implicitHeight: label.implicitHeight + 2
        color: Theme.yellow1

        Text {
            id: label
            text: root.currentSubmap
            anchors.centerIn: parent
            color: Theme.bg
            font {
                pixelSize: Theme.fontSizeSm
                weight: Font.Medium
            }
        }
    }
}
