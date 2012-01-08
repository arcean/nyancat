import QtQuick 1.1
import com.nokia.meego 1.0
import "Utils.js" as Utils

Page {
    id: gameBoard
    //orientationLock: PageOrientation

    // 0 - right, 1 - down, 2 - left, 3 - up
    property int current_direction: 0
    property int move_step: 10
    property int _WIDTH: 480
    property int _HEIGHT: 854
    property int _BLOCKS_VERTICAL: 14
    property int _BLOCKS_HORIZONTAL: 9
    // Empty space between top screen edge and first block in pixels
    property int _BLOCKS_SPACE: 76
    property int beginX: 0
    property int beginY: 0
    property int _MOUSE_TRESHOLD: 50
    property bool _MOUSE_LOCK: false
    property int hurted_cat_counter: 0

    var _MAX_STAR = 16;

    property int _MAX_MINES: 20
    property int _MINES_IN_USE: 0

    Component.onCompleted: {
        placeStars();
        placeCat();
        moveTimer.start();
        placeMines();
    }

    function getNewPosX(newX, newY)
    {

    }

    function getNewX(oldX)
    {
        var x;
        if (current_direction == 0) {
            x = oldX + 4;

            if (x > _WIDTH)
                x = 0;

            return x;
        }
        else if (current_direction == 2) {
            x = oldX - 4;

            if (x < 0)
                x = _WIDTH;

            return x;
        }
        else
            return oldX;
    }

    function getNewY(oldY)
    {
        var y;
        if (current_direction == 1) {
            y = oldY + 4;

            if (y > _HEIGHT)
                y = 0;

            return y;
        }
        else if (current_direction == 3) {
            y = oldY - 4;

            if (y < 0)
                y = _HEIGHT;

            return y;
        }
        else
            return oldY;
    }

    function movePlayer()
    {
        if (player._DIRECTION == 0) {

            if (Game.movePlayer(player._CURRENT_X, player._CURRENT_Y, player._CURRENT_X + 1, player._CURRENT_Y)) {
                player._CURRENT_X++;
                player.x = Game.getNewPosX(player._CURRENT_X);
            }
            else {
                console.log(player._CURRENT_X);
                console.log(player._CURRENT_Y);
                console.log('Player was hurted!');
                player.visible = !player.visible;
            }
        }
        else if (player._DIRECTION == 1) {

            if (Game.movePlayer(player._CURRENT_X, player._CURRENT_Y, player._CURRENT_X, player._CURRENT_Y + 1)) {
                player._CURRENT_Y++;
                player.y = Game.getNewPosY(player._CURRENT_Y);
            }
            else {
                console.log(player._CURRENT_X);
                console.log(player._CURRENT_Y);
                console.log('Player was hurted!');
                player.visible = !player.visible;
            }
        }
        else if (player._DIRECTION == 2) {

            if (Game.movePlayer(player._CURRENT_X, player._CURRENT_Y, player._CURRENT_X - 1, player._CURRENT_Y)) {
                player._CURRENT_X--;
                player.x = Game.getNewPosX(player._CURRENT_X);
            }
            else {
                console.log(player._CURRENT_X);
                console.log(player._CURRENT_Y);
                console.log('Player was hurted!');
                player.visible = !player.visible;
            }
        }
        else if (player._DIRECTION == 3) {

            if (Game.movePlayer(player._CURRENT_X, player._CURRENT_Y - 1, player._CURRENT_X, player._CURRENT_Y)) {
                player._CURRENT_Y--;
                player.y = Game.getNewPosY(player._CURRENT_Y);
            }
            else {
                console.log(player._CURRENT_X);
                console.log(player._CURRENT_Y);
                console.log('Player was hurted!');
                player.visible = !player.visible;
            }
        }
    }

    function moveTail()
    {
        if (current_direction == 0) {
            tail.x =  player.x - tail.width + 14;
            tail.y =  player.y + 1;
        }
        else if (current_direction == 1) {
            tail.x =  player.x - 1;
            tail.y =  player.y - player.width + 14;
        }
        else if (current_direction == 2) {
            tail.x =  player.x + player.width - 14;
            tail.y =  player.y + 1;
        }
        else if (current_direction == 3) {
            tail.x =  player.x + 1;
            tail.y =  player.y + tail.width - 14;
        }
    }

    /*
     * Main function responsible for every move.
     */
    function move()
    {
        //movePlayer();
        player.x = getNewX(player.x);
        player.y = getNewY(player.y);
        moveTail();
        //var z = Game.insertNewObject(player.x, player.y, player.width, player.height, 2);
       /* if(current_direction == 0)
            var z = Game.isMoveLocked(player.x+player.width, player.y, player.width, player.height);
        else if(current_direction == 1)
            var z = Game.isMoveLocked(player.x, player.y+player.width, player.width, player.height);*/
       // else
        var dim = (player.width - player.height) / 2;
        console.log('dim', dim);
        if (current_direction == 0 || current_direction == 2)
            var z = Game.isMoveLocked(player.x, player.y, player.width, player.height);
        else if (current_direction == 1 || current_direction == 3)
            var z = Game.isMoveLocked(player.x + dim, player.y - dim, player.height, player.width);

        console.log('ZZZZZ: ', z)
        if (z > 0) {
            hurtedCatTimer.start();
            console.log('x', player.x)
            console.log('y', player.y)
            console.log('x2', player.x+player.width)
            console.log('y2', player.y+player.height)
            current_direction = -1;
        }
        Game.printList();
    }

    function moveStars()
    {
        star1.x = getNewX(star1.x);
        star1.y = getNewY(star1.y);
        star2.x = getNewX(star2.x);
        star2.y = getNewY(star2.y);
        star3.x = getNewX(star3.x);
        star3.y = getNewY(star3.y);
        star4.x = getNewX(star4.x);
        star4.y = getNewY(star4.y);
        star5.x = getNewX(star5.x);
        star5.y = getNewY(star5.y);
        star6.x = getNewX(star6.x);
        star6.y = getNewY(star6.y);
        star7.x = getNewX(star7.x);
        star7.y = getNewY(star7.y);
        star8.x = getNewX(star8.x);
        star8.y = getNewY(star8.y);
        star9.x = getNewX(star9.x);
        star9.y = getNewY(star9.y);
        star10.x = getNewX(star10.x);
        star10.y = getNewY(star10.y);
        star11.x = getNewX(star11.x);
        star11.y = getNewY(star11.y);
        star12.x = getNewX(star12.x);
        star12.y = getNewY(star12.y);
        star13.x = getNewX(star13.x);
        star13.y = getNewY(star13.y);
        star14.x = getNewX(star14.x);
        star14.y = getNewY(star14.y);
        star15.x = getNewX(star15.x);
        star15.y = getNewY(star15.y);
        star16.x = getNewX(star16.x);
        star16.y = getNewY(star16.y);
    }

    function placeCat()
    {
        player.x = (_WIDTH / 2) - player.width;
        player.y = (_HEIGHT / 2) - player.height;
       /* player.x = Game.getNewPosX(4);
        player.y = Game.getNewPosY(6);
        player._CURRENT_X = 4;
        player._CURRENT_Y = 6;*/
        // Let's start animation
        player.startTimer();
    }

    function placeStars()
    {
        star1.x = (Math.floor(_WIDTH * Math.random()));
        star1.y = (Math.floor(_HEIGHT * Math.random()));
        star1.star = (Math.floor(6 * Math.random()));
        star2.x = (Math.floor(_WIDTH * Math.random()));
        star2.y = (Math.floor(_HEIGHT * Math.random()));
        star2.star = (Math.floor(6 * Math.random()));
        star3.x = (Math.floor(_WIDTH * Math.random()));
        star3.y = (Math.floor(_HEIGHT * Math.random()));
        star3.star = (Math.floor(6 * Math.random()));
        star4.x = (Math.floor(_WIDTH * Math.random()));
        star4.y = (Math.floor(_HEIGHT * Math.random()));
        star4.star = (Math.floor(6 * Math.random()));
        star5.x = (Math.floor(_WIDTH * Math.random()));
        star5.y = (Math.floor(_HEIGHT * Math.random()));
        star5.star = (Math.floor(6 * Math.random()));
        star6.x = (Math.floor(_WIDTH * Math.random()));
        star6.y = (Math.floor(_HEIGHT * Math.random()));
        star6.star = (Math.floor(6 * Math.random()));
        star7.x = (Math.floor(_WIDTH * Math.random()));
        star7.y = (Math.floor(_HEIGHT * Math.random()));
        star7.star = (Math.floor(6 * Math.random()));
        star8.x = (Math.floor(_WIDTH * Math.random()));
        star8.y = (Math.floor(_HEIGHT * Math.random()));
        star8.star = (Math.floor(6 * Math.random()));
        star9.x = (Math.floor(_WIDTH * Math.random()));
        star9.y = (Math.floor(_HEIGHT * Math.random()));
        star9.star = (Math.floor(6 * Math.random()));
        star10.x = (Math.floor(_WIDTH * Math.random()));
        star10.y = (Math.floor(_HEIGHT * Math.random()));
        star10.star = (Math.floor(6 * Math.random()));
        star11.x = (Math.floor(_WIDTH * Math.random()));
        star11.y = (Math.floor(_HEIGHT * Math.random()));
        star11.star = (Math.floor(6 * Math.random()));
        star12.x = (Math.floor(_WIDTH * Math.random()));
        star12.y = (Math.floor(_HEIGHT * Math.random()));
        star12.star = (Math.floor(6 * Math.random()));
        star13.x = (Math.floor(_WIDTH * Math.random()));
        star13.y = (Math.floor(_HEIGHT * Math.random()));
        star13.star = (Math.floor(6 * Math.random()));
        star14.x = (Math.floor(_WIDTH * Math.random()));
        star14.y = (Math.floor(_HEIGHT * Math.random()));
        star14.star = (Math.floor(6 * Math.random()));
        star15.x = (Math.floor(_WIDTH * Math.random()));
        star15.y = (Math.floor(_HEIGHT * Math.random()));
        star15.star = (Math.floor(6 * Math.random()));
        star16.x = (Math.floor(_WIDTH * Math.random()));
        star16.y = (Math.floor(_HEIGHT * Math.random()));
        star16.star = (Math.floor(6 * Math.random()));
    }

    function rotatePlayer()
    {
        if (current_direction == 0) {
            player.rotation = 0;
            tail.rotation = 0;
            player._MIRROR = false;
        }
        else if (current_direction == 1) {
            player.rotation = 90;
            tail.rotation = 90;
            player._MIRROR = false;
        }
        else if (current_direction == 2) {
            player.rotation = 0;
            tail.rotation = 0;
            player._MIRROR = true;
        }
        else {
            player.rotation = 270;
            tail.rotation = 270;
            player._MIRROR = false;
        }
    }

    function setDirection(mouseX, mouseY)
    {
        var absX = Math.abs(beginX - mouseX);
        var absY = Math.abs(beginY - mouseY);

        // Check if the mouse move is long enough
        if ( (absX < _MOUSE_TRESHOLD) && (absY < _MOUSE_TRESHOLD))
            return;

        if ((beginX > mouseX) && (beginY > mouseY)) {
            if (absX > absY)
                current_direction = 0;
            else
                current_direction = 1;
        }
        else if ((beginX > mouseX) && (beginY < mouseY)) {
            if (absX > absY)
                current_direction = 0;
            else
                current_direction = 3;
        }
        else if ((beginX < mouseX) && (beginY > mouseY)) {
            if (absX > absY)
                current_direction = 2;
            else
                current_direction = 1;
        }
        else if ((beginX < mouseX) && (beginY < mouseY)) {
            if (absX > absY)
                current_direction = 2;
            else
                current_direction = 3;
        }

        rotatePlayer();
        _MOUSE_LOCK = true;
    }

    function hurtedCat()
    {
        hurted_cat_counter++;

        if (hurted_cat_counter > 6) {
            hurtedCatTimer.stop();
            hurted_cat_counter = 0;
            player.state = "show";
            tail.state = "show";
            return;
        }

        if (player.state == "show") {
            player.state = "hide";
            tail.state = "hide";
        }
        else {
            player.state = "show";
            tail.state = "show";
        }
    }

    Rectangle {
        id: background
        anchors.fill: parent
        color: "#294c78"
    }

    BlinkingStar {
        id: star1
    }
    BlinkingStar {
        id: star2
    }
    BlinkingStar {
        id: star3
    }
    BlinkingStar {
        id: star4
    }
    BlinkingStar {
        id: star5
    }
    BlinkingStar {
        id: star6
    }
    BlinkingStar {
        id: star7
    }
    BlinkingStar {
        id: star8
    }
    BlinkingStar {
        id: star9
    }
    BlinkingStar {
        id: star10
    }
    BlinkingStar {
        id: star11
    }
    BlinkingStar {
        id: star12
    }
    BlinkingStar {
        id: star13
    }
    BlinkingStar {
        id: star14
    }
    BlinkingStar {
        id: star15
    }
    BlinkingStar {
        id: star16
    }

    /* ChipMines BEGIN ===================================== */

    function placeMines()
    {
        var num_of_mines = (Math.floor(3 * Math.random()));

        var component = Qt.createComponent("ChipMine.qml");
        var sprite;
        if (component.status == Component.Ready) {
            sprite = component.createObject(gameBoard, {"x": 100, "y": 100, "visible": true});
            sprite.x = 400;
        }

      //  placeMine1();
     //   placeMine2();
      //  placeMine3();
    }

    Timer {
        id: placeMinesTimer
        running: true
        repeat: true
        interval: 3000
        onTriggered: placeMines()
    }

    function switchPlaceMine(n)
    {
        switch (n)
        {
        case 0:
            placeMine1();
            break;
        case 1:
            placeMine2();
            break;
        case 2:
            placeMine3();
            break;
        }
    }

    function placeMine1()
    {
        chip1.x = (Math.floor(_WIDTH * Math.random()));
        chip1.y = (Math.floor(_HEIGHT * Math.random()));
        chip1.itemID = Game.insertNewObject(chip1.x, chip1.y, chip1.width, chip1.height, 2);
        chip1.visible = true;
        _MINES_IN_USE++;
    }
    function placeMine2()
    {
        chip2.x = (Math.floor(_WIDTH * Math.random()));
        chip2.y = (Math.floor(_HEIGHT * Math.random()));
        chip2.itemID = Game.insertNewObject(chip2.x, chip2.y, chip2.width, chip2.height, 2);
        chip2.visible = true;
        _MINES_IN_USE++;
    }
    function placeMine3()
    {
        chip3.x = (Math.floor(_WIDTH * Math.random()));
        chip3.y = (Math.floor(_HEIGHT * Math.random()));
        chip3.itemID = Game.insertNewObject(chip3.x, chip3.y, chip3.width, chip3.height, 2);
        chip3.visible = true;
        _MINES_IN_USE++;
    }

    function removeMine1()
    {
        Game.removeObject(chip1.itemID);
        chip1.visible = false;
        _MINES_IN_USE--;
    }
    function removeMine2()
    {
        Game.removeObject(chip2.itemID);
        chip2.visible = false;
        _MINES_IN_USE--;
    }
    function removeMine3()
    {
        Game.removeObject(chip3.itemID);
        chip3.visible = false;
        _MINES_IN_USE--;
    }

    ChipMine {
        id: chip1
        mineID: 0
    }
    ChipMine {
        id: chip2
        mineID: 1
    }
    ChipMine {
        id: chip3
        mineID: 2
    }
    ChipMine {
        id: chip4
        mineID: 3
    }
    ChipMine {
        id: chip5
        mineID: 4
    }
    ChipMine {
        id: chip6
        mineID: 5
    }
    ChipMine {
        id: chip7
        mineID: 6
    }
    ChipMine {
        id: chip8
        mineID: 7
    }
    ChipMine {
        id: chip9
        mineID: 8
    }
    ChipMine {
        id: chip10
        mineID: 9
    }
    ChipMine {
        id: chip11
        mineID: 10
    }
    ChipMine {
        id: chip12
        mineID: 11
    }
    ChipMine {
        id: chip13
        mineID: 12
    }
    ChipMine {
        id: chip14
        mineID: 13
    }
    ChipMine {
        id: chip15
        mineID: 14
    }
    ChipMine {
        id: chip16
        mineID: 15
    }
    ChipMine {
        id: chip17
        mineID: 16
    }
    ChipMine {
        id: chip18
        mineID: 17
    }
    ChipMine {
        id: chip19
        mineID: 18
    }
    ChipMine {
        id: chip20
        mineID: 19
    }
    /* ChipMines END ===================================== */

    Tail {
        id: tail
        //x: player._MIRROR ? 52 : player.x - tail.width + 16
        //y: player.y + 1
        x: 0
        y: 0
        opacity: 0.8
        _MIRROR: player._MIRROR
    }

    Cat {
        id: player
        _DIRECTION: parent.current_direction
    }

    Label {
        id: label
        anchors.top: parent.top
        anchors.left: parent.left
        color: "red"
        text: "x1: " + player.x + " x2:" + (player.x + player.width)
    }

    Label {
        id: label2
        anchors.top: parent.top
        anchors.right: parent.right
        color: "red"
        text: "y1: " + player.y + " y2:" + (player.y + player.height)
    }

    Timer {
        id: moveTimer
        running: false
        repeat: true
        interval: 50
        onTriggered: move()
    }

    Timer {
        id: hurtedCatTimer
        running: false
        repeat: true
        interval: 300
        onTriggered: hurtedCat();
    }

    MouseArea {
        anchors.fill: parent
        onPressed: {
            beginX = mouseX;
            beginY = mouseY;
        }
        onPositionChanged: {
            if (!_MOUSE_LOCK) {
                setDirection(mouseX, mouseY);

                console.log('pc')
            }
        }
        onReleased: {
            _MOUSE_LOCK = false;
            console.log('rel')
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
