import QtQuick 2.15

Item {

    Image {
        id: speedlimit
        source: "qrc:/road/Frame33.png"
        scale: 0.3
        transformOrigin: Item.TopLeft

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.topMargin: -10
        anchors.leftMargin: 50
        Text {
            text: "90"
            color: "black"
            font.pixelSize: 100
            font.bold: true
            anchors.horizontalCenter: parent.horizontalCenter
            anchors.verticalCenter: parent.verticalCenter

            anchors.verticalCenterOffset: 50
        }
    }
    // Mũi tên điều hướng rẽ phải
        Image {
            id: turnRight
            source: "qrc:/road/turn-right.svg"
            width: 45
            height: 45
            fillMode: Image.PreserveAspectFit

            anchors.top: parent.top
            anchors.topMargin: -5

            anchors.horizontalCenter: parent.horizontalCenter
            anchors.horizontalCenterOffset: -30
        }

        Text {
            id: distanceText
            text: "372 m"
            color: "white"
            font.pixelSize: 20
            font.bold: true

            anchors.left: turnRight.right
            anchors.leftMargin: 10
            anchors.verticalCenter: turnRight.verticalCenter
        }

            Image {
                id: steeringWheel
                source: "qrc:/road/steering.svg"
                width: 60
                height: 60
                fillMode: Image.PreserveAspectFit
                anchors.top: parent.top
                anchors.topMargin: -5
                anchors.right: parent.right
                anchors.rightMargin: 50
            }
    Image {
        id: road
        anchors.fill: parent
        source: "qrc:/road/road3.svg"
        fillMode: Image.Stretch

    Image {
        id: car1
        width: parent.width * 0.15
        height: parent.height * 0.20
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 70
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: 22
        source: "qrc:/road/car.png"
        fillMode: Image.PreserveAspectFit
    }
    Image {
        id: car2
        width: parent.width * 0.10
        height: parent.height * 0.10
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 200
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.horizontalCenterOffset: -18
        source: "qrc:/road/car.png"
        fillMode: Image.PreserveAspectFit
    }


    Row {
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.bottomMargin: 50
            anchors.leftMargin: 100
            spacing: 8

            Image {
                source: "qrc:/road/marker.svg"
                height: 18
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: "26 KM"
                color: "white"
                font.pixelSize: 18
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
            }
        }

        Row {
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.bottomMargin: 50
            anchors.rightMargin: 80
            spacing: 8

            Image {
                source: "qrc:/road/clock.svg"
                width: 18
                height: 18
                fillMode: Image.PreserveAspectFit
                anchors.verticalCenter: parent.verticalCenter
            }

            Text {
                text: "22 Min"
                color: "white"
                font.pixelSize: 18
                font.bold: true
                anchors.verticalCenter: parent.verticalCenter
            }
        }
    }
}