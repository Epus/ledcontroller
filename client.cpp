#include "client.h"

#include <QDataStream>
#include <QDebug>

Client::Client(QObject *parent) : QObject(parent)
{
    m_tcpSocket = new QTcpSocket();
    m_timeoutTimer = new QTimer();
    m_timeoutTimer->setSingleShot(true);
    m_isConnected = false;

    connect(m_timeoutTimer, &QTimer::timeout, this, &Client::connectionTimeout);
    connect(m_tcpSocket, &QTcpSocket::connected, this, &Client::connected);
    connect(m_tcpSocket, &QTcpSocket::disconnected, this, &Client::disconnected);
    connect(m_tcpSocket, SIGNAL(error(QAbstractSocket::SocketError)), this, SLOT(handleError(QAbstractSocket::SocketError)));
}

bool Client::isConnected() const
{
    return m_isConnected;
}

void Client::setIsConnected(bool isConnected)
{
    if(m_isConnected != isConnected)
    {
        m_isConnected = isConnected;
        emit isConnectedChanged();
    }
}

void Client::connectToArduino(QString ip, QString port)
{
    m_tcpSocket->connectToHost(ip, port.toUInt());
    m_timeoutTimer->start(3000);
}

void Client::disconnectFromArduino()
{
    m_tcpSocket->disconnectFromHost();
}

void Client::sendCmd(int cmd)
{
    QByteArray arrBlock;
    QDataStream out(&arrBlock, QIODevice::WriteOnly);
    out << QString::number(cmd);
    m_tcpSocket->write(arrBlock);
}

void Client::connected()
{
    m_timeoutTimer->stop();
    setIsConnected(true);
}

void Client::disconnected()
{
    setIsConnected(false);
}

void Client::connectionTimeout()
{
    m_tcpSocket->abort();
    emit timeout();
}

void Client::handleError(QAbstractSocket::SocketError error)
{
    emit this->error(error);
}
