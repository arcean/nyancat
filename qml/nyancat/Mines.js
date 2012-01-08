var _MAX_MINES = 20;
var array_mines = new Array(_MAX_MINES);
var array_mines_indi = 0;
var component_mine;

/* GET functions ============================================================ */

function getMineX(n)
{
    if (array_mines[n] == null)
        return -1;

    return array_mines[n].x;
}

function getMineY(n)
{
    if (array_mines[n] == null)
        return -1;

    return array_mines[n].y;
}

function getMineWidth(n)
{
    if (array_mines[n] == null)
        return -1;

    return array_mines[n].width;
}

function getMineHeight(n)
{
    if (array_mines[n] == null)
        return -1;

    return array_mines[n].height;
}

/* CREATE function =================================================== */

function createMine() {
    if (component_mine == null)
        component_mine = Qt.createComponent("ChipMine.qml");

    if (component_mine.status == Component.Ready) {
        var dynamicObject = component_mine.createObject(background);
        if (dynamicObject == null) {
            console.log("error creating mine");
            console.log(component_mine.errorString());
            return false;
        }
        dynamicObject.x = (Math.floor(_WIDTH * Math.random()));
        dynamicObject.y = (Math.floor(_HEIGHT * Math.random()));
        dynamicObject.visible = true;
        array_mines[array_mines_indi] = dynamicObject;
        array_mines_indi++;
    } else {
        console.log("error loading mine component");
        console.log(component_mine.errorString());
        return false;
    }
    return true;
}
