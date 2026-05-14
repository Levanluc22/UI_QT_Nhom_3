// import QtQuick 2.15
// import QtQuick.Window 2.15
// import QtQuick.Controls 2.15
// import QtQuick.Layouts 1.15

// Window {
//     id: root
//     width: 1280
//     height: 800
//     visible: true
//     title: "nhom3"
//     color: "#0b0f19"

//     // TOP BAR
//     Rectangle {
//                 id: topBar
//                 height: 50
//                 anchors.top: parent.top
//                 anchors.left: parent.left
//                 anchors.right: rightBar.left
//                 color: "#151925"
//                 Rectangle {
//                     width: parent.width
//                     height: 1
//                     color: "#1e293b"
//                     anchors.bottom: parent.bottom
//                 }
//                 Text {
//                     text: {
//                         if (rightBar.activePage === "home") return "Trang chủ"
//                         if (rightBar.activePage === "music") return "Trình phát nhạc"
//                         if (rightBar.activePage === "settings") return "Cài đặt"
//                         return "Trang chủ" // Giá trị mặc định nếu không khớp
//                         }
//                     color: "white"
//                     font.bold: true
//                     font.pixelSize: 16
//                     anchors.left: parent.left
//                     anchors.leftMargin: 40
//                     anchors.verticalCenter: parent.verticalCenter
//                 }
//                 Row {
//                     anchors.right: parent.right
//                     anchors.rightMargin: 40
//                     anchors.verticalCenter: parent.verticalCenter
//                     spacing: 20
//                     Text { text: "25°C"; color: "#C3C3C3"; font.pixelSize: 14; anchors.verticalCenter: parent.verticalCenter }
//                     Text { text: "15:30"; color: "#C3C3C3"; font.pixelSize: 14; anchors.verticalCenter: parent.verticalCenter }
//                     Image {
//                         id: wifiIcon
//                         source: "qrc:/image_icons/wifi.png"
//                         width: 30
//                         height: 30
//                         fillMode: Image.PreserveAspectFit
//                         anchors.verticalCenter: parent.verticalCenter
//                     }
//                     // BLUETOOTH
//                     Image {
//                         id: btIcon
//                         source: "qrc:/image_icons/bluetooth.png"
//                         width: 30
//                         height: 30
//                         fillMode: Image.PreserveAspectFit
//                         anchors.verticalCenter: parent.verticalCenter
//                     }
//                 }
//             }

//     // RIGHT BAR
//     Rectangle {
//         id: rightBar
//         width: 80
//         anchors.right: parent.right
//         anchors.top: parent.top
//         anchors.bottom: parent.bottom
//         color: "#151925"
//         property string activePage: "home"
//         Rectangle {
//             width: 1
//             color: "#1e293b"
//             anchors.left: parent.left
//             anchors.top: parent.top
//             anchors.bottom: parent.bottom
//         }
//         Column {
//             anchors.top: parent.top
//             anchors.topMargin: 30
//             anchors.horizontalCenter: parent.horizontalCenter
//             spacing: 25
//             // HOME
//             Item {
//                 width: 60
//                 height: 60
//                 anchors.horizontalCenter: parent.horizontalCenter
//                 // Gradient nền khi đang chọn
//                 Rectangle {
//                     anchors.fill: parent
//                     radius: 18
//                     visible: rightBar.activePage === "home"
//                     gradient: Gradient {
//                         GradientStop { position: 0.0; color: "#c084fc" }
//                         GradientStop { position: 1.0; color: "#db2777" }
//                     }
//                 }
//                 // Hiệu ứng màng mờ khi di chuột vào
//                 Rectangle {
//                     anchors.fill: parent
//                     radius: 18
//                     color: "white"
//                     opacity: (mouseHome.containsMouse && rightBar.activePage !== "home") ? 0.1 : 0.0
//                     Behavior on opacity { NumberAnimation { duration: 200 } }
//                 }
//                 Image {
//                     id: appIcon
//                     source: "qrc:/image_icons/app.png"
//                     width: 30
//                     height: 30
//                     fillMode: Image.PreserveAspectFit
//                     anchors.centerIn: parent
//                 }
//                 MouseArea {
//                     id: mouseHome
//                     anchors.fill: parent
//                     hoverEnabled: true
//                     onClicked: {
//                         if (rightBar.activePage !== "home") {
//                             rightBar.activePage = "home"
//                             stackView.replace("qrc:/HomePage.qml")
//                         }
//                     }
//                 }
//             }
//             //NHẠC
//             Item {
//                 width: 60
//                 height: 60
//                 anchors.horizontalCenter: parent.horizontalCenter

//                 Rectangle {
//                     anchors.fill: parent
//                     radius: 18
//                     visible: rightBar.activePage === "music"
//                     gradient: Gradient {
//                         GradientStop { position: 0.0; color: "#c084fc" }
//                         GradientStop { position: 1.0; color: "#db2777" }
//                     }
//                 }
//                 Rectangle {
//                     anchors.fill: parent
//                     radius: 18
//                     color: "white"
//                     opacity: (mouseMusic.containsMouse && rightBar.activePage !== "music") ? 0.1 : 0.0
//                     Behavior on opacity { NumberAnimation { duration: 200 } }
//                 }
//                 Image {
//                     id: musicIcon
//                     source: "qrc:/image_icons/music.png"
//                     width: 30
//                     height: 30
//                     fillMode: Image.PreserveAspectFit
//                     anchors.centerIn: parent
//                 }
//                 MouseArea {
//                     id: mouseMusic
//                     anchors.fill: parent
//                     hoverEnabled: true
//                     onClicked: {
//                         if (rightBar.activePage !== "music") {
//                             rightBar.activePage = "music"
//                             stackView.replace("qrc:/MusicPage.qml")
//                         }
//                     }
//                 }
//             }
//             //  CÀI ĐẶT
//             Item {
//                 width: 60
//                 height: 60
//                 anchors.horizontalCenter: parent.horizontalCenter

