// import QtQuick 2.15
// import QtQuick.Layouts 1.15
// import QtQuick.Controls 2.15

// Item {
//     anchors.fill: parent
//     // Model dữ liệu cho danh sách phát
//     ListModel {
//         id: playlistModel
//         ListElement {
//             title: "Đêm Nay Không Ngủ"
//             artist: "Hiếu Thứ Hai"
//             duration: "3:45"
//             isPlaying: true
//         }
//         ListElement {
//             title: "Có Chắc Yêu Là Đây"
//             artist: "Sơn Tùng M-TP"
//             duration: "4:12"
//             isPlaying: false
//         }
//         ListElement {
//             title: "Waiting For You"
//             artist: "MONO"
//             duration: "3:58"
//             isPlaying: false
//         }
//         ListElement {
//             title: "Nơi Này Có Anh"
//             artist: "Sơn Tùng M-TP"
//             duration: "4:32"
//             isPlaying: false
//         }
//         ListElement {
//             title: "Lạ Lùng"
//             artist: "Vũ."
//             duration: "5:01"
//             isPlaying: false
//         }
//     }
//     ColumnLayout {
//         anchors.fill: parent
//         anchors.margins: 40
//         spacing: 30
//         // TRÌNH PHÁT NHẠC CHÍNH
//         Column {
//             Layout.alignment: Qt.AlignHCenter
//             spacing: 20
//             // Ảnh Album Art
//             Item {
//                 width: 260
//                 height: 260
//                 anchors.horizontalCenter: parent.horizontalCenter

//                 Rectangle {
//                     anchors.centerIn: parent
//                     width: 280
//                     height: 280
//                     radius: 40
//                     color: "#a855f7"
//                     opacity: 0.2
//                 }
//                 Rectangle {
//                     anchors.fill: parent
//                     radius: 30
//                     gradient: Gradient {
//                         GradientStop { position: 0.0; color: "#a855f7" }
//                         GradientStop { position: 1.0; color: "#f97316" }
//                     }
//                     Image {
//                         id: musicIcon
//                         source: "qrc:/image_icons/music.png"
//                         width: 60
//                         height: 60
//                         fillMode: Image.PreserveAspectFit
//                         anchors.centerIn: parent
//                     }
//                     Image {
//                         source: iconSource
//                         width: 30
//                         height: 30
//                         anchors.centerIn: parent
//                         fillMode: Image.PreserveAspectFit
//                         }
//                 }
//             }
//             // Tên bài hát và ca sĩ
//             Column {
//                 spacing: 8
//                 anchors.horizontalCenter: parent.horizontalCenter
//                 Text {
//                     text: "Đêm Nay Không Ngủ"
//                     color: "white"
//                     font.pixelSize: 22
//                     font.bold: true
//                     anchors.horizontalCenter: parent.horizontalCenter
//                 }
//                 Text {
//                     text: "Hiếu Thứ Hai"
//                     color: "#94a3b8"
//                     font.pixelSize: 16
//                     anchors.horizontalCenter: parent.horizontalCenter
//                 }
//             }
//             //  Thanh tiến trình
//             RowLayout {
//                 width: 500
//                 anchors.horizontalCenter: parent.horizontalCenter
//                 spacing: 15

//                 Text { text: "1:23"; color: "#94a3b8"; font.pixelSize: 13 }

//                 Rectangle {
//                     Layout.fillWidth: true
//                     height: 6
//                     radius: 3
//                     color: "#1e293b"

//                     Rectangle {
//                         width: parent.width * 0.4
//                         height: parent.height
//                         radius: 3
//                         gradient: Gradient {
//                             GradientStop { position: 0.0; color: "#a855f7" }
//                             GradientStop { position: 1.0; color: "#ec4899" }
//                         }
//                     }
//                 }
//                 Text { text: "3:45"; color: "#94a3b8"; font.pixelSize: 13 }
//             }
//             // Các nút điều khiển
//             Row {
//                 anchors.horizontalCenter: parent.horizontalCenter
//                 spacing: 25

