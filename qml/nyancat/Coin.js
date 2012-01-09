var _MAX_COINS = 20;
var _MAX_COINS_PER_ONCE = 2;
var _MAX_DESTROY_INTERVAL = 6000;
var array_COINS = new Array(_MAX_COINS);
var component_Coin;

function checkAndDestroyCoin()
{
    for (var i = 0; i < _MAX_COINS; i++) {
        if (array_COINS[i] != null)
            if (array_COINS[i].shouldBeDestroyed) {
                array_COINS[i].destroy();
                array_COINS[i] = null;
            }
    }
}

/* COLLISION functions ============================================================== */

function isCollisionCoin(p_x, p_y, p_x2, p_y2)
{
    for (var i = 0; i < _MAX_COINS; i++) {
        if (isCollisionCoinFor(p_x, p_y, p_x2, p_y2, i))
            return true;
    }

    return false;
}

function isCollisionCoinFor(p_x, p_y, p_x2, p_y2, Coin_number)
{
    var m_x = getCoinX(Coin_number);
    var m_y = getCoinY(Coin_number);
    var m_x2 = m_x + getCoinWidth(Coin_number);
    var m_y2 = m_y + getCoinHeight(Coin_number);

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

function getCoinX(n)
{
    if (array_COINS[n] == null)
        return -1;

    return array_COINS[n].x;
}

function getCoinY(n)
{
    if (array_COINS[n] == null)
        return -1;

    return array_COINS[n].y;
}

function getCoinWidth(n)
{
    if (array_COINS[n] == null)
        return -1;

    return array_COINS[n].width;
}

function getCoinHeight(n)
{
    if (array_COINS[n] == null)
        return -1;

    return array_COINS[n].height;
}

/* CREATE function =================================================== */

function createCoinRandomNumber()
{
    var ran = (Math.floor(_MAX_COINS_PER_ONCE * 3 * Math.random()));
    ran = ran - _MAX_COINS_PER_ONCE * 2;

    for (var i = 0; i < ran; i++) {
        createCoin();
    }
}

function getFreeSpaceCoin()
{
    for (var i = 0; i < _MAX_COINS; i++) {
        if (array_COINS[i] == null)
            return i;
    }
    return -1;
}

function createCoin()
{
    var indi = getFreeSpaceCoin();

    if (indi == -1)
        return;

    if (component_Coin == null)
        component_Coin = Qt.createComponent("Coin.qml");

    if (component_Coin.status == Component.Ready) {
        var dynamicObject = component_Coin.createObject(background);
        if (dynamicObject == null) {
            console.log("error creating Coin");
            console.log(component_Coin.errorString());
            return false;
        }
        dynamicObject.x = (Math.floor(_WIDTH * Math.random()));
        dynamicObject.y = (Math.floor(_HEIGHT * Math.random()));
        dynamicObject.itemID = indi;
        dynamicObject.visible = true;
        dynamicObject.interval = (Math.floor(_MAX_DESTROY_INTERVAL * Math.random()));

        if (dynamicObject.interval >= 2000)
            dynamicObject.startDestroyTimer();

        array_COINS[indi] = dynamicObject;
    } else {
        console.log("error loading Coin component");
        console.log(component_Coin.errorString());
        return false;
    }
    return true;
}
