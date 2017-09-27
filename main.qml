import QtQuick 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.1 as Kirigami
import QtQuick.Extras 1.4
import QtQuick.Dialogs 1.0

Kirigami.ApplicationItem {
    id: root
    property var file: ""

    globalDrawer: Kirigami.GlobalDrawer {
        id: left
        title: "AtCore Gui"
        titleIcon: "applications-graphics"
        handleVisible: true
        width: Kirigami.Units.gridUnit * 25

        ColumnLayout {
            id: mainLayout

            RowLayout {
                id: connectionMenu

                TextField {
                    placeholderText: "/dev/ttyUSB0"
                    Layout.fillWidth: true
                }
                Button {
                    text: "Connect"
                    onClicked: {
                        rowPie.visible = !rowPie.visible
                    }
                }
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
                    folder: shortcuts.home
                    onAccepted: {
                        // https://stackoverflow.com/questions/24927850/get-the-path-from-a-qml-url
                        var path = fileDialog.fileUrl.toString();
                        // remove prefixed "file:///"
                        path = path.replace(/^(file:\/{3})/,"");
                        // unescape html codes like '%23' for '#'
                        var cleanPath = "/" + decodeURIComponent(path);
                        root.file = cleanPath
                    }
                }

                Button {
                    text: "Print"
                }
            }

            ColumnLayout {
                id: controlMenu
                width: parent.width

                RowLayout {
                    Button {
                        text: "Stop"
                    }
                    Button {
                        text: "Emergency"
                    }
                    Button {
                        Layout.fillWidth: true
                        text: "Motors Off"
                    }
                }

                RowLayout {
                    id: rowPie
                    height: width
                    Pie {
                        id: pie
                        width: rowPie.width
                        visible: true
                    }
                }

                RowLayout {
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
                    }
                }

                RowLayout {
                    Label {
                        text: "Heat:"
                        color: "gray"
                    }
                    Button {
                        Layout.fillWidth: true
                        text: "Off"
                    }
                    ComboBox {
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
                    }
                }
            }

            Item {
                Layout.fillHeight: true
            }
        }
    }

    contextDrawer: Kirigami.ContextDrawer {
        id: contextDrawer
    }

    pageStack.initialPage: mainPageComponent

    Component {
        id: mainPageComponent
        Principal{
            id: principal
            file: root.file
        }
    }
}
