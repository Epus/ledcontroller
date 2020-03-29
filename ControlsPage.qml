import QtQuick 2.0
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.0

Item {
    id: element
    Rectangle
    {
        id: background
//        color: "#1c1d1f"
        anchors.fill: parent
    }

    CustomButton {
        id: disconnectButton
        y: 46
        text: qsTr("Disconnect")
        custombg.color: "#f82d2d"
        anchors.bottom: parent.bottom
        anchors.bottomMargin: 25
        anchors.left: parent.left
        anchors.leftMargin: 25
        anchors.right: parent.right
        anchors.rightMargin: 25
        onClicked: client.disconnectFromArduino()
    }

    Label {
        id: modelabel
        color: "#fefdfd"
        text: qsTr("MODE")
        anchors.top: parent.top
        anchors.topMargin: 50
        anchors.horizontalCenter: parent.horizontalCenter
        font.pointSize: 30
    }

    RowLayout {
        id: mode
        spacing: 0
        anchors.top: modelabel.bottom
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter


        CustomButton {
            id: onButton
            text: qsTr("On")
            custombg.color: "#45cb7a"
            onClicked: client.sendCmd(1)
        }

        CustomButton {
            id: blinkButton
            text: qsTr("Blink")
            custombg.color: "#39d778"
            onClicked: client.sendCmd(2)
        }

        CustomButton {
            id: offButton
            text: qsTr("Off")
            custombg.color: "#2de376"
            onClicked: client.sendCmd(0)
        }



    }

    Label {
        id: flashspeedLabel
        color: "#fefdfd"
        text: qsTr("FLASH SPEED")
        anchors.top: mode.bottom
        anchors.topMargin: 25
        font.pointSize: 30
        anchors.horizontalCenter: parent.horizontalCenter
    }

    RowLayout {
        id: flashspeed
        spacing: 0
        anchors.top: flashspeedLabel.bottom
        CustomButton {
            id: slowButton
            text: qsTr("Slow")
            custombg.color: "#cb7c45"
            onClicked: client.sendCmd(5)

        }

        CustomButton {
            id: mediumButton
            text: qsTr("Medium")
            custombg.color: "#d77a39"
            onClicked: client.sendCmd(6)

        }

        CustomButton {
            id: fastButton
            text: qsTr("Fast")
            custombg.color: "#e3782d"
            onClicked: client.sendCmd(7)
        }
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Label {
        id: brightnessLabel
        color: "#fefdfd"
        text: qsTr("BRIGHTNESS")
        anchors.top: flashspeed.bottom
        anchors.topMargin: 25
        font.pointSize: 30
        anchors.horizontalCenter: parent.horizontalCenter
    }

    RowLayout {
        id: brightness
        spacing: 0
        anchors.top: brightnessLabel.bottom
        CustomButton {
            id: dimButton
            text: qsTr("Dim")
            custombg.color: "#bcb743"
            onClicked: client.sendCmd(3)
        }

        CustomButton {
            id: highButton
            text: qsTr("High")
            custombg.color: "#efe710"
            onClicked: client.sendCmd(4)
        }
        anchors.topMargin: 25
        anchors.horizontalCenter: parent.horizontalCenter
    }


}

/*##^##
Designer {
    D{i:4;anchors_y:0}D{i:9;anchors_y:0}D{i:14;anchors_y:"-8"}
}
##^##*/
