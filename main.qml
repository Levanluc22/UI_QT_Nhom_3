import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

Window {
    id: root
    width: 1280
    height: 800
    visible: true
    title: "UI OTO NHÓM 3"
    color: "#0b0f19"

    property bool isPlaying: false
    property int currentSongIndex: 0
    property real songProgress: 0.0
    property bool isShuffle: false
    property bool isRepeat: false

    ListModel {
        id: globalPlaylist
        ListElement { title: "Đêm Nay Không Ngủ"; artist: "Hiếu Thứ Hai"; duration: "3:45"; isPlaying: true }
        ListElement { title: "Có Chắc Yêu Là Đây"; artist: "Sơn Tùng M-TP"; duration: "4:12"; isPlaying: false }
        ListElement { title: "Waiting For You"; artist: "MONO"; duration: "3:58"; isPlaying: false }
        ListElement { title: "Nơi Này Có Anh"; artist: "Sơn Tùng M-TP"; duration: "4:32"; isPlaying: false }
        ListElement { title: "Thiên Mệnh"; artist: "Quân AP"; duration: "5:01"; isPlaying: false }
    }

    // Các hàm tính toán thời gian
    function timeToSeconds(timeStr) {
        if (!timeStr) return 0
        var parts = timeStr.split(":")
        if (parts.length !== 2) return 0
        return parseInt(parts[0]) * 60 + parseInt(parts[1])
    }

    function formatTime(seconds) {
        var m = Math.floor(seconds / 60)
        var s = Math.floor(seconds % 60)
        var sStr = s < 10 ? "0" + s : s.toString()
        return m + ":" + sStr
    }

    Timer {
        id: mainMusicTimer
        interval: 1000
        running: root.isPlaying
        repeat: true
        onTriggered: {
            var total = root.timeToSeconds(globalPlaylist.get(root.currentSongIndex).duration)
            if (total > 0) {
                root.songProgress += (1.0 / total)
            }
            if (root.songProgress >= 1.0) {
                root.nextSong()
            }
        }
    }

    function playSong(index) {
        root.currentSongIndex = index
        root.songProgress = 0.0
        root.isPlaying = true

        for (var i = 0; i < globalPlaylist.count; i++) {
            globalPlaylist.setProperty(i, "isPlaying", i === index)
        }
    }

    function nextSong() {
        if (root.isRepeat) {
            root.playSong(root.currentSongIndex)
        } else if (root.isShuffle) {
            var nextIdx = root.currentSongIndex
            if (globalPlaylist.count > 1) {
                while (nextIdx === root.currentSongIndex) {
                    nextIdx = Math.floor(Math.random() * globalPlaylist.count)
                }
            }
            root.playSong(nextIdx)
        } else {
            var normalNextIdx = root.currentSongIndex + 1
            if (normalNextIdx >= globalPlaylist.count) {
                normalNextIdx = 0
            }
            root.playSong(normalNextIdx)
        }
    }

    function prevSong() {
        var prevIdx = root.currentSongIndex - 1
        if (prevIdx < 0) {
            prevIdx = globalPlaylist.count - 1
        }
        root.playSong(prevIdx)
    }

    function seek(secondsOffset) {
        var totalSecs = root.timeToSeconds(globalPlaylist.get(root.currentSongIndex).duration)
        if (totalSecs > 0) {
            var newProgress = root.songProgress + (secondsOffset / totalSecs)
            root.songProgress = Math.min(Math.max(newProgress, 0), 1)
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