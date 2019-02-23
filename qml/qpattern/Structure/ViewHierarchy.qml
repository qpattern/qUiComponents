import QtQuick 2.0
import QtQuick.Controls 2.0
import qpattern.Popups 1.0

Item {
    id: root

    property bool initialized : false
    property bool loggedIn    : false

    readonly property alias state : stackView.state

    property Component splashPage : nullComponent
    property Component guestPage  : nullComponent
    property Component homePage   : nullComponent

    Component {
        id: nullComponent

        Item {
            Component.onCompleted: console.warn(qsTr("ViewHierarchy is showing an empty component for the state %1").arg(root.state))
        }
    }

    StackView {
        id: stackView

        anchors.fill: parent

        states: [
            State {
                name: "splash"
                when: !root.initialized
                StateChangeScript { script: stackView.replace(root.splashPage) }
            },
            State {
                name: "guest"
                when: root.initialized && !root.loggedIn
                StateChangeScript { script: stackView.replace(root.guestPage) }
            },
            State {
                name: "home"
                when: root.initialized && root.loggedIn
                StateChangeScript { script: stackView.replace(root.homePage) }
            }
        ]

        replaceExit : Transition { PropertyAnimation { property: "opacity"; from: 1; to: 0; duration: 1000; easing.type: Easing.OutCubic }}
        replaceEnter: Transition { PropertyAnimation { property: "opacity"; from: 0; to: 1; duration: 1000; easing.type: Easing.OutCubic }}
    }

    PopupLayer {
        anchors.fill: parent
    }
}
