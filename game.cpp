#include <QDebug>
#include "game.h"

Game::Game(QObject *parent) :
    QObject(parent) {

}

#ifdef DEBUG_MODE
void Game::printList()
{
    for (int i = 0; i < objectsList.length(); i++) {
        qDebug() << "A:" << objectsList.at(i).get_x_pos() << "L:" << objectsList.length();
        if(i > 10)
            qDebug() << "A LO:" << objectsList.at(i-10).get_x_pos() << "L:" << objectsList.at(i).get_width();
    }
}
#endif

/*
 * Check, if the given object (from the objectsList) contains a point with x and y as pos.
 * Returns: -1 - an object does not contains our positions, anything else - ITEM_ID
  */
int Game::containsPoint(int objectNumber, int p_x, int p_y)
{
    int x1 = objectsList.at(objectNumber).get_x_pos();
    int y1 = objectsList.at(objectNumber).get_y_pos();
    int width = objectsList.at(objectNumber).get_width();
    int height = objectsList.at(objectNumber).get_height();
    int type = objectsList.at(objectNumber).get_type();
    int x2 = x1 + width;
    int y2 = y1 + height;
    int result = -1;

    if (p_x >= x1 && p_x <= x2)
        if (p_y >= y1 && p_y <= y2) {
            result = type;
#ifdef DEBUG_MODE
            qDebug() << "Contains on" << p_x << "x" << p_y;
            qDebug() << "Where x1" << x1 << "y1" << y1 << "x2" << x2 << "y2" << y2;
#endif
        }

    return result;
}

/*
 * Check, if the given positions conflicts with an object.
 * Positions: every corner of the rectangle.
 * Returns: 0 - is not locked, anything else - ITEM_ID
  */
int Game::isMoveLocked(int x1, int y1, int width, int height)
{
    int x2 = x1 + width;
    int y2 = y1 + height;
    int temp;

    for (int i = 0; i < objectsList.length(); i++) {
#ifdef DEBUG_MODE
        qDebug() << "Iter" << i;
#endif
        temp = containsPoint(i, x1, y1);
        if (temp != -1)
            return temp;
        temp = containsPoint(i, x2, y1);
        if (temp != -1)
            return temp;
        temp = containsPoint(i, x1, y2);
        if (temp != -1)
            return temp;
        temp = containsPoint(i, x2, y2);
        if (temp != -1)
            return temp;
#ifdef DEBUG_MODE
        qDebug() << "Iter" << i << "OK";
#endif
    }
#ifdef DEBUG_MODE
    qDebug() << "Iter" << "all done; ret -1";
#endif

    return -1;
}

//void Game::removeObject()

int Game::insertNewObject(int x, int y, int width, int height, int type)
{
    Object temp(x, y, width, height, type);
    int id = objectsList.length();

    //objectsList.append(temp);
    objectsList.insert(id, temp);

    return id;
}
