#include "musiccontroller.h"
#include <QRandomGenerator>

MusicController::MusicController(QObject *parent)
    : QObject(parent), m_isPlaying(false), m_currentSongIndex(0),
    m_songProgress(0.0), m_isShuffle(false), m_isRepeat(false),
    m_hasStartedPlaying(false), m_currentSongDuration(0)
{
    loadInitialData();
    m_timer = new QTimer(this);
    connect(m_timer, &QTimer::timeout, this, &MusicController::onTimerTick);
}

void MusicController::loadInitialData()
{
    m_usbPlaylist.clear();
    m_favPlaylist.clear();
    m_recentPlaylist.clear();
    m_allCustomPlaylists.clear();
    m_customPlaylistsInfo.clear();

    auto createSong = [](QString title, QString artist, QString duration) -> QVariantMap {
        QVariantMap song;
        song["title"] = title;
        song["artist"] = artist;
        song["duration"] = duration;
        song["isPlaying"] = false;
        song["isFavorite"] = false;
        return song;
    };

    m_usbPlaylist.append(createSong("Đêm Nay Không Ngủ", "Hiếu Thứ Hai", "3:45"));
    m_usbPlaylist.append(createSong("Có Chắc Yêu Là Đây", "Sơn Tùng M-TP", "4:12"));
    m_usbPlaylist.append(createSong("Waiting For You", "MONO", "3:58"));
    m_usbPlaylist.append(createSong("Nơi Này Có Anh", "Sơn Tùng M-TP", "4:32"));
    m_usbPlaylist.append(createSong("Thiên Mệnh", "Quân AP", "5:01"));

    loadPlaylist("all");
}

void MusicController::loadPlaylist(QString type)
{
    m_currentPlaylistType = type;
    if (type == "usb" || type == "all") m_playlist = m_usbPlaylist;
    else if (type == "favorite") m_playlist = m_favPlaylist;
    else if (type == "recent") m_playlist = m_recentPlaylist;
    else if (type.startsWith("custom_")) {
        int index = type.split("_")[1].toInt();
        if (index >= 0 && index < m_allCustomPlaylists.size()) m_playlist = m_allCustomPlaylists[index];
        else m_playlist.clear();
    } else m_playlist.clear();

    updatePlaylistState();
}

void MusicController::syncActivePlaylist()
{
    if (m_currentPlaylistType == "usb" || m_currentPlaylistType == "all") m_usbPlaylist = m_playlist;
    else if (m_currentPlaylistType == "favorite") m_favPlaylist = m_playlist;
    else if (m_currentPlaylistType == "recent") m_recentPlaylist = m_playlist;
    else if (m_currentPlaylistType.startsWith("custom_")) {
        int index = m_currentPlaylistType.split("_")[1].toInt();
        if (index >= 0 && index < m_allCustomPlaylists.size()) m_allCustomPlaylists[index] = m_playlist;
    }
}

void MusicController::createCustomPlaylist(QString name)
{
    QVariantMap info;
    info["name"] = name;
    m_customPlaylistsInfo.append(info);
    m_allCustomPlaylists.append(QVariantList());
    emit customPlaylistsChanged();
    emit showNotification("Đã tạo Playlist: " + name);
}

void MusicController::toggleFavorite(int index)
{
    if (index >= 0 && index < m_playlist.count()) {
        QVariantMap song = m_playlist[index].toMap();
        bool isFav = !song["isFavorite"].toBool();
        song["isFavorite"] = isFav;

        QString title = song["title"].toString();
        QString artist = song["artist"].toString();

        // Cập nhật lên màn hình
        m_playlist[index] = song;

        // BẢO VỆ CHỐNG LỖI BÓNG MA: Không bao giờ được dùng syncActivePlaylist() ghi đè m_favPlaylist
        if (m_currentPlaylistType == "usb" || m_currentPlaylistType == "all") m_usbPlaylist = m_playlist;
        else if (m_currentPlaylistType == "recent") m_recentPlaylist = m_playlist;
        else if (m_currentPlaylistType.startsWith("custom_")) {
            int idx = m_currentPlaylistType.split("_")[1].toInt();
            m_allCustomPlaylists[idx] = m_playlist;
        }

        // ĐỒNG BỘ TIM CHO TẤT CẢ DANH SÁCH
        for (int i = 0; i < m_usbPlaylist.count(); i++) {
            QVariantMap s = m_usbPlaylist[i].toMap();
            if (s["title"] == title && s["artist"] == artist) { s["isFavorite"] = isFav; m_usbPlaylist[i] = s; }
        }
        for (int i = 0; i < m_recentPlaylist.count(); i++) {
            QVariantMap s = m_recentPlaylist[i].toMap();
            if (s["title"] == title && s["artist"] == artist) { s["isFavorite"] = isFav; m_recentPlaylist[i] = s; }
        }
        for (int i = 0; i < m_allCustomPlaylists.size(); i++) {
            QVariantList cl = m_allCustomPlaylists[i];
            for (int j = 0; j < cl.count(); j++) {
                QVariantMap s = cl[j].toMap();
                if (s["title"] == title && s["artist"] == artist) { s["isFavorite"] = isFav; cl[j] = s; }
            }
            m_allCustomPlaylists[i] = cl;
        }

        // Xử lý list Yêu Thích ngầm
        if (isFav) {
            bool alreadyInFav = false;
            for (const QVariant& item : m_favPlaylist) {
                if (item.toMap()["title"] == title && item.toMap()["artist"] == artist) alreadyInFav = true;
            }
            if (!alreadyInFav) m_favPlaylist.append(song);
            emit showNotification("Đã thêm vào bài hát yêu thích");
        } else {
            for (int i = 0; i < m_favPlaylist.count(); ++i) {
                if (m_favPlaylist[i].toMap()["title"] == title && m_favPlaylist[i].toMap()["artist"] == artist) {
                    m_favPlaylist.removeAt(i);
                    break;
                }
            }
            emit showNotification("Đã xóa khỏi bài hát yêu thích");
        }

        emit playlistChanged();
    }
}

