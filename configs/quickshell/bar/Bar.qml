import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Hyprland
import "../theme"

// qmllint disable uncreatable-type
PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 27
    color: Theme.bg

    RowLayout {
        anchors {
            fill: parent
            leftMargin: Theme.spacingXs
            rightMargin: Theme.spacingXs
        }

        spacing: 0

        // Left section
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 1

            RowLayout {
                anchors {
                    left: parent.left
                    verticalCenter: parent.verticalCenter
                }

                height: parent.height
                spacing: Theme.spacingSm

                Repeater {
                    model: {
                        const ids = [1, 2, 3];
                        const activeId = Hyprland.focusedWorkspace?.id;

                        if (activeId && !ids.includes(activeId)) {
                            ids.push(activeId);
                            ids.sort((a, b) => a - b);
                        }

                        return ids;
                    }

                    Workspace {
                        required property int modelData
                        workspaceId: modelData
                    }
                }

                Repeater {
                    model: {
                        const monitorName = Hyprland.monitorFor(root.screen)?.name ?? "";
                        const workspaces = Hyprland.workspaces.values;
                        const specials = [];

                        for (let i = 0; i < workspaces.length; i++) {
                            if (workspaces[i].name?.startsWith("special:"))
                                specials.push({
                                    name: workspaces[i].name,
                                    monitorName: monitorName
                                });
                        }

                        return specials;
                    }

                    SpecialWorkspace {
                        required property var modelData
                        workspaceName: modelData.name
                        monitorName: modelData.monitorName
                    }
                }

                Submap {}
            }
        }

        // Center section
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 1

            Clock {
                anchors.centerIn: parent
            }
        }

        // Right section
        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true
            Layout.preferredWidth: 1

            RowLayout {
                anchors {
                    right: parent.right
                    verticalCenter: parent.verticalCenter
                }

                spacing: Theme.spacingSm

                Tray {}
                Logo {}
            }
        }
    }
}
