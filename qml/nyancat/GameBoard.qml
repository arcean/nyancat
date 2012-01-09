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
        var width = Game.player.width;
        var height = Game.player.height;
        var diff = (width - height) / 2;
        var width_diff = Game.player.height + Game.player.x + diff;
        var height_diff = Game.player.width + Game.player.y - diff;
        width += Game.player.x;
        height += Game.player.y;

        if (Game.current_direction == 0 || Game.current_direction == 2)
            var z = Game.isCollision(Game.player.x, Game.player.y, width, height);
        else if (Game.current_direction == 1 || Game.current_direction == 3)
            var z = Game.isCollision(Game.player.x + diff, Game.player.y - diff, width_diff, height_diff);

        //var z = Game.isCollision(Game.player.x, Game.player.y, width, width);
        console.log('det: ',z)
        if (Game.current_direction == 0 || Game.current_direction == 2){
            console.log('det x: ',Game.player.x)
            console.log('det y: ',Game.player.y)
            console.log('det width: ',width)
            console.log('det height: ',height)
        }
        else {
            console.log('det x: ',Game.player.x + diff)
            console.log('det y: ',Game.player.y- diff)
            console.log('det width: ',width_diff)
            console.log('det height: ',height_diff)
        }

        console.log('mine x: ', Game.getMineX(0))
        console.log('mine y: ', Game.getMineY(0))
        console.log('mine width: ', Game.getMineWidth(0))
        console.log('mine height: ', Game.getMineHeight(0))

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
