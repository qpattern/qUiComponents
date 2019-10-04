import QtQuick 2.9
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

import "Themes"

Button {
    id: root

    property FloatingButtonTheme theme: FloatingButtonTheme {}

    background: DropShadow {
        anchors.fill   : parent

        radius         : root.theme.shadow.radius
        samples        : root.theme.shadow.samples
        verticalOffset : root.theme.shadow.verticalOffset

        color          : root.theme.shadow.color

        source         : rectangle

        Rectangle {
            id: rectangle
            objectName: "backgoundRectangle"

            anchors.fill : parent

            radius       : root.theme.background.radius > 0 ? root.theme.background.radius : root.height * 0.5
            smooth       : true

            visible      : false

            color        : root.theme.background.color
        }
    }

    contentItem: Text {
        horizontalAlignment : Text.AlignHCenter
        verticalAlignment   : Text.AlignVCenter

        font.pointSize      : root.theme.label.fontSize > 0 ? root.theme.label.fontSize : fontInfo.pointSize
        font.family         : root.theme.label.fontFamily

        color               : root.theme.label.color

        text                : root.text
    }
}
