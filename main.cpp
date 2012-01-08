#include <QtGui/QApplication>
#include <QtDeclarative>
#include "qmlapplicationviewer.h"
#include "game.h"

Q_DECL_EXPORT int main(int argc, char *argv[])
{
    QScopedPointer<QApplication> app(createApplication(argc, argv));

   // Game game;

    QmlApplicationViewer viewer;

    QDeclarativeContext *context = viewer.rootContext();
    //context->setContextProperty("Game", &game);

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/nyancat/main.qml"));
    viewer.showExpanded();

    return app->exec();
}
