import QtQuick 2.0

QtObject {
    property color  backgroundColor
    property color  buttonColor
    property color  buttonColorPressed
    property int    buttonFontSize
    property int    buttonsSpacing
    property string fontFamily
    property color  messageColor
    property int    messageFontSize
    property int    padding
    property int    spacing
    property color  titleColor
    property int    titleFontSize

    function copy(theme) {
        backgroundColor     = Qt.binding(function() { return theme.backgroundColor    })
        buttonColor         = Qt.binding(function() { return theme.buttonColor        })
        buttonColorPressed  = Qt.binding(function() { return theme.buttonColorPressed })
        buttonFontSize      = Qt.binding(function() { return theme.buttonFontSize     })
        buttonsSpacing      = Qt.binding(function() { return theme.buttonsSpacing     })
        fontFamily          = Qt.binding(function() { return theme.fontFamily         })
        messageColor        = Qt.binding(function() { return theme.messageColor       })
        messageFontSize     = Qt.binding(function() { return theme.messageFontSize    })
        padding             = Qt.binding(function() { return theme.padding            })
        spacing             = Qt.binding(function() { return theme.spacing            })
        titleColor          = Qt.binding(function() { return theme.titleColor         })
        titleFontSize       = Qt.binding(function() { return theme.titleFontSize      })
    }
}
