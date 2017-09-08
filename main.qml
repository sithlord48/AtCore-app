import QtQuick 2.1
import org.kde.kirigami 2.1 as Kirigami

Kirigami.ApplicationItem {
    id: root

    globalDrawer: Kirigami.GlobalDrawer {
        title: "AtCore Gui"
        titleIcon: "applications-graphics"

        actions: [
            Kirigami.Action {
                text: "Control"
                iconName: "view-list-icons"
                Kirigami.Action {
                    text: "Up"
                    iconName: "go-up"
                }
                Kirigami.Action {
                    text: "Down"
                    iconName: "go-down"
                }
                Kirigami.Action {
                    text: "Right"
                    iconName: "go-next"
                }
                Kirigami.Action {
                    text: "Left"
                    iconName: "go-previous"
                }
            },
            Kirigami.Action {
                text: "Files"
                iconName: "view-list-icons"
                Kirigami.Action {
                    text: "Last file"
                }
                Kirigami.Action {
                    text: "Last file"
                }
            },
            Kirigami.Action {
                text: "Something"
            }
        ]
        handleVisible: true
    }
    contextDrawer: Kirigami.ContextDrawer {
        id: contextDrawer
    }

    pageStack.initialPage: mainPageComponent

    Component {
        id: mainPageComponent
        Kirigami.Page {
            title: "Preferences"
            actions {
                contextualActions: [
                    Kirigami.Action {
                        text: "Perfils"
                    },
                    Kirigami.Action {
                        text: "Settings"
                    }
                ]
            }
            Rectangle {
                color: "red"
                anchors.fill: parent
            }
        }
    }


}
