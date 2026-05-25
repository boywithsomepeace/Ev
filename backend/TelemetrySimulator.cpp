#include "TelemetrySimulator.h"

#include "VehicleData.h"

#include <QtMath>

TelemetrySimulator::TelemetrySimulator(VehicleData *vehicleData, QObject *parent)
    : QObject(parent)
    , m_vehicleData(vehicleData)
{
    m_timer.setInterval(80);
    connect(&m_timer, &QTimer::timeout, this, &TelemetrySimulator::tick);
    m_timer.start();
}

void TelemetrySimulator::setRunning(bool running)
{
    if (running)
        m_timer.start();
    else
        m_timer.stop();
}

void TelemetrySimulator::tick()
{
    if (!m_vehicleData)
        return;

    m_phase += 0.035;
    const double cruise = (qSin(m_phase) + 1.0) * 0.5;
    const int speed = qRound(28.0 + cruise * 64.0 + qSin(m_phase * 2.7) * 5.0);

    m_vehicleData->setSpeed(speed);
    m_vehicleData->setPackCurrent(18.0 + speed * 0.62 + qSin(m_phase * 1.8) * 6.0);
    m_vehicleData->setPackVoltage(386.0 - speed * 0.035 + qSin(m_phase * 0.7) * 1.2);
    m_vehicleData->setMotorTemp(41.0 + speed * 0.11);
    m_vehicleData->setInverterTemp(36.0 + speed * 0.08);
    m_vehicleData->setBatteryTemp(30.0 + speed * 0.035);
    m_vehicleData->setRangeKm(qMax(0, 203 - qRound(speed * 0.12)));
    m_vehicleData->setRegenKw(speed < 36 ? 6.5 * (1.0 - speed / 36.0) : 0.0);
    m_vehicleData->setLeftIndicator(qSin(m_phase * 2.2) > 0.35);
    m_vehicleData->setRightIndicator(false);
    m_vehicleData->setFaultCode(speed > 88 ? QStringLiteral("THERMAL WATCH") : QString());
}
