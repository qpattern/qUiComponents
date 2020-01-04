import QtQuick 2.0
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    width   : 840
    height  : 480

    visible : true

    title   : qsTr("Showcase")

    RowLayout {
        anchors.fill: parent

        spacing: 0

        Column {
            id: examplesList

            Layout.minimumWidth         : 100
            Layout.fillHeight           : true

            property int currentIndex   : 0

            Repeater {
                id: repeater

                model: [
                    "MainStackView",
                    "PopupLayer",
                ]

                MouseArea {
                    width : parent.width
                    height: 20

                    onClicked: examplesList.currentIndex = index

                    Rectangle {
                        anchors.fill        : parent

                        color               : index === examplesList.currentIndex ? "black" : "transparent"
                        opacity             : 0.2
                    }

                    Text {
                        anchors.fill        : parent

                        verticalAlignment   : Text.AlignVCenter

                        fontSizeMode        : Text.Fit
                        font.pixelSize      : 20
                        minimumPixelSize    : 10

                        text                : modelData
                    }
                }
            }
        }

        Rectangle {
            Layout.preferredWidth : 2
            Layout.fillHeight     : true

            color                 : "gray"
        }

        Loader {
            id: loader

            Layout.fillWidth  : true
            Layout.fillHeight : true

            clip              : true

            source: examplesList.currentIndex >= 0 ? repeater.model[examplesList.currentIndex] + "Example.qml" : ""
        }
    }

    Drawer {
        id: drawer
        width: 0.66 * parent.width
        height: parent.height

        Label {
            text: "Content goes here!"
            anchors.centerIn: parent
        }
    }
}
