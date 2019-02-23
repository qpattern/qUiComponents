import QtQuick 2.0
import QtQuick.Controls 2.0
import qpattern.Popups 1.0

Item {
    id: root

    Column {
        id: controlsContainer

        width: parent.width

        CheckBox {
            id: modalCheckbox

            text: qsTr("Modal")
        }

        CheckBox {
            id: withButtonCheckbox

            text: qsTr("With button")
        }

        Row {
            CheckBox {
                id: autoCloseCheckbox

                anchors.verticalCenter: parent.verticalCenter

                text: qsTr("Autoclose:")
            }

            SpinBox {
                id: autoCloseSpin

                enabled: autoCloseCheckbox.checked

                editable: true
                from: 0
                to: 10000
                value: 2000
            }
        }

        CheckBox {
            id: forceCloseCheckbox

            text: qsTr("Force close:")
        }

        CheckBox {
            id: dismissImmediatelyCheckbox

            text: qsTr("Dismiss immediately:")
        }

        Row {
            Text {
                anchors.verticalCenter: parent.verticalCenter

                text: qsTr("Priority:")
            }

            SpinBox {
                id: prioritySpin

                value: 0
            }
        }

        Row {

            spacing: 20

            Button {
                text: qsTr("Show popup")

                onClicked: {
                    var title = "Popup" + popupLayer.count
                    popupLayer.showPopup(
                        {
                            modal            : modalCheckbox.checked,
                            priority         : prioritySpin.value,
                            autoCloseAfterMs : autoCloseCheckbox.checked ? autoCloseSpin.value : -1,
                        },
                        {
                            title            : title,
                            message          : "modal=%1, priority=%2, autoCloseAfterMs=%3".arg(modalCheckbox.checked).arg(prioritySpin.value).arg(autoCloseSpin.value),
                            buttons          : withButtonCheckbox.checked ? [ "Ok" ] : [],
                            buttonsCallback  : function() { console.log("popupCliecked:", title) },
                        }
                    )
                }
            }

            Button {
                text: qsTr("Dismiss last popup")

                enabled: popupLayer.count > 0

                onClicked: popupLayer.dismiss(popupLayer.count-1, forceCloseCheckbox.checked, dismissImmediatelyCheckbox.checked)
            }
        }

        Text {
            text: qsTr("Open popups: %1").arg(popupLayer.count)
        }
    }

    PopupLayer {
        id: popupLayer

        anchors.fill      : parent
        anchors.topMargin : controlsContainer.height
    }
}
