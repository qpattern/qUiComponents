import QtQuick 2.0
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

import QmlScaffold.Controls.Themes 1.0

Menu {
    id: root

    closePolicy: Popup.CloseOnEscape | Popup.CloseOnReleaseOutside

    transformOrigin: "BottomRight"
    enter : Transition { NumberAnimation { property: "scale"; from: 0.0; to: 1.0; duration: 150 } }
    exit  : Transition { NumberAnimation { property: "scale"; from: 1.0; to: 0.0; duration: 150 } }

    clip: false

    width: {
        var result = 0;
        var padding = 0;
        for (var i = 0; i < count; ++i) {
            var item = itemAt(i);
            result = Math.max(item.contentItem.implicitWidth, result);
            padding = Math.max(item.padding, padding);
        }
        return result + padding * 2;
    }

    property FloatingOptionsMenuTheme theme : FloatingOptionsMenuTheme {}

    background: null

    delegate: MenuItem {
        id: delegate

        implicitWidth  : contentItem.implicitWidth + leftPadding + rightPadding
        implicitHeight : contentItem.implicitHeight + topPadding + bottomPadding

        background: MouseArea {
            onClicked : root.close()
        }

        contentItem: Item {

            implicitWidth  : labelOptionButton.width + labelOptionButton.anchors.rightMargin + roundOptionButton.width
            implicitHeight : childrenRect.height

            FloatingButton {
                id: labelOptionButton
                objectName: "labelOptionButton"

                anchors.right          : roundOptionButton.left
                anchors.rightMargin    : root.theme.spacing
                anchors.verticalCenter : roundOptionButton.verticalCenter

                action                 : delegate.action

                theme                  : root.theme.label
            }

            FloatingActionButton {
                id: roundOptionButton
                objectName: "roundOptionButton"

                height        : 40

                anchors.right : parent.right

                action        : delegate.action

                theme         : root.theme.item
            }
        }
    }
}
