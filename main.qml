import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.13
import LedController 1.0
import QtQuick.Layouts 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 360
    height: 640
    color: "#1c1d1f"
    title: qsTr("LED Controller")
    visibility: "FullScreen"
    Client
    {
        id: client
        onIsConnectedChanged:
        {
            if (isConnected)
            {
                stackView.push(controlspage)
                connectpage.resetdisplay()
            }

            else
                if (stackView.depth > 1) stackView.pop()

        }

        onTimeout:
        {
            connectpage.displayerror("connection timeout")
        }

        onError:
        {
            var msg = "SocketError[" + error + "] occured";
            connectpage.displayerror(msg)
        }

    }

    ConnectPage{
        id: connectpage
        width: window.width
        height: window.height
    }

    ControlsPage
    {
        id: controlspage
        width: window.width
        height: window.height
    }

    StackView {
        id: stackView
        anchors.fill: parent
        initialItem: connectpage

        pushEnter: Transition{
            PropertyAnimation {
                property: "opacity"
                from: 0
                to:1
                duration: 1000
            }
        }
        pushExit: Transition{
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }

        popEnter: Transition{
            PropertyAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 200
            }
        }


        popExit: Transition{
            PropertyAnimation {
                property: "opacity"
                from: 1
                to: 0
                duration: 200
            }
        }
    }

}


