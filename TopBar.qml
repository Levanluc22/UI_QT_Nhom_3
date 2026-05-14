import QtQuick 2.15

Item {

    Image {
        anchors.fill: parent
        source: "qrc:/TopBar.png"
        fillMode: Image.PreserveAspectFit

        Row {
                    anchors.verticalCenter: parent.verticalCenter
                    anchors.left: parent.left
                    anchors.leftMargin: 50
                    spacing: 8

                    Image {

                        source: "qrc:/icons/cloud.svg"
                        width: 24
                        height: 24
                        fillMode: Image.PreserveAspectFit
                        anchors.verticalCenter: parent.verticalCenter
                    }

                    Text {
                        id: tempText
                        text: "12 °C"
                        color: "white"
                        font.pixelSize: 20
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }

        Text {
            id: timeText
            text: "12:14 AM"
            color: "white"
            font.pixelSize: 20
            font.bold: true
            anchors.verticalCenter: parent.verticalCenter
            anchors.right: parent.right
            anchors.rightMargin: 50
        }
    }
}