import QtQuick 1.1
import com.nokia.meego 1.0
import "Utils.js" as Utils
import "Game.js" as Game

Page {
    id: gameBoard
    //orientationLock: PageOrientation

    // 0 - right, 1 - down, 2 - left, 3 - up
    property int move_step: 10

    Component.onCompleted: {
        Game.placeStars();
        Game.createPlayer();
        Game.createTail();
        Game.moveTail();
        Game.createMine();
        moveTimer.start();
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#294c78"
    }

    function move()
    {
        Game.movePlayer();
    }

    Timer {
        id: moveTimer
        running: false
        repeat: true
        interval: 50
        onTriggered: move()
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            Game.beginX = mouseX;
            Game.beginY = mouseY;
        }
        onPositionChanged: {
            if (!Game._MOUSE_LOCK)
                Game.setDirection(mouseX, mouseY);
        }
        onReleased: {
            Game._MOUSE_LOCK = false;
        }
    }

    transitions: [
        Transition {
            ParallelAnimation {
                NumberAnimation { properties: "x,y"; duration: 90; easing.type: Easing.InOutQuad }
            }
        }
    ]

}
