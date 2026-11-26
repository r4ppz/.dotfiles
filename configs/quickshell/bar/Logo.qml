import QtQuick
import "../theme"

Item {
    id: root

    readonly property string logo: "󱄅"

    implicitWidth: content.implicitWidth
    implicitHeight: content.implicitHeight

    Rectangle {
        id: content

        anchors.fill: parent

        implicitWidth: icon.implicitWidth + Theme.spacingMd
        implicitHeight: icon.implicitHeight + Theme.spacingXs

        color: Theme.red1

        Text {
            id: icon
            text: root.logo
            anchors.centerIn: parent
            color: Theme.bg
            font {
                pixelSize: Theme.fontSizeSm
                weight: Font.Bold
            }
        }
    }
}