void MusicController::addSong(QString title, QString artist, QString duration)
{
    QVariantMap newSong;
    newSong["title"] = title;
    newSong["artist"] = artist;
    newSong["duration"] = duration;
    newSong["isPlaying"] = false;
    newSong["isFavorite"] = false;
    m_playlist.append(newSong);
    syncActivePlaylist();
    emit playlistChanged();
    emit showNotification("Đã thêm bài hát mới");
}

void MusicController::addSongToCustomPlaylist(int songIndex, int targetPlaylistIndex)
{
    if (songIndex < 0 || songIndex >= m_playlist.count()) return;
    if (targetPlaylistIndex < 0 || targetPlaylistIndex >= m_allCustomPlaylists.size()) return;

    QVariantMap songToAdd = m_playlist[songIndex].toMap();
    QVariantList currentTargetList = m_allCustomPlaylists[targetPlaylistIndex];

    bool alreadyExists = false;
    for (const QVariant& item : currentTargetList) {
        if (item.toMap()["title"] == songToAdd["title"] && item.toMap()["artist"] == songToAdd["artist"]) {
            alreadyExists = true;
            break;
        }
    }

    if (!alreadyExists) {
        currentTargetList.append(songToAdd);
        m_allCustomPlaylists[targetPlaylistIndex] = currentTargetList;
        if (m_currentPlaylistType == "custom_" + QString::number(targetPlaylistIndex)) {
            m_playlist = currentTargetList;
            emit playlistChanged();
        }
        QString plName = m_customPlaylistsInfo[targetPlaylistIndex].toMap()["name"].toString();
        emit showNotification("Đã thêm vào " + plName);
    } else {
        emit showNotification("Bài hát đã có trong Playlist");
    }
}

void MusicController::editSong(int index, QString title, QString artist)
{
    if (index >= 0 && index < m_playlist.count()) {
        QVariantMap song = m_playlist[index].toMap();
        song["title"] = title;
        song["artist"] = artist;
        m_playlist[index] = song;
        syncActivePlaylist();
        emit playlistChanged();
        emit showNotification("Đã cập nhật thông tin");
    }
}

void MusicController::deleteSong(int index)
{
    if (index >= 0 && index < m_playlist.count()) {
        bool isDeletingCurrent = (m_currentSongIndex == index);
        bool wasPlaying = m_isPlaying;
        m_playlist.removeAt(index);

        if (m_playlist.isEmpty()) {
            setIsPlaying(false);
            m_currentSongIndex = 0;
            m_songProgress = 0.0;
            emit currentSongIndexChanged();
            emit songProgressChanged();
        } else {
            if (isDeletingCurrent) {
                int nextIdx = (index >= m_playlist.count()) ? 0 : index;
                if (wasPlaying) playSong(nextIdx);
                else {
                    m_currentSongIndex = nextIdx;
                    m_songProgress = 0.0;
                    emit currentSongIndexChanged();
                    emit songProgressChanged();
                    updatePlaylistState();
                }
            } else if (m_currentSongIndex > index) {
                m_currentSongIndex--;
                emit currentSongIndexChanged();
                updatePlaylistState();
            } else {
                updatePlaylistState();
            }
        }
        syncActivePlaylist();
        emit playlistChanged();
        emit showNotification("Đã xóa khỏi danh sách");
    }
}

