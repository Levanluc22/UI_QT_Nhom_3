#ifndef DASHBOARDCONTROLLER_H
#define DASHBOARDCONTROLLER_H

#include <QObject>

class DashboardController : public QObject
{
    Q_OBJECT

    // 2 Biến cho Slider (Giá trị thô)
    Q_PROPERTY(int speed READ speed WRITE setSpeed NOTIFY speedChanged)
    Q_PROPERTY(int tacho READ tacho WRITE setTacho NOTIFY tachoChanged)

    // THÊM MỚI: 2 Biến Góc quay để QML đọc (Kết quả sau khi C++ tính toán)
    Q_PROPERTY(double speedAngle READ speedAngle NOTIFY speedAngleChanged)
    Q_PROPERTY(double tachoAngle READ tachoAngle NOTIFY tachoAngleChanged)

    // 5 Biến cho Buttons
    Q_PROPERTY(bool turnLeft READ turnLeft WRITE setTurnLeft NOTIFY turnLeftChanged)
    Q_PROPERTY(bool turnRight READ turnRight WRITE setTurnRight NOTIFY turnRightChanged)
    Q_PROPERTY(bool hiBeam READ hiBeam WRITE setHiBeam NOTIFY hiBeamChanged)
    Q_PROPERTY(bool engineOil READ engineOil WRITE setEngineOil NOTIFY engineOilChanged)
    Q_PROPERTY(bool battery READ battery WRITE setBattery NOTIFY batteryChanged)

public:
    explicit DashboardController(QObject *parent = nullptr);

    int speed() const;
    int tacho() const;
    double speedAngle() const; // THÊM MỚI
    double tachoAngle() const; // THÊM MỚI

    bool turnLeft() const;
    bool turnRight() const;
    bool hiBeam() const;
    bool engineOil() const;
    bool battery() const;

public slots:
    void setSpeed(int speed);
    void setTacho(int tacho);
    void setTurnLeft(bool turnLeft);
    void setTurnRight(bool turnRight);
    void setHiBeam(bool hiBeam);
    void setEngineOil(bool engineOil);
    void setBattery(bool battery);

signals:
    void speedChanged();
    void tachoChanged();
    void speedAngleChanged(); // THÊM MỚI
    void tachoAngleChanged(); // THÊM MỚI

    void turnLeftChanged();
    void turnRightChanged();
    void hiBeamChanged();
    void engineOilChanged();
    void batteryChanged();

private:
    int m_speed;
    int m_tacho;
    double m_speedAngle; // THÊM MỚI
    double m_tachoAngle; // THÊM MỚI

    bool m_turnLeft;
    bool m_turnRight;
    bool m_hiBeam;
    bool m_engineOil;
    bool m_battery;
};

#endif // DASHBOARDCONTROLLER_H