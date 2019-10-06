import QtQuick 2.0
import QtQuick.Controls 2.3
import QtTest 1.0

import QmlScaffold.Controls 1.0

Item {
    id: root

    FloatingActionButton {
        id: itemToTest

        action : Action {
            id: action

        }
    }

    TestCase {
        name: "FloatingActionButton"

        when: windowShown

        function cleanup() {
            actionSpy.clear()
        }

        function test_actionIconNameShouldBeUsedAsLabelIfBothTextAndIconNameAreDefined() {
            var iconName = action.icon.name
            var text     = action.text

            action.icon.name = "action-icon-name"
            action.text = "action-text"

            compare(itemToTest.contentItem.text, "action-icon-name")

            action.icon.name = action.icon.name
            action.text      = action.text
        }

        function test_labelShouldBeEmptyIfActionIconNameIsNotDefined() {
            var iconName = action.icon.name
            var text     = action.text

            action.icon.name = ""
            action.text = ""

            compare(itemToTest.contentItem.text, "")

            action.icon.name = action.icon.name
            action.text      = action.text
        }

        function test_sizeShouldHaveExpectedDefaultValues() {
            compare(itemToTest.width, 56)
            compare(itemToTest.height, 56)
        }

        function test_sizeShouldHaveWidthBoundToHeight() {
            compare(itemToTest.width, 56)
            compare(itemToTest.height, 56)

            itemToTest.height = 60
            compare(itemToTest.width, 60)
        }

        function test_triggerDefinedActionOnClick() {
            compare(actionSpy.count, 0)
            mouseClick(itemToTest)
            compare(actionSpy.count, 1)
        }

        SignalSpy {
            id: actionSpy
            target: action
            signalName: "triggered"
        }
    }
}
