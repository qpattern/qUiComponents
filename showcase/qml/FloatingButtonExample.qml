import QtQuick 2.4
import QtQuick.Controls 2.3

import QmlScaffold.Controls 1.0

Item {
    id: root

    function showResult(msg) {
        dialog.title = msg
        dialog.open()
    }

    FloatingButton {
        id: squareButton

        anchors.centerIn: parent

        action: Action {
            text: "action message"
            icon.name: "icon name"
            onTriggered: root.showResult("Message from the button")
        }
    }

    Dialog {
        id: dialog

        anchors.centerIn : parent

        standardButtons  : Dialog.Ok

        title            : qsTr("Button clicked")
    }
}
