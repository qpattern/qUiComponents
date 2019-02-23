import QtQuick 2.0
import qpattern.Popups.Themes 1.0

Popup {
    id: root

    height                         : childrenRect.height + internalTheme.padding*2

    property alias title           : titleLabel.text
    property alias message         : messageLabel.text

    property alias buttonLabels    : buttonsRepeater.model
    property alias buttonDelegate  : buttonsRepeater.delegate
    property var   buttonsCallback : null

    requiresInteraction            : buttonsRepeater.count > 0

    Rectangle { width: parent.width; height: parent.height; color: "white"; z: -1; border { color: "red"; width: 1 }}

    // Theme management
    property GenericPopupTheme theme
    GenericPopupTheme { id: internalTheme }
    onThemeChanged: internalTheme.copy(theme)

    function configure(configuration) {
        title        = configuration.title   ? configuration.title    : ""
        message      = configuration.message ? configuration.message  : ""
        buttonLabels = configuration.buttons ? configuration.buttons  : []

        if (configuration.buttonsCallback) root.buttonsCallback = configuration.buttonsCallback
        if (configuration.buttonDelegate ) root.buttonDelegate  = configuration.buttonDelegate
    }

    Column {
        id: content

        width                    : parent.width - internalTheme.padding*2

        anchors.horizontalCenter : parent.horizontalCenter
        y                        : internalTheme.padding

        spacing                  : internalTheme.spacing

        Text {
            id: titleLabel

            width                : parent.width

            visible              : text ? true : false

            horizontalAlignment  : Text.AlignHCenter

            color                : internalTheme.titleColor

            font.family          : internalTheme.fontFamily
            font.pixelSize       : internalTheme.titleFontSize
            font.weight          : Font.Light

            wrapMode             : Text.WordWrap

            onTextChanged: console.log("title", text)
        }

        Text {
            id: messageLabel

            width               : parent.width

            visible             : text ? true : false

            horizontalAlignment : Text.AlignHCenter

            color               : internalTheme.messageColor

            elide               : Text.ElideNone

            font.family         : internalTheme.fontFamily
            font.pixelSize      : internalTheme.messageFontSize

            wrapMode            : Text.WordWrap
        }

        Column {
            width   : parent.width

            visible : buttonsRepeater.count ? true : false

            spacing : internalTheme.buttonsSpacing

            Repeater {
                id: buttonsRepeater

                anchors.horizontalCenter     : parent.horizontalCenter

                delegate: Text {
                    anchors.horizontalCenter : parent.horizontalCenter

                    font.family              : internalTheme.fontFamily
                    font.pixelSize           : internalTheme.buttonFontSize

                    color                    : mouseArea.pressed ? internalTheme.buttonColorPressed : internalTheme.buttonColor

                    text                     : modelData

                    MouseArea {
                        id: mouseArea

                        anchors.fill: parent

                        onClicked: {
                            if (buttonsCallback) buttonsCallback(index);
                            root.dismiss()
                        }
                    }
                }
            }
        }
    }
}
