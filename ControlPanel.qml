import QtQuick 2.7
import QtQuick.Controls 2.2
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.3

ColumnLayout {
    id: mainLayout
    property var par: parent
    Layout.fillWidth: true

    RowLayout {
        id: connectionMenu

        ComboBox {
            id: devText
            editable: true
            model: atcore.serialPorts
            Layout.fillWidth: true
        }
        ComboBox{
            id: devSpeed
            editable: false
            model: atcore.portSpeeds
            currentIndex: 7
        }
    }

    Button {
        text: "Connect"
        onClicked: {
            atcore.initSerial(devText.text, devSpeed.currentText.valueOf())
        }
        Layout.fillWidth: true
    }

    RowLayout {
        id: printMenu

        Button {
            text: "Load file..."
            Layout.fillWidth: true
            onClicked: {
                fileDialog.visible = true
            }
        }

        FileDialog {
            id: fileDialog
            title: "Please choose a file"
            selectExisting: true
            selectFolder: false
            selectMultiple: false
            nameFilters: [ "GCode file (*.gcode)"]
            folder: shortcuts.home
            onAccepted: {
                // https://stackoverflow.com/questions/24927850/get-the-path-from-a-qml-url
                var path = fileDialog.fileUrl.toString();
                // remove prefixed "file:///"
                path = path.replace(/^(file:\/{3})/,"");
                // unescape html codes like '%23' for '#'
                var cleanPath = "/" + decodeURIComponent(path);
                parent.file = cleanPath
            }
        }

        Button {
            text: "Print"
            onClicked: {
                if(!parent.file) {
                    return
                }
                atcore.print(parent.file)
            }
        }
    }

    ColumnLayout {
        id: controlMenu
        width: parent.width

        RowLayout {
            Button {
                text: "Stop"
                onClicked: atcore.stop()
            }
            Button {
                text: "Emergency"
                onClicked: atcore.emergencyStop()
            }
            Button {
                Layout.fillWidth: true
                text: "Motors Off"
            }
        }

        RowLayout {
            id: positionLayout
            Button {
                text: "Relative Mode"
                onClicked: {
                    text = text == "Relative Mode" ? "Absolute" : "Relative"
                    text = text + " Mode"
                }
            }
            SpinBox {
                Layout.fillWidth: true
                editable: true
                value: 50
                textFromValue: function(value) {return value + " mm"}
            }
            Button {
                Layout.fillWidth: true
                text: "Set"
                onClicked: atcore.setExtruderTemp(hendTemp.currentText.valueOf(), 0)
            }
        }

        RowLayout {
            id: tempLayout
            Label {
                text: "Heat:"
                color: "gray"
            }
            Button {
                Layout.fillWidth: true
                text: "Off"
            }
            ComboBox {
                id: hendTemp
                editable: true
                validator: IntValidator {
                    bottom: 0
                    top: 300
                }
                model: [185, 235]
            }
            Button {
                Layout.fillWidth: true
                text: "Set"
            }
        }

        RowLayout {
            Label {
                text: "Bed :"
                color: "gray"
            }
            Button {
                Layout.fillWidth: true
                text: "Off"
            }
            ComboBox {
                id: bedTemp
                editable: true
                validator: IntValidator {
                    bottom: 0
                    top: 300
                }
                model: [50, 80]
            }
            Button {
                Layout.fillWidth: true
                text: "Set"
                onClicked: atcore.setBedTemp(bedTemp.currentText.valueOf())
            }
        }

        ColumnLayout {
            id: rowPie
            height: width
            anchors.right: controlMenu.right
            anchors.left: controlMenu.left

            Pie {
                id: pie
                visible: true
            }
        }
    }
}