//                 Rectangle {
//                     anchors.fill: parent
//                     radius: 18
//                     visible: rightBar.activePage === "settings"
//                     gradient: Gradient {
//                         GradientStop { position: 0.0; color: "#c084fc" }
//                         GradientStop { position: 1.0; color: "#db2777" }
//                     }
//                 }
//                 Rectangle {
//                     anchors.fill: parent
//                     radius: 18
//                     color: "white"
//                     opacity: (mouseSettings.containsMouse && rightBar.activePage !== "settings") ? 0.1 : 0.0
//                     Behavior on opacity { NumberAnimation { duration: 200 } }
//                 }
//                 Image {
//                     id: settingIcon
//                     source: "qrc:/image_icons/setting.png"
//                     width: 30
//                     height: 30
//                     fillMode: Image.PreserveAspectFit
//                     anchors.centerIn: parent
//                 }
//                 MouseArea {
//                     id: mouseSettings
//                     anchors.fill: parent
//                     hoverEnabled: true
//                     onClicked: {
//                         if (rightBar.activePage !== "settings") {
//                             rightBar.activePage = "settings"
//                             stackView.replace("qrc:/SettingPage.qml")
//                         }
//                     }
//                 }
//             }
//         }
//         // Nút nguồn ở dưới cùng
//         Image {
//             id: buttonIcon
//             source: "qrc:/image_icons/on-off-button.png"
//             width: 30
//             height: 30
//             fillMode: Image.PreserveAspectFit
//             anchors.centerIn: parent
//         }
//     }
//     // STACK VIEW
//     StackView {
//         id: stackView
//         anchors.top: topBar.bottom
//         anchors.bottom: parent.bottom
//         anchors.left: parent.left
//         anchors.right: rightBar.left
//         initialItem: "qrc:/HomePage.qml"
//     }
// }

import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: root
    width: 1280
    height: 800
    visible: true
    title: "Artemis OS"
    color: "#0b0f19"

    // ==========================================
    // QUẢN LÝ DỮ LIỆU NHẠC TOÀN HỆ THỐNG
    // ==========================================
    property bool isPlaying: false
    property int currentSongIndex: 0
    property real songProgress: 0.0

    ListModel {
        id: globalPlaylist
        ListElement { title: "Đêm Nay Không Ngủ"; artist: "Hiếu Thứ Hai"; duration: "3:45"; isPlaying: true }
        ListElement { title: "Có Chắc Yêu Là Đây"; artist: "Sơn Tùng M-TP"; duration: "4:12"; isPlaying: false }
        ListElement { title: "Waiting For You"; artist: "MONO"; duration: "3:58"; isPlaying: false }
        ListElement { title: "Nơi Này Có Anh"; artist: "Sơn Tùng M-TP"; duration: "4:32"; isPlaying: false }
        ListElement { title: "Lạ Lùng"; artist: "Vũ."; duration: "5:01"; isPlaying: false }
    }

    function timeToSeconds(timeStr) {
        if (!timeStr) return 0
        var parts = timeStr.split(":")
        return parseInt(parts[0]) * 60 + parseInt(parts[1])
    }

    Timer {
        id: mainMusicTimer
        interval: 1000
        running: root.isPlaying
        repeat: true
        onTriggered: {
            var total = timeToSeconds(globalPlaylist.get(root.currentSongIndex).duration)
            root.songProgress += (1.0 / total)
            if (root.songProgress >= 1.0) nextSong()
        }
    }

    function nextSong() {
        root.currentSongIndex = (root.currentSongIndex + 1) % globalPlaylist.count
        root.songProgress = 0.0
        root.isPlaying = true
    }

    function prevSong() {
        root.currentSongIndex = (root.currentSongIndex - 1 + globalPlaylist.count) % globalPlaylist.count
        root.songProgress = 0.0
        root.isPlaying = true
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
                if (rightBar.activePage === "home") return "Trang chủ"
                if (rightBar.activePage === "music") return "Trình phát nhạc"
                if (rightBar.activePage === "settings") return "Cài đặt"
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
        property string activePage: "home"

        Rectangle { width: 1; color: "#1e293b"; anchors.left: parent.left; anchors.top: parent.top; anchors.bottom: parent.bottom }

        Column {
            anchors.top: parent.top
            anchors.topMargin: 30
            anchors.horizontalCenter: parent.horizontalCenter
            spacing: 25

            // Các nút Sidebar (Home, Music, Settings...)
            // Giữ nguyên logic như bạn đã có
            Repeater {
                model: [
                    { id: "home", icon: "app.png" },
                    { id: "music", icon: "music.png" },
                    { id: "settings", icon: "setting.png" }
                ]
                delegate: Item {
                    width: 60
                    height: 60
                    anchors.horizontalCenter: parent.horizontalCenter

                    Rectangle {
                        anchors.fill: parent
                        radius: 18
                        visible: rightBar.activePage === modelData.id
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
                        onClicked: {
                            if (rightBar.activePage !== modelData.id) {
                                rightBar.activePage = modelData.id
                                stackView.replace("qrc:/" + (modelData.id === "home" ? "HomePage" : (modelData.id === "music" ? "MusicPage" : "SettingPage")) + ".qml")
                            }
                        }
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
        initialItem: "qrc:/HomePage.qml"
    }
}