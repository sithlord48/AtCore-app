import QtQuick 2.7
import org.kde.kirigami 2.1 as Kirigami
import Logger 1.0
import QtQuick.Controls 2.2

Item {
    id: root
    property var content: ""

    Connections {
        target: Logger
        onLogTextChanged: {
            content = textEdit.text + Logger.logText
            Logger.logText = ''
        }
    }

    ScrollView {
        id: view
        anchors.fill: parent
        clip: true

        TextEdit {
            id : textEdit
            readOnly: true
            textFormat: TextEdit.RichText

            text: content
        }
    }
}