//                 Rectangle {
//                     width: 50
//                     height: 50
//                     radius: 25
//                     color: "#161b26"
//                     Image {
//                         id: shuIcon
//                         source: "qrc:/image_icons/shuffle.png"
//                         width: 30
//                         height: 30
//                         fillMode: Image.PreserveAspectFit
//                         anchors.centerIn: parent
//                     }
//                 }
//                 Rectangle {
//                     width: 50
//                     height: 50
//                     radius: 25
//                     color: "#161b26"
//                     Image {
//                         id: preIcon
//                         source: "qrc:/image_icons/previous.png"
//                         width: 30
//                         height: 30
//                         fillMode: Image.PreserveAspectFit
//                         anchors.centerIn: parent
//                     }
//                 }

//                 Item {
//                     width: 70
//                     height: 70
//                     Rectangle { anchors.centerIn: parent; width: 85; height: 85; radius: 42.5; color: "#c084fc"; opacity: 0.2 }
//                     Rectangle {
//                         anchors.fill: parent
//                         radius: 35
//                         gradient: Gradient {
//                             GradientStop { position: 0.0; color: "#c084fc" }
//                             GradientStop { position: 1.0; color: "#db2777" }
//                         }
//                         Image {
//                             id: playIcon
//                             source: "qrc:/image_icons/play.png"
//                             width: 30
//                             height: 30
//                             fillMode: Image.PreserveAspectFit
//                             anchors.centerIn: parent
//                         }
//                     }
//                 }
//                 Rectangle {
//                     width: 50
//                     height: 50
//                     radius: 25
//                     color: "#161b26"
//                     Image {
//                         id: nextIcon
//                         source: "qrc:/image_icons/next.png"
//                         width: 30
//                         height: 30
//                         fillMode: Image.PreserveAspectFit
//                         anchors.centerIn: parent
//                     }
//                 }
//                 Rectangle {
//                     width: 50
//                     height: 50
//                     radius: 25
//                     color: "#161b26"
//                     Image {
//                         id: repeatIcon
//                         source: "qrc:/image_icons/repeat.png"
//                         width: 30
//                         height: 30
//                         fillMode: Image.PreserveAspectFit
//                         anchors.centerIn: parent
//                     }
//                 }
//             }
//         }
//         // DANH SÁCH PHÁT
//         ColumnLayout {
//             Layout.fillWidth: true
//             Layout.fillHeight: true
//             spacing: 15

//             Text {
//                 text: "Danh sách phát"
//                 color: "white"
//                 font.pixelSize: 20
//                 font.bold: true
//             }
//             ListView {
//                 id: playlistView
//                 Layout.fillWidth: true
//                 Layout.fillHeight: true
//                 model: playlistModel
//                 clip: true
//                 spacing: 8

//                 delegate: Rectangle {
//                     width: playlistView.width
//                     height: 75
//                     radius: 15
//                     color: isPlaying ? "#22173f" : "transparent"
//                     border.color: isPlaying ? "#3b2260" : "transparent"
//                     border.width: 1
//                     RowLayout {
//                         anchors.fill: parent
//                         anchors.margins: 20
//                         spacing: 20
//                         Text {
//                             text: isPlaying ? "▶" : (index + 1)
//                             color: isPlaying ? "#c084fc" : "#64748b"
//                             font.pixelSize: 16
//                             Layout.preferredWidth: 20
//                         }
//                         Column {
//                             Layout.fillWidth: true
//                             spacing: 5
//                             Text { text: title; color: "white"; font.bold: true; font.pixelSize: 16 }
//                             Text { text: artist; color: "#64748b"; font.pixelSize: 14 }
//                         }
//                         Text { text: duration; color: "#64748b"; font.pixelSize: 14 }
//                     }
//                 }
//             }
//         }
//     }
// }

