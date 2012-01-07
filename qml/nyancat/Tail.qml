// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1

    Item {
        id: item
        property int tail: 0
        property bool _MIRROR: false
        width: 68
        height: 40
        state: "show"

        Image {
            id: tail1
            width: 68
            height: 40
            source: "qrc:/data/images/tail1.png"
            visible: false
            mirror: _MIRROR
        }
        Image {
            id: tail2
            width: 68
            height: 40
            source: "qrc:/data/images/tail2.png"
            visible: false
            mirror: _MIRROR
        }
        Image {
            id: tail3
            width: 68
            height: 40
            source: "qrc:/data/images/tail3.png"
            visible: false
            mirror: _MIRROR
        }
        Image {
            id: tail4
            width: 68
            height: 40
            source: "qrc:/data/images/tail2.png"
            visible: false
            mirror: _MIRROR
        }

        function changeTail()
        {
            if(tail >= 4)
                tail = 0;
            tail++;
            tail1.visible = false;
            tail2.visible = false;
            tail3.visible = false;
            tail4.visible = false;

            if (tail == 1)
                tail1.visible = true;
            else if (tail == 2)
                tail2.visible = true;
            else if (tail == 3)
                tail3.visible = true;
            else
                tail4.visible = true;
        }

        function startTimer()
        {
            tailTimer.start();
        }

        Timer {
            id: tailTimer
            running: true
            repeat: true
            interval: 120
            onTriggered: changeTail()
        }

        states: [
            State {
                name: "show"
                PropertyChanges {
                    target: item
                    opacity: 0.8
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

        transitions: [
            Transition {
                ParallelAnimation {
                    NumberAnimation { properties: "opacity"; duration: 200; easing.type: Easing.InOutQuad }
                }
            }
        ]
    }
