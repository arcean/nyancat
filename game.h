#ifndef GAME_H
#define GAME_H

#include <QObject>
#include <QList>
#include "object.h"

#define DEBUG_MODE

#define WIDTH 480
#define HEIGHT 854

#define EMPTY 0
#define PLAYER 1
#define MINE 2
#define COIN 3
#define APPLE 4
#define BANANA 5
#define HEART 6
#define UNKNOWN_BAD 100
#define UNKNOWN_GOOD 101

/* 0 - X pos, 1 - Y pos, 2 - object type. */
#define DATA_NUM 3


class Game : public QObject {
    Q_OBJECT

public:
    explicit Game(QObject *parent = 0);

public slots:
    int isMoveLocked(int x1, int y1, int width, int height);
    int insertNewObject(int x, int y, int width, int height, int type);
#ifdef DEBUG_MODE
    void printList();
#endif

private:
    int containsPoint(int objectNumber, int p_x, int p_y);

    QList<Object> objectsList;

};

#endif // GAME_H
