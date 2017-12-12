import QtQuick 2.1
import QtQuick.Controls 2.2
import QtQuick.Layouts 1.3
import org.kde.kirigami 2.1 as Kirigami
import QtQuick.Extras 1.4
import org.kde.atcore 1.0

Kirigami.ApplicationWindow {
    id: root
    property var file: ""

    AtCore {
        id: atcore
        Component.onCompleted: atcore.setSerialTimerInterval(1000)
    }

    globalDrawer: Kirigami.GlobalDrawer {
        id: left
        title: "AtCore Gui"
        titleIcon: "applications-graphics"
        handleVisible: true

        ControlPanel {
            id: controlPanel
        }
        Item {
            Layout.fillHeight: true
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
            file: controlPanel.file

            actions {
                contextualActions: [
                    Kirigami.Action {
                        text: "Logger"
                        onTriggered: {
                            pageStack.push(loggerPage)
                        }
                    },
                    Kirigami.Action {
                        text: "Settings"
                        onTriggered: {
                            pageStack.push(settingsPage)
                        }
                    }
                ]
            }
        }
    }

    Component {
        id: loggerPage
        LoggerPage{
            id: logger
        }
    }
    Component {
        id: settingsPage
        SettingsPage {
            id: settings
        }
    }
}
