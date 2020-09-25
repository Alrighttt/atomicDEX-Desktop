import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15
import QtGraphicalEffects 1.0
import "../Constants"

// Swap button
Item {
    id: root
    property alias pixelSize: right_arrow.font.pixelSize
    property string top_arrow_ticker
    property string bottom_arrow_ticker

    property bool hovered: false

    implicitWidth: right_arrow.width
    implicitHeight: 50

    DefaultText {
        id: right_arrow
        anchors.right: parent.right
        anchors.top: parent.top
        anchors.topMargin: -font.pixelSize/4
        text_value: "→"
        font.family: "Impact"
        font.pixelSize: 30
        font.bold: true
        color: Qt.lighter(Style.getCoinColor(top_arrow_ticker), hovered ? Style.hoverLightMultiplier : 1.0)
    }

    DefaultText {
        anchors.left: parent.left
        anchors.bottom: parent.bottom
        text_value: "←"
        font.family: right_arrow.font.family
        font.pixelSize: right_arrow.font.pixelSize
        font.bold: right_arrow.font.bold
        color: Qt.lighter(Style.getCoinColor(bottom_arrow_ticker), hovered ? Style.hoverLightMultiplier : 1.0)
    }
}
