import QtQuick 2.7
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    width   : 640
    height  : 480

    visible : true

    title   : qsTr("Showcase")

    RowLayout {
        anchors.fill : parent

        Column {
            id: examplesList

            Layout.fillHeight   : true
            Layout.minimumWidth : 100

            Repeater {
                id: repeater

                property int currentIndex : 0

                property list<Example> examples: [
                    Example { component: "DraggableItem" },
                    Example { component: "FloatingButton" }
                ]

                model : examples

                MouseArea {
                    height    : 20
                    width     : parent.width

                    onClicked : repeater.currentIndex = index

                    Rectangle {
                        id: selectedIndicator

                        height : parent.height
                        width  : 5

                        color  : index === repeater.currentIndex ? "cyan" : "transparent"
                    }

                    Text {
                        anchors.fill       : parent
                        anchors.leftMargin : selectedIndicator.width + 5

                        verticalAlignment  : Text.AlignVCenter

                        fontSizeMode       : Text.Fit
                        font.pixelSize     : 20
                        minimumPixelSize   : 10
                        elide              : Text.ElideRight

                        text               : model.label
                    }
                }
            }
        }

        Rectangle {
            Layout.preferredWidth : 2
            Layout.fillHeight     : true

            color                 : "lightgray"
        }

        Loader {
            id: loader

            Layout.margins    : 10
            Layout.fillWidth  : true
            Layout.fillHeight : true

            source            : repeater.currentIndex >= 0 ? repeater.model[repeater.currentIndex].component + "Example.qml" : ""
        }
    }
}