void MusicController::playSong(int index)
{
    if (index < 0 || index >= m_playlist.count()) return;

    m_currentSongIndex = index;
    m_songProgress = 0.0;
    m_isPlaying = true;
    m_currentSongDuration = timeToSeconds(m_playlist[index].toMap()["duration"].toString());

    // --- LƯU VÀO LỊCH SỬ NGHE GẦN ĐÂY ---
    QVariantMap playingSong = m_playlist[index].toMap();
    QString title = playingSong["title"].toString();
    QString artist = playingSong["artist"].toString();

    for (int i = 0; i < m_recentPlaylist.count(); ++i) {
        if (m_recentPlaylist[i].toMap()["title"] == title && m_recentPlaylist[i].toMap()["artist"] == artist) {
            m_recentPlaylist.removeAt(i);
            break;
        }
    }
    m_recentPlaylist.insert(0, playingSong);
    // -----------------------------------

    if (!m_hasStartedPlaying) {
        m_hasStartedPlaying = true;
        emit hasStartedPlayingChanged();
    }

    updatePlaylistState();
    m_timer->start(1000);

    emit currentSongIndexChanged();
    emit songProgressChanged();
    emit isPlayingChanged();
}

void MusicController::nextSong()
{
    if (m_playlist.isEmpty()) { setIsPlaying(false); return; }
    if (m_isRepeat) playSong(m_currentSongIndex);
    else if (m_isShuffle) {
        int nextIdx = m_currentSongIndex;
        if (m_playlist.count() > 1) {
            while (nextIdx == m_currentSongIndex) nextIdx = QRandomGenerator::global()->bounded(m_playlist.count());
        }
        playSong(nextIdx);
    } else {
        int nextIdx = (m_currentSongIndex + 1) % m_playlist.count();
        playSong(nextIdx);
    }
}

void MusicController::prevSong()
{
    if (m_playlist.isEmpty()) { setIsPlaying(false); return; }
    int prevIdx = m_currentSongIndex - 1;
    if (prevIdx < 0) prevIdx = m_playlist.count() - 1;
    playSong(prevIdx);
}

void MusicController::seek(int secondsOffset)
{
    if (!m_isPlaying || m_currentSongDuration <= 0) return;
    double newProgress = m_songProgress + ((double)secondsOffset / m_currentSongDuration);
    setSongProgress(qBound(0.0, newProgress, 1.0));
}

void MusicController::seekToProgress(double progress)
{
    setSongProgress(qBound(0.0, progress, 1.0));
}

void MusicController::onTimerTick()
{
    if (!m_isPlaying || m_currentSongDuration <= 0) return;

    m_songProgress += (1.0 / m_currentSongDuration);
    emit songProgressChanged();

    if (m_songProgress >= 1.0) nextSong();
}

void MusicController::updatePlaylistState()
{
    for (int i = 0; i < m_playlist.count(); i++) {
        QVariantMap song = m_playlist[i].toMap();
        song["isPlaying"] = (i == m_currentSongIndex);
        m_playlist[i] = song;
    }
    syncActivePlaylist();
    emit playlistChanged();
}

int MusicController::timeToSeconds(QString timeStr)
{
    QStringList parts = timeStr.split(":");
    if (parts.length() != 2) return 0;
    return parts[0].toInt() * 60 + parts[1].toInt();
}

QString MusicController::formatTime(int totalSeconds)
{
    int m = totalSeconds / 60;
    int s = totalSeconds % 60;
    return QString("%1:%2").arg(m).arg(s, 2, 10, QChar('0'));
}

QVariantList MusicController::playlist() const { return m_playlist; }
QVariantList MusicController::customPlaylists() const { return m_customPlaylistsInfo; }
bool MusicController::isPlaying() const { return m_isPlaying; }
bool MusicController::hasStartedPlaying() const { return m_hasStartedPlaying; }
void MusicController::setIsPlaying(bool playing) {
    if (m_isPlaying != playing) {
        m_isPlaying = playing;
        if (m_isPlaying) m_timer->start(1000);
        else m_timer->stop();
        emit isPlayingChanged();
    }
}
int MusicController::currentSongIndex() const { return m_currentSongIndex; }
void MusicController::setCurrentSongIndex(int index) {
    if (m_currentSongIndex != index) {
        m_currentSongIndex = index;
        emit currentSongIndexChanged();
    }
}
double MusicController::songProgress() const { return m_songProgress; }
void MusicController::setSongProgress(double progress) {
    if (m_songProgress != progress) {
        m_songProgress = progress;
        emit songProgressChanged();
    }
}
bool MusicController::isShuffle() const { return m_isShuffle; }
void MusicController::setIsShuffle(bool shuffle) {
    if (m_isShuffle != shuffle) {
        m_isShuffle = shuffle;
        emit isShuffleChanged();
    }
}
bool MusicController::isRepeat() const { return m_isRepeat; }
void MusicController::setIsRepeat(bool repeat) {
    if (m_isRepeat != repeat) {
        m_isRepeat = repeat;
        emit isRepeatChanged();
    }
}