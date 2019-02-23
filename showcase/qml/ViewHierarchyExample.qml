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

    ViewHierarchy {
        id: viewHierarchy

        anchors.fill: parent
        anchors.topMargin: comboBox.height

        splashPage: splashPage
        guestPage: guestPage
        homePage: homePage

        Component {
            id: splashPage

            Item {

                Rectangle { width: parent.width; height: parent.height; color: "transparent"; border { color: "red"; width: 1 }}

                Text {
                    anchors.centerIn: parent

                    text: qsTr("Splash screen")
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
