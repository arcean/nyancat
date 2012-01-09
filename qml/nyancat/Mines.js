var _MAX_MINES = 20;
var array_mines = new Array(_MAX_MINES);
var array_mines_indi = 0;
var component_mine;

function isCollision(p_x, p_y, p_x2, p_y2)
{
    for (var i = 0; i < array_mines_indi; i++) {
        if (isCollisionFor(p_x, p_y, p_x2, p_y2, i))
            return true;
    }

    return false;
}

function isCollisionFor(p_x, p_y, p_x2, p_y2, mine_number)
{
    var m_x = getMineX(mine_number);
    var m_y = getMineY(mine_number);
    var m_x2 = m_x + getMineWidth(mine_number);
    var m_y2 = m_y + getMineHeight(mine_number);

    if (p_x >= m_x && p_x <= m_x2)
        if (p_y >= m_y && p_y <= m_y2) {
            console.log('detrrrrr 1')
            return true;
        }

    if (p_x >= m_x && p_x <= m_x2)
        if (p_y2 >= m_y && p_y2 <= m_y2) {
            console.log('detrrrrr 2')
            return true;
        }

    if (p_x2 >= m_x && p_x2 <= m_x2)
        if (p_y >= m_y && p_y <= m_y2) {
            console.log('detrrrrr 3')
            return true;
        }

    if (p_x2 >= m_x && p_x2 <= m_x2)
        if (p_y2 >= m_y && p_y2 <= m_y2) {
            console.log('detrrrrr 4')
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
