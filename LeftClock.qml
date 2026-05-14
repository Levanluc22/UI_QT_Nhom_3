import QtQuick 2.15

Item {
    Image {
        id: bgClock
        anchors.fill: parent
        source: "qrc:/Tacometer.png"
        fillMode: Image.PreserveAspectFit
    }
    QIndicator {
        id: tachoNeedle
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.verticalCenter
        rotation: myController.tachoAngle
        Behavior on rotation { NumberAnimation { duration: 200 } }
        }
}