import QtQuick 2.0
import QtQuick.Extras 1.4
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4

Item {
    id: root
    anchors.fill: parent
    visible: true

    property real lastN: -1
    property var pies: [pieMenu3, pieMenu2, pieMenu]
    property var axis: ["Z", "Y", "X"]
    property var values: [0.1, 1, 10]

    PieMenu {
        id: pieMenu
        focus: false

        MenuItem {
            onTriggered: print("Z + 10mm")
        }
        MenuItem {
            onTriggered: print("Y + 10mm")
        }
        MenuItem {
            onTriggered: print("X + 10mm")
        }
        MenuItem {
            onTriggered: print("Z - 10mm")
        }
        MenuItem {
            onTriggered: print("Y - 10mm")
        }
        MenuItem {
            onTriggered: print("X - 10mm")
        }

        onSelectionAngleChanged: {
            createPieInfo(axis[currentIndex%3], currentIndex < 3 ? values[2] : -values[2])

            var x =__protectedScope.selectionPos.x - width/2
            var y =__protectedScope.selectionPos.y - height/2
            var r = Math.sqrt(x*x + y*y)
            winner(r)
        }

        __mouseThief.onClicked : {
            checkClick(mouseX - width/2, mouseY - height/2)
        }
    }

    PieMenu {
        id: pieMenu2
        focus: false

        MenuItem {
            onTriggered: print("Z + 1mm")
        }
        MenuItem {
            onTriggered: print("Y + 1mm")
        }
        MenuItem {
            onTriggered: print("X + 1mm")
        }
        MenuItem {
            onTriggered: print("Z - 1mm")
        }
        MenuItem {
            onTriggered: print("Y - 1mm")
        }
        MenuItem {
            onTriggered: print("X - 1mm")
        }

        onSelectionAngleChanged: {
            createPieInfo(axis[currentIndex%3], currentIndex < 3 ? values[1] : -values[1])

            var x =__protectedScope.selectionPos.x - width/2
            var y =__protectedScope.selectionPos.y - height/2
            var r = Math.sqrt(x*x + y*y)
            winner(r)
        }

        __mouseThief.onClicked : {
            checkClick(mouseX - width/2, mouseY - height/2)
        }
    }

    PieMenu {
        id: pieMenu3
        focus: false

        MenuItem {
            onTriggered: print("Z + 0.1mm")
        }
        MenuItem {
            onTriggered: print("Y + 0.1mm")
        }
        MenuItem {
            onTriggered: print("X + 0.1mm")
        }
        MenuItem {
            onTriggered: print("Z - 0.1mm")
        }
        MenuItem {
            onTriggered: print("Y - 0.1mm")
        }
        MenuItem {
            onTriggered: print("X - 0.1mm")
        }

        onSelectionAngleChanged: {
            createPieInfo(axis[currentIndex%3], currentIndex < 3 ? values[0] : -values[0])

            var x =__protectedScope.selectionPos.x - width/2
            var y =__protectedScope.selectionPos.y - height/2
            var r = Math.sqrt(x*x + y*y)
            winner(r)
        }

        __mouseThief.onClicked : {
            checkClick(mouseX - width/2, mouseY - height/2)
        }
    }

    function checkClick(x, y) {
        popupAll(lastN)
        for(var i in pies) {
            pies[i].__mouseThief.ungrabMouse()
        }
    }

     function winner(r) {
        if (r == 0) {
            return
        }
        if (r < pieMenu3.__style.radius) {
            popupAll(0)
        } else if (r < pieMenu2.__style.radius) {
            popupAll(1)
        } else if (r < pieMenu.__style.radius) {
            popupAll(2)
        } else {
            for (var i in pies) {
                pies[i].__mouseThief.ungrabMouse()
            }
        }
    }

    function createPieInfo(coord, value) {
        if (typeof coord == 'undefined' || typeof value == 'undefined') {
            return
        }
        coordPieInfo.text = coord + " : " + value
    }

    Label {
        id: coordPieInfo
        color: "gray"
        anchors {
            horizontalCenter: root.horizontalCenter;
            verticalCenter: root.verticalCenter;
        }
        text: ""
    }

    function resize(N) {
        N = typeof N !== 'undefined' ? N : lastN;
        pieMenu.__style.startAngle = -30
        pieMenu.__style.endAngle = 330
        pieMenu.width = Math.min(root.width, root.height)
        pieMenu.height = Math.min(root.width, root.height)
        pieMenu.__style.cancelRadius = pieMenu.width/2 - pieMenu.width/8

        for (var i = pies.length - 2; i > -1; i--) {
            pies[i].__style.startAngle = -30
            pies[i].__style.endAngle = 330
            pies[i].width = pies[i + 1].__style.cancelRadius*2
            pies[i].height = pies[i].width
            pies[i].__style.cancelRadius = pies[i].width/2 - pies[pies.length - 1].width/8
        }

        popupAll(N)
    }

    function popupAll(n) {
        lastN = n
        for (var i in pies) {
            pies[i].visible = false
        }
        switch (n) {
            case 0:
                pieMenu.popup(root.width/2, root.height/2)
                pieMenu2.popup(root.width/2, root.height/2)
                pieMenu3.popup(root.width/2, root.height/2)
                pieMenu.focus = false
                pieMenu2.focus = false
                pieMenu3.focus = true
                for (var i in pies) {
                    pies[i].visible = true
                }
                pieMenu.__mouseThief.ungrabMouse()
                pieMenu2.__mouseThief.ungrabMouse()
            break
            case 1:
                pieMenu.popup(root.width/2, root.height/2)
                pieMenu3.popup(root.width/2, root.height/2)
                pieMenu2.popup(root.width/2, root.height/2)
                pieMenu.focus = false
                pieMenu3.focus = false
                pieMenu2.focus = true
                for (var i in pies) {
                    pies[i].visible = true
                }
                pieMenu.__mouseThief.ungrabMouse()
                pieMenu3.__mouseThief.ungrabMouse()
            break
            case 2:
                pieMenu3.popup(root.width/2, root.height/2)
                pieMenu2.popup(root.width/2, root.height/2)
                pieMenu.popup(root.width/2, root.height/2)
                pieMenu3.focus = false
                pieMenu2.focus = false
                pieMenu.focus = true
                for (var i in pies) {
                    pies[i].visible = true
                }
                pieMenu3.__mouseThief.ungrabMouse()
                pieMenu2.__mouseThief.ungrabMouse()
            break
        }
    }

    Button {
        x: pieMenu.x
        y: pieMenu.y
        width: (pieMenu.width - pieMenu.width/Math.sqrt(2))/2
        height: width
        text: "ZH"
        style: ButtonStyle {
            background: Rectangle {
                radius: width/2
                color: control.pressed ? Qt.rgba(0.86, 0.86, 0.86) : Qt.rgba(0.6, 0.6, 0.6, 0.66)
                border.width: control.activeFocus ? 2 : 1
            }
        }
        onHoveredChanged: {
            coordPieInfo.text = "Home Z"
        }
    }

    Button {
        x: pieMenu.x + pieMenu.width - width
        y: pieMenu.y
        width: (pieMenu.width - pieMenu.width/Math.sqrt(2))/2
        height: width
        text: "YH"
        style: ButtonStyle {
            background: Rectangle {
                radius: width/2
                color: control.pressed ? Qt.rgba(0.86, 0.86, 0.86) : Qt.rgba(0.6, 0.6, 0.6, 0.66)
                border.width: control.activeFocus ? 2 : 1
            }
        }
        onHoveredChanged: {
            coordPieInfo.text = "Home Y"
        }
    }

    Button {
        x: pieMenu.x + pieMenu.width - width
        y: pieMenu.y + pieMenu.height - height
        width: (pieMenu.width - pieMenu.width/Math.sqrt(2))/2
        height: width
        text: "XH"
        style: ButtonStyle {
            background: Rectangle {
                radius: width/2
                color: control.pressed ? Qt.rgba(0.86, 0.86, 0.86) : Qt.rgba(0.6, 0.6, 0.6, 0.66)
                border.width: control.activeFocus ? 2 : 1
            }
        }
        onHoveredChanged: {
            coordPieInfo.text = "Home X"
        }
    }

    Button {
        x: pieMenu.x
        y: pieMenu.y + pieMenu.height - height
        width: (pieMenu.width - pieMenu.width/Math.sqrt(2))/2
        height: width
        text: "H"
        style: ButtonStyle {
            background: Rectangle {
                radius: width/2
                color: control.pressed ? Qt.rgba(0.86, 0.86, 0.86) : Qt.rgba(0.6, 0.6, 0.6, 0.66)
                border.width: control.activeFocus ? 2 : 1
            }
        }
        onHoveredChanged: {
            coordPieInfo.text = "Home All"
        }
    }

    onWidthChanged: resize()
    onHeightChanged: resize()
    Component.onCompleted: resize(0)
}
