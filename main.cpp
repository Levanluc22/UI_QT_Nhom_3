#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QDirIterator>
#include <QDebug>
#include <QUrl>
#include <QQmlContext>

// Include các file header của Controller C++
#include "dashboardcontroller.h"
#include "musiccontroller.h" // THÊM DÒNG NÀY

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    // 1. Khởi tạo các Controller
    DashboardController controller;
    MusicController musicCtrl; // THÊM DÒNG NÀY

    // 2. Bơm các Controller vào môi trường QML
    engine.rootContext()->setContextProperty("myController", &controller);
    engine.rootContext()->setContextProperty("MusicApp", &musicCtrl); // THÊM DÒNG NÀY ĐỂ QML GỌI ĐƯỢC

    const QUrl url(QStringLiteral("qrc:/main.qml"));

    // Vòng lặp debug kiểm tra đường dẫn file (Giữ nguyên của bạn)
    QDirIterator it(":", QDirIterator::Subdirectories);
    while (it.hasNext()) {
        qDebug() << it.next();
    }

    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);

    engine.load(url);

    return app.exec(); // Đổi QCoreApplication::exec() thành app.exec() để chuẩn xác hơn với QGuiApplication
}