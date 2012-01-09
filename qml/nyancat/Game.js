Qt.include("Mines.js")

var _MAX_STARS = 16;
var _WIDTH = 480;
var _HEIGHT = 854;
var _MAX_STEP = 4;

var current_direction = 0;
var _MOUSE_LOCK = false;
var beginX = 0;
var beginY = 0;
var _MOUSE_TRESHOLD = 50;

var array_star = new Array(_MAX_STARS);
var array_star_indi = 0;
var component_star;

var player_component;
var player;
var tail_component;
var tail;

/* CHECK AND DESTROY functions ====================================================== */

function checkAndDestroy()
{
    checkAndDestroyMine();
}

/* PLACE functions ================================================================== */

function placeStars()
{
    var x, y;
    var i = 0;

    for (i = 0; i < _MAX_STARS; i++) {
        x = (Math.floor(_WIDTH * Math.random()));
        y = (Math.floor(_HEIGHT * Math.random()));
        createStar(x, y);
    }
}

/* CREATE functions ================================================================== */

function createStar(x, y) {
    if (component_star == null)
        component_star = Qt.createComponent("BlinkingStar.qml");

    if (component_star.status == Component.Ready) {
        var dynamicObject = component_star.createObject(background);
        if (dynamicObject == null) {
            console.log("error creating star");
            console.log(component_star.errorString());
            return false;
        }
        dynamicObject.x = x;
        dynamicObject.y = y;
        dynamicObject.visible = true;
        dynamicObject.star = (Math.floor(6 * Math.random()));
        array_star[array_star_indi] = dynamicObject;
        array_star_indi++;
    } else {
        console.log("error loading star component");
        console.log(component_star.errorString());
        return false;
    }
    return true;
}

function createPlayer() {
    if (player_component == null)
        player_component = Qt.createComponent("Cat.qml");

    if (player_component.status == Component.Ready) {
        var dynamicObject = player_component.createObject(gameBoard);
        if (dynamicObject == null) {
            console.log("error creating cat");
            console.log(player_component.errorString());
            return false;
        }
        dynamicObject.x = (_WIDTH / 2) - dynamicObject.width;
        dynamicObject.y = (_HEIGHT / 2) - dynamicObject.height;
        dynamicObject.visible = true;
        player = dynamicObject;
    } else {
        console.log("error loading cat component");
        console.log(player_component.errorString());
        return false;
    }
    return true;
}

function createTail() {
    if (tail_component == null)
        tail_component = Qt.createComponent("Tail.qml");

    if (tail_component.status == Component.Ready) {
        var dynamicObject = tail_component.createObject(gameBoard);
        if (dynamicObject == null) {
            console.log("error creating tail");
            console.log(tail_component.errorString());
            return false;
        }
        dynamicObject.visible = true;
        dynamicObject.x =  player.x - dynamicObject.width + 14;
        dynamicObject.y =  player.y + 1;
        tail = dynamicObject;
    } else {
        console.log("error loading tail component");
        console.log(tail_component.errorString());
        return false;
    }
    return true;
}

/* DIRECTION, ROTATION, TAIL_FOLLOW functions ============================================================ */

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
    moveTail();
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

/* MOVE functions ========================================================================= */

function movePlayer()
{
    player.x = getNewX(player.x);
    player.y = getNewY(player.y);
    /* Let's the tail follow a body :). */
    moveTail();
}

function getNewX(oldX)
{
    var x;
    if (current_direction == 0) {
        x = oldX + _MAX_STEP;

        if (x > _WIDTH)
            x = 0;

        return x;
    }
    else if (current_direction == 2) {
        x = oldX - _MAX_STEP;

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
        y = oldY + _MAX_STEP;

        if (y > _HEIGHT)
            y = 0;

        return y;
    }
    else if (current_direction == 3) {
        y = oldY - _MAX_STEP;

        if (y < 0)
            y = _HEIGHT;

        return y;
    }
    else
        return oldY;
}
