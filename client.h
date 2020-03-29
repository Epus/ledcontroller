#ifndef CLIENT_H
#define CLIENT_H

#include <QObject>
#include <QTcpSocket>
#include <QTimer>

class Client : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool isConnected READ isConnected NOTIFY isConnectedChanged)
public:
    explicit Client(QObject *parent = nullptr);

    bool isConnected() const;

public slots:
    void connectToArduino(QString ip, QString port);
    void disconnectFromArduino();
    void sendCmd(int cmd);

signals:
    void isConnectedChanged();
    void error(int error);
    void timeout();

private slots:
    //IDK how to implement connect without using SIGNAL->SLOT syntax because of inherited signal
    void handleError(QAbstractSocket::SocketError error);

private:
    void setIsConnected(bool isConnected);
    void connected();
    void disconnected();
    void connectionTimeout();

    QTcpSocket *m_tcpSocket;
    QTimer *m_timeoutTimer;
    bool m_isConnected;
};

#endif // CLIENT_H