import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Item {
    anchors.fill: parent

    // --- 1. BIẾN QUẢN LÝ TRẠNG THÁI ---
    property bool isPlaying: false
    property int currentSongIndex: 0
    property real songProgress: 0.0

    // Hai tính năng mới: Trộn bài và Lặp lại
    property bool isShuffle: false
    property bool isRepeat: false

    // Model dữ liệu danh sách phát
    ListModel {
        id: playlistModel
        ListElement { title: "Đêm Nay Không Ngủ"; artist: "Hiếu Thứ Hai"; duration: "3:45"; isPlaying: true }
        ListElement { title: "Có Chắc Yêu Là Đây"; artist: "Sơn Tùng M-TP"; duration: "4:12"; isPlaying: false }
        ListElement { title: "Waiting For You"; artist: "MONO"; duration: "3:58"; isPlaying: false }
        ListElement { title: "Nơi Này Có Anh"; artist: "Sơn Tùng M-TP"; duration: "4:32"; isPlaying: false }
        ListElement { title: "Lạ Lùng"; artist: "Vũ."; duration: "5:01"; isPlaying: false }
    }

    // --- 2. CÁC HÀM XỬ LÝ THỜI GIAN ---
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

    // --- 3. LOGIC ĐIỀU KHIỂN CHÍNH ---
    Timer {
        id: progressTimer
        interval: 1000
        running: isPlaying
        repeat: true
        onTriggered: {
            var totalSecs = timeToSeconds(playlistModel.get(currentSongIndex).duration)
            if (totalSecs > 0) {
                songProgress += (1.0 / totalSecs)
            }
            // Khi hết bài, thực hiện chuyển bài dựa trên mode đã chọn
            if (songProgress >= 1.0) {
                nextSong()
            }
        }
    }

    function playSong(index) {
        currentSongIndex = index
        songProgress = 0.0
        isPlaying = true

        for (var i = 0; i < playlistModel.count; i++) {
            playlistModel.setProperty(i, "isPlaying", i === index)
        }
    }

    function nextSong() {
        // Ưu tiên 1: Chế độ lặp lại (Repeat)
        if (isRepeat) {
            playSong(currentSongIndex)
        }
        // Ưu tiên 2: Chế độ trộn bài (Shuffle)
        else if (isShuffle) {
            var nextIdx = currentSongIndex
            if (playlistModel.count > 1) {
                // Đảm bảo bài tiếp theo ngẫu nhiên không trùng bài cũ
                while (nextIdx === currentSongIndex) {
                    nextIdx = Math.floor(Math.random() * playlistModel.count)
                }
            }
            playSong(nextIdx)
        }
        // Chế độ phát tuần tự bình thường
        else {
            var normalNextIdx = currentSongIndex + 1
            if (normalNextIdx >= playlistModel.count) {
                normalNextIdx = 0
            }
            playSong(normalNextIdx)
        }
    }

    function prevSong() {
        var prevIdx = currentSongIndex - 1
        if (prevIdx < 0) {
            prevIdx = playlistModel.count - 1
        }
        playSong(prevIdx)
    }

    function seek(secondsOffset) {
        var totalSecs = timeToSeconds(playlistModel.get(currentSongIndex).duration)
        if (totalSecs > 0) {
            var newProgress = songProgress + (secondsOffset / totalSecs)
            if (newProgress < 0) newProgress = 0
            if (newProgress > 1) newProgress = 1
            songProgress = newProgress
        }
    }

    // --- 4. GIAO DIỆN NGƯỜI DÙNG ---
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40
        spacing: 30

        Column {
            Layout.alignment: Qt.AlignHCenter
            spacing: 20

            // Khu vực đĩa nhạc xoay
            Item {
                width: 260
                height: 260
                anchors.horizontalCenter: parent.horizontalCenter

                Rectangle {
                    anchors.centerIn: parent
                    width: 280
                    height: 280
                    radius: 140
                    color: "#a855f7"
                    opacity: 0.2
                }

                Rectangle {
                    id: albumArt
                    anchors.fill: parent
                    radius: 130
                    gradient: Gradient {
                        GradientStop { position: 0.0; color: "#a855f7" }
                        GradientStop { position: 1.0; color: "#f97316" }
                    }

                    Image {
                        source: "qrc:/image_icons/music.png"
                        width: 60
                        height: 60
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                    }

                    RotationAnimator on rotation {
                        loops: Animation.Infinite
                        from: 0
                        to: 360
                        duration: 10000
                        running: isPlaying
                    }
                }
            }

            // Tên bài hát & Ca sĩ
            Column {
                spacing: 8
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    text: playlistModel.get(currentSongIndex).title
                    color: "white"
                    font.pixelSize: 22
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    text: playlistModel.get(currentSongIndex).artist
                    color: "#94a3b8"
                    font.pixelSize: 16
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            // Thanh tiến trình với hiệu ứng Hover
            RowLayout {
                width: 500
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 15

                Text {
                    text: formatTime(timeToSeconds(playlistModel.get(currentSongIndex).duration) * songProgress)
                    color: "#94a3b8"
                    font.pixelSize: 13
                    Layout.preferredWidth: 35
                    horizontalAlignment: Text.AlignRight
                }

                Item {
                    Layout.fillWidth: true
                    height: 12
                    anchors.verticalCenter: parent.verticalCenter

                    Rectangle {
                        id: progressBarTrack
                        anchors.centerIn: parent
                        width: parent.width
                        height: progressMouseArea.containsMouse ? 10 : 6
                        radius: progressMouseArea.containsMouse ? 5 : 3
                        color: "#1e293b"

                        Behavior on height { NumberAnimation { duration: 150 } }
                        Behavior on radius { NumberAnimation { duration: 150 } }

                        Rectangle {
                            width: parent.width * songProgress
                            height: parent.height
                            radius: parent.radius
                            gradient: Gradient {
                                GradientStop { position: 0.0; color: "#a855f7" }
                                GradientStop { position: 1.0; color: "#ec4899" }
                            }
                            Behavior on width { NumberAnimation { duration: 50 } }
                        }

                        MouseArea {
                            id: progressMouseArea
                            anchors.fill: parent
                            anchors.margins: -5
                            hoverEnabled: true
                            onClicked: {
                                var newProgress = mouse.x / width
                                songProgress = Math.min(Math.max(newProgress, 0), 1)
                            }
                            onPositionChanged: {
                                if (pressed) {
                                    var dragProgress = mouse.x / width
                                    songProgress = Math.min(Math.max(dragProgress, 0), 1)
                                }
                            }
                        }
                    }
                }

                Text {
                    text: playlistModel.get(currentSongIndex).duration
                    color: "#94a3b8"
                    font.pixelSize: 13
                    Layout.preferredWidth: 35
                }
            }

            // CỤM NÚT ĐIỀU KHIỂN
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 15

                // Nút Shuffle (Trộn bài)
                Rectangle {
                    width: 50; height: 50; radius: 25
                    // Nếu đang bật Shuffle thì nút sẽ có màu tím sáng
                    color: isShuffle ? "#a855f7" : (mouseShuffle.containsMouse ? "#2a324a" : "#161b26")
                    scale: mouseShuffle.pressed ? 0.9 : 1.0
                    Behavior on color { ColorAnimation { duration: 150 } }
                    Behavior on scale { NumberAnimation { duration: 100 } }

                    Image {
                        source: "qrc:/image_icons/shuffle.png"
                        width: 22; height: 22
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                        opacity: isShuffle ? 1.0 : 0.6
                    }
                    MouseArea {
                        id: mouseShuffle
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            isShuffle = !isShuffle
                            if (isShuffle) isRepeat = false // Tắt lặp lại nếu bật trộn bài
                        }
                    }
                }

                // Nút Quay lại bài trước
                Rectangle {
                    width: 50; height: 50; radius: 25
                    color: mousePrev.containsMouse ? "#2a324a" : "#161b26"
                    scale: mousePrev.pressed ? 0.9 : 1.0
                    Behavior on color { ColorAnimation { duration: 150 } }

                    Image { source: "qrc:/image_icons/previous.png"; width: 22; height: 22; fillMode: Image.PreserveAspectFit; anchors.centerIn: parent }
                    MouseArea { id: mousePrev; anchors.fill: parent; hoverEnabled: true; onClicked: prevSong() }
                }

                // Nút Lùi 5 giây
                Rectangle {
                    width: 50; height: 50; radius: 25
                    color: mouseRewind.containsMouse ? "#2a324a" : "#161b26"
                    scale: mouseRewind.pressed ? 0.9 : 1.0

                    Image { source: "qrc:/image_icons/backward.png"; width: 22; height: 22; fillMode: Image.PreserveAspectFit; anchors.centerIn: parent }
                    MouseArea { id: mouseRewind; anchors.fill: parent; hoverEnabled: true; onClicked: seek(-10) }
                }

                // Nút Play/Pause chính
                Item {
                    width: 70; height: 70
                    scale: mousePlay.pressed ? 0.9 : 1.0

                    Rectangle { anchors.centerIn: parent; width: 85; height: 85; radius: 42.5; color: "#c084fc"; opacity: 0.2 }
                    Rectangle {
                        anchors.fill: parent; radius: 35
                        gradient: Gradient {
                            GradientStop { position: 0.0; color: mousePlay.containsMouse ? "#d8b4fe" : "#c084fc" }
                            GradientStop { position: 1.0; color: mousePlay.containsMouse ? "#f17eb8" : "#db2777" }
                        }
                        Image {
                            source: isPlaying ? "qrc:/image_icons/pause.png" : "qrc:/image_icons/play.png"
                            width: 30; height: 30; fillMode: Image.PreserveAspectFit; anchors.centerIn: parent
                        }
                        MouseArea { id: mousePlay; anchors.fill: parent; hoverEnabled: true; onClicked: isPlaying = !isPlaying }
                    }
                }

                // Nút Tiến 5 giây
                Rectangle {
                    width: 50; height: 50; radius: 25
                    color: mouseForward.containsMouse ? "#2a324a" : "#161b26"
                    scale: mouseForward.pressed ? 0.9 : 1.0

                    Image { source: "qrc:/image_icons/forward.png"; width: 22; height: 22; fillMode: Image.PreserveAspectFit; anchors.centerIn: parent }
                    MouseArea { id: mouseForward; anchors.fill: parent; hoverEnabled: true; onClicked: seek(10) }
                }

                // Nút Tiếp theo
                Rectangle {
                    width: 50; height: 50; radius: 25
                    color: mouseNext.containsMouse ? "#2a324a" : "#161b26"
                    scale: mouseNext.pressed ? 0.9 : 1.0

                    Image { source: "qrc:/image_icons/next.png"; width: 22; height: 22; fillMode: Image.PreserveAspectFit; anchors.centerIn: parent }
                    MouseArea { id: mouseNext; anchors.fill: parent; hoverEnabled: true; onClicked: nextSong() }
                }

                // Nút Repeat (Lặp lại)
                Rectangle {
                    width: 50; height: 50; radius: 25
                    // Nếu đang bật Repeat thì nút sẽ sáng lên
                    color: isRepeat ? "#a855f7" : (mouseRepeat.containsMouse ? "#2a324a" : "#161b26")
                    scale: mouseRepeat.pressed ? 0.9 : 1.0

                    Image {
                        source: "qrc:/image_icons/repeat.png"
                        width: 22; height: 22
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                        opacity: isRepeat ? 1.0 : 0.6
                    }
                    MouseArea {
                        id: mouseRepeat
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            isRepeat = !isRepeat
                            if (isRepeat) isShuffle = false // Tắt trộn bài nếu bật lặp lại
                        }
                    }
                }
            }
        }

        // Danh sách phát có thể tương tác
        ColumnLayout {
            Layout.fillWidth: true; Layout.fillHeight: true; spacing: 15
            Text { text: "Danh sách phát"; color: "white"; font.pixelSize: 20; font.bold: true }
            ListView {
                id: playlistView
                Layout.fillWidth: true; Layout.fillHeight: true; model: playlistModel; clip: true; spacing: 8
                delegate: Rectangle {
                    width: playlistView.width; height: 75; radius: 15
                    color: isPlaying ? "#22173f" : "transparent"
                    border.color: isPlaying ? "#3b2260" : "transparent"
                    border.width: 1
                    RowLayout {
                        anchors.fill: parent; anchors.margins: 20; spacing: 20
                        Text { text: isPlaying ? "▶" : (index + 1); color: isPlaying ? "#c084fc" : "#64748b"; font.pixelSize: 16; Layout.preferredWidth: 20 }
                        Column {
                            Layout.fillWidth: true; spacing: 5
                            Text { text: title; color: "white"; font.bold: true; font.pixelSize: 16 }
                            Text { text: artist; color: "#64748b"; font.pixelSize: 14 }
                        }
                        Text { text: duration; color: "#64748b"; font.pixelSize: 14 }
                    }
                    MouseArea { anchors.fill: parent; onClicked: playSong(index) }
                }
            }
        }
    }
}