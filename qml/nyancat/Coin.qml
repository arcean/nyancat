// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

    Item {
        id: item
        property int itemID: 0
        property int takesLife: 0
        property bool destroyAfterUse: true
        property bool isBad: true
        property alias interval: destroyTimer.interval
        property bool shouldBeDestroyed: false

        width: 25
        height: 61
        visible: false

        Image {
            id: chip1
            source: "qrc:/data/images/moneta_y.png"
            visible: true
        }

        function eventOnTriggered()
        {
            item.shouldBeDestroyed = true;
        }

        function startDestroyTimer()
        {
            destroyTimer.start();
        }

        Timer {
            id: destroyTimer
            running: false
            repeat: false
            onTriggered: eventOnTriggered()
        }

    }
