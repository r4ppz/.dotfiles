import QtQuick
import QtQuick.Layouts
import Quickshell.Hyprland
import "../theme/"

Item {
    id: root

    required property string workspaceName
    property string monitorName: ""

    property string activeSpecialName: ""

    property bool active: root.activeSpecialName === workspaceName
    property bool activeOrHovered: root.active || mouseArea.containsMouse

    implicitWidth: 28

    Layout.fillHeight: true
    Layout.topMargin: Theme.spacingXs
    Layout.bottomMargin: Theme.spacingXs

    Connections {
        target: Hyprland

        function onRawEvent(event) {
            if (event.name !== "activespecialv2")
                return;

            const parts = event.parse(3);

            if (parts[2] === root.monitorName)
                root.activeSpecialName = parts[1] ?? "";
        }
    }

    Component.onCompleted: {
        const monitors = Hyprland.monitors.values;

        for (let i = 0; i < monitors.length; i++) {
            if (monitors[i].name === root.monitorName) {
                root.activeSpecialName = monitors[i].lastIpcObject?.specialWorkspace?.name ?? "";
                break;
            }
        }
    }

    Rectangle {
        anchors.fill: parent

        color: root.activeOrHovered ? Theme.orange2 : Theme.orange1

        MouseArea {
            id: mouseArea

            anchors.fill: parent
            hoverEnabled: true

            onClicked: {
                const name = root.workspaceName.replace(/^special:/, "");
                Hyprland.dispatch(`hl.dsp.workspace.toggle_special("${name}")`);
            }
        }

        Text {
            text: "S"
            anchors.centerIn: parent
            color: Theme.bg
            font {
                family: Theme.fontMono
                pixelSize: Theme.iconSizeSm
                weight: root.activeOrHovered ? Font.FontWeight.Bold : Font.FontWeight.DemiBold
            }
        }
    }
}
