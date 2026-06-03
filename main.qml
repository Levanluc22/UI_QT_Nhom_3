import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: root
    width: 1280
    height: 800
    visible: true
    title: "Nhóm 3"
    color: "#0b0f19"

    property string activePage: "home"

    function navigateTo(pageId, pageUrl) {
        if (root.activePage !== pageId) {
            root.activePage = pageId
            stackView.replace(pageUrl)
        }
    }

    // TOP BAR
    Rectangle {
        id: topBar
        height: 50
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: rightBar.left
        color: "#151925"

        Rectangle { width: parent.width; height: 1; color: "#1e293b"; anchors.bottom: parent.bottom }

        Text {
            text: {
                if (root.activePage === "home") return "Trang chủ"
                if (root.activePage === "music") return "Trình phát nhạc"
                if (root.activePage === "settings") return "Cài đặt"
                return "Trang chủ"
            }
            color: "white"
            font.bold: true
            font.pixelSize: 16
            anchors.left: parent.left
            anchors.leftMargin: 40
            anchors.verticalCenter: parent.verticalCenter
        }

        Row {
            anchors.right: parent.right
            anchors.rightMargin: 40
            anchors.verticalCenter: parent.verticalCenter
            spacing: 20
            Text { text: "25°C"; color: "#C3C3C3"; font.pixelSize: 14 }
            Text { text: "15:30"; color: "#C3C3C3"; font.pixelSize: 14 }
            Image { source: "qrc:/image_icons/wifi.png"; width: 25; height: 25; fillMode: Image.PreserveAspectFit }
            Image { source: "qrc:/image_icons/bluetooth.png"; width: 25; height: 25; fillMode: Image.PreserveAspectFit }
        }
    }

    // RIGHT BAR
    Rectangle {
        id: rightBar
        width: 80
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.bottom: parent.bottom
        color: "#151925"

        Rectangle { width: 1; color: "#1e293b"; anchors.left: parent.left; anchors.top: parent.top; anchors.bottom: parent.bottom }

        Column {
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 25

            Repeater {
                model: [
                    { id: "home", icon: "app.png", page: "HomePage.qml" },
                    { id: "music", icon: "music.png", page: "MusicHub.qml" },
                    { id: "settings", icon: "setting.png", page: "SettingPage.qml" }
                ]
                delegate: Item {
                    width: 60
                    height: 60
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle {
                        anchors.fill: parent
                        radius: 18
                        visible: root.activePage === modelData.id
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: "#c084fc" }
                            GradientStop { position: 1.0; color: "#db2777" }
                        }
                    }

                    Image {
                        source: "qrc:/image_icons/" + modelData.icon
                        width: 30
                        height: 30
                        anchors.centerIn: parent
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: root.navigateTo(modelData.id, modelData.page)
                    }
                }
            }
        }
    }

    StackView {
        id: stackView
        anchors.top: topBar.bottom
        anchors.bottom: parent.bottom
        anchors.left: parent.left
        anchors.right: rightBar.left
        initialItem: "HomePage.qml"

        replaceEnter: Transition {
            PropertyAnimation { property: "opacity"; from: 0.0; to: 1.0; duration: 250 }
        }
        replaceExit: Transition {
            PropertyAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 250 }
        }
    }

    Window {
        id: carWindow
        width: 1280
        height: 480
        title: " Nhóm 3"
        visible: true
        color: "#0f111a"

        DashboardCar {
            anchors.fill: parent
        }
    }

    function showCarWindow() {
        carWindow.show()
        carWindow.raise()
        carWindow.requestActivate()
    }
}