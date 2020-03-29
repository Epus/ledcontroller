import QtQuick 2.0
import QtQuick.Controls 2.13
import QtQuick.Layouts 1.0

Button {
    id: control
    property alias custombg : bgRectangle
    contentItem: Text {
        color: "#ffffff"
        text: control.text
        font.pointSize: control.down? 15 : 10
        font.bold: true
        font.family: "Arial"
        opacity: enabled ? 1.0 : 0.3
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        elide: Text.ElideRight
    }

    background: Rectangle{
        id: bgRectangle
        color: "#609b66"
        implicitWidth: 100
        implicitHeight: 40

    }
}
