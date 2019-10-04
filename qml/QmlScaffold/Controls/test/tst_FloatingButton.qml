import QtQuick 2.0
import QtQuick.Controls 2.3
import QtTest 1.0

import QmlScaffold.Controls 1.0
import QmlScaffold.Controls.Themes 1.0

Item {
    id: root

    FloatingButton {
        id: itemToTest

        action : Action {
            text: "action-text"
        }
    }

    FloatingButtonTheme {
        id: newTheme

        background.color      : "#ff00ff"
        background.radius     : 7

        label.color           : "#0000FF"
        label.fontSize        : 20
        label.fontFamily      : "Times"

        shadow.radius         : 10
        shadow.samples        : 25
        shadow.verticalOffset : 5
        shadow.color          : "#800000AA"
    }

    TestCase {
        name: "FloatingButton"

        property FloatingButtonTheme theme

        function init() {
            theme = itemToTest.theme
        }

        function cleanup() {
            itemToTest.theme = theme
        }

        function test_shouldUseActionText() {
            compare(itemToTest.text, "action-text")
        }

        function test_shouldUseThemeProperties() {
            var background = findChild(itemToTest, "backgoundRectangle")
            compare(background.color , "#ffffff")
            compare(background.radius, itemToTest.height/2)

            compare(itemToTest.background.radius        , 8)
            compare(itemToTest.background.samples       , 17)
            compare(itemToTest.background.verticalOffset, 3)
            compare(itemToTest.background.color         , "#80000000")

            compare(itemToTest.contentItem.font.pointSize, 13)
            compare(itemToTest.contentItem.font.family   , "")
            compare(itemToTest.contentItem.color         , "#000000")

            itemToTest.theme = newTheme

            compare(background.color                     , newTheme.background.color )
            compare(background.radius                    , newTheme.background.radius)

            compare(itemToTest.background.radius         , newTheme.shadow.radius        )
            compare(itemToTest.background.samples        , newTheme.shadow.samples       )
            compare(itemToTest.background.verticalOffset , newTheme.shadow.verticalOffset)
            compare(itemToTest.background.color          , newTheme.shadow.color         )

            compare(itemToTest.contentItem.font.pointSize, newTheme.label.fontSize  )
            compare(itemToTest.contentItem.font.family   , newTheme.label.fontFamily)
            compare(itemToTest.contentItem.color         , newTheme.label.color     )
        }
    }
}
