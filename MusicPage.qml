import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Item {
    anchors.fill: parent

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
                        running: root.isPlaying
                    }
                }
            }

            // Tên bài hát & Ca sĩ
            Column {
                spacing: 8
                anchors.horizontalCenter: parent.horizontalCenter
                Text {
                    text: globalPlaylist.get(root.currentSongIndex).title
                    color: "white"
                    font.pixelSize: 22
                    font.bold: true
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                Text {
                    text: globalPlaylist.get(root.currentSongIndex).artist
                    color: "#94a3b8"
                    font.pixelSize: 16
                    anchors.horizontalCenter: parent.horizontalCenter
                }
            }

            // Thanh tiến trình
            RowLayout {
                width: 500
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 15

                Text {
                    text: root.formatTime(root.timeToSeconds(globalPlaylist.get(root.currentSongIndex).duration) * root.songProgress)
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
                            width: parent.width * root.songProgress
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
                                root.songProgress = Math.min(Math.max(newProgress, 0), 1)
                            }
                            onPositionChanged: {
                                if (pressed) {
                                    var dragProgress = mouse.x / width
                                    root.songProgress = Math.min(Math.max(dragProgress, 0), 1)
                                }
                            }
                        }
                    }
                }

                Text {
                    text: globalPlaylist.get(root.currentSongIndex).duration
                    color: "#94a3b8"
                    font.pixelSize: 13
                    Layout.preferredWidth: 35
                }
            }

            // NÚT ĐIỀU KHIỂN
            Row {
                anchors.horizontalCenter: parent.horizontalCenter
                spacing: 15

                Rectangle {
                    width: 50; height: 50; radius: 25
                    color: root.isShuffle ? "#a855f7" : (mouseShuffle.containsMouse ? "#2a324a" : "#161b26")
                    scale: mouseShuffle.pressed ? 0.9 : 1.0
                    Behavior on color { ColorAnimation { duration: 150 } }
                    Behavior on scale { NumberAnimation { duration: 100 } }

                    Image {
                        source: "qrc:/image_icons/shuffle.png"
                        width: 30; height: 30
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                        opacity: root.isShuffle ? 1.0 : 0.6
                    }
                    MouseArea {
                        id: mouseShuffle
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            root.isShuffle = !root.isShuffle
                            if (root.isShuffle) root.isRepeat = false
                        }
                    }
                }

                Rectangle {
                    width: 50; height: 50; radius: 25
                    color: mousePrev.containsMouse ? "#2a324a" : "#161b26"
                    scale: mousePrev.pressed ? 0.9 : 1.0
                    Behavior on color { ColorAnimation { duration: 150 } }

                    Image { source: "qrc:/image_icons/previous.png"; width: 30; height: 30; fillMode: Image.PreserveAspectFit; anchors.centerIn: parent }
                    MouseArea { id: mousePrev; anchors.fill: parent; hoverEnabled: true; onClicked: root.prevSong() }
                }

                Rectangle {
                    width: 50; height: 50; radius: 25
                    color: mouseRewind.containsMouse ? "#2a324a" : "#161b26"
                    scale: mouseRewind.pressed ? 0.9 : 1.0

                    Image { source: "qrc:/image_icons/backward.png"; width: 30; height: 30; fillMode: Image.PreserveAspectFit; anchors.centerIn: parent }
                    MouseArea { id: mouseRewind; anchors.fill: parent; hoverEnabled: true; onClicked: root.seek(-10) }
                }

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
                            source: root.isPlaying ? "qrc:/image_icons/pause.png" : "qrc:/image_icons/play.png"
                            width: 30; height: 30; fillMode: Image.PreserveAspectFit; anchors.centerIn: parent
                        }
                        MouseArea { id: mousePlay; anchors.fill: parent; hoverEnabled: true; onClicked: root.isPlaying = !root.isPlaying }
                    }
                }

                Rectangle {
                    width: 50; height: 50; radius: 25
                    color: mouseForward.containsMouse ? "#2a324a" : "#161b26"
                    scale: mouseForward.pressed ? 0.9 : 1.0

                    Image { source: "qrc:/image_icons/forward.png"; width: 30; height: 30; fillMode: Image.PreserveAspectFit; anchors.centerIn: parent }
                    MouseArea { id: mouseForward; anchors.fill: parent; hoverEnabled: true; onClicked: root.seek(10) }
                }

                Rectangle {
                    width: 50; height: 50; radius: 25
                    color: mouseNext.containsMouse ? "#2a324a" : "#161b26"
                    scale: mouseNext.pressed ? 0.9 : 1.0

                    Image { source: "qrc:/image_icons/next.png"; width: 30; height: 30; fillMode: Image.PreserveAspectFit; anchors.centerIn: parent }
                    MouseArea { id: mouseNext; anchors.fill: parent; hoverEnabled: true; onClicked: root.nextSong() }
                }

                Rectangle {
                    width: 50; height: 50; radius: 25
                    color: root.isRepeat ? "#a855f7" : (mouseRepeat.containsMouse ? "#2a324a" : "#161b26")
                    scale: mouseRepeat.pressed ? 0.9 : 1.0

                    Image {
                        source: "qrc:/image_icons/repeat.png"
                        width: 30; height: 30
                        fillMode: Image.PreserveAspectFit
                        anchors.centerIn: parent
                        opacity: root.isRepeat ? 1.0 : 0.6
                    }
                    MouseArea {
                        id: mouseRepeat
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: {
                            root.isRepeat = !root.isRepeat
                            if (root.isRepeat) root.isShuffle = false
                        }
                    }
                }
            }
        }

        // Danh sách phát
        ColumnLayout {
            Layout.fillWidth: true; Layout.fillHeight: true; spacing: 15
            Text { text: "Danh sách phát"; color: "white"; font.pixelSize: 20; font.bold: true }
            ListView {
                id: playlistView
                Layout.fillWidth: true; Layout.fillHeight: true; model: globalPlaylist; clip: true; spacing: 8
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
                    MouseArea { anchors.fill: parent; onClicked: root.playSong(index) }
                }
            }
        }
    }
}