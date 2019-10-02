import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0

import QmlScaffold.Controls 1.0

ColumnLayout {
    id: root

    Text {
        Layout.fillWidth : true

        wrapMode         : Text.WordWrap

        text             : qsTr("This example shows how to make a custom element (in this case a blue circle) draggable inside his parent")
    }

    Row {
        Layout.fillWidth: true

        CheckBox {
            id: stickyDragCheckbox

            text            : qsTr("Sticky drag")

            ToolTip.visible : hovered
            ToolTip.text    : qsTr("Indicates whether to stick the item to the edges at the end of the drag")
        }
    }

    // Container: the element can be dragged arround inside this item
    Rectangle {
        Layout.fillHeight : true
        Layout.fillWidth  : true

        color             : "transparent"
        border.color      : "green"

        // Wraps the element to enable the drag inside the parent
        DraggableItem {
            id: draggableItem

            stickyDrag : stickyDragCheckbox.checked

            // Item to drag
            Rectangle {
                width  : 50
                height : 50

                color  : "blue"
                radius : width * 0.5
            }
        }

        Rectangle {
            height  : draggableItem.height
            width   : draggableItem.width

            opacity : 0.5
            radius  :  width * 0.5

            x       : draggableItem.stickLeft ? 0 : parent.width - width
            y       : draggableItem.stickTop  ? 0 : parent.height - height

            color   : "lightgray"
            
            visible : draggableItem.stickyDrag && draggableItem.dragging
        }
    }
}
