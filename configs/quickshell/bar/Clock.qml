import QtQuick
import QtQuick.Layouts
import Quickshell
import "../theme"

RowLayout {
    id: root

    spacing: Theme.spacingSm

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Text {
        text: "󰥔"
        color: Theme.aqua2
        font {
            pixelSize: Theme.fontSizeSm
            weight: Font.Medium
        }
    }

    Text {
        text: Qt.formatDateTime(clock.date, "hh:mm:ss AP")
        color: Theme.aqua2
        font {
            pixelSize: Theme.fontSizeSm
            weight: Font.Medium
            letterSpacing: 1.2
        }
    }
}
