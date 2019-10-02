import QtQuick 2.0
import QtQuick.Controls 2.3
import QtTest 1.0

import QmlScaffold.Controls 1.0

Item {
    id: root

    height : 200
    width  : 300

    DraggableItem {
        id: itemToTest

        height : 20
        width  : 30
    }

    TestCase {
        name: "DraggableItem"

        when: windowShown

        property int margin
        property bool stickyDrag

        function init() {
            this.margin = itemToTest.margin
            this.stickyDrag = itemToTest.stickyDrag
            this.x = itemToTest.x
            this.y = itemToTest.y
        }

        function cleanup() {
            itemToTest.margin = this.margin
            itemToTest.stickyDrag = this.stickyDrag
            itemToTest.x = this.x
            itemToTest.y = this.y
        }

        function test_shouldNotStickyDragByDefault() {
            compare(itemToTest.stickyDrag, false)
        }

        function test_shouldUseMargin() {
            compare(itemToTest.minimumX, 0)
            compare(itemToTest.maximumX, 270)
            compare(itemToTest.minimumY, 0)
            compare(itemToTest.maximumY, 180)
            itemToTest.margin = 5
            compare(itemToTest.minimumX, 5)
            compare(itemToTest.maximumX, 265)
            compare(itemToTest.minimumY, 5)
            compare(itemToTest.maximumY, 175)
        }

        function test_stickToTheNearestEdge_shouldStickToLeftIfCenterXIsLessThanHalfWidthOfParent() {
            itemToTest.x = (root.width - itemToTest.width)/2 - 1
            compare(itemToTest.x, 134)

            itemToTest.stickToTheNearestEdge()

            compare(itemToTest.x, 0)
            compare(itemToTest.y, 0)
        }

        function test_stickToTheNearestEdge_shouldStickToLeftIfCenterXIsEqualToHalfWidthOfParent() {
            itemToTest.x = (root.width - itemToTest.width)/2
            compare(itemToTest.x, 135)

            itemToTest.stickToTheNearestEdge()

            compare(itemToTest.x, 0)
            compare(itemToTest.y, 0)
        }

        function test_stickToTheNearestEdge_shouldStickToRightIfCenterXIsGreaterThanHalfWidthOfParent() {
            itemToTest.x = (root.width - itemToTest.width)/2 + 1
            compare(itemToTest.x, 136)

            itemToTest.stickToTheNearestEdge()

            compare(itemToTest.x, 270)
            compare(itemToTest.y, 0)
        }

        function test_stickToTheNearestEdge_shouldStickToTopIfCenterYIsLessThanHalfWHeightOfParent() {
            itemToTest.y = (root.height - itemToTest.height)/2 - 1
            compare(itemToTest.y, 89)

            itemToTest.stickToTheNearestEdge()

            compare(itemToTest.x, 0)
            compare(itemToTest.y, 0)
        }

        function test_stickToTheNearestEdge_shouldStickToTopIfCenterYIsEqualToHalfWHeightOfParent() {
            itemToTest.y = (root.height - itemToTest.height)/2
            compare(itemToTest.y, 90)

            itemToTest.stickToTheNearestEdge()

            compare(itemToTest.x, 0)
            compare(itemToTest.y, 0)
        }

        function test_stickToTheNearestEdge_shouldStickToBottomIfCenterYIsGreaterThanHalfWHeightOfParent() {
            itemToTest.y = (root.height - itemToTest.height)/2 + 1
            compare(itemToTest.y, 91)

            itemToTest.stickToTheNearestEdge()

            compare(itemToTest.x, 0)
            compare(itemToTest.y, 180)
        }

        function test_shouldStickToNearestEdgeWhenStickyDraggingIsCompleted() {
            itemToTest.stickyDrag = true
            mouseDrag(itemToTest, 0, 0, 136, 0)

            tryCompare(itemToTest, "x", 270)
            compare(itemToTest.y, 0)
        }
    }
}
