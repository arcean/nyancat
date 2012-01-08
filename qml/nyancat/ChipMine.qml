// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

    Item {
        id: item
        property int itemID: 0
        property int takesLife: 1
        property bool destroyAfterUse: true
        property bool isBad: true
        property int mineID: 0

        width: 64
        height: 64
        visible: false

        Image {
            id: chip1
            source: "qrc:/data/images/mine.png"
            visible: true
        }
    }
