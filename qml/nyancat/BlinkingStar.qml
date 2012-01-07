// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

    Item {
        property int star: 0

        Image {
            id: star1
            width: 48
            height: 48
            source: "qrc:/data/images/star1.png"
            visible: false
        }
        Image {
            id: star2
            width: 48
            height: 48
            source: "qrc:/data/images/star2.png"
            visible: false
        }
        Image {
            id: star3
            width: 48
            height: 48
            source: "qrc:/data/images/star3.png"
            visible: false
        }
        Image {
            id: star4
            width: 48
            height: 48
            source: "qrc:/data/images/star4.png"
            visible: false
        }
        Image {
            id: star5
            width: 48
            height: 48
            source: "qrc:/data/images/star5.png"
            visible: false
        }
        Image {
            id: star6
            width: 48
            height: 48
            source: "qrc:/data/images/star6.png"
            visible: false
        }

        function changeStar()
        {
            if(star >= 6)
                star = 0;
            star++;
            star1.visible = false;
            star2.visible = false;
            star3.visible = false;
            star4.visible = false;
            star5.visible = false;
            star6.visible = false;

            if (star == 1)
                star1.visible = true;
            else if (star == 2)
                star2.visible = true;
            else if (star == 3)
                star3.visible = true;
            else if (star == 4)
                star4.visible = true;
            else if (star == 5)
                star5.visible = true;
            else
                star6.visible = true;
        }

        function startTimer()
        {
            starTimer.start();
        }

        Timer {
            id: starTimer
            running: true
            repeat: true
            interval: 120
            onTriggered: changeStar()
        }
    }
