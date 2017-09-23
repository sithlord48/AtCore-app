import QtQuick 2.0
import QtQuick.Scene3D 2.0
import LineMesh 1.0

Item {
    id: root
    anchors.fill: parent

    property var file: ""

    Rectangle {
        id: scene
        anchors.fill: parent
        Scene3D {
            id: scene3d
            anchors.fill: parent
            focus: true
            aspects: ["input", "logic"]
            cameraAspectRatioMode: Scene3D.AutomaticAspectRatio
            AnimatedEntity {
                id: entity
                onFpsChanged: {
                    fpsText.text = Math.round(fps)
                }
            }
        }
    }

    Text {
        id: fpsText
        text: ""
        anchors {
            top: root.top;
            right: root.right;
        }
    }

    Text {
        id: fileName
        text: root.file
        onTextChanged: {
            entity.runLineMesh(text)
        }
    }
}
