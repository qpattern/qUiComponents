import QtQuick 2.4
import QtQuick.Controls 2.3
import QtGraphicalEffects 1.0

import QmlScaffold.Controls 1.0
import QmlScaffold.Controls.Themes 1.0

Item {
    id: root

    // disable item when popup is opened to avoid unwanted clicks on items below the menu
    enabled: !optionsPopup.opened

    function showResult(msg) {
        dialog.title = msg
        dialog.open()
    }

    FloatingButton {
        id: squareButton

        action: Action {
            text        : "action message"
            icon.name   : "icon name"
            onTriggered : root.showResult("Message from the button")
        }
    }

    FloatingActionButton {
        id: button

        anchors.bottom : parent.bottom
        anchors.right  : parent.right

        action: Action {
            icon.name   : "+"
            onTriggered : optionsPopup.open()
        }

        theme.background.color : "red"
        theme.label.color      : "white"
        theme.label.fontSize   : 40

        Behavior on rotation { NumberAnimation {}}

        Connections {
            target: optionsPopup

            onAboutToHide: {
                enterAnimation.stop()
                exitAnimation.start()
            }

            onAboutToShow: {
                exitAnimation.stop()
                enterAnimation.start()
            }
        }

        NumberAnimation {
            id: enterAnimation

            target   : button.contentItem
            property : "rotation"
            to       : 45
            duration : 150
        }

        NumberAnimation {
            id: exitAnimation

            target   : button.contentItem
            property : "rotation"
            to       : 0
            duration : 150
        }
    }

    FloatingOptionsMenu {
        id: optionsPopup

        parent : button

        x      : parent.width - width - 3
        y      : -height - 10

        theme.item.background.color : "green"
        theme.item.label.color      : "white"
        theme.item.label.fontSize   : 25

        Action { text: "Plus"     ; icon.name: "+"; onTriggered: root.showResult(text) }
        Action { text: "Minus"    ; icon.name: "-"; onTriggered: root.showResult(text) }
        Action { text: "Multiply" ; icon.name: "x"; onTriggered: root.showResult(text) }
        Action { text: "Divide"   ; icon.name: "/"; onTriggered: root.showResult(text) }
    }

    Dialog {
        id: dialog

        anchors.centerIn : parent

        standardButtons  : Dialog.Ok

        title            : qsTr("Button clicked")
    }
}
