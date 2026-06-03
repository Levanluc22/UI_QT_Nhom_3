import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

Item {
    id: hubRoot

    Component.onCompleted: {
        contentLoader.setSource("PlaylistView.qml", { "pageTitle": "Tất cả bài hát (USB)", "playlistType": "all" })
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 30
        spacing: 20

        RowLayout {
            Layout.fillWidth: true
            Layout.fillHeight: true
            spacing: 30

            // --- CỘT TRÁI (SIDEBAR) ---
            Rectangle {
                Layout.preferredWidth: 320
                Layout.fillHeight: true
                color: "#151925"
                radius: 20
                border.color: "#1e293b"

                ColumnLayout {
                    anchors.fill: parent
                    anchors.margins: 25
                    spacing: 15

                    Text {
                        text: "Thư viện của Lực"
                        color: "white"
                        font.pixelSize: 22
                        font.bold: true
                        Layout.bottomMargin: 10
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        radius: 8
                        color: favMouse.containsMouse ? "#1e293b" : "transparent"

                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 15

                            Image {
                                source: "qrc:/image_icons/hearted.png"
                                Layout.preferredWidth: 24
                                Layout.preferredHeight: 24
                            }
                            Text {
                                text: "Bài hát Yêu thích"
                                color: favMouse.containsMouse ? "white" : "#94a3b8"
                                font.pixelSize: 16
                                Layout.fillWidth: true
                            }
                        }
                        MouseArea {
                            id: favMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: contentLoader.setSource("PlaylistView.qml", { "pageTitle": "Bài hát Yêu thích", "playlistType": "favorite" })
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        radius: 8
                        color: recMouse.containsMouse ? "#1e293b" : "transparent"

                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 15

                            Image {
                                source: "qrc:/image_icons/history.png"
                                Layout.preferredWidth: 24
                                Layout.preferredHeight: 24
                            }
                            Text {
                                text: "Nghe gần đây"
                                color: recMouse.containsMouse ? "white" : "#94a3b8"
                                font.pixelSize: 16
                                Layout.fillWidth: true
                            }
                        }
                        MouseArea {
                            id: recMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: contentLoader.setSource("PlaylistView.qml", { "pageTitle": "Nghe gần đây", "playlistType": "recent" })
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        radius: 8
                        color: usbMouse.containsMouse ? "#1e293b" : "transparent"

                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 15

                            Image {
                                source: "qrc:/image_icons/music.png"
                                Layout.preferredWidth: 24
                                Layout.preferredHeight: 24
                            }
                            Text {
                                text: "Tất cả bài hát (USB)"
                                color: usbMouse.containsMouse ? "white" : "#94a3b8"
                                font.pixelSize: 16
                                Layout.fillWidth: true
                            }
                        }
                        MouseArea {
                            id: usbMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: contentLoader.setSource("PlaylistView.qml", { "pageTitle": "Tất cả bài hát (USB)", "playlistType": "all" })
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        radius: 8
                        color: playMouse.containsMouse ? "#1e293b" : "transparent"

                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 15

                            Image {
                                source: "qrc:/image_icons/music.png"
                                Layout.preferredWidth: 24
                                Layout.preferredHeight: 24
                            }
                            Text {
                                text: "Đang phát"
                                color: playMouse.containsMouse ? "white" : "#94a3b8"
                                font.pixelSize: 16
                                Layout.fillWidth: true
                            }
                        }
                        MouseArea {
                            id: playMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: stackView.push("NowPlaying.qml")
                        }
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        height: 1
                        color: "#334155"
                        Layout.topMargin: 5
                        Layout.bottomMargin: 5
                    }

                    Rectangle {
                        Layout.fillWidth: true
                        Layout.preferredHeight: 45
                        radius: 8
                        color: addMouse.containsMouse ? "#1e293b" : "transparent"

                        Behavior on color {
                            ColorAnimation {
                                duration: 150
                            }
                        }

                        RowLayout {
                            anchors.fill: parent
                            anchors.margins: 10
                            spacing: 15

                            Image {
                                source: "qrc:/image_icons/addplaylist.png"
                                Layout.preferredWidth: 24
                                Layout.preferredHeight: 24
                            }
                            Text {
                                text: "Tạo Playlist mới"
                                color: addMouse.containsMouse ? "#c084fc" : "#a855f7"
                                font.pixelSize: 16
                                font.bold: true
                                Layout.fillWidth: true
                            }
                        }
                        MouseArea {
                            id: addMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: createPlaylistPopup.open()
                        }
                    }

                    ListView {
                        id: customPlaylistsView
                        Layout.fillWidth: true
                        Layout.fillHeight: true
                        model: MusicApp.customPlaylists
                        clip: true
                        spacing: 5

                        delegate: Rectangle {
                            width: customPlaylistsView.width
                            height: 45
                            radius: 8
                            color: plMouse.containsMouse ? "#1e293b" : "transparent"

                            Behavior on color {
                                ColorAnimation {
                                    duration: 150
                                }
                            }

                            RowLayout {
                                anchors.fill: parent
                                anchors.margins: 10
                                spacing: 15

                                Image {
                                    source: "qrc:/image_icons/playlist.png"
                                    Layout.preferredWidth: 20
                                    Layout.preferredHeight: 20
                                }
                                Text {
                                    text: modelData.name
                                    color: plMouse.containsMouse ? "white" : "#94a3b8"
                                    font.pixelSize: 16
                                    Layout.fillWidth: true
                                }
                            }
                            MouseArea {
                                id: plMouse
                                anchors.fill: parent
                                hoverEnabled: true
                                onClicked: contentLoader.setSource("PlaylistView.qml", { "pageTitle": modelData.name, "playlistType": "custom_" + index })
                            }
                        }
                    }
                }
            }

            // --- CỘT PHẢI (MAIN CONTENT) ---
            Loader {
                id: contentLoader
                Layout.fillWidth: true
                Layout.fillHeight: true

                Behavior on opacity {
                    NumberAnimation {
                        duration: 200
                    }
                }

                onSourceChanged: opacity = 0
                onLoaded: opacity = 1
            }
        }

        // ==========================================
        // PHẦN DƯỚI: MINI PLAYER
        // ==========================================
        Rectangle {
            id: miniPlayer
            Layout.fillWidth: true
            Layout.preferredHeight: 90
            color: "#181425"
            radius: 25
            border.color: "#1e293b"
            border.width: 1
            visible: MusicApp.playlist.length > 0 && MusicApp.hasStartedPlaying

            MouseArea {
                anchors.fill: parent
                onClicked: stackView.push("NowPlaying.qml")
            }

            RowLayout {
                anchors.fill: parent
                anchors.margins: 15
                anchors.leftMargin: 20
                anchors.rightMargin: 20
                spacing: 25

                Rectangle {
                    width: 60
                    height: 60
                    radius: 15
                    gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: "#c084fc"
                        }
                        GradientStop {
                            position: 1.0
                            color: "#db2777"
                        }
                    }
                    Image {
                        source: "qrc:/image_icons/music.png"
                        width: 30
                        height: 30
                        anchors.centerIn: parent
                        RotationAnimator on rotation {
                            running: MusicApp.isPlaying
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
                    spacing: 5
                    Text {
                        text: MusicApp.playlist.length > 0 ? MusicApp.playlist[MusicApp.currentSongIndex].title : ""
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
                        width: parent.width * 0.8
                        height: 10
                        Rectangle {
                            anchors.centerIn: parent
                            width: parent.width
                            height: 4
                            color: "#334155"
                            radius: 2
                            Rectangle {
                                width: parent.width * MusicApp.songProgress
                                height: parent.height
                                radius: 2
                                gradient: Gradient {
                                    GradientStop {
                                        position: 0.0
                                        color: "#c084fc"
                                    }
                                    GradientStop {
                                        position: 1.0
                                        color: "#db2777"
                                    }
                                }
                            }
                        }
                    }
                }

                Row {
                    spacing: 20
                    Layout.alignment: Qt.AlignVCenter

                    Item {
                        width: 40
                        height: 40
                        scale: mousePrevMini.pressed ? 0.8 : (mousePrevMini.containsMouse ? 1.1 : 1.0)

                        Behavior on scale {
                            NumberAnimation {
                                duration: 100
                            }
                        }

                        Image {
                            source: "qrc:/image_icons/previous.png"
                            anchors.fill: parent
                        }
                        MouseArea {
                            id: mousePrevMini
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: MusicApp.prevSong()
                        }
                    }

                    Item {
                        width: 40
                        height: 40
                        scale: mousePlayMini.pressed ? 0.8 : (mousePlayMini.containsMouse ? 1.1 : 1.0)

                        Behavior on scale {
                            NumberAnimation {
                                duration: 100
                            }
                        }

                        Image {
                            source: MusicApp.isPlaying ? "qrc:/image_icons/pause.png" : "qrc:/image_icons/play.png"
                            anchors.fill: parent
                        }
                        MouseArea {
                            id: mousePlayMini
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: MusicApp.isPlaying = !MusicApp.isPlaying
                        }
                    }

                    Item {
                        width: 40
                        height: 40
                        scale: mouseNextMini.pressed ? 0.8 : (mouseNextMini.containsMouse ? 1.1 : 1.0)

                        Behavior on scale {
                            NumberAnimation {
                                duration: 100
                            }
                        }

                        Image {
                            source: "qrc:/image_icons/next.png"
                            anchors.fill: parent
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

    Popup {
        id: createPlaylistPopup
        width: 400
        height: 200
        anchors.centerIn: parent
        modal: true
        background: Rectangle {
            color: "#0f111a"
            radius: 15
            border.color: "#334155"
        }

        ColumnLayout {
            anchors.fill: parent
            anchors.margins: 20
            spacing: 15

            Text {
                text: "Tạo Playlist Mới"
                color: "white"
                font.bold: true
                font.pixelSize: 18
            }

            TextField {
                id: playlistNameInput
                Layout.fillWidth: true
                color: "white"
                placeholderText: "Nhập tên playlist..."
                placeholderTextColor: "#64748b"
                background: Rectangle {
                    color: "#1e293b"
                    radius: 8
                }
            }

            RowLayout {
                Layout.alignment: Qt.AlignRight
                spacing: 10

                Button {
                    text: "Hủy"
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    background: Rectangle {
                        color: "#334155"
                        radius: 8
                        implicitWidth: 80
                        implicitHeight: 35
                    }
                    onClicked: {
                        playlistNameInput.text = ""
                        createPlaylistPopup.close()
                    }
                }

                Button {
                    text: "Tạo mới"
                    contentItem: Text {
                        text: parent.text
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                    }
                    background: Rectangle {
                        color: "#c084fc"
                        radius: 8
                        implicitWidth: 80
                        implicitHeight: 35
                    }
                    onClicked: {
                        if (playlistNameInput.text.trim() !== "") {
                            MusicApp.createCustomPlaylist(playlistNameInput.text)
                            playlistNameInput.text = ""
                            createPlaylistPopup.close()
                        }
                    }
                }
            }
        }
    }
    // ==========================================
    // TOAST NOTIFICATION (CHỈ ĐẶT DUY NHẤT Ở MUSICHUB)
    // ==========================================
    Popup {
        id: toastPopup
        parent: Overlay.overlay
        x: Math.round((parent.width - width) / 2)
        y: Math.round(parent.height - height - 100)
        height: 45

        background: Rectangle {
            color: "#1e293b"
            radius: 22.5
            border.color: "#c084fc"
            border.width: 1
        }

        contentItem: Text {
            id: toastText
            color: "white"
            font.pixelSize: 15
            horizontalAlignment: Text.AlignHCenter
            verticalAlignment: Text.AlignVCenter
            padding: 15
        }

        Timer {
            id: toastTimer
            interval: 2000
            onTriggered: toastPopup.close()
        }
    }

    Connections {
        target: MusicApp
        function onShowNotification(msg) {
            toastText.text = msg
            toastPopup.open()
            toastTimer.restart()
        }
    }
}
