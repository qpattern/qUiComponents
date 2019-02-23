import QtQuick 2.0

Rectangle {
    id: root

    property int popupMargin: 0

    property alias count: repeater.count
    property alias model: repeater.model

    color : count > 0 ? "#66000000" : "transparent"

    readonly property string __STATE_OPENED: "opened"
    readonly property string __STATE_CLOSED: "closed"

    function reset() {
        popupModel.clear()
    }

    function dismiss(index, force, immediate) {
        if (index < 0 || index >= count) {
            console.warn("Invalid index:", index)
            return

        } else if (!force && root.children[index].closeable) {
            console.warn("Can't dismiss popup")
            return

        } else if (!immediate && root.children[index].open) {
                root.children[index].close()

        } else {
            popupModel.remove(index)
        }
    }

    function find(identifier) {
        for (var i = 0; i < popupModel.count; i++) {
            if (identifier === popupModel.get(i).identifier) {
                return i
            }
        }

        return -1
    }

    /**
      * This method shows the popup in the scene.
      * @param popupData map of popup's parameters:
      *     - name: indicates the name of the qml file to show (without extension); default is "GenericPopup"
      *     - modal: if false a tap outside the popup closes it (unless it requires interaction); default is false
      *     - priority: indicates the stack order; default is 0
      *     - autoCloseAfterMs: timeout in ms after which the popup should automatically be closed
      *     - identifier: an id by which the popup can be found using popupLayer.find(...) when it is created; if a
      *             popup with the same identifier is already opened the current request will be ignored
	  *
      * @param configuration custom popup's configuration
      */
    function showPopup(popupData, configuration) {
        // set defaul values
        if (!popupData.name            ) popupData.name             = "GenericPopup"
        if (!popupData.modal           ) popupData.modal            = false
        if (!popupData.priority        ) popupData.priority         = 0
        if (!popupData.autoCloseAfterMs) popupData.autoCloseAfterMs = -1

        if (popupData.identifier && find(popupData.identifier) >= 0) {
            // the popup is already opened, ignore the request
            return
        }

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

            z         : model.priority

            onClicked : if (!model.modal && !closeable && !popupLoader.contains(mapToItem(popupLoader, mouse.x, mouse.y))) popupLoader.state = root.__STATE_CLOSED

            property bool closeable : popupLoader.item.requiresInteraction ? popupLoader.item.requiresInteraction : false
            property bool open      : popupLoader.state == root.__STATE_OPENED

            resources: [
                Connections {
                    target               : popupLoader.item
                    ignoreUnknownSignals : true
                    onDismiss            : popupDelegate.close()
                },
                Timer {
                    interval    : model.autoCloseAfterMs
                    running     : interval > 0
                    onTriggered : popupDelegate.close()
                }
            ]

            function close() {
                popupLoader.state = root.__STATE_CLOSED
            }

            function configure(configuration) {
                popupLoader.item.configure(configuration)
            }

            Loader {
                id: popupLoader

                width : root.width - 2*root.popupMargin

                anchors.horizontalCenter: parent.horizontalCenter

                source: name + ".qml"

                onLoaded: popupLoader.state = root.__STATE_OPENED

                readonly property int _POSITION_OPENED: popupDelegate.height - popupLoader.height - root.popupMargin
                readonly property int _POSITION_CLOSED: -popupLoader.height

                state: root.__STATE_CLOSED
                states: [
                    State {
                        name: root.__STATE_OPENED

                        PropertyChanges { target: popupLoader; opacity: 1; y: popupLoader._POSITION_OPENED }
                    },
                    State {
                        name: root.__STATE_CLOSED

                        PropertyChanges { target: popupLoader; opacity: 0; y: popupLoader._POSITION_CLOSED }
                    }
                ]

                transitions: [
                    Transition {
                        from: root.__STATE_CLOSED
                        to  : root.__STATE_OPENED

                        NumberAnimation { property: "opacity"; duration: 350; easing.type: Easing.OutCirc; from: 0 }
                        NumberAnimation { property: "y";       duration: 350; easing.type: Easing.OutCirc; from: popupDelegate.height }
                    },
                    Transition {
                        from: root.__STATE_OPENED
                        to  : root.__STATE_CLOSED

                        onRunningChanged: if (!running) root.dismiss(index, true) // remove element

                        NumberAnimation { property: "opacity"; duration: 350; easing.type: Easing.InCirc; from: 1 }
                        NumberAnimation { property: "y";       duration: 350; easing.type: Easing.InCirc; from: popupLoader._POSITION_OPENED }
                    }
                ]
            }
        }
    }
}
