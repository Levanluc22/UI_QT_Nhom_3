import QtQuick 2.15
import QtQuick.Layouts 1.15

Item {
    anchors.fill: parent
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 40
        spacing: 30

        Text {
            text: "Trang chủ"
            color: "white"
            font.pixelSize: 28
            font.bold: true
            Layout.bottomMargin: 10
        }

        GridLayout {
            columns: 4
            columnSpacing: 25
            rowSpacing: 25
            Layout.fillWidth: true

            AppCard {
                title: "Nhạc"
                iconSource: "qrc:/image_icons/music.png"
                color1: "#c084fc"
                color2: "#db2777"
                onClicked: root.navigateTo("music", "MusicHub.qml")
            }
            AppCard {
                title: "Xe"
                iconSource: "qrc:/image_icons/car.png"
                color1: "#38bdf8"
                color2: "#0284c7"
                onClicked: root.showCarWindow()
            }
            AppCard { title: "Bản đồ"; iconSource: "qrc:/image_icons/google-maps.png"; color1: "#38bdf8"; color2: "#0284c7" }
            AppCard { title: "Điện thoại"; iconSource: "qrc:/image_icons/call.png"; color1: "#4ade80"; color2: "#16a34a" }
            AppCard {
                title: "Cài đặt"
                iconSource: "qrc:/image_icons/setting.png"
                color1: "#94a3b8"
                color2: "#475569"
                onClicked: root.navigateTo("settings", "SettingPage.qml")
            }
            AppCard { title: "Radio"; iconSource: "qrc:/image_icons/radio.png"; color1: "#fbbf24"; color2: "#d97706" }
            AppCard { title: "Điều hoà"; iconSource: "qrc:/image_icons/wind.png"; color1: "#f87171"; color2: "#dc2626" }
        }

        Item { Layout.fillHeight: true }

        // ==========================================
        // MINI PLAYER ĐÃ KẾT NỐI VỚI C++ (MusicApp)
        // ==========================================
        Rectangle {
            Layout.fillWidth: true
            Layout.preferredHeight: 110
            color: "#181425"
            radius: 25
            border.color: "#1e293b"
            border.width: 1
            visible: MusicApp.playlist.length > 0 && MusicApp.hasStartedPlaying
            RowLayout {
                anchors.fill: parent
                anchors.margins: 20
                spacing: 25

                Rectangle {
                    width: 70
                    height: 70
                    radius: 15
                    gradient: Gradient {
                        GradientStop { position: 0; color: "#c084fc" }
                        GradientStop { position: 1; color: "#db2777" }
                    }
                    Image {
                        source: "qrc:/image_icons/music.png"
                        width: 35
                        height: 35
                        anchors.centerIn: parent
                        RotationAnimator on rotation {
                            running: MusicApp.isPlaying // Gọi trạng thái từ C++
                            from: 0
                            to: 360
                            duration: 8000
                            loops: Animation.Infinite
                        }
                    }
                }

                Column {
                    Layout.fillWidth: true
                    Layout.alignment: Qt.AlignVCenter
                    spacing: 8

                    Text {
                        // Tránh lỗi khi danh sách nhạc từ C++ trống
                        text: MusicApp.playlist.length > 0 ? MusicApp.playlist[MusicApp.currentSongIndex].title : "Chưa có bài hát"
                        color: "white"
                        font.bold: true
                        font.pixelSize: 18
                    }
                    Text {
                        text: MusicApp.playlist.length > 0 ? MusicApp.playlist[MusicApp.currentSongIndex].artist : ""
                        color: "#94a3b8"
                        font.pixelSize: 14
                    }

                    Item {
                        width: parent.width * 0.7
                        height: 15

                        Rectangle {
                            anchors.centerIn: parent
                            width: parent.width
                            height: 5
                            color: "#334155"
                            radius: 2.5
                            Rectangle {
                                width: parent.width * MusicApp.songProgress // Lấy phần trăm chạy từ C++
                                height: parent.height
                                radius: 2.5
                                gradient: Gradient {
                                    GradientStop { position: 0; color: "#c084fc" }
                                    GradientStop { position: 1; color: "#db2777" }
                                }
                            }
                        }

                        // Gửi lệnh tua nhạc xuống C++
                        MouseArea {
                            anchors.fill: parent
                            onClicked: {
                                var newProgress = mouse.x / width
                                MusicApp.seekToProgress(Math.min(Math.max(newProgress, 0), 1))
                            }
                            onPositionChanged: {
                                if (pressed) {
                                    var dragProgress = mouse.x / width
                                    MusicApp.seekToProgress(Math.min(Math.max(dragProgress, 0), 1))
                                }
                            }
                        }
                    }
                }

                Row {
                    spacing: 25
                    Layout.alignment: Qt.AlignVCenter

                    Item {
                        width: 40
                        height: 40
                        Image {
                            source: "qrc:/image_icons/previous.png"
                            anchors.fill: parent
                            opacity: mousePrevMini.containsMouse ? 1.0 : 0.7
                        }
                        MouseArea {
                            id: mousePrevMini
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: MusicApp.prevSong() // Lệnh chuyển bài C++
                        }
                    }

                    Item {
                        width: 40
                        height: 40
                        Image {
                            source: MusicApp.isPlaying ? "qrc:/image_icons/pause.png" : "qrc:/image_icons/play.png"
                            anchors.fill: parent
                        }
                        MouseArea {
                            anchors.fill: parent
                            onClicked: MusicApp.isPlaying = !MusicApp.isPlaying
                        }
                    }

                    Item {
                        width: 40
                        height: 40
                        Image {
                            source: "qrc:/image_icons/next.png"
                            anchors.fill: parent
                            opacity: mouseNextMini.containsMouse ? 1.0 : 0.7
                        }
                        MouseArea {
                            id: mouseNextMini
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: MusicApp.nextSong()
                        }
                    }
                }
            }
        }
    }
}