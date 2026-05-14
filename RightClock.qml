import QtQuick 2.15

Item {
    Image {
        id: bgClock
        anchors.fill: parent
        source: "qrc:/Speedometer.png"
        fillMode: Image.PreserveAspectFit
    }

    QIndicator {
            id: speedNeedle
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.bottom: parent.verticalCenter
            rotation: myController.speedAngle

            Behavior on rotation { NumberAnimation { duration: 200 } }
        }
    }
