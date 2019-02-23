import QtQuick 2.0
import QtQuick.Controls 2.0
import qpattern.Structure 1.0

Item {

    ComboBox {
        id: comboBox

        model: ["Splash sceen", "Guest screen", "Home page"]

        onCurrentIndexChanged: {
            switch (currentIndex) {
                case 0: viewHierarchy.initialized = false; break
                case 1: viewHierarchy.initialized = true; viewHierarchy.loggedIn = false; break
                case 2: viewHierarchy.initialized = true; viewHierarchy.loggedIn = true; break
            }
        }
    }

    MainStackView {
        id: viewHierarchy

        anchors.fill: parent
        anchors.topMargin: comboBox.height

        splashPage: splashPage
        guestPage: guestPage
        homePage: homePage

        Component {
            id: splashPage

            Item {
                id: splashPageItem

                signal showPopup(var data, var config)
                signal dismissPopupById(var id)

                Rectangle { width: parent.width; height: parent.height; color: "transparent"; border { color: "red"; width: 1 }}

                Column {
                    anchors.centerIn: parent

                    Button {
                        text: qsTr("Show popup")

                        onClicked: {
                            splashPageItem.showPopup(
                                {
                                    identifier : "popup-id",
                                },
                                {
                                    title      : qsTr("Test popup"),
                                    message    : qsTr("This is a test"),
                                }
                            )
                            timer.restart()
                        }
                    }

                    Timer {
                        id: timer

                        interval: 5000
                        onTriggered: splashPageItem.dismissPopupById("popup-id")
                    }
                }
            }
        }

        Component {
            id: guestPage

            Item {

                Rectangle { width: parent.width; height: parent.height; color: "transparent"; border { color: "green"; width: 1 }}

                Text {
                    anchors.centerIn: parent

                    text: qsTr("Guest screen")
                }
            }
        }

        Component {
            id: homePage

            Item {

                Rectangle { width: parent.width; height: parent.height; color: "transparent"; border { color: "blue"; width: 1 }}

                Text {
                    anchors.centerIn: parent

                    text: qsTr("Home screen")
                }
            }
        }
    }
}
