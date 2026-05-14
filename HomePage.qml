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

            AppCard { title: "Nhạc"; iconSource: "qrc:/image_icons/music.png"; color1: "#c084fc"; color2: "#db2777"  ; onClicked: stackView.replace("qrc:/MusicPage.qml") }
            AppCard {
                title: "Xe"
                iconSource: "qrc:/image_icons/car.png"
                color1: "#38bdf8"
                color2: "#0284c7"
                onClicked: stackView.push("qrc:/DashboardCar.qml") // Mở file Taplo
            }
            AppCard { title: "Bản đồ"; iconSource: "qrc:/image_icons/google-maps.png"; color1: "#38bdf8"; color2: "#0284c7" }
            AppCard { title: "Điện thoại"; iconSource: "qrc:/image_icons/call.png"; color1: "#4ade80"; color2: "#16a34a" }
            AppCard { title: "Cài đặt"; iconSource: "qrc:/image_icons/setting.png"; color1: "#94a3b8"; color2: "#475569" ; onClicked: stackView.replace("qrc:/SettingPage.qml")}
            AppCard { title: "Radio"; iconSource: "qrc:/image_icons/radio.png"; color1: "#fbbf24"; color2: "#d97706" }
            AppCard { title: "Điều hoà"; iconSource: "qrc:/image_icons/wind.png"; color1: "#f87171"; color2: "#dc2626" } 
        }
        Item { Layout.fillHeight: true } // Khoảng trống đẩy Mini Player xuống đáy

        // Mini Player thu nhỏ
        // Rectangle {
        //     Layout.fillWidth: true
        //     Layout.preferredHeight: 90
        //     color: "#181425"
        //     radius: 20
        //     RowLayout {
        //         anchors.fill: parent
        //         anchors.margins: 20
        //         spacing: 20
        //         Rectangle {
        //             width: 55
        //             height: 55
        //             radius: 15
        //             gradient: Gradient {
        //                 GradientStop { position: 0; color: "#c084fc" }
        //                 GradientStop { position: 1; color: "#db2777" }
        //             }
        //             Image {
        //                 id: musicIcon
        //                 source: "qrc:/image_icons/music.png"
        //                 width: 30
        //                 height: 30
        //                 fillMode: Image.PreserveAspectFit
        //                 anchors.centerIn: parent
        //             }
        //         }
        //         // Thông tin bài hát và thanh tiến trình
        //         Column {
        //             Layout.fillWidth: true
        //             Layout.alignment: Qt.AlignVCenter
        //             spacing: 8
        //             Text { text: "Đêm Nay Không Ngủ"; color: "white"; font.bold: true; font.pixelSize: 17 }
        //             Text { text: "Hiếu Thứ Hai"; color: "#94a3b8"; font.pixelSize: 13 }
        //             // Thanh tiến trình Gradient giả lập
        //             Rectangle {
        //                 width: parent.width * 0.4
        //                 height: 4
        //                 color: "#334155"
        //                 radius: 2
        //                 Rectangle {
        //                     width: parent.width * 0.6
        //                     height: parent.height
        //                     radius: 2
        //                     gradient: Gradient {
        //                         GradientStop { position: 0; color: "#c084fc" }
        //                         GradientStop { position: 1; color: "#db2777" }
        //                     }
        //                 }
        //             }
        //         }
        //         // Nút điều khiển
        //         Row {
        //             spacing: 30
        //             Layout.alignment: Qt.AlignVCenter

        //             Image {
        //                 id: preIcon
        //                 source: "qrc:/image_icons/previous.png"
        //                 width: 30
        //                 height: 30
        //                 fillMode: Image.PreserveAspectFit
        //                 }

        //             Image {
        //                 id: playIcon
        //                 source: "qrc:/image_icons/play.png"
        //                 width: 30
        //                 height: 30
        //                 fillMode: Image.PreserveAspectFit
        //                 }
        //             Image {
        //                 id: nextIcon
        //                 source: "qrc:/image_icons/next.png"
        //                 width: 30
        //                 height: 30
        //                 fillMode: Image.PreserveAspectFit
        //                }
        //             }
        //     }
        // }
        Rectangle {
                    Layout.fillWidth: true
                    Layout.preferredHeight: 110
                    color: "#181425"
                    radius: 25
                    border.color: "#1e293b"
                    border.width: 1

                    RowLayout {
                        anchors.fill: parent
                        anchors.margins: 20
                        spacing: 25

                        // Ảnh Mini Album
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
                                // Hiệu ứng xoay nhẹ khi đang phát
                                RotationAnimator on rotation {
                                    running: root.isPlaying
                                    from: 0; to: 360; duration: 8000; loops: Animation.Infinite
                                }
                            }
                        }

                        // Thông tin & Thanh tiến trình
                        Column {
                            Layout.fillWidth: true
                            Layout.alignment: Qt.AlignVCenter
                            spacing: 8

                            Text {
                                text: globalPlaylist.get(root.currentSongIndex).title
                                color: "white"
                                font.bold: true
                                font.pixelSize: 18
                            }
                            Text {
                                text: globalPlaylist.get(root.currentSongIndex).artist
                                color: "#94a3b8"
                                font.pixelSize: 14
                            }

                            // Thanh tiến trình đồng bộ 100% với trang Music
                            Rectangle {
                                width: parent.width * 0.7
                                height: 5
                                color: "#334155"
                                radius: 2.5
                                Rectangle {
                                    width: parent.width * root.songProgress
                                    height: parent.height
                                    radius: 2.5
                                    gradient: Gradient {
                                        GradientStop { position: 0; color: "#c084fc" }
                                        GradientStop { position: 1; color: "#db2777" }
                                    }
                                }
                            }
                        }

                        // 3 NÚT ĐIỀU KHIỂN
                        Row {
                            spacing: 25
                            Layout.alignment: Qt.AlignVCenter

                            // Nút Lùi
                            Item {
                                width: 40; height: 40
                                Image {
                                    source: "qrc:/image_icons/previous.png"; anchors.fill: parent
                                    opacity: mousePrevMini.containsMouse ? 1.0 : 0.7
                                }
                                MouseArea { id: mousePrevMini; anchors.fill: parent; hoverEnabled: true; onClicked: root.prevSong() }
                            }

                            // Nút Play/Pause
                            Item {
                                width: 40; height: 40
                                Image {
                                    source: root.isPlaying ? "qrc:/image_icons/pause.png" : "qrc:/image_icons/play.png"
                                    anchors.fill: parent
                                }
                                MouseArea { anchors.fill: parent; onClicked: root.isPlaying = !root.isPlaying }
                            }

                            // Nút Tiếp
                            Item {
                                width: 40; height: 40
                                Image {
                                    source: "qrc:/image_icons/next.png"; anchors.fill: parent
                                    opacity: mouseNextMini.containsMouse ? 1.0 : 0.7
                                }
                                MouseArea { id: mouseNextMini; anchors.fill: parent; hoverEnabled: true; onClicked: root.nextSong() }
                            }
                        }
                    }
        }
    }
}