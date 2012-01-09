var _MAX_MINES = 20;
var _MAX_MINES_PER_ONCE = 2;
var _MAX_DESTROY_INTERVAL = 6000;
var array_mines = new Array(_MAX_MINES);
var component_mine;

function checkAndDestroyMine()
{
    for (var i = 0; i < _MAX_MINES; i++) {
        if (array_mines[i] != null)
            if (array_mines[i].shouldBeDestroyed) {
                array_mines[i].destroy();
                array_mines[i] = null;
            }
    }
}

/* COLLISION functions ============================================================== */

function isCollisionMine(p_x, p_y, p_x2, p_y2)
{
    for (var i = 0; i < _MAX_MINES; i++) {
        if (isCollisionMineFor(p_x, p_y, p_x2, p_y2, i))
            return true;
    }

    return false;
}

function isCollisionMineFor(p_x, p_y, p_x2, p_y2, mine_number)
{
    var m_x = getMineX(mine_number);
    var m_y = getMineY(mine_number);
    var m_x2 = m_x + getMineWidth(mine_number);
    var m_y2 = m_y + getMineHeight(mine_number);

    if (p_x >= m_x && p_x <= m_x2)
        if (p_y >= m_y && p_y <= m_y2) {
            return true;
        }

    if (p_x >= m_x && p_x <= m_x2)
        if (p_y2 >= m_y && p_y2 <= m_y2) {
            return true;
        }

    if (p_x2 >= m_x && p_x2 <= m_x2)
        if (p_y >= m_y && p_y <= m_y2) {
            return true;
        }

    if (p_x2 >= m_x && p_x2 <= m_x2)
        if (p_y2 >= m_y && p_y2 <= m_y2) {
            return true;
        }

    return false;
}

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

function createMineRandomNumber()
{
    var ran = (Math.floor(_MAX_MINES_PER_ONCE * 3 * Math.random()));
    ran = ran - _MAX_MINES_PER_ONCE * 2;

    for (var i = 0; i < ran; i++) {
        createMine();
    }
}

function getFreeSpaceMine()
{
    for (var i = 0; i < _MAX_MINES; i++) {
        if (array_mines[i] == null)
            return i;
    }
    return -1;
}

function createMine()
{
    var indi = getFreeSpaceMine();

    if (indi == -1)
        return;

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
        dynamicObject.itemID = indi;
        dynamicObject.visible = true;
        dynamicObject.interval = (Math.floor(_MAX_DESTROY_INTERVAL * Math.random()));

        if (dynamicObject.interval >= 2000)
            dynamicObject.startDestroyTimer();

        array_mines[indi] = dynamicObject;
    } else {
        console.log("error loading mine component");
        console.log(component_mine.errorString());
        return false;
    }
    return true;
}
