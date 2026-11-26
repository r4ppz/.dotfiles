pragma Singleton
import QtQuick

QtObject {
    id: root

    readonly property color bg: "#282828"
    readonly property color fg: "#ebdbb2"

    readonly property color gray1: "#a89984"
    readonly property color gray2: "#928374"

    readonly property color aqua1: "#689d6a"
    readonly property color aqua2: "#8ec07c"

    readonly property color blue1: "#458588"
    readonly property color blue2: "#83a598"

    readonly property color yellow1: "#d79921"
    readonly property color yellow2: "#fabd2f"

    readonly property color purple1: "#b16286"
    readonly property color purple2: "#d3869b"

    readonly property color red1: "#cc241d"
    readonly property color red2: "#fb4934"

    readonly property color green1: "#98971a"
    readonly property color green2: "#b8bb26"

    readonly property color orange1: "#d65d0e"
    readonly property color orange2: "#fe8019"

    readonly property int spacingXs: 4
    readonly property int spacingSm: 8
    readonly property int spacingMd: 12
    readonly property int spacingLg: 16
    readonly property int spacingXl: 24
    readonly property int spacingXxl: 32

    readonly property int sizeXs: 16
    readonly property int sizeSm: 20
    readonly property int sizeMd: 24
    readonly property int sizeLg: 32
    readonly property int sizeXl: 40
    readonly property int sizeXxl: 48

    readonly property int barHeightSm: 24
    readonly property int barHeightMd: 32
    readonly property int barHeightLg: 40

    readonly property int radiusXs: 2
    readonly property int radiusSm: 4
    readonly property int radiusMd: 8
    readonly property int radiusLg: 12
    readonly property int radiusXl: 16
    readonly property int radiusFull: 999

    readonly property string fontFamily: "Inter, sans-serif"
    readonly property string fontMono: "JetBrainsMono Nerd Font, monospace"

    readonly property int fontSizeXs: 10
    readonly property int fontSizeSm: 11
    readonly property int fontSizeMd: 13
    readonly property int fontSizeLg: 15
    readonly property int fontSizeXl: 18
    readonly property int fontSizeXxl: 22

    readonly property int iconSizeSm: 14
    readonly property int iconSizeMd: 16
    readonly property int iconSizeLg: 20

    readonly property int controlHeightSm: 24
    readonly property int controlHeightMd: 32
    readonly property int controlHeightLg: 40
}
