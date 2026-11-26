import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Services.SystemTray
import "../theme/"

RowLayout {
    spacing: Theme.spacingXs

    Repeater {
        model: SystemTray.items

        delegate: Item {
            id: trayItem
            required property SystemTrayItem modelData

            implicitWidth: Theme.sizeSm
            implicitHeight: Theme.sizeSm

            QsMenuAnchor {
                id: menuAnchor
                // This is ai shit so I dont understant
                menu: trayItem.modelData.menu // qmllint disable incompatible-type
                anchor.item: trayItem
            }

            Image {
                anchors.fill: parent
                source: trayItem.modelData.icon
                fillMode: Image.PreserveAspectFit
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton | Qt.MiddleButton

                onClicked: mouse => {
                    if (mouse.button === Qt.LeftButton) {
                        if (trayItem.modelData.onlyMenu) {
                            if (trayItem.modelData.hasMenu)
                                menuAnchor.open();
                        } else {
                            trayItem.modelData.activate();
                        }
                    } else if (mouse.button === Qt.RightButton) {
                        if (trayItem.modelData.hasMenu)
                            menuAnchor.open();
                    } else if (mouse.button === Qt.MiddleButton) {
                        trayItem.modelData.secondaryActivate();
                    }
                }

                onWheel: wheel => {
                    trayItem.modelData.scroll(wheel.angleDelta.y, false);
                }
            }
        }
    }
}
