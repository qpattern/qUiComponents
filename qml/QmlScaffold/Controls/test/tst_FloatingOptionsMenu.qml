import QtQuick 2.0
import QtQuick.Controls 2.3
import QtTest 1.0

import QmlScaffold.Controls 1.0

Item {
    id: root

    width: 500
    height: 400

    FloatingOptionsMenu {
        id: itemToTest

        Action { id: action0; text: "action-0" ; icon.name: "icon-0" }
        Action { id: action1; text: "action-1" ; icon.name: "icon-1" }
        Action { id: action2; text: "action-2" ; icon.name: "icon-2" }
        Action { id: action3; text: "action-3" ; icon.name: "icon-3" }
    }

    TestCase {
        name: "FloatingOptionsMenu"

        when: windowShown

        function cleanup() {
            actionSpy.clear()
        }

        function test_triggerDefinedActionOnClick() {
            var item = itemToTest.itemAt(2)
            var labelButton  = findChild(item.contentItem, "labelOptionButton")
            var actionButton = findChild(item.contentItem, "roundOptionButton")

            helper_verifyMenuItemClick("helper_verifyMenuItemClick(labelButton, true)" , labelButton, true)
            helper_verifyMenuItemClick("helper_verifyMenuItemClick(actionButton, true)", actionButton, true)

            helper_verifyClickOutsideButton(labelButton, "labelButton")
            helper_verifyClickOutsideButton(actionButton, "actionButton")
        }

        function helper_verifyClickOutsideButton(button, buttonName) {
            helper_verifyMenuItemClick("helper_verifyMenuItemClick(" + buttonName + ", left)"  , button, false, -1)
            helper_verifyMenuItemClick("helper_verifyMenuItemClick(" + buttonName + ", right)" , button, false, button.width + 1)
            helper_verifyMenuItemClick("helper_verifyMenuItemClick(" + buttonName + ", top)"   , button, false, button.width/2, -1)
            helper_verifyMenuItemClick("helper_verifyMenuItemClick(" + buttonName + ", bottom)", button, false, button.width/2, button.height + 1)
        }

        function helper_verifyMenuItemClick(msg, button, verifyTriggered, x, y) {
            buttonSpy.target = button
            actionSpy.clear()
            buttonSpy.clear()
            compare(actionSpy.count, 0)
            compare(buttonSpy.count, 0)

            // open popup
            itemToTest.open()
            tryCompare(itemToTest, "opened", true)

            // assert action was triggered and the menu was closed on click on action button
            mouseClick(button, x, y)
            compare(buttonSpy.count, verifyTriggered ? 1 : 0, msg)
            compare(actionSpy.count, verifyTriggered ? 1 : 0, msg)
            compare(itemToTest.opened, false, msg)
        }

        SignalSpy {
            id: actionSpy
            target: action2
            signalName: "triggered"
        }

        SignalSpy {
            id: buttonSpy
            signalName: "clicked"
        }
    }
}
