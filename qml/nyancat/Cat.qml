// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

    Item {
        id: item
        property int _CURRENT_X: 0
        property int _CURRENT_Y: 0
        // 0 - right, 1 - down, 2 - left, 3 - up
        property int _DIRECTION: 0
        property int cat: 0
        property bool _MIRROR: false
        width: 68 //68 + 64
        height: 40
        state: "show"
/*
        Tail {
            id: tail
            y: 1
            x: parent._MIRROR ? 52 : 16
            opacity: 0.8
            _MIRROR: parent._MIRROR
        }*/

        Image {
            id: cat1
            source: "qrc:/data/images/cat1.png"
            visible: false
            mirror: _MIRROR
        }
        Image {
            id: cat2
            source: "qrc:/data/images/cat2.png"
            visible: false
            mirror: _MIRROR
        }
        Image {
            id: cat3
            source: "qrc:/data/images/cat3.png"
            visible: false
            mirror: _MIRROR
        }
        Image {
            id: cat4
            source: "qrc:/data/images/cat4.png"
            visible: false
            mirror: _MIRROR
        }
        Image {
            id: cat5
            source: "qrc:/data/images/cat5.png"
            visible: false
            mirror: _MIRROR
        }
        Image {
            id: cat6
            source: "qrc:/data/images/cat6.png"
            visible: false
            mirror: _MIRROR
        }

        function changeCat()
        {
            if(cat >= 6)
                cat = 0;
            cat++;
            cat1.visible = false;
            cat2.visible = false;
            cat3.visible = false;
            cat4.visible = false;
            cat5.visible = false;
            cat6.visible = false;

            if (cat == 1)
                cat1.visible = true;
            else if (cat == 2)
                cat2.visible = true;
            else if (cat == 3)
                cat3.visible = true;
            else if (cat == 4)
                cat4.visible = true;
            else if (cat == 5)
                cat5.visible = true;
            else
                cat6.visible = true;
        }

        function startTimer()
        {
            catTimer.start();
            tail.startTimer();
        }

        Timer {
            id: catTimer
            running: true
            repeat: true
            interval: 120
            onTriggered: changeCat()
        }

        states: [
            State {
                name: "show"
                PropertyChanges {
                    target: item
                    opacity: 1
                }
            },
            State {
                name: "hide"
                PropertyChanges {
                    target: item
                    opacity: 0
                }
            }
        ]
/*
        transitions: [
            Transition {
                ParallelAnimation {
                    NumberAnimation { properties: "opacity"; duration: 200; easing.type: Easing.InOutQuad }
                }
            }
        ]*/

    }
