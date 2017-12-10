import QtQuick 2.7
import org.kde.kirigami 2.1 as Kirigami
import Logger 1.0
import QtQuick.Controls 2.2

Kirigami.Page {
    id: root

    LoggerComponent {
        id: view
        anchors.fill: parent
    }
}
