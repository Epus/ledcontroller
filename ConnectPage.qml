import QtQuick 2.12
import QtQuick.Controls 2.13

Item {
    id: element
    width: 720
    height: 1280
    function displayerror(msg)
    {
        errornotification.text = msg
        errornotification.visible = true
        connectButton.text = "Connect"
        connectingdialog.close()
    }

    function resetdisplay()
    {
        connectingdialog.close()
        connectButton.text = "Connect"
    }

    Rectangle
    {
        id: background
        color: "#1c1d1f"
        anchors.fill: parent
    }

    Dialog{
        id: connectingdialog
        modal: true
        padding: 0
        anchors.centerIn: Overlay.overlay
        closePolicy: Popup.NoAutoClose
        background: Rectangle
        {
            opacity: 0
        }

        contentItem:
            BusyIndicator {
            id: control

            contentItem: Item {
                implicitWidth: 64
                implicitHeight: 64

                Item {
                    id: item1
                    x: parent.width / 2 - 32
                    y: parent.height / 2 - 32
                    width: 64
                    height: 64
                    opacity: control.running ? 1 : 0

                    Behavior on opacity {
                        OpacityAnimator {
                            duration: 250
                        }
                    }

                    RotationAnimator {
                        target: item1
                        running: control.visible && control.running
                        from: 0
                        to: 360
                        loops: Animation.Infinite
                        duration: 1250
                    }

                    Repeater {
                        id: repeater
                        model: 6

                        Rectangle {
                            x: item1.width / 2 - width / 2
                            y: item1.height / 2 - height / 2
                            implicitWidth: 10
                            implicitHeight: 10
                            radius: 5
                            color: "#ffffff"
                            transform: [
                                Translate {
                                    y: -Math.min(item1.width, item1.height) * 0.5 + 5
                                },
                                Rotation {
                                    angle: index / repeater.count * 360
                                    origin.x: 5
                                    origin.y: 5
                                }
                            ]
                        }
                    }
                }
            }
        }

    }

    TextField {
        id: ipField
        font.pointSize: 15
        placeholderText: "IP Address"
        color: "#ffffff"
        anchors.right: portLabel.left
        anchors.rightMargin: 10
        anchors.verticalCenter: ipLabel.verticalCenter
        anchors.left: ipLabel.right
        anchors.leftMargin: 10
        background: Rectangle
        {
            height: parent.height
            width: parent.width
            color: "#2b2b2b"
        }
    }

    TextField {
        id: portField
        width: 50
        font.pointSize: 15
        anchors.right: parent.right
        anchors.rightMargin: 25
        placeholderText: "#"
        color: "#ffffff"
        anchors.verticalCenter: portLabel.verticalCenter
        background: Rectangle
        {
            width: parent.width
            height: parent.height
            color: "#2b2b2b"
        }
    }

    CustomButton {
        id: connectButton
        text: qsTr("Connect")
        anchors.top: parent.top
        anchors.topMargin: 300
        custombg.color: "#2c7ef9"
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.right: parent.right
        anchors.rightMargin: 25
        onClicked:
        {
            text = "Connecting"
            errornotification.visible = false
            connectingdialog.open()
            client.connectToArduino(ipField.text, portField.text)
        }
    }

    Label {
        id: ipLabel
        color: "#fefdfd"
        text: qsTr("IP:")
        anchors.bottom: connectButton.top
        anchors.bottomMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 25
        font.pointSize: 20
    }

    Label {
        id: errornotification
        x: 212
        y: 330
        color: "#e90a0a"
        text: qsTr("display error notifications here")
        visible: false
        font.pointSize: 10
        anchors.top: connectButton.bottom
        anchors.topMargin: 30
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Label {
        id: portLabel
        x: 281
        y: 194
        color: "#fefdfd"
        text: qsTr("PORT:")
        anchors.bottom: connectButton.top
        anchors.bottomMargin: 25
        anchors.right: portField.left
        anchors.rightMargin: 10
        font.pointSize: 20
    }

}

/*##^##
Designer {
    D{i:5;anchors_width:50}D{i:12;anchors_width:200}D{i:18;anchors_y:330}
}
##^##*/
