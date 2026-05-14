#include "dashboardcontroller.h"

DashboardController::DashboardController(QObject *parent)
    : QObject(parent),
    m_speed(0), m_tacho(0), m_speedAngle(-120.0), m_tachoAngle(-120.0),
    m_turnLeft(false), m_turnRight(false), m_hiBeam(false), m_engineOil(false), m_battery(false)
{
}

//  SLIDERS VÀ LOGIC TÍNH GÓC
int DashboardController::speed() const { return m_speed; }
double DashboardController::speedAngle() const { return m_speedAngle; }

void DashboardController::setSpeed(int speed) {
    if (m_speed == speed) return;
    m_speed = speed;

    // Tốc độ max là 200. Góc quay từ -120 đến 120
    m_speedAngle = -120.0 + (static_cast<double>(m_speed) / 200.0) * 240.0;

    emit speedChanged();
    emit speedAngleChanged();
}

int DashboardController::tacho() const { return m_tacho; }
double DashboardController::tachoAngle() const { return m_tachoAngle; }

void DashboardController::setTacho(int tacho) {
    if (m_tacho == tacho) return;
    m_tacho = tacho;

    // Vòng tua max là 8. Góc quay từ -120 đến 120
    m_tachoAngle = -120.0 + (static_cast<double>(m_tacho) / 8.0) * 240.0;

    emit tachoChanged();
    emit tachoAngleChanged();
}

//  BUTTONS
bool DashboardController::turnLeft() const { return m_turnLeft; }
void DashboardController::setTurnLeft(bool turnLeft) {
    if (m_turnLeft == turnLeft) return;
    m_turnLeft = turnLeft;
    emit turnLeftChanged();
}

bool DashboardController::turnRight() const { return m_turnRight; }
void DashboardController::setTurnRight(bool turnRight) {
    if (m_turnRight == turnRight) return;
    m_turnRight = turnRight;
    emit turnRightChanged();
}

bool DashboardController::hiBeam() const { return m_hiBeam; }
void DashboardController::setHiBeam(bool hiBeam) {
    if (m_hiBeam == hiBeam) return;
    m_hiBeam = hiBeam;
    emit hiBeamChanged();
}

bool DashboardController::engineOil() const { return m_engineOil; }
void DashboardController::setEngineOil(bool engineOil) {
    if (m_engineOil == engineOil) return;
    m_engineOil = engineOil;
    emit engineOilChanged();
}

bool DashboardController::battery() const { return m_battery; }
void DashboardController::setBattery(bool battery) {
    if (m_battery == battery) return;
    m_battery = battery;
    emit batteryChanged();
}