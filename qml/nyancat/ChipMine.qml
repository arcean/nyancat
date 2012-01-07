// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

    Item {
        property int itemID: 0
        property int takesLife: 1
        property bool destroyAfterUse: true
        property bool isBad: true

        width: 80
        height: 80

        Image {
            id: chip1
            source: "qrc:/data/images/chip_mine.png"
            visible: true
        }
    }
