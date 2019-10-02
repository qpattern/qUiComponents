import QtQuick 2.0
import QtQuick.Controls 2.4

import QmlScaffold.Controls 1.0

Item {
    id: root

    width : childrenRect.width
    height: childrenRect.height

    default property alias children: childrenContainer.children

    property real minimumX   : margin
    property real maximumX   : parent.width - margin - width
    property real minimumY   : margin
    property real maximumY   : parent.height - margin - height
    property int  margin     : 0
    property bool stickyDrag : false

    readonly property bool dragging  : dragArea.drag.active
    readonly property bool stickLeft : x <= (minimumX + (maximumX - minimumX) * 0.5)
    readonly property bool stickTop  : y <= (minimumY + (maximumY - minimumY) * 0.5)

    function stickToTheNearestEdge() {
        x = stickLeft ? minimumX : maximumX
        y = stickTop  ? minimumY : maximumY
    }

    Behavior on x { enabled: root.stickyDrag; animation: NumberAnimation{} }
    Behavior on y { enabled: root.stickyDrag; animation: NumberAnimation{} }

    MouseArea {
        id: dragArea

        width : childrenRect.width
        height: childrenRect.height

        drag.target         : root
        drag.axis           : Drag.XAndYAxis
        drag.minimumX       : root.minimumX
        drag.maximumX       : root.maximumX
        drag.minimumY       : root.minimumY
        drag.maximumY       : root.maximumY
        drag.filterChildren : true

        onReleased : if (root.stickyDrag) stickToTheNearestEdge()

        Item {
            id: childrenContainer

            width : childrenRect.width
            height: childrenRect.height
        }
    }
}
