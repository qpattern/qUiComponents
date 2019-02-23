import QtQuick 2.0

Rectangle {
    id: root

    property int popupMargin: 0

    property alias count: repeater.count

    color  : count > 0 ? "#66000000" : "transparent"

    function reset() {
        popupModel.clear()
    }

    function dismiss(index) {
        popupModel.remove(index)
    }

    /**
      * This method shows the popup in the scene.
      * @param popupData map of popup's parameters:
      *     - name: indicates the name of the qml file to show (without extension); default is "GenericPopup"
      *     - modal: if false a tap outside the popup closes it (unless it requires interaction); default is false
      *     - priority: indicates the stack order; default is 0
      *     - autoCloseAfterMs: timeout in ms after which the popup should automatically be closed
	  *
      * @param configuration custom popup's configuration
      */
    function showPopup(popupData, configuration) {
        // set defaul values
        if (!popupData.name            ) popupData.name             = "GenericPopup"
        if (!popupData.modal           ) popupData.modal            = false
        if (!popupData.priority        ) popupData.priority         = 0
        if (!popupData.autoCloseAfterMs) popupData.autoCloseAfterMs = -1

        // append popup to the scene
        popupModel.append(popupData)

        // set custom configuration
        if (configuration) {
            root.children[root.children.length-2].configure(configuration) // ignore the last element (the repeater)
        }
    }

    // Popup repater
    Repeater {
        id: repeater

        // popup list
        model: ListModel { id: popupModel }

        delegate: MouseArea {
            id: popupDelegate

            width     : parent.width
            height    : parent.height

            z         : priority

            onClicked : if (!modal && !popupLoader.item.requiresInteraction && !popupLoader.contains(mapToItem(popupLoader, mouse.x, mouse.y))) popupLoader.state = popupLoader._STATE_CLOSED

            resources: Timer {
                id: hideTimer

                interval    : model.autoCloseAfterMs

                running     : model.autoCloseAfterMs > 0

                onTriggered : popupLoader.state = popupLoader._STATE_CLOSED
            }

            function close() {
                popupLoader.state = popupLoader._STATE_CLOSED
            }

            function configure(configuration) {
                popupLoader.item.configure(configuration)
            }

            Loader {
                id: popupLoader

                width : root.width - 2*root.popupMargin

                anchors.horizontalCenter: parent.horizontalCenter

                source: name + ".qml"

                onLoaded: {
                    if (popupDelegate.conf) {
                        item.configure(popupDelegate.conf)
                    }

                    popupLoader.state = popupLoader._STATE_OPENED
                }

                Connections {
                    target               : popupLoader.item
                    ignoreUnknownSignals : true
                    onDismiss            : popupLoader.state = popupLoader._STATE_CLOSED
                }

                readonly property string _STATE_OPENED: "opened"
                readonly property string _STATE_CLOSED: "closed"

                readonly property int _POSITION_OPENED: popupDelegate.height - popupLoader.height - root.popupMargin
                readonly property int _POSITION_CLOSED: -popupLoader.height

                state: _STATE_CLOSED
                states: [
                    State {
                        name: popupLoader._STATE_OPENED

                        PropertyChanges { target: popupLoader; opacity: 1; y: popupLoader._POSITION_OPENED }
                    },
                    State {
                        name: popupLoader._STATE_CLOSED

                        PropertyChanges { target: popupLoader; opacity: 0; y: popupLoader._POSITION_CLOSED }
                    }
                ]

                transitions: [
                    Transition {
                        from: popupLoader._STATE_CLOSED
                        to  : popupLoader._STATE_OPENED

                        NumberAnimation { property: "opacity"; duration: 350; easing.type: Easing.OutCirc; from: 0 }
                        NumberAnimation { property: "y";       duration: 350; easing.type: Easing.OutCirc; from: popupDelegate.height }
                    },
                    Transition {
                        from: popupLoader._STATE_OPENED
                        to  : popupLoader._STATE_CLOSED

                        onRunningChanged: if (!running) root.dismiss(index) // remove element

                        NumberAnimation { property: "opacity"; duration: 350; easing.type: Easing.InCirc; from: 1 }
                        NumberAnimation { property: "y";       duration: 350; easing.type: Easing.InCirc; from: popupLoader._POSITION_OPENED }
                    }
                ]
            }
        }
    }
}
