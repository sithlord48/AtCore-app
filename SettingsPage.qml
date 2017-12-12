import QtQuick 2.7
import QtQuick.Controls 1.4
import QtQuick.Layouts 1.3
import Qt.labs.settings 1.0
import org.kde.kirigami 2.1 as Kirigami
//Needs AtCore from main
Kirigami.Page {
ColumnLayout {
    id:mainLayout
    Item {
        Settings {
            id:gloablSetttings
            category: "Printer-Profile"
            property alias name: txtName.text
            property alias firmware: cbFirmware.currentIndex
            property alias speed: cbPortSpeed.currentIndex
            property alias bedMax: sbBedMax.value
            property alias extMax: sbExtMax.value
            property alias xMax: sbXMax.value
            property alias yMax: sbYMax.value
            property alias zMax: sbZMax.value
            property alias postPause: txtPostPause.text
        }
    }
    TextField {
        id: txtName
        placeholderText: "Profile Name"
        Layout.fillWidth: true
    }
    RowLayout {
        ComboBox {
            id: cbFirmware
            model: atcore.availableFirmwarePlugins
            Layout.fillWidth: true
        }
        ComboBox {
            id: cbPortSpeed
            model: atcore.portSpeeds
            Layout.fillWidth: true
        }
    }
    GroupBox {
            title: "Maximum Temperatures"
            Layout.fillWidth: true
        ColumnLayout {
            RowLayout {
                Label {
                    text: "Bed (0: Not Heated)"
                }
                SpinBox {
                    id: sbBedMax
                    decimals: 0
                    suffix: "°C"
                    maximumValue: 150
                    value: 100
                    Layout.fillWidth: true
                }
            }
            RowLayout {
                Label {
                    text: "Extruder"
                }
                SpinBox {
                    id: sbExtMax
                    decimals: 0
                    suffix: "°C"
                    maximumValue: 350
                    value: 250
                    Layout.fillWidth: true
                }
            }
        }
    }
    GroupBox {
        title: "Build Volume"
        Layout.fillWidth: true
        ColumnLayout {
            RowLayout{
                Label {
                    text: "X:"
                }
                SpinBox {
                    id: sbXMax
                    suffix: "mm"
                    decimals: 0
                    maximumValue: 10000
                    Layout.fillWidth: true
                }
            }
                   RowLayout{
                Label {
                    text: "Y:"
                }
                SpinBox {
                    id: sbYMax
                    suffix: "mm"
                    decimals: 0
                    maximumValue: 10000
                    Layout.fillWidth: true
                }
            }
                   RowLayout{
                Label {
                    text: "Z:"
                }
                SpinBox {
                    id: sbZMax
                    suffix: "mm"
                    decimals: 0
                    maximumValue: 10000
                    Layout.fillWidth: true
                }
            }
        }
    }
    ColumnLayout {
        Item {
            Text{
                text:"Post Pause Actions"
            }
        }
        TextField {
            id: txtPostPause
            placeholderText: "Post Pause Move(s)."
            Layout.fillWidth: true
        }
    }
    Item {
        Layout.fillHeight: true
    }
}
}
